//
//  GZUIKitIconFontHelper.m
//  GZEmojiKeyboard
//
//  Created by zhaoy on 31/8/16.
//  Copyright © 2016 com.gz. All rights reserved.
//

#import "GZUIKitIconFontHelper.h"

@implementation GZUIKitIconFontHelper

+ (NSString *)_charStringFromHexString:(NSString *)string
{
    if (![string length]) {
        return nil;
    }
    unsigned int result = 0;
    NSScanner *scanner = [NSScanner scannerWithString:string];
    
    [scanner setScanLocation:0];
    [scanner scanHexInt:&result];
    return [NSString stringWithFormat:@"%C", (unichar)result];
}

+ (UIFont *)iconFontWithSize:(CGFloat)size
{
    return [UIFont fontWithName:@"iconfont" size:size];
}

+ (NSString *)stringWithIdentifier:(NSString *)identifier
{
    return [self _charStringFromHexString:identifier];
}

+ (UILabel *)labelWithIdentifier:(NSString *)identifier tintColor:(UIColor *)color fontSize:(CGFloat)fontSize
{
    UILabel *label = [[UILabel alloc] init];
    label.font = [GZUIKitIconFontHelper iconFontWithSize:fontSize];
    label.textColor = color;
    label.text = [self _charStringFromHexString:identifier];
    return label;
}

@end
