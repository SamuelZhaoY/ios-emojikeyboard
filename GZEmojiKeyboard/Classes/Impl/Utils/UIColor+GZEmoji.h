//
//  UIColor+GZEmoji.h
//  GZEmojiKeyboard
//
//  Created by zhaoy on 31/8/16.
//  Copyright © 2016 com.gz. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface UIColor (GZEmoji)

/**
 *  a category method to create UIColor with rgb values
 *
 *  @param rgb rgb value like 0xRRGGBB
 *
 *  @return an UIColor instance
 */
+ (UIColor *)colorWithRGB:(NSUInteger)rgb;


@end
