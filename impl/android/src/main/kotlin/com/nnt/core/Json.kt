package com.nnt.core;

import org.json.JSONObject

typealias JsObj = Any; // JSONObject or String
typealias JsStr = String;

fun toJsonObj(str: JsObj?, def: JSONObject? = null): JSONObject? {
    if (str == null) {
        return def;
    }
    if (str is JSONObject) {
        return str;
    }
    if (str is String) {
        try {
            return JSONObject(str);
        } catch (err: Exception) {
            return def;
        }
    }
    return def;
}

fun toJson(obj: JsObj?, def: String ? = null): String? {
    if (obj == null) {
        return null;
    }
    if (obj is String) {
        return obj;
    }
    if (obj is JSONObject) {
        return obj.toString();
    }
    return def;
}

fun json_of_file(path: String, def: JSONObject? = null): JSONObject? {
    val cnt = content_of_file(path, null);
    if (cnt == null) {
        return def;
    }
    return toJsonObj(cnt);
}
