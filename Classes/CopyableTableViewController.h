//
//  CopyableTableViewController.h
//  CopyableTableView
//
//  Created by Alex Pretzlav on 10/18/09.
//  Copyright 2009 Alex Pretzlav. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CopyableTableViewCell.h"
#import "CopyableTableView.h"

@interface CopyableTableViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, CopyableTableViewCellDelegate> {
  NSMutableArray *cellValues;
  UIAlertView *alertView;
  CopyableTableView *copyableTableView;
}

@property (retain, nonatomic) CopyableTableView *tableView;

- (void)showSelectMenuForCell:(CopyableTableViewCell *)cell;

@end
