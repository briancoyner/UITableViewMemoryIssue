//
//  HCADynamicTableViewController.m
//  TableViewTest
//
//  Created by Brian Coyner on 9/30/13.
//  Copyright (c) 2013 Brian Coyner. All rights reserved.
//

#import "HCADynamicTableViewController.h"

// 1. Launch the "TableViewTest" in Instruments (any simulator)
// 2. Select the Leaks Instrument
// 3. Once the app launches filter Instruments to show "UITableView"
// - there is one UITableView instance
// 4. Tap the "UITableView Memory Issue" row in the "main" view
// - there are now two UITableView instances (good)
// 6. Tap the back button
// - there is now one UITableView instance (good)
// 7. Tap the "UITableView Memory Issue" row in the "main" view
// - there are now two UITableView instances (good)
// 8. Tap the "+" navigation bar button item
// - this executes the "beginUpdates" / "endUpdates" UITableView API
// 9. Tap the back button
// - there are still two UITableView instances (bad)
// - the HCADynamicTableViewController is released properly (good)

@interface HCADynamicTableViewController () {
    NSString *_name;
}

@end

@implementation HCADynamicTableViewController

#pragma mark - Object Life Cycle

- (id)init
{
    self = [super initWithStyle:UITableViewStyleGrouped];
    return self;
}

#pragma mark - View Life Cycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UITableView *tableView = [self tableView];
    [self registerTableViewCellsForTableView:tableView];
    [self configureNavigationItem:[self navigationItem]];
}

#pragma mark - UITableView Data Source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _name == nil ? 0 : 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellIdentifier = [self demoTableViewCellIdentifier];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    [[cell textLabel] setText:_name];
    
    return cell;
}

#pragma mark - Toggle Rows Action

- (void)toggleRow:(id)sender
{
    // The table view is not properly released once the "beginUpdates" / "endUpdates" methods execute.
    //
    // NOTE: The app does not have to actually insert or remove rows. Simply calling begin/ end is enough to cause
    //       the table view to live forever.
    [[self tableView] beginUpdates];
    
    NSArray *indexPaths = @[ [NSIndexPath indexPathForRow:0 inSection:0] ];
    
    if (_name == nil) {
        _name = @"My Name";
        [[self tableView] insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationFade];
    } else {
        _name = nil;
        [[self tableView] deleteRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationFade];
    }
         
    [[self tableView] endUpdates];
}

#pragma mark - UINavigationItem Configuration

- (void)configureNavigationItem:(UINavigationItem *)navigationItem
{
    [self addToggleRowButtonItemToNavigationItem:navigationItem];
    [navigationItem setTitle:@"Table Issue"];
}

- (void)addToggleRowButtonItemToNavigationItem:(UINavigationItem *)navigationItem
{
    UIBarButtonItem *toggle = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(toggleRow:)];
    [navigationItem setRightBarButtonItem:toggle];
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
    return @"HCADynamicTableViewCell";
}

@end
