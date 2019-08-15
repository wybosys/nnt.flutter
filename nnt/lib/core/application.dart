library nnt.core;

abstract class CoreApplication {
  static CoreApplication _shared;

  CoreApplication() {
    _shared = this;
  }
}
