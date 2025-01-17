#include <Foundation/NSRunLoop.h>
#include <Foundation/NSData.h>
#include <Foundation/NSArray.h>
#include <Foundation/NSAutoreleasePool.h>
#include <Foundation/NSGeometry.h>
#include <AppKit/NSPasteboard.h>
#include <AppKit/NSApplication.h>

@interface	pbOwner : NSObject
{
}
- (void) pasteboard: (NSPasteboard *)pb provideDataForType: (NSString *)type;
@end

@implementation	pbOwner
- (void) pasteboard: (NSPasteboard *)pb provideDataForType: (NSString *)type
{
  if ([type isEqual: NSFileContentsPboardType])
    {
      NSString	*s = [pb stringForType: NSStringPboardType];

      if (s)
        {
          const char	*ptr;
          int		len;
          NSData		*d;

          ptr = [s cString];
          len = strlen(ptr);
          d = [NSData dataWithBytes: ptr length: len];
          [pb setData: d forType: type];
        }
    }
}
@end

int
main(int argc, char **argv)
{
  NSPasteboard	*pb;
  NSArray	*types;
  NSData	*d;
  NSApplication *theApp;
  pbOwner	*owner = [pbOwner new];

  ENTER_POOL
#if LIB_FOUNDATION_LIBRARY
  [NSProcessInfo initializeWithArguments: argv count: argc environment: env];
#endif

  theApp = [NSApplication sharedApplication];
  [theApp registerServicesMenuSendTypes: [NSArray arrayWithObject: NSStringPboardType]
                            returnTypes: [NSArray arrayWithObject: NSStringPboardType]];

  [NSObject enableDoubleReleaseCheck: YES];

  types = [NSArray arrayWithObjects:
                   NSStringPboardType, NSFileContentsPboardType, nil];
  pb = [NSPasteboard generalPasteboard];
  [pb declareTypes: types owner: owner];
  [pb setString: @"This is a test" forType: NSStringPboardType];
  d = [pb dataForType: NSFileContentsPboardType];
  printf("%.*s\n", [d length], [d bytes]);

  pb = [NSPasteboard pasteboardWithUniqueName];
  types = [NSArray arrayWithObjects:
                   NSStringPboardType, nil];
  [pb declareTypes: types owner: owner];
  [pb setString: @"a lowercase test string" forType: NSStringPboardType];
  if (NSPerformService(@"To upper", pb) == NO)
    {
      printf("Failed to perform 'To upper' service\n");
    }
  else
    {
      NSString	*result = [pb stringForType: NSStringPboardType];

      printf("To upper - result - '%s'\n", [result cString]);
    }
  LEAVE_POOL
  exit(0);
}


