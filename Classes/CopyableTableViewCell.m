//
//  CopyableTableViewCell.m
//  CopyableTableView
//
//  Created by Alex Pretzlav on 10/18/09.
//  Copyright 2009 Alex Pretzlav. All rights reserved.
//

#import "CopyableTableViewCell.h"


@implementation CopyableTableViewCell

@synthesize delegate;

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated {
  if (delegate)
    [delegate copyableTableViewCell:self willHighlight:highlighted];
  [super setHighlighted:highlighted animated:animated];
}

- (BOOL)canBecomeFirstResponder {
  return YES;
}

- (BOOL)canPerformAction:(SEL)action withSender:(id)sender {
  if (action == @selector(copy:)) {
    return YES;
  } else {
    return NO;
  }
}

- (void)copy:(id)sender {
  UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
  [pasteboard setString:self.textLabel.text];
}

- (void)dealloc {
    [super dealloc];
}


@end
