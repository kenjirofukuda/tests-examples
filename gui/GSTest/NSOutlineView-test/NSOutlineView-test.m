/* NSOutlineView-test.m: NSOutlineView Class Demo/Test

   Copyright (C) 1999 Free Software Foundation, Inc.

   Author:  Gregory John Casamento <greg_casamento@yahoo.com>
   Date:  Feb 2002
   
   Based on Nicola's test for NSTableView...

   This file is part of GNUstep.
   
   This program is free software; you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation; either version 2 of the License, or
   (at your option) any later version.
   
   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.
   
   You should have received a copy of the GNU General Public License
   along with this program; if not, write to the Free Software
   Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA. */

#include <Foundation/Foundation.h>
#include <AppKit/AppKit.h>
#include <AppKit/GSVbox.h>
#include "../GSTestProtocol.h"

// Something to show in the table
NSString *keys[20] = 
{ 
  @"NSObject",
  @"NSApplication",
  @"NSResponder", 
  @"NSWindow",
  @"NSPanel"
}; 
NSString *values[20] = 
{ 
  @"Nicola Pero <n.pero@mi.flashnet.it>",
  @"Nicola Pero <n.pero@mi.flashnet.it>",
  @"richard@brainstorm.co.uk",
  @"ettore@helixcode.com",
  @"greg_casamento@yahoo.com"
};

NSString *test[20] = 
{ 
  @"Other info (1)",
  @"Other info (2)",
  @"Other info (3)",
  @"Other info (4)",
  @"Other info (5)"
};
//
@interface NSOutlineViewTest: NSObject <GSTest>
{
  NSWindow *win;
}
-(void) restart;
@end

@implementation NSOutlineViewTest: NSObject

-(id) init
{
  NSBox *externalBox;
  NSOutlineView *outlineView;
  NSRect winFrame;
  NSTableColumn *keyColumn;
  NSTableColumn *valueColumn;  
  NSTableColumn *testColumn;
  NSTableColumn *tb;
  NSScrollView *scrollView;
  int i;
  NSString *string;

  keyColumn = [[NSTableColumn alloc] initWithIdentifier: @"classes"];
  AUTORELEASE (keyColumn);
  [keyColumn setEditable: NO];
  [[keyColumn headerCell] setStringValue: @"classes"];
  [keyColumn setMinWidth: 100];

  valueColumn = [[NSTableColumn alloc] initWithIdentifier: @"outlets"];
  AUTORELEASE (valueColumn);
  [valueColumn setEditable: NO];
  [[valueColumn headerCell] setStringValue: @"outlets"];
  [valueColumn setMinWidth: 100];

  testColumn = [[NSTableColumn alloc] initWithIdentifier: @"actions"];
  AUTORELEASE (testColumn);
  [testColumn setEditable: NO];
  [[testColumn headerCell] setStringValue: @"actions"];
  [testColumn setMinWidth: 100];

  outlineView = [[NSOutlineView alloc] 
		 initWithFrame: NSMakeRect (0, 0, 300, 300)];
  [outlineView addTableColumn: keyColumn];
  [outlineView addTableColumn: valueColumn];
  [outlineView addTableColumn: testColumn];
  [outlineView setOutlineTableColumn: keyColumn];
  [outlineView setDrawsGrid: NO];
  [outlineView setIndentationPerLevel: 10];
  [outlineView setAutoresizesOutlineColumn: YES];
  [outlineView setIndentationMarkerFollowsCell: YES];

  /* Now add some more columns */
  for (i = 0; i < 5; i++)
    {
      string = [NSString stringWithFormat: @"Column %d", i];
      tb = AUTORELEASE ([[NSTableColumn alloc] initWithIdentifier: string]);
      [tb setEditable: NO];
      [[tb headerCell] setStringValue: string];
      [outlineView addTableColumn: tb];
    }
  [outlineView setDataSource: self];
  [outlineView setDelegate: self];

  scrollView = [[NSScrollView alloc] 
		 initWithFrame: NSMakeRect (0, 0, 300, 200)];
  [scrollView setDocumentView: outlineView];
  RELEASE (outlineView);
  [scrollView setHasHorizontalScroller: YES];
  [scrollView setHasVerticalScroller: YES];
  [scrollView setBorderType: NSBezelBorder];
  [scrollView setAutoresizingMask: (NSViewWidthSizable 
				    | NSViewHeightSizable)];
	 
  [outlineView sizeToFit];

  externalBox = [NSBox new];
  [externalBox setTitlePosition: NSNoTitle];
  [externalBox setBorderType: NSNoBorder];
  [externalBox addSubview: scrollView];
  RELEASE (scrollView);
  [externalBox sizeToFit];
  [externalBox setAutoresizingMask: (NSViewWidthSizable 
				     | NSViewHeightSizable)];
  
  winFrame.size = [externalBox frame].size;
  winFrame.origin = NSMakePoint (100, 200);
  
  win = [[NSWindow alloc] initWithContentRect: winFrame
			  styleMask: (NSTitledWindowMask 
				      | NSClosableWindowMask 
				      | NSMiniaturizableWindowMask 
				      | NSResizableWindowMask)
			  backing: NSBackingStoreBuffered
			  defer: NO];
  
  [win setReleasedWhenClosed: NO];
  [win setContentView: externalBox];
  RELEASE (externalBox);
  [win setTitle: @"NSOutlineView Test"];
  
  [self restart];
  return self;
}

-(void) restart
{
  [win orderFront: nil]; 
  [[NSApplication sharedApplication] addWindowsItem: win
				     title: @"NSOutlineView Test"
				     filename: NO];
}

// required methods for data source
- (id)outlineView: (NSOutlineView *)outlineView
	    child: (int)index
	   ofItem: (id)item
{
  //  NSLog(@"child: %d ofItem: %@", index, item);
  if([item isEqual: @"NSObject"])
    {
      switch(index)
	{
	case 1:
	  return @"NSApplication";
	  break;
	case 2:
	  return @"NSPanel";
	  break;
	case 3:
	  return @"NSWindow";
	  break;
	case 4:
	  return @"NSOutlineView";
	  break;
	default:
	  break;
	}
    }
  if([item isEqual: @"NSPanel"])
    {
      switch(index)
	{
	case 1:
	  return @"class1";
	  break;
	case 2:
	  return @"class2";
	  break;
	case 3:
	  return @"class3";
	  break;
	case 4:
	  return @"class4";
	  break;
	default:
	  break;
	}
    }
  else
    if(item == nil)
      {
	if(index == 1)
	  return @"NSObject";
      }

  return nil;
}

- (BOOL)outlineView: (NSOutlineView *)outlineView
   isItemExpandable: (id)item
{
  NSLog(@"isItemExpandable:....");
  if([item isEqual: @"NSObject"])
    return YES;
  if([item isEqual: @"NSPanel"])
    return YES;

  return NO;
}

- (int)        outlineView: (NSOutlineView *)outlineView 
    numberOfChildrenOfItem: (id)item
{
  //  NSLog(@"numberOfChildren:....");
  if(item == nil)
    return 1;
  else
    if([item isEqual: @"NSObject"])
      return 4;
  else
    if([item isEqual: @"NSPanel"])
      return 4;

  return 0;
}

- (id)         outlineView: (NSOutlineView *)outlineView 
 objectValueForTableColumn: (NSTableColumn *)tableColumn 
		    byItem: (id)item
{
  NSString *value = nil;
  //  NSLog(@"item = %@", item);
  if([item isEqual: @"NSObject"])
    {
      if([[[tableColumn headerCell] stringValue] isEqual: @"classes"])
	{
	  value = @"NSObject";
	}
      else
      if([[[tableColumn headerCell] stringValue] isEqual: @"outlets"])
	{
	  value = @"1";
	}
      else
      if([[[tableColumn headerCell] stringValue] isEqual: @"actions"])
	{
	  value = @"2";
	}
    }
  if([item isEqual: @"NSApplication"])
    {
      if([[[tableColumn headerCell] stringValue] isEqual: @"classes"])
	{
	  value = @"NSApplication";
	}
      else
      if([[[tableColumn headerCell] stringValue] isEqual: @"outlets"])
	{
	  value = @"2";
	}
      else
      if([[[tableColumn headerCell] stringValue] isEqual: @"actions"])
	{
	  value = @"3";
	}
    }
  if([item isEqual: @"NSPanel"])
    {
      if([[[tableColumn headerCell] stringValue] isEqual: @"classes"])
	{
	  value = @"NSPanel";
	}
      else
      if([[[tableColumn headerCell] stringValue] isEqual: @"outlets"])
	{
	  value = @"2";
	}
      else
      if([[[tableColumn headerCell] stringValue] isEqual: @"actions"])
	{
	  value = @"3";
	}
    }
  if([item isEqual: @"NSWindow"])
    {
      if([[[tableColumn headerCell] stringValue] isEqual: @"classes"])
	{
	  value = @"NSWindow";
	}
      else
      if([[[tableColumn headerCell] stringValue] isEqual: @"outlets"])
	{
	  value = @"3";
	}
      else
      if([[[tableColumn headerCell] stringValue] isEqual: @"actions"])
	{
	  value = @"5";
	}
    }
  if([item isEqual: @"NSOutlineView"])
    {
      if([[[tableColumn headerCell] stringValue] isEqual: @"classes"])
	{
	  value = @"NSOutlineView";
	}
      else
      if([[[tableColumn headerCell] stringValue] isEqual: @"outlets"])
	{
	  value = @"4";
	}
      else
      if([[[tableColumn headerCell] stringValue] isEqual: @"actions"])
	{
	  value = @"6";
	}
    }
  
  if([item isEqual: @"class1"] ||
     [item isEqual: @"class2"] ||
     [item isEqual: @"class3"] ||
     [item isEqual: @"class4"])
    {
      if([[[tableColumn headerCell] stringValue] isEqual: @"classes"])
	{
	  value = item;
	}
      else
      if([[[tableColumn headerCell] stringValue] isEqual: @"outlets"])
	{
	  value = @"2";
	}
      else
      if([[[tableColumn headerCell] stringValue] isEqual: @"actions"])
	{
	  value = @"3";
	}
    }

  return value;
}

// delegate methods
- (BOOL) outlineView: (NSOutlineView *)aTableView 
     willDisplayCell: (id)aCell 
      forTableColumn: (NSTableColumn *)aTableColumn
		item: (id)item
{
  NSLog(@"outlineView:willDisplayCell:forTableColumn:item:");
  return YES;
}

- (BOOL) outlineView: (NSOutlineView *)anOutlineView
    shouldSelectItem: (id)item
{
  NSLog(@"should select item....");
  return YES;
}
@end
