/* CalcBrain.h: Brain of Calculator.app

   Copyright (C) 1999 Free Software Foundation, Inc.

   Author:  Nicola Pero <n.pero@mi.flashnet.it>
   Date: 1999

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
#include "CalcTypes.h"
@class CalcFace;

@interface CalcBrain : NSObject
{
  CalcFace *face;
  double result;
  double enteredNumber;
  calcOperation operation;
  int fractionalDigits;
  BOOL decimalSeparator;
  BOOL editing;
}
// Set the corresponding face
- (void) setFace: (CalcFace *)aFace;
// The various buttons
- (void) clear: (id)sender;
- (void) equal: (id)sender;
- (void) digit: (id)sender;
- (void) decimalSeparator: (id)sender;
- (void) operation: (id)sender;
- (void) squareRoot: (id)sender;
// Jump here on calculation errors
- (void) error;
@end

