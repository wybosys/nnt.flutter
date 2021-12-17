package com.nnt.core;

val _global_objects = mutableMapOf<Int, Any>()

fun GlobalAdd(obj: Any) {
    _global_objects[obj.hashCode()] = obj
}

fun <T> GlobalDel(objorhc: T): Boolean {
    val hc: Int = if (objorhc is Int) objorhc else objorhc?.hashCode() as Int
    if (!_global_objects.containsKey(hc))
        return false
    _global_objects.remove(hc)
    return true
}

fun <T> GlobalLookup(hc: Int, def: T? = null): T? {
    if (!_global_objects.containsKey(hc))
        return def
    return _global_objects[hc] as T
}

fun <T> GlobalGet(hc: Int): T {
    return _global_objects[hc] as T
}