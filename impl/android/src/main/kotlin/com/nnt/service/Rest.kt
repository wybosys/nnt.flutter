package com.nnt.service

import com.nnt.core.AnyMap
import java.net.HttpURLConnection
import java.net.URL
import java.net.URLEncoder

fun Get(url: String, args: AnyMap, cbsuc: (data: AnyMap) -> Void, cbfail: (err: Error) -> Void) {
    val params = mutableListOf<String>()
    args.forEach { (k, v) ->
        val sk = URLEncoder.encode(k.toString())
        val sv = URLEncoder.encode(v.toString())
        params.add("$sk=$sv")
    }
    val h = URL(url + "?" + params.joinToString("&"))
    with(h.openConnection() as HttpURLConnection) {

    }
}

fun Post(url: String, args: AnyMap, cbsuc: (data: AnyMap) -> Void, cbfail: (err: Error) -> Void) {

}