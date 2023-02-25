/*
   nscursor.m

   Simple application to test NSCursor class.

   Copyright (C) 1997 Free Software Foundation, Inc.

   Author:  Scott Christley <scottc@net-community.com>
   Date: February 1997
   Author:  Felipe A. Rodriguez <far@ix.netcom.com>
   Date: November 1998

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

#import <AppKit/AppKit.h>
#import <Foundation/NSAutoreleasePool.h>
#include "ColorView.h"

@interface nscursorController : NSObject
@end

@implementation nscursorController

- (void) applicationDidFinishLaunching: (NSNotification *)aNotification
{
  NSWindow *win;
  NSView *v;
  NSColorWell *c;
  NSRect cf = {{10, 10}, {150, 100}};
  NSRect wf0 = {{150, 150}, {300, 300}};
  NSColor *green;
  NSCursor *cur;
  NSCursor *arrow, *beam;
  ColorView *cv0;
  NSRect cvf0 = {{10, 120}, {150, 100}};
  NSImage *image;

  green = [NSColor greenColor];
  win = [[NSWindow alloc] init];
  //  [win setBackgroundColor: green];
  v = [win contentView];

  c = [[NSColorWell alloc] initWithFrame: cf];
  [c setColor: green];
  //  [c setColor:[NSColor whiteColor]];
  [v addSubview: c];
  cv0 = [[ColorView alloc] initWithFrame: cvf0];
  [cv0 setColor: [NSColor blueColor]];
  //  [cv0 setFrameRotation:30];
  [v addSubview: cv0];

  // Cursor for color view
  image = [[NSImage alloc] initWithContentsOfFile: @"Smiley.tiff"];
  cur = [[NSCursor alloc] initWithImage: image];
  RELEASE(image);
  [cv0 setCursor: cur];

  // Cursor for color well using tracking rectangle
  arrow = [[NSCursor arrowCursor] retain];
  [arrow setOnMouseExited: YES];
  beam = [[NSCursor IBeamCursor] retain];
  [beam setOnMouseEntered: YES];
  [v addTrackingRect: cf owner: arrow userData: NULL assumeInside: YES];
  [v addTrackingRect: cf owner: beam userData: NULL assumeInside: YES];

  [win setFrame: wf0 display: YES];
  [win setTitle: @"GNUstep Cursor Management"];
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
  [theApp setDelegate: [nscursorController new]];
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
