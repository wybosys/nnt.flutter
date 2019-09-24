package com.nnt.service

import com.nnt.core.AnyMap
import com.nnt.core.Config


fun Get(domain: String, action: String, args: AnyMap, cb: (res: AnyMap?) -> Void) {
    try {
        Fetch(domain, action, args, cb)
    } catch (err: Exception) {
        cb(null)
    }
}

fun Fetch(domain: String, action: String, args: AnyMap, cb: (res: AnyMap?) -> Void) {
    // 拼装url
    val url = Config.shared.get("PROTOCOL") as String + "//" + Config.shared.get("SDK_HOST") + '/' + domain + "/?action=" + action
}