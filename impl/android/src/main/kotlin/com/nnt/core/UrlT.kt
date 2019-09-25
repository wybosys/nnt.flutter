package com.nnt.core

import java.net.URLEncoder

class UrlT {

    companion object {
        fun BuildQuery(args: AnyMap): String {
            val params = mutableListOf<String>()
            args.forEach { (k, v) ->
                run {
                    val sk = URLEncoder.encode(k.toString())
                    val sv = URLEncoder.encode(v.toString())
                    params.add("$k=$v")
                }
            }
            return params.joinToString("&")
        }
    }
}
