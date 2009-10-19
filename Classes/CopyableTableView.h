//
//  CopyableTableView.h
//  CopyableTableView
//
//  Created by Alex Pretzlav on 10/18/09.
//  Copyright 2009 Alex Pretzlav. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface CopyableTableView : UITableView {
  BOOL showingEditMenu;
}

@property (assign, nonatomic) BOOL showingEditMenu;

@end
