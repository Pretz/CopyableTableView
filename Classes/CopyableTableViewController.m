//
//  CopyableTableViewController.m
//  CopyableTableView
//
//  Created by Alex Pretzlav on 10/18/09.
//  Copyright 2009 Alex Pretzlav. All rights reserved.
//

#import "CopyableTableViewController.h"


@implementation CopyableTableViewController

@synthesize tableView=copyableTableView;

- (void)loadView {
  copyableTableView = [[CopyableTableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
  copyableTableView.delegate = self;
  copyableTableView.dataSource = self;
  self.view = copyableTableView;
  cellValues = [[NSMutableArray alloc] initWithObjects:@"(555) 555-5555", @"Joe Schmoe", @"10:00am - 4:00pm", nil];
  self.title = @"Example Table View";
  alertView = [[UIAlertView alloc] init];
  alertView.cancelButtonIndex = [alertView addButtonWithTitle:@"Cancel"];
}

- (void)showSelectMenuForCell:(CopyableTableViewCell *)cell {
  if ([cell isHighlighted]) {
    UIMenuController *sharedMenu = [UIMenuController sharedMenuController];
    [cell becomeFirstResponder];
    [sharedMenu setTargetRect:cell.frame inView:self.view];
    [sharedMenu setMenuVisible:YES animated:YES];
    copyableTableView.showingEditMenu = YES;
    self.tableView.scrollEnabled = NO;
    // Select cell so it doesn't become un-highlighted if finger moves off it while showing edit menu
    [self.tableView selectRowAtIndexPath:[self.tableView indexPathForCell:cell] animated:NO scrollPosition:UITableViewScrollPositionNone];
  }
}

- (void)dealloc {
  [copyableTableView release];
  [alertView release];
  [cellValues release];
  [super dealloc];
}

#pragma mark Table view methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  return [cellValues count];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  
  static NSString *CellIdentifier = @"CopyableTableViewCell";
  
  CopyableTableViewCell *cell = (CopyableTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
  if (cell == nil) {
    cell = [[[CopyableTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault 
                                         reuseIdentifier:CellIdentifier] autorelease];
  }
  cell.delegate = self;
  cell.textLabel.text = [cellValues objectAtIndex:indexPath.section];
  
  return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  if (copyableTableView.showingEditMenu) {
    // Don't act in response to cell tap or deselect cell if showing edit menu
    return;
  }
  // Handle any cell selection action here: make phone call, push navigation controller, etc.
  alertView.message = [NSString stringWithFormat:@"You pressed %@!", [cellValues objectAtIndex:indexPath.section]];
  [alertView show];
  // Deselect cell after tapping
  [[self.tableView cellForRowAtIndexPath:indexPath] setSelected:NO animated:YES];
}

#pragma mark Delegates (CopyableTableViewCell)

- (void)copyableTableViewCell:(CopyableTableViewCell *)copyableTableViewCell willBecomeHighlighted:(BOOL)highlighted {
  if (highlighted)
    [self performSelector:@selector(showSelectMenuForCell:) withObject:copyableTableViewCell afterDelay:0.3];
}

@end

