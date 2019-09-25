package com.nnt.core

class StringT {
    companion object {
        fun FromBytes(src: ByteArray?, def: String = ""): String {
            if (src == null)
                return def
            try {
                return String(src, Charsets.UTF_8)
            } catch (e: Exception) {
                e.printStackTrace()
            }
            return def
        }
    }
}
