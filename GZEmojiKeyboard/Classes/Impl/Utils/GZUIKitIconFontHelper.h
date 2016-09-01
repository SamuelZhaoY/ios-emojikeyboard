//
//  GZUIKitIconFontHelper.h
//  GZEmojiKeyboard
//
//  Created by zhaoy on 31/8/16.
//  Copyright © 2016 com.gz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GZUIKitIconFontHelper : NSObject

+ (UIFont *)iconFontWithSize:(CGFloat)size;

+ (NSString *)stringWithIdentifier:(NSString *)identifier;

+ (UIBarButtonItem *)barButtonItemWithIdentifier:(NSString *)identifier target:(id)target selector:(SEL)selector;

+ (UILabel *)labelWithIdentifier:(NSString *)identifier tintColor:(UIColor *)color fontSize:(CGFloat)fontSize;

+ (UIButton *)buttonWithIdentifier:(NSString *)identifier tintColor:(UIColor *)color fontSize:(CGFloat)fontSize;

+ (UIImage *)imageWithIdentifier:(NSString *)identifier tintColor:(UIColor *)color size:(CGSize)size;


@end
