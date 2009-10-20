//
//  CopyableTableViewController.m
//  CopyableTableView
//
//  Created by Alex Pretzlav on 10/18/09.
//  Copyright 2009 Alex Pretzlav. All rights reserved.
//

#import "CopyableTableViewController.h"

@interface CopyableTableViewController (Private)
- (void)menuControllerWillHide:(NSNotification *)notification;
- (void)menuControllerWillShow:(NSNotification *)notification;
- (void)menuControllerDidShow:(NSNotification *)notification;
@end



@implementation CopyableTableViewController

- (void)loadView {
  [super loadView];
  self.title = @"Example Table View";
  cellValues = [[NSMutableArray alloc] initWithObjects:@"(555) 555-5555", @"Joe Schmoe", @"10:00am - 4:00pm", nil];
  alertView = [[UIAlertView alloc] init];
  alertView.cancelButtonIndex = [alertView addButtonWithTitle:@"Cancel"];
}

- (void)viewDidLoad {
  [super viewDidLoad];
  [[NSNotificationCenter defaultCenter] addObserver:self 
                                           selector:@selector(menuControllerWillHide:)
                                               name:UIMenuControllerWillHideMenuNotification
                                             object:nil];
  [[NSNotificationCenter defaultCenter] addObserver:self 
                                           selector:@selector(menuControllerWillShow:)
                                               name:UIMenuControllerWillShowMenuNotification
                                             object:nil];
  [[NSNotificationCenter defaultCenter] addObserver:self 
                                           selector:@selector(menuControllerDidShow:)
                                               name:UIMenuControllerDidShowMenuNotification
                                             object:nil];
}

- (void)viewDidUnload {
  [[NSNotificationCenter defaultCenter] removeObserver:self];
  [super viewDidUnload];
}

- (void)showSelectMenuForCell:(CopyableTableViewCell *)cell {
  if ([cell isHighlighted]) {
    UIMenuController *sharedMenu = [UIMenuController sharedMenuController];
    [cell becomeFirstResponder];
    [sharedMenu setTargetRect:cell.frame inView:self.view];
    [sharedMenu setMenuVisible:YES animated:YES];
    // Select cell so it doesn't become un-highlighted if finger moves off it while showing edit menu
    [self.tableView selectRowAtIndexPath:[self.tableView indexPathForCell:cell] animated:NO scrollPosition:UITableViewScrollPositionNone];
  }
}

- (void)dealloc {
  [self viewDidUnload];
  [alertView release];
  [cellValues release];
  [super dealloc];
}

#pragma mark Notification Handlers

- (void)menuControllerWillHide:(NSNotification *)notification {
  _showingEditMenu = NO;
  [self.tableView deselectRowAtIndexPath:[self.tableView indexPathForSelectedRow] animated:YES];
}
   
- (void)menuControllerWillShow:(NSNotification *)notification {
  _showingEditMenu = YES;
  self.tableView.scrollEnabled = NO;
}

- (void)menuControllerDidShow:(NSNotification *)notification {
  self.tableView.scrollEnabled = YES;
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
  // Don't act in response to cell tap or deselect cell if showing edit menu
  if (_showingEditMenu) {
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

