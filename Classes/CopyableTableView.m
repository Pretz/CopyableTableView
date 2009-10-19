//
//  CopyableTableView.m
//  CopyableTableView
//
//  Created by Alex Pretzlav on 10/18/09.
//  Copyright 2009 Alex Pretzlav. All rights reserved.
//

#import "CopyableTableView.h"


@implementation CopyableTableView

@synthesize showingEditMenu;


- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
  if (showingEditMenu) {
    showingEditMenu = NO;
    self.scrollEnabled = YES;
    NSIndexPath *selectedRow = [self indexPathForSelectedRow];
    if (selectedRow) {
      [[self cellForRowAtIndexPath:selectedRow] setHighlighted:NO animated:YES];
      [[self cellForRowAtIndexPath:selectedRow] setSelected:NO animated:YES];
    }
  }
  return [super hitTest:point withEvent:event];
}

@end
