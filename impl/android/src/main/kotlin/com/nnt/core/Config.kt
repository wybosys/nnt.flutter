package com.nnt.core

class Config {
    companion object {
        private var _shared: Config? = null
        val shared: Config
            get() {
                if (_shared == null)
                    _shared = Config()
                return _shared as Config
            }
    }

    fun override(cfg: AnyMap): Config {
        cfg.forEach {
            _cfg.set(it.key as String, it.value as Any)
        }
        return this
    }

    fun get(key: String, def: Any? = null): Any? {
        if (!_cfg.containsKey(key))
            return def
        return _cfg[key]
    }

    fun set(key: String, v: Any) {
        _cfg[key] = v
    }

    fun containsKey(key: String): Boolean {
        return _cfg.containsKey(key)
    }

    fun valueByKeyPath(kp: String, def: Any? = null): Any? {
        return MapT.GetValueByKeyPath(_cfg, kp, def)
    }

    private var _cfg = mutableMapOf<String, Any>()
}
