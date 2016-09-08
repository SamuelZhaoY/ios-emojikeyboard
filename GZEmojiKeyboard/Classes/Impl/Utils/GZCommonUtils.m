//
//  GZCommonUtils.m
//  GZEmojiKeyboard
//
//  Created by zhaoy on 31/8/16.
//  Copyright © 2016 com.gz. All rights reserved.
//

#import "GZCommonUtils.h"

@implementation GZCommonUtils

+ (CGFloat)getMainScreenWidth
{
    return [UIScreen mainScreen].bounds.size.width;
}

+ (CGFloat)getNavigationHeight
{
    return 44 + [UIApplication sharedApplication].statusBarFrame.size.height;
}

+ (UIImage*)imageFromString:(NSString*)string
                  tintColor:(UIColor*)color
                       size:(CGSize)size
{
    UIGraphicsBeginImageContextWithOptions(size, NO, 0);
    [string drawInRect:CGRectMake(0, 0, size.width, size.height)
        withAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:MIN(size.width, size.height)],NSForegroundColorAttributeName:color}];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

@end
