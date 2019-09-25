package com.nnt.core

class HttpT {

}

class FormData() {
    private val boundary = "===" + System.currentTimeMillis() + "===";
    private val LINE_FEED = "\r\n"
    private val writer = StringBuilder()

    fun variable(k: String, v: String): FormData {
        writer.append("--$boundary").append(LINE_FEED);
        writer.append("Content-Disposition: form-data; name=\"$k\"")
                .append(LINE_FEED)
        writer.append("Content-Type: text/plain; charset=utf-8").append(LINE_FEED)
        writer.append(LINE_FEED)
        writer.append(v).append(LINE_FEED)
        return this
    }

    fun variables(vs: AnyMap?): FormData {
        if (vs == null)
            return this
        vs.forEach {
            if (it.value != null) {
                variable(it.key.toString(), it.value.toString())
            }
        }
        return this
    }

    fun header(k: String, v: String): FormData {
        writer.append("$k: $v").append(LINE_FEED);
        return this
    }

    fun finish(): FormData {
        writer.append(LINE_FEED)
        writer.append("--$boundary--").append(LINE_FEED)
        return this
    }

    override fun toString(): String {
        return writer.toString()
    }

    fun toBytes(): ByteArray {
        return writer.toString().toByteArray(Charsets.UTF_8)
    }
}