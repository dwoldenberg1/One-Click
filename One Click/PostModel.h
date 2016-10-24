//
//  PostModel.h
//  Harlem Shake
//
//  Created by Jason Fieldman on 2/12/13.
//  Copyright (c) 2013 Jason Fieldman. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "SingletonHelper.h"
#import "PersistentDictionary.h"


typedef NSString* PostID;


@interface PostModel : NSObject {
	
	/* Filesystem cache */
	NSString *_appSuppDir;
	NSString *_postsDir;
	
}

SINGLETON_INTR(PostModel);

@property (nonatomic, assign, readonly) int numberOfVideos;

@property (nonatomic, strong, readonly) NSMutableArray      *vpostOrder;
@property (nonatomic, strong, readonly) NSMutableDictionary *posts;


- (PostID) createNewPostId;
- (void) moveVideoAtIndex:(int)from toIndex:(int)to;

- (NSMutableDictionary*) videoDic:(PostID)videoId;


- (NSString*) pathToClipForVideo:(PostID)videoId beforeDrop:(BOOL)before;
- (NSString*) pathToClipForVideoTemp:(PostID)videoId beforeDrop:(BOOL)before;
- (NSString*) pathToFullVideo:(PostID)videoId;
- (NSString*) pathToFullVideoTemp:(PostID)videoId;
- (UIImage*) screenshotForVideo:(PostID)videoId beforeDrop:(BOOL)before;
- (void) deleteScreenshotForVideo:(PostID)videoId beforeDrop:(BOOL)before;
- (BOOL) clipExistsforVideo:(PostID)videoId beforeDrop:(BOOL)before;
- (BOOL) fullVideoExistsForVideo:(PostID)videoId;

@end
