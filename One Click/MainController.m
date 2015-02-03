//
//  MainController.m
//  One Click
//
//  Created by David Woldenberg on 2/3/15.
//  Copyright (c) 2015 davidwoldenberg. All rights reserved.
//

#import "MainController.h"

@interface MainController ()

@end

@implementation MainController

- (id) init {
    if ((self = [super init])) {
        // Do any additional setup after loading the view, typically from a nib.
        self.navigationItem.leftBarButtonItem = self.editButtonItem;
        
        UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(refreshFeed:)];
        self.navigationItem.rightBarButtonItem = addButton;
        
        UITableView *myTable = [[UITableView alloc] initWithFrame:CGRectMake(50, 50, 100, 100)];
        [self.view addSubview:myTable];
        
        self.title = @"Your Feed";
        
    }
    return self;
}
- (void)refreshFeed{
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
