/*
   buttons.m

   All of the various NSButtons

   Copyright (C) 1996 Free Software Foundation, Inc.

   Author:  Scott Christley <scottc@net-community.com>
   Author:  Ovidiu Predescu <ovidiu@net-community.com>
   Date: June 1996
   Author:  Felipe A. Rodriguez <far@ix.netcom.com>
   Date: August 1998

   This file is part of the GNUstep GUI X/RAW Backend.

   This library is free software; you can redistribute it and/or
   modify it under the terms of the GNU Library General Public
   License as published by the Free Software Foundation; either
   version 2 of the License, or (at your option) any later version.

   This library is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
   Library General Public License for more details.

   You should have received a copy of the GNU Library General Public
   License along with this library; see the file COPYING.LIB.
   If not, write to the Free Software Foundation,
   59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
*/

#include <Foundation/NSAutoreleasePool.h>
#include <AppKit/AppKit.h>
#include <AppKit/NSPopUpButton.h>

#include "TestView.h"
#include "ColorView.h"

@interface buttonsController : NSObject
{
  NSWindow *win;
  id textField;
  id textField1;
  NSView *anotherView1;
  NSView *anotherView2;
}

@end

@implementation buttonsController

- (void) buttonAction: (id)sender
{
  NSLog(@"buttonAction:");
}

- (void) buttonAction2: (id)sender
{
  NSLog(@"buttonAction2:");
  [textField setStringValue: [sender intValue] ? @"on" : @"off"];
}

- (void) buttonSwitchView: (id)sender
{
  NSString *title;
  NSLog(@"Sender = %@", sender);

  title = [sender titleOfSelectedItem];

  NSLog(@"title value = %@, indexOfSelectedItem: %d, titleIndexOfSelectedItem: %d numItems: %d",
        title,
        [sender indexOfSelectedItem],
        [sender indexOfItem: [sender selectedItem]],
        [sender numberOfItems]);

  /*
  if ([title isEqualToString:@"Devices"])
    [[win contentView] addSubview:anotherView1];
  else
    [[win contentView] addSubview:anotherView2];
  */
}

- (void) applicationDidFinishLaunching: (NSNotification *)aNotification
{
  NSRect wf = {{100, 100}, {400, 400}};
  NSRect f = {{10, 10}, {380, 200}};
  NSPopUpButton *pushb;

  id anItem;
  unsigned int style = NSTitledWindowMask | NSClosableWindowMask
                       | NSMiniaturizableWindowMask | NSResizableWindowMask;

  win = [[NSWindow alloc] initWithContentRect: wf
                                    styleMask: style
                                      backing: NSBackingStoreRetained
                                        defer: NO];

  anotherView1 = [[NSScrollView alloc] initWithFrame: f];
  [[win contentView] addSubview: anotherView1];

  anotherView2 = [[TestView alloc] initWithFrame: f];

  pushb = [[NSPopUpButton alloc] initWithFrame: NSMakeRect(200, 375, 100, 20)];
  [pushb setTarget: self];
  [pushb setAction: @selector(buttonSwitchView:)];
  [pushb addItemWithTitle: @"Devices Pop"];
  [pushb addItemWithTitle: @"Network"];
  [pushb addItemWithTitle: @"Printers"];
  [pushb addItemWithTitle: @"Austin"];
  [pushb addItemWithTitle: @"Powers"];
  [pushb addItemWithTitle: @"Shag"];
  [[win contentView] addSubview: pushb];
  RELEASE(pushb);

  pushb = [[NSPopUpButton alloc] initWithFrame: NSMakeRect(200, 175, 100, 20)];
  [pushb setTarget: self];
  [pushb setAction: @selector(buttonSwitchView:)];
  [[win contentView] addSubview: pushb];
  RELEASE(pushb);

  /* NB: popupbuttons with images are not possible in the
  present framework */
#if 0
  pushb = [[NSPopUpButton alloc] initWithFrame: NSMakeRect(15, 275, 64, 64)];

  [pushb addItemWithTitle: @""];
  anItem = [pushb itemAtIndex: 0];
  [anItem setImage: [NSImage imageNamed: @"animations.tiff"]];

  [pushb addItemWithTitle: @""];
  anItem = [pushb itemAtIndex: 1];
  [anItem setImage: [NSImage imageNamed: @"appearance.tiff"]];

  [pushb addItemWithTitle: @""];
  anItem = [pushb itemAtIndex: 2];
  [anItem setImage: [NSImage imageNamed: @"configs.tiff"]];

  [pushb addItemWithTitle: @""];
  anItem = [pushb itemAtIndex: 3];
  [anItem setImage: [NSImage imageNamed: @"dock.tiff"]];

//  [pushb setTarget:self];
//  [pushb setAction:@selector(buttonSwitchView:)];
  [[win contentView] addSubview: pushb];
#endif

  pushb = [[NSPopUpButton alloc] initWithFrame: NSMakeRect(15, 375, 100, 20)
                                     pullsDown: YES];
  [pushb setTarget: self];
  [pushb setAction: @selector(buttonSwitchView:)];
  [pushb addItemWithTitle: @"Devices Pull"];
  [pushb addItemWithTitle: @"Network"];
  [pushb addItemWithTitle: @"Printers"];
  [pushb addItemWithTitle: @"Austin"];
  [pushb addItemWithTitle: @"Powers"];
  [pushb addItemWithTitle: @"Shag"];
  [[win contentView] addSubview: pushb];
  RELEASE(pushb);

  pushb = [[NSPopUpButton alloc] initWithFrame: NSMakeRect(15, 175, 100, 20)
                                     pullsDown: YES];
  [pushb setTarget: self];
  [pushb setAction: @selector(buttonSwitchView:)];
  [[win contentView] addSubview: pushb];
  RELEASE(pushb);

  [win display];
  [win orderFront: nil];
}

@end

int
main(int argc, char **argv, char **env)
{
  ENTER_POOL
  NSApplication *theApp;

#if LIB_FOUNDATION_LIBRARY
  [NSProcessInfo initializeWithArguments: argv count: argc environment: env];
#endif

  theApp = [NSApplication sharedApplication];
  [theApp setDelegate: [buttonsController new]];
  {
    NSMenu	*menu = [NSMenu new];

    [menu addItemWithTitle: @"Quit"
                    action: @selector(terminate:)
             keyEquivalent: @"q"];
    [NSApp setMainMenu: menu];
  }

  [theApp run];

  LEAVE_POOL

  return 0;
}
