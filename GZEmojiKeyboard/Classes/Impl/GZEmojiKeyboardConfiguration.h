//
//  GZStickerConfiguration.h
//  GZEmojiKeyboard
//
//  Created by zhaoy on 10/9/16.
//  Copyright © 2016 com.gz. All rights reserved.
//

#import <Foundation/Foundation.h>

@class GZStickerPage;
@interface GZEmojiKeyboardConfiguration : NSObject

/**
 *  Mutable array which containing customized packages
 */
@property NSMutableArray* stickerPackageList;

/**
 *  Singleton controller instance
 *
 *  @return default instance
 */
+ (GZEmojiKeyboardConfiguration*) defaultInstance;

/**
 *  Use default emoji and sticker package, which will restore the stickerPackageList to the default 2 sticker package
 */
- (void)useDefaultPackages;

@end
