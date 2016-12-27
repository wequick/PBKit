//
//  PBViewController.m
//  PBKit
//
//  Created by galenlin on 09/12/2016.
//  Copyright (c) 2016 galenlin. All rights reserved.
//

#import "PBExampleViewController.h"
#import <PBKit/PBDropdownMenu.h>

@interface PBExampleViewController ()
{
    PBDropdownMenu *_menu;
}

@end

@implementation PBExampleViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self.navigationController.navigationBar setBarTintColor:[UIColor blackColor]];
    [self.view setBackgroundColor:[UIColor lightGrayColor]];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(showMenu:)];
    self.navigationItem.rightBarButtonItem = item;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)showMenu:(id)sender {
    if (_menu == nil) {
        _menu = [[PBDropdownMenu alloc] init];
        [_menu setPlist:@"PBDropdown"];
    }
    [_menu showAndPointToBarButtonItem:sender];
}

@end