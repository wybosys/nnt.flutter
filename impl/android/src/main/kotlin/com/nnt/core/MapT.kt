package com.nnt.core;

class MapT {

    companion object {
        fun Get(o: AnyMap, k: Any, def: Any? = null): Any? {
            if (o.containsKey(k))
                return o[k]
            return def
        }

        /** 根据查询路径获取值 */
        fun GetValueByKeyPath(o: AnyMap?, kp: KeyPath, def: Any? = null): Any? {
            if (o == null) {
                return def;
            }
            val ks = kp.split('.');
            var r = o as Any?
            for (k in ks) {
                if (!(r is MapType)) {
                    return def;
                }
                r = r[k]
                if (r == null) {
                    return def
                }
            }
            return r
        }
    }
}

fun toMap(o: Any?, def: Map<*, *>? = null): Map<*, *>? {
    if (o == null)
        return def
    if (o is Map<*, *>) {
        return o
    }
    if (o is String) {
        return toJsonObj(o)
    }
    return def
}