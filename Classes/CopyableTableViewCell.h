//
//  CopyableTableViewCell.h
//  CopyableTableView
//
//  Created by Alex Pretzlav on 10/18/09.
//  Copyright 2009 Alex Pretzlav. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CopyableTableViewCell;

@protocol CopyableTableViewCellDelegate
- (void)copyableTableViewCell:(CopyableTableViewCell *)copyableTableViewCell willBecomeHighlighted:(BOOL)highlighted;
@end


@interface CopyableTableViewCell : UITableViewCell {
  id<CopyableTableViewCellDelegate> delegate;
}

@property (assign, nonatomic) id<CopyableTableViewCellDelegate> delegate;

@end
