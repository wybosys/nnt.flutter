part of nnt.core;

class STATUS {
  static const UNKNOWN = -1000;
  static const EXCEPTION = -999; // 遇到了未处理的异常
  static const ROUTER_NOT_FOUND = -998; // 没有找到路由
  static const CONTEXT_LOST = -997; // 上下文丢失
  static const MODEL_ERROR = -996; // 恢复模型失败
  static const PARAMETER_NOT_MATCH = -995; // 参数不符合要求
  static const NEED_AUTH = -994; // 需要登陆
  static const TYPE_MISMATCH = -993; // 参数类型错误
  static const FILESYSTEM_FAILED = -992; // 文件系统失败
  static const FILE_NOT_FOUND = -991; // 文件不存在
  static const ARCHITECT_DISMATCH = -990; // 代码不符合标准架构
  static const SERVER_NOT_FOUND = -989; // 没有找到服务器
  static const LENGTH_OVERFLOW = -988; // 长度超过限制
  static const TARGET_NOT_FOUND = -987; // 目标对象没有找到
  static const PERMISSIO_FAILED = -986; // 没有权限
  static const WAIT_IMPLEMENTION = -985; // 等待实现
  static const ACTION_NOT_FOUND = -984; // 没有找到动作
  static const TARGET_EXISTS = -983; // 已经存在
  static const STATE_FAILED = -982; // 状态错误
  static const UPLOAD_FAILED = -981; // 上传失败
  static const MASK_WORD = -980; // 有敏感词
  static const SELF_ACTION = -979; // 针对自己进行操作
  static const PASS_FAILED = -978; // 验证码匹配失败
  static const OVERFLOW = -977; // 数据溢出
  static const AUTH_EXPIRED = -976; // 授权过期
  static const SIGNATURE_ERROR = -975; // 签名错误
  static const FORMAT_ERROR = -974; // 返回的数据格式错误
  static const CONFIG_ERROR = -973; // 配置错误
  static const PRIVILEGE_ERROR = -972; // 权限错误
  static const LIMIT = -971; // 受到限制
  static const PAGED_OVERFLOW = -970; // 超出分页数据的处理能力
  static const NEED_ITEMS = -969; // 需要额外物品
  static const DECODE_ERROR = -968; // 解码错误
  static const ENCODE_ERROR = -967; // 编码错误

  static const IM_CHECK_FAILED = -899; // IM检查输入的参数失败
  static const IM_NO_RELEATION = -898; // IM检查双方不存在关系

  static const SOCK_WRONG_PORTOCOL = -860; // SOCKET请求了错误的通讯协议
  static const SOCK_AUTH_TIMEOUT = -859; // 因为连接后长期没有登录，所以服务端主动断开了链接
  static const SOCK_SERVER_CLOSED = -858; // 服务器关闭

  static const THIRD_FAILED = -5; // 第三方出错
  static const MULTIDEVICE = -4; // 多端登陆
  static const HFDENY = -3; // 高频调用被拒绝（之前的访问还没有结束) high frequency deny
  static const TIMEOUT = -2; // 超时
  static const FAILED = -1; // 一般失败
  static const OK = 0; // 成功
}
