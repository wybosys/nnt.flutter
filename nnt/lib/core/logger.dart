part of nnt.core;

// 基础的日志管理器
class Logger {
  log(String msg) {
    print(msg);
  }

  warn(String msg) {
    print(msg);
  }

  fatal(String msg) {
    print(msg);
  }
}

final Logger logger = new Logger();
