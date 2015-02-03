//
//  VideoListViewController.h
//  Harlem Shake
//
//  Created by Jason Fieldman on 2/12/13.
//  Copyright (c) 2013 Jason Fieldman. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "SingletonHelper.h"

@interface VideoListViewController : UIViewController  {
	UITableView *_tableView;
	
	UILabel *_noVideoLabel;
}

SINGLETON_INTR(VideoListViewController);

@end
