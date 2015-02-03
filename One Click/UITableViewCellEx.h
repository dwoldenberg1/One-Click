//
//  UITableViewCellEx.h
//  One Click
//
//  Created by David Woldenberg on 2/2/15, credit to Jason Fieldman.
//  Copyright (c) 2015 David Woldenberg. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface UITableViewCellEx : UITableViewCell {
	UILabel *_footerLabel;
}

@property (nonatomic, assign) float cellHeight;

@property (nonatomic, strong) NSString *postType;
@property (nonatomic, strong) NSString *postTitle;

@end
