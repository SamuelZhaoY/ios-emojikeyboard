//
//  UIImage+GZEmoji.m
//  GZEmojiKeyboard
//
//  Created by zhaoy on 31/8/16.
//  Copyright © 2016 com.gz. All rights reserved.
//

#import "UIImage+GZEmoji.h"

static NSCache *imageCache;

@implementation UIImage (GZEmoji)

+ (UIImage *)imageFromBundle:(NSString *)bundleName withName:(NSString *)imgName
{
    NSString *imagePath = [NSString stringWithFormat:@"%@.bundle/ap_%@",bundleName, imgName];
    return [UIImage imageNamed:imagePath];
}

+ (UIImage *)imageWithColor:(UIColor *)color {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        imageCache = [[NSCache alloc] init];
    });
    
    UIImage *image = [imageCache objectForKey:color];
    if (image) {
        return image;
    }
    
    image = [self imageWithColor:color size:CGSizeMake(1,1)];
    [imageCache setObject:image forKey:color];
    
    return image;
}

+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size {
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return img;
}

+ (UIImage *)resizableImageWithColor:(UIColor *)color cornerRadius:(CGFloat)cornerRadius {
    CGFloat minEdgeSize = cornerRadius * 2 + 1;
    CGRect rect = CGRectMake(0, 0, minEdgeSize, minEdgeSize);
    UIBezierPath *roundedRect = [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:cornerRadius];
    roundedRect.lineWidth = 0;
    
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0.0f);
    [color setFill];
    [roundedRect fill];
    [roundedRect stroke];
    [roundedRect addClip];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return [image resizableImageWithCapInsets:UIEdgeInsetsMake(cornerRadius, cornerRadius, cornerRadius, cornerRadius)];
}

@end
