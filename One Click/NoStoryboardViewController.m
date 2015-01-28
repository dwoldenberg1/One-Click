//
//  NoStoryboardViewController.m
//  One Click
//
//  Created by David Woldenberg on 1/27/15.
//  Copyright (c) 2015 davidwoldenberg. All rights reserved.
//

#import "NoStoryboardViewController.h"

@interface NoStoryboardViewController ()

@end

@implementation NoStoryboardViewController

- (id) init {
    if ((self = [super init])) {
        self.view = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        self.view.backgroundColor = [UIColor yellowColor];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(50, 50, 100, 100)];
        label.backgroundColor = [UIColor redColor];
        label.text = @"Foo";
        [self.view addSubview:label];
        
        UIButton *myButton = [UIButton buttonWithType:UIButtonTypeSystem];
        myButton.frame = CGRectMake(100, 170, 100, 30);
        [myButton setTitle:@"Click Me!" forState:UIControlStateNormal];
        myButton.backgroundColor = [UIColor blueColor];
        
        [myButton addTarget:self action:@selector(myButtonPressed) forControlEvents:UIControlEventTouchUpInside];

        
        [self.view addSubview:myButton];
        
    }
    return self;
}

-(void)myButtonPressed {
    #define ARC4RANDOM_MAX      0x100000000
    int h = self.view.frame.size.height;
    int w = self.view.frame.size.width;
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake((w-200) * ((double)arc4random() / ARC4RANDOM_MAX), h * ((double)arc4random() / ARC4RANDOM_MAX), 200, 20)];
    label.text = @"Saf sucks eggs";
    label.backgroundColor = [UIColor blueColor];
    
    [self.view addSubview:label];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
