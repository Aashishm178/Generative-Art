#import "GenerativeArtPlugin.h"
#if __has_include(<generative_art/generative_art-Swift.h>)
#import <generative_art/generative_art-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "generative_art-Swift.h"
#endif

@implementation GenerativeArtPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftGenerativeArtPlugin registerWithRegistrar:registrar];
}
@end
