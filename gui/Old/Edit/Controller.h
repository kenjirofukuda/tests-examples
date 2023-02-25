#import <Foundation/Foundation.h>
#import <AppKit/AppKit.h>
#include <AppKit/NSDocumentController.h>

@interface Controller : NSDocumentController
{
  id infoPanel;
}

/* NSApplication delegate methods */
- (BOOL) application: (NSApplication *)app openFile: (NSString *)filename;
- (BOOL) application: (NSApplication *)app openTempFile: (NSString *)filename;
- (BOOL) applicationOpenUntitledFile: (NSApplication *)app;
- (BOOL) applicationShouldTerminate: (NSApplication *)app;

/* Action methods */
- (void) createNew: (id)sender;
- (void) open: (id)sender;
- (void) saveAll: (id)sender;
- (void) showInfoPanel: (id)sender;

/* Outlet methods */
- (void) setVersionField: (id)anObject;	/* Fake; there's no outlet */

- (void) method: menuCell;							// temp for sake of menu

@end
