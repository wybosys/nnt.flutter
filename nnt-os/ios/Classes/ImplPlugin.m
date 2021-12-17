#import "ImplPlugin.h"
#import <impl/impl-Swift.h>

@implementation ImplPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftImplPlugin registerWithRegistrar:registrar];
}
@end
