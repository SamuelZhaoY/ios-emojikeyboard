//
//  IAPCommonUtils.m
//  GZEmojiKeyboard
//
//  Created by zhaoy on 31/8/16.
//  Copyright © 2016 com.gz. All rights reserved.
//

#import "IAPCommonUtils.h"

@implementation IAPCommonUtils

+ (CGFloat)getMainScreenWidth
{
    return [UIScreen mainScreen].bounds.size.width;
}

+ (CGFloat)getMainScreenHeight
{
    return [UIScreen mainScreen].bounds.size.height;
}

+ (CGFloat)getNavigationHeight
{
    return 44 + [UIApplication sharedApplication].statusBarFrame.size.height;
}

@end
