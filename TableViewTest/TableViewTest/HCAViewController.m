//
//  HCAViewController.m
//  TableViewTest
//
//  Created by Brian Coyner on 9/30/13.
//  Copyright (c) 2013 Brian Coyner. All rights reserved.
//

#import "HCAViewController.h"

#import "HCADynamicTableViewController.h"

@implementation HCAViewController

#pragma mark - View Life Cycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self registerTableViewCellsForTableView:[self tableView]];
    [self configureNavigationItem:[self navigationItem]];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[self demoTableViewCellIdentifier ]];
    [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    [[cell textLabel] setText:@"UITableView Memory Issue"];

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // The UITableView created by the HCADynamicTableViewController is not properly released if the
    // table view's "beginUpdates" / "endUpdates" methods are called. 
    HCADynamicTableViewController *viewController = [[HCADynamicTableViewController alloc] init];
    [[self navigationController] pushViewController:viewController animated:YES];
}

#pragma mark - UINavigationItem Configuration

- (void)configureNavigationItem:(UINavigationItem *)navigationItem
{
    [navigationItem setTitle:@"Table Issue Demo"];
}

#pragma mark - UITableViewCell Registration

- (void)registerTableViewCellsForTableView:(UITableView *)tableView
{
    [self registerDemoTableViewCellForTableView:tableView identifier:[self demoTableViewCellIdentifier]];
}

- (void)registerDemoTableViewCellForTableView:(UITableView *)tableView identifier:(NSString *)identifier
{
    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:identifier];
}

- (NSString *)demoTableViewCellIdentifier
{
    return @"HCADemoTableViewCell";
}

@end
