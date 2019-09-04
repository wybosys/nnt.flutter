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
                if (!(r is AnyMap)) {
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
