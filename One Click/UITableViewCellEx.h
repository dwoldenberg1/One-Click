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

@property (nonatomic, assign) BOOL selectionActivatesAccessory;
@property (nonatomic, assign) float cellHeight;
@property (nonatomic, assign) BOOL shouldHighlight;
@property (nonatomic, assign) BOOL shouldSelect;

@property (nonatomic, strong) NSString *sectionFooterText;

@end
