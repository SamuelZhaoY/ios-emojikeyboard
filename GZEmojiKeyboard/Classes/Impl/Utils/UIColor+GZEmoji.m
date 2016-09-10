//
//  UIColor+GZEmoji.m
//  GZEmojiKeyboard
//
//  Created by zhaoy on 31/8/16.
//  Copyright © 2016 com.gz. All rights reserved.
//

#import "UIColor+GZEmoji.h"

@implementation UIColor (GZEmoji)

#pragma util method

+ (UIColor *)colorWithRGB:(NSUInteger)rgb
{
    return [UIColor colorWithRGB:rgb alpha:1.0];
}

+ (UIColor *)colorWithRGB:(NSUInteger)rgb alpha:(CGFloat)alpha
{
    return [UIColor colorWithRed:((rgb & 0xFF0000) >> 16) / 255.0f
                           green:((rgb & 0xFF00) >> 8) / 255.0f
                            blue:((rgb & 0xFF)) / 255.0f
                           alpha:alpha];
}

@end
