//
//  CopyableTableViewAppDelegate.m
//  CopyableTableView
//
//  Created by Alex Pretzlav on 10/18/09.
//  Copyright Alex Pretzlav 2009. All rights reserved.
//

#import "CopyableTableViewAppDelegate.h"

@implementation CopyableTableViewAppDelegate

- (void)applicationDidFinishLaunching:(UIApplication *)application {    
  window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
  CopyableTableViewController *rootViewController = [[CopyableTableViewController alloc] initWithStyle:UITableViewStyleGrouped];
  rootNavigationController = [[UINavigationController alloc] initWithRootViewController:rootViewController];
  [rootViewController release];
  
  [window addSubview:rootNavigationController.view];
  [window makeKeyAndVisible];
}


- (void)dealloc {
  [rootNavigationController release];
  [window release];
  [super dealloc];
}


@end
