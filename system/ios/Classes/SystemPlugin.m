#import "SystemPlugin.h"
#import <system/system-Swift.h>

@implementation SystemPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftSystemPlugin registerWithRegistrar:registrar];
}
@end
