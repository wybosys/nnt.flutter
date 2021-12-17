package com.nnt.core;

import com.google.gson.Gson

typealias JsObj = Map<String, Any?>
typealias JsObjOrStr = Any; // JSONObject or String
typealias JsStr = String;

fun toJsonObj(str: JsObjOrStr?, def: JsObj? = null): JsObj? {
    if (str == null) {
        return def;
    }
    if (str is Map<*, *>) {
        return str as JsObj?
    }
    if (str is String) {
        try {
            return Gson().fromJson(str, Map::class.java) as JsObj
        } catch (err: Exception) {
            return def;
        }
    }
    return def;
}

fun toJson(obj: JsObjOrStr?, def: String? = null): JsStr? {
    if (obj == null) {
        return null;
    }
    if (obj is JsStr) {
        return obj;
    }
    if (obj is Map<*, *>) {
        return Gson().toJson(obj)
    }
    return def;
}

fun json_of_file(path: String, def: JsObj? = null): JsObj? {
    val cnt = content_of_file(path, null);
    if (cnt == null) {
        return def;
    }
    return toJsonObj(cnt);
}
