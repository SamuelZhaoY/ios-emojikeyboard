//
//  UIImage+GZEmoji.h
//  GZEmojiKeyboard
//
//  Created by zhaoy on 31/8/16.
//  Copyright © 2016 com.gz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UIImage (GZEmoji)


+ (UIImage *)imageFromBundle:(NSString *)bundleName withName:(NSString *)imgName;

/**
 Returns a 1x1 image with the single pixel set to the specified color.
 Usage Note: almost all of UIKit will stretch this UIImage when you set
 it as, eg. backgroundImage, hence you often don’t need the size variant.
 */
+ (UIImage *)imageWithColor:(UIColor *)color;

/**
 Returns an image of the requested size filled with the provided color.
 */
+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size;

/**
 Returns a (minimal) resizable image with the requested corner radius and
 filled with the provided color.
 */
+ (UIImage *)resizableImageWithColor:(UIColor *)color cornerRadius:(CGFloat)cornerRadius;

@end
