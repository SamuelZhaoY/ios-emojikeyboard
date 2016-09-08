//
//  GZCommonUtils.h
//  GZEmojiKeyboard
//
//  Created by zhaoy on 31/8/16.
//  Copyright © 2016 com.gz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GZCommonUtils : NSObject

+ (CGFloat)getMainScreenWidth;

+ (CGFloat)getNavigationHeight;

+ (UIImage*)imageFromString:(NSString*)string
                  tintColor:(UIColor*)color
                       size:(CGSize)size;


@end
