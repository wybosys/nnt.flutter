package com.nnt.service

import com.nnt.core.Config
import com.nnt.core.FormData
import com.nnt.core.StringT
import com.nnt.core.UrlT
import kotlinx.coroutines.GlobalScope
import kotlinx.coroutines.launch
import java.io.BufferedInputStream
import java.io.BufferedOutputStream
import java.io.ByteArrayOutputStream
import java.io.InputStream
import java.net.HttpURLConnection
import java.net.URL

// 请求形式
const val METHOD_GET = 0x1000
const val METHOD_POST = 0x1000000
const val METHOD_POST_URLENCODED = METHOD_POST and 1
// const val METHOD_POST_XML = METHOD_POST and 2
// const val METHOD_POST_JSON = METHOD_POST and 3

class Connector {
    var url = ""
    var method = METHOD_GET

    // 请求参数
    private var _args = mutableMapOf<String, Any>()

    // 请求使用的头
    private var _headers = mutableMapOf<String, String>()

    // 响应头
    private var _respheaders: Map<String, String>? = null
    val respheaders get() = _respheaders as Map<String, String>

    // 是否获得完整返回数据
    var full = false

    // 是否是devops请求
    var devops = false

    fun arg(k: String, v: Any?) {
        if (v != null) {
            _args[k] = v
        } else {
            _args.remove(k)
        }
    }

    fun args(args: Map<String, Any?>?) {
        if (args == null)
            return

        args.forEach { (k, v) ->
            run {
                if (v == null) {
                    _args.remove(k)
                } else {
                    _args[k] = v
                }
            }
        }
    }

    fun header(k: String, v: String?) {
        if (v == null) {
            this._headers.remove(k)
        } else {
            this._headers[k] = v
        }
    }

    fun headers(headers: Map<String, String>?) {
        if (headers == null)
            return

        headers.forEach { (k, v) ->
            run {
                _headers[k] = v
            }
        }
    }

    // 返回协程中的处理
    fun send() {
        GlobalScope.launch {
            try {
                _send()
            } catch (e: Exception) {
                errno = 404
                _errmsg = e.localizedMessage
            }
        }
    }

    private fun _send() {
        // 清理
        _body = null
        _respheaders = null
        errno = 200
        _errmsg = ""

        // 组装基础url
        url = this.url

        // 处理devops
        if (devops) {
            if (Config.shared.get("DEVOPS_RELEASE") != true) {
                _args[KEY_SKIPPERMISSION] = 1
            }
        }

        // 处理get请求
        if (method == METHOD_GET) {
            if (url.indexOf("?") == -1) {
                url += "?"
            } else {
                url += "&"
            }
            url += UrlT.BuildQuery(_args)
        }

        // 构造请求对象
        val u = URL(url)
        val h = u.openConnection() as HttpURLConnection
        h.useCaches = false

        if (method == METHOD_GET) {
            h.requestMethod = "GET"
        } else {
            h.requestMethod = "POST"
            val os = h.outputStream
            when (method) {
                METHOD_POST -> {
                    val fd = FormData()
                    fd.variables(_args).finish()
                    os.write(fd.toBytes())
                    _headers["Content-Type"] = "multipart/form-data"
                }
                METHOD_POST_URLENCODED -> {
                    val params = UrlT.BuildQuery(_args)
                    os.write(params.toByteArray(Charsets.UTF_8))
                    _headers["Content-Type"] = "application/x-www-form-urlencoded"
                }
            }
            os.flush()
            os.close()
        }

        // 设置头信息
        _headers.forEach { (k, v) ->
            run {
                h.setRequestProperty(k, v)
            }
        }

        // 请求
        h.connect()

        // 处理结果
        val inp = h.inputStream
        _body = GetResponse(inp)
        _respheaders = GetResponseHeaders(h)
    }

    // 错误信息
    var errno = 200
    private var _errmsg: String? = null
    val errmsg get() = _errmsg as String

    // 消息主体
    private var _body: String? = null
    val body get() = _body as String

    companion object {
        private fun GetResponse(inp: InputStream): String {
            val bis = BufferedInputStream(inp)
            val baos = ByteArrayOutputStream()
            val bos = BufferedOutputStream(baos)
            val buf = ByteArray(1024 * 4) // 4k分段读取
            try {
                var len = bis.read(buf)
                while (len > 0) {
                    bos.write(buf, 0, len)
                    len = bis.read(buf)
                }
                bos.flush()
                return StringT.FromBytes(baos.toByteArray())
            } catch (e: Exception) {
                e.printStackTrace()
            } finally {
                try {
                    bos.close()
                } catch (e: Exception) {
                    e.printStackTrace()
                }
                try {
                    bis.close()
                } catch (e: Exception) {
                    e.printStackTrace()
                }
            }
            return ""
        }

        private fun GetResponseHeaders(hdl: HttpURLConnection): Map<String, String> {
            val ret = mutableMapOf<String, String>()
            val ref = hdl.headerFields
            ref.forEach {
                if (it.key == null) {
                    ret["Http-Status"] = it.value.joinToString(" ")
                } else {
                    ret[it.key] = it.value.joinToString(" ")
                }
            }
            return ret
        }
    }
}
