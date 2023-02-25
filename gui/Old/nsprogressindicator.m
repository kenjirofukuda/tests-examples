/*
   nsprogressindicator.m

   Copyright (C) 1999 Free Software Foundation, Inc.

   Author: Gerrit van Dyk <gerritvd@decimax.com>
   Date: September 1999

   This file is part of the GNUstep GUI Library.

   This library is free software; you can redistribute it and/or
   modify it under the terms of the GNU Library General Public
   License as published by the Free Software Foundation; either
   version 2 of the License, or (at your option) any later version.

   This library is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
   Library General Public License for more details.

   You should have received a copy of the GNU Library General Public
   License along with this library; if not, write to the Free
   Software Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
*/

#include <Foundation/NSAutoreleasePool.h>
#include <AppKit/AppKit.h>

@interface MyObject : NSObject
{
  NSProgressIndicator	*horInd, *verInd;
}

- (id) initWithHorIndicator: (NSProgressIndicator *)aHorInd
               verIndicator: (NSProgressIndicator *)aVerInd;
- (void) doProgress;

@end

int
main(int argc, char **argv, char **env)
{
  NSApplication *theApp;
  NSWindow *window;
  NSProgressIndicator	*horInd, *verInd;
  NSMenu	*menu;
  MyObject	*trigger;
  NSRect winRect = {{100, 100}, {300, 150}};
  NSRect horIndRect = {{40, 60}, {250, 30}};
  NSRect verIndRect = {{10, 10}, {20, 130}};
  id target;

  ENTER_POOL
#if LIB_FOUNDATION_LIBRARY
  [NSProcessInfo initializeWithArguments: argv count: argc environment: env];
#endif

  theApp = [NSApplication sharedApplication];

#if 0
  window = [[NSWindow alloc]
            initWithContentRect: winRect
                      styleMask: style
                        backing: NSBackingStoreNonretained
                          defer: NO];
#else
  window = [[NSWindow alloc] init];
#endif

  [window setFrame: winRect display: YES];

  target = AUTORELEASE([MyObject new]);

  horInd = AUTORELEASE([[NSProgressIndicator alloc] initWithFrame: horIndRect]);
  verInd = AUTORELEASE([[NSProgressIndicator alloc] initWithFrame: verIndRect]);
  [[window contentView] addSubview: horInd];
  [[window contentView] addSubview: verInd];
  trigger = [[MyObject alloc] initWithHorIndicator: horInd
                                      verIndicator: verInd];

  menu = [NSMenu new];
  [menu addItemWithTitle: @"Quit the Test" action: @selector(terminate:)
           keyEquivalent: @"q"];

  [theApp setMainMenu: menu];
  [menu setTitle: @"Test"];
  [menu update];
  [menu display];

  [window orderFrontRegardless];

  [theApp run];
  RELEASE(trigger);
  LEAVE_POOL
  return 0;
}

@implementation MyObject :
NSObject

- (id) initWithHorIndicator: (NSProgressIndicator *)aHorIndicator
               verIndicator: (NSProgressIndicator *)aVerIndicator
{
  self = [self init];
  horInd = [aHorIndicator retain];
  verInd = [aVerIndicator retain];
  [horInd setIndeterminate: NO];
  [verInd setIndeterminate: NO];
  [verInd setVertical: YES];
  [verInd setMinValue: 100];
  [verInd setMaxValue: 700];
  [self performSelector: @selector(doProgress)
             withObject: nil
             afterDelay: 1.0];
  return self;
}

- (void) dealloc
{
  RELEASE(horInd);
  RELEASE(verInd);
  DEALLOC
}

- (void) doProgress
{
  int	i;

  for (i = 0; i < 100; i++)
    {
      [horInd incrementBy: 1.0];
      [horInd displayIfNeeded];
    }
  for (i = 0; i < 200; i++)
    {
      [verInd incrementBy: 3.0];
      [verInd displayIfNeeded];
    }
}

@end
