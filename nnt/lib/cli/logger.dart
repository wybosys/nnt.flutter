part of nnt.cli;

// 打印于控制台的日志
class CliLogger extends Logger {
  @override
  log(String msg) {
    print(msg);
  }
}
