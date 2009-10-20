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

@interface CopyableTableViewController : UITableViewController <CopyableTableViewCellDelegate> {
  NSMutableArray *cellValues;
  UIAlertView *alertView;
  BOOL _showingEditMenu;
}

@end
