package com.nnt.service

import com.nnt.core.*

fun Get(domain: String, action: String, args: AnyMap): Any? {
    try {
        return Fetch(domain, action, args)
    } catch (e: Exception) {
        Logger.warn(e.toString())
    }
    return null
}

fun Fetch(domain: String, action: String, args: AnyMap): Any? {
    // 拼装url
    var url = Config.shared.get("PROTOCOL") as String + "//" + Config.shared.get("SDK_HOST") + "/" + domain + "/?action=" + action

    // devops测试参数
    if (Config.shared.get("DEVOPS_RELEASE") != true)
        url += "&_skippermission=1";

    // sid
    val sid = Config.shared.get("USER_SID")
    if (sid != null)
        url += "&_sid=" + sid

    val conn = Connector()
    conn.url = url
    conn.method = METHOD_GET
    conn.args(args as Map<String, Any?>)
    conn.send()
    if (conn.errno != 200) {
        throw CodeError(STATUS.FAILED, conn.errmsg)
    } else {
        // 解析数据
        val raw = toJsonObj(conn.body)
        if (raw == null || !raw.containsKey("code")) {
            throw CodeError(STATUS.FORMAT_ERROR, conn.body)
        } else {
            val code = toInt(raw["code"])
            val payload = MapT.ValueAtFirstExistsKey(raw, listOf("message", "data"), {}) as Any?
            if (code != STATUS.OK) {
                throw CodeError(code, toJson(payload))
            } else {
                return payload
            }
        }
    }
}