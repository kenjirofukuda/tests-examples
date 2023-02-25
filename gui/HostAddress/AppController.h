/*
 * AppController.h created by phr on 2000-08-27 11:38:59 +0000
 *
 * Project TestApp
 *
 * Created with ProjectCenter - http://www.projectcenter.ch
 *
 * $Id$
 */

#import <AppKit/AppKit.h>

@class Resolver;

@interface AppController : NSObject
{
  Resolver *resolver;
}

+ (void) initialize;

- (id) init;
- (void) dealloc;

- (void) awakeFromNib;

- (void) applicationDidFinishLaunching: (NSNotification *)notif;

- (BOOL) applicationShouldTerminate: (id)sender;
- (void) applicationWillTerminate: (NSNotification *)notification;

- (BOOL) application: (NSApplication *)application openFile: (NSString *)fileName;

- (void) showPrefPanel: (id)sender;
- (void) showInfoPanel: (id)sender;

- (void) showResolverWindow: (id)sender;

@end
