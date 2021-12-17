package com.nnt.core

class STATUS {
    companion object {
        val UNKNOWN = -1000;
        val EXCEPTION = -999; // 遇到了未处理的异常
        val ROUTER_NOT_FOUND = -998; // 没有找到路由
        val CONTEXT_LOST = -997; // 上下文丢失
        val MODEL_ERROR = -996; // 恢复模型失败
        val PARAMETER_NOT_MATCH = -995; // 参数不符合要求
        val NEED_AUTH = -994; // 需要登陆
        val TYPE_MISMATCH = -993; // 参数类型错误
        val FILESYSTEM_FAILED = -992; // 文件系统失败
        val FILE_NOT_FOUND = -991; // 文件不存在
        val ARCHITECT_DISMATCH = -990; // 代码不符合标准架构
        val SERVER_NOT_FOUND = -989; // 没有找到服务器
        val LENGTH_OVERFLOW = -988; // 长度超过限制
        val TARGET_NOT_FOUND = -987; // 目标对象没有找到
        val PERMISSION_FAILED = -986; // 没有权限
        val NOT_IMPLEMENTION = -985; // 等待实现
        val ACTION_NOT_FOUND = -984; // 没有找到动作
        val TARGET_EXISTS = -983; // 已经存在
        val STATE_FAILED = -982; // 状态错误
        val UPLOAD_FAILED = -981; // 上传失败
        val MASK_WORD = -980; // 有敏感词
        val SELF_ACTION = -979; // 针对自己进行操作
        val PASS_FAILED = -978; // 验证码匹配失败
        val OVERFLOW = -977; // 数据溢出
        val AUTH_EXPIRED = -976; // 授权过期
        val SIGNATURE_ERROR = -975; // 签名错误
        val FORMAT_ERROR = -974; // 格式错误
        val CONFIG_ERROR = -973; // 配置错误
        val PRIVILEGE_ERROR = -972; // 权限错误
        val LIMIT = -971; // 受到限制
        val PAGED_OVERFLOW = -970; // 超出分页数据的处理能力
        val NEED_ITEMS = -969; // 需要额外物品
        val DECODE_ERROR = -968; // 解码失败
        val ENCODE_ERROR = -967; // 编码失败

        val IM_CHECK_FAILED = -899; // IM检查输入的参数失败
        val IM_NO_RELEATION = -898; // IM检查双方不存在关系

        val SOCK_WRONG_PORTOCOL = -860; // SOCKET请求了错误的通讯协议
        val SOCK_AUTH_TIMEOUT = -859; // 因为连接后长期没有登录，所以服务端主动断开了链接
        val SOCK_SERVER_CLOSED = -858; // 服务器关闭

        val SECURITY_FAILED = -6; // 检测到安全问题
        val THIRD_FAILED = -5; // 第三方出错
        val MULTIDEVICE = -4; // 多端登陆
        val HFDENY = -3; // 高频调用被拒绝（之前的访问还没有结束) high frequency deny
        val TIMEOUT = -2; // 超时
        val FAILED = -1; // 一般失败
        val OK = 0; // 成功
    }
}
