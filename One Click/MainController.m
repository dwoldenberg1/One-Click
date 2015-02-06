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

@synthesize postsArray;

- (id) init {
    if ((self = [super init])) {
        // Do any additional setup after loading the view, typically from a nib.
        self.navigationItem.leftBarButtonItem = self.editButtonItem;
        
        UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(refreshFeed:)];
        self.navigationItem.rightBarButtonItem = addButton;
        
        self.postsArray = [NSArray arrayWithObjects:@"Brave new world",@"Call of the Wild",@"Catch-22",@"Atlas Shrugged",@"The Great Gatsby",@"The Art of War",@"The Catcher in the Rye",@"The Picture of Dorian Gray",@"The Grapes of Wrath", @"The Metamorphosis",nil];
        
        UITableView *myTable = [[UITableView alloc] initWithFrame:(self.view.bounds) style:UITableViewStylePlain];
        myTable.dataSource = self;
        [self.view addSubview:myTable];
        
        self.title = @"Your Feed";

    }
    return self;
}
- (void)refreshFeed{
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    // Configure the cell.
    cell.textLabel.text = [self.postsArray objectAtIndex:indexPath.row];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection: (NSInteger)section {
    return self.postsArray.count;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
