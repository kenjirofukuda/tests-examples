/*
   menu.m

   Copyright (C) 1996 Free Software Foundation, Inc.

   Author: Ovidiu Predescu <ovidiu@net-community.com>
   Date: May 1997

   This file is part of the GNUstep GUI X/RAW Library.

   This library is free software; you can redistribute it and/or
   modify it under the terms of the GNU Library General Public
   License as published by the Free Software Foundation; either
   version 2 of the License, or (at your option) any later version.
n
   This library is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
   Library General Public License for more details.

   You should have received a copy of the GNU Library General Public
   License along with this library; if not, write to the Free
   Software Foundation, Inc., 675 Mass Ave, Cambridge, MA 02111, USA.
*/

#import <Foundation/NSAutoreleasePool.h>
#import <AppKit/AppKit.h>


@interface MyObject : NSObject
@end

@implementation MyObject
- (void) method: menuItem
{
  NSLog(@"method invoked from cell with title '%@'", [menuItem title]);
}
- (void) eepzact: menuItem
{
  [menuItem setState: [menuItem state] ? NSOffState : NSOnState];
}
@end

int
main(int argc, char **argv, char **env)
{
  NSApplication *theApp;
  NSMenu *menu;
  NSMenu *infoMenu;
  NSMenu *fileMenu;
  NSMenu *editMenu;
  NSMenu *linkMenu;
  NSMenu *findMenu;
  NSMenuItem *menuItem;

  SEL action = @selector(method:);
  SEL doEepz = @selector(eepzact:);

  ENTER_POOL
#if LIB_FOUNDATION_LIBRARY
  [NSProcessInfo initializeWithArguments: argv count: argc environment: env];
#endif

  theApp = [NSApplication sharedApplication];
  [theApp setDelegate: [MyObject new]];

  menuItem = [[NSMenuItem alloc] initWithTitle: @"Eepz"
                                        action: doEepz
                                 keyEquivalent: @"z"];
  [menuItem setState: NSOffState];

  menu = [NSMenu new];

  [menu setMenuChangedMessagesEnabled: NO];

  [menu addItemWithTitle: @"File" action: action keyEquivalent: @""];
  [menu addItemWithTitle: @"Edit" action: action keyEquivalent: @""];
  [menu addItemWithTitle: @"Format" action: action keyEquivalent: @""];
  [menu addItemWithTitle: @"Utilities" action: action keyEquivalent: @""];
  [menu addItemWithTitle: @"Windows" action: action keyEquivalent: @""];
  [menu addItemWithTitle: @"Print" action: NULL keyEquivalent: @"p"];
  [menu addItemWithTitle: @"Services" action: action keyEquivalent: @""];
  [menu addItemWithTitle: @"Hide" action: action keyEquivalent: @"h"];
  [menu insertItem: menuItem atIndex: [[menu itemArray] count]];
  [menu addItemWithTitle: @"Info" action: action keyEquivalent: @""];
  [menu addItemWithTitle: @"Quit"
                  action: @selector(terminate:)
           keyEquivalent: @"q"];

  [menu setMenuChangedMessagesEnabled: YES];

  infoMenu = [NSMenu new];
  [menu setSubmenu: infoMenu forItem: [menu itemWithTitle: @"Info"]];
  [infoMenu addItemWithTitle: @"Info Panel..." action: action keyEquivalent: @""];
  [infoMenu addItemWithTitle: @"Preferences..." action: action keyEquivalent: @""];
  [infoMenu addItemWithTitle: @"Help" action: action keyEquivalent: @"?"];

  fileMenu = [NSMenu new];
  [fileMenu addItemWithTitle: @"Open..." action: action keyEquivalent: @"o"];
  [fileMenu addItemWithTitle: @"New" action: action keyEquivalent: @"n"];
  [fileMenu addItemWithTitle: @"Save" action: action keyEquivalent: @"s"];
  [fileMenu addItemWithTitle: @"Save As..." action: action keyEquivalent: @"S"];
  [fileMenu addItemWithTitle: @"Save To..." action: action keyEquivalent: @""];
  [fileMenu addItemWithTitle: @"Save All" action: action keyEquivalent: @""];
  [fileMenu addItemWithTitle: @"Return to Saved" action: action keyEquivalent: @"u"];
  [fileMenu addItemWithTitle: @"Open Selection" action: action keyEquivalent: @"O"];
  [fileMenu addItemWithTitle: @"Open Folder..." action: action keyEquivalent: @"D"];
  [fileMenu addItemWithTitle: @"Close" action: action keyEquivalent: @""];
  [menu setSubmenu: fileMenu forItem: [menu itemWithTitle: @"File"]];

  editMenu = [NSMenu new];
  [editMenu addItemWithTitle: @"Cut" action: action keyEquivalent: @"x"];
  [editMenu addItemWithTitle: @"Copy" action: action keyEquivalent: @"c"];
  [editMenu addItemWithTitle: @"Paste" action: action keyEquivalent: @"v"];
  [editMenu addItemWithTitle: @"Link" action: action keyEquivalent: @""];
  [editMenu addItemWithTitle: @"Delete" action: action keyEquivalent: @""];
  [editMenu addItemWithTitle: @"Undelete" action: action keyEquivalent: @""];
  [editMenu addItemWithTitle: @"Find" action: action keyEquivalent: @""];
  [editMenu addItemWithTitle: @"Spelling..." action: action keyEquivalent: @":"];
  [editMenu addItemWithTitle: @"Check Spelling" action: action keyEquivalent: @";"];
  [editMenu addItemWithTitle: @"Select All" action: action keyEquivalent: @"a"];
  [menu setSubmenu: editMenu forItem: [menu itemWithTitle: @"Edit"]];

  linkMenu = [NSMenu new];
  [linkMenu addItemWithTitle: @"Paste and Link" action: action keyEquivalent: @"V"];
  [linkMenu addItemWithTitle: @"Show Links" action: action  keyEquivalent: @""];
  [linkMenu addItemWithTitle: @"Link Inspector..." action: action keyEquivalent: @""];
  [linkMenu addItemWithTitle: @"Verify Links" action: action keyEquivalent: @""];
  [editMenu setSubmenu: linkMenu forItem: [editMenu itemWithTitle: @"Link"]];

  findMenu = [NSMenu new];
  [findMenu addItemWithTitle: @"Find Panel..." action: action keyEquivalent: @"f"];
  [findMenu addItemWithTitle: @"Find Next" action: action keyEquivalent: @"g"];
  [findMenu addItemWithTitle: @"Find Previous" action: action keyEquivalent: @"d"];
  [findMenu addItemWithTitle: @"Enter Selection" action: action keyEquivalent: @"e"];
  [findMenu addItemWithTitle: @"Jump to Selection" action: action keyEquivalent: @"j"];
  [findMenu addItemWithTitle: @"Line Range..." action: action keyEquivalent: @"l"];
  [linkMenu setSubmenu: findMenu forItem: [linkMenu itemWithTitle: @"Verify Links"]];

  findMenu = [NSMenu new];
  [findMenu addItemWithTitle: @"Find Panel..." action: action keyEquivalent: @"f"];
  [findMenu addItemWithTitle: @"Find Next" action: action keyEquivalent: @"g"];
  [findMenu addItemWithTitle: @"Find Previous" action: action keyEquivalent: @"d"];
  [findMenu addItemWithTitle: @"Enter Selection" action: action keyEquivalent: @"e"];
  [findMenu addItemWithTitle: @"Jump to Selection" action: action keyEquivalent: @"j"];
  [findMenu addItemWithTitle: @"Line Range..." action: action keyEquivalent: @"l"];
  [editMenu setSubmenu: findMenu forItem: [editMenu itemWithTitle: @"Find"]];

  [[menu itemWithTitle: @"Format"] setImage: [NSImage imageNamed: @"Smiley"]];
  [[menu itemWithTitle: @"Format"] setTitle: @"Smile for me..."];
  [menu itemChanged: [menu itemWithTitle: @"Smile for me..."]];

  [theApp setMainMenu: menu];

  NSLog(@"start displaying the menu...");
  [menu update];
  [menu display];
  NSLog(@"ready!");

  [theApp run];
  LEAVE_POOL
  return 0;
}
