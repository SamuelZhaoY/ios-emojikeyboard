//
//  GZStickerPackage.m
//  MobileFramework
//
//  Created by zhaoy on 5/10/15.
//  Copyright © 2015 com.gz. All rights reserved.
//

#import "GZStickerPackage.h"
#import "GZEmojiKeyboardControl.h"
#import "GZCommonUtils.h"
#import "GZEmojiKeyboardConfiguration.h"

@implementation GZStickerPackage


+ (NSArray*)loadPackages
{
    NSMutableArray* stickerPackages = [GZEmojiKeyboardConfiguration defaultInstance].stickerPackageList;
    return [stickerPackages copy];
}

#pragma mark - Display config

- (int)checkRowCount
{
    if (self.type == GZ_TYPE_EMOJI) {
        return 4;
    } else {
        return 2;
    }
}

- (int)checkColumnCount
{
    if (self.type == GZ_TYPE_EMOJI) {
        return ((int)[GZCommonUtils getMainScreenWidth]) / GZ_EMO_ICON_SIZE;
    } else {
        return ((int)[GZCommonUtils getMainScreenWidth]) / GZ_EMO_STICKER_SIZE;
    }
}

- (int)checkPageCount
{
    return ceilf((float)(self.contentArray.count) / ([self checkColumnCount] * [self checkRowCount]));
}

- (float)checkHorizontalSpacing
{
    if (self.type == GZ_TYPE_EMOJI) {
        return ([GZCommonUtils getMainScreenWidth] - [self checkColumnCount] * GZ_EMO_ICON_SIZE)/ ([self checkColumnCount] + 1);
    } else {
        return ([GZCommonUtils getMainScreenWidth] - [self checkColumnCount] * GZ_EMO_STICKER_SIZE)/ ([self checkColumnCount] + 1);
    }
}

- (float)checkVerticalSpacing
{
    if (self.type == GZ_TYPE_EMOJI) {
        return 5.0f;
    } else {
        return 5.0f;
    }
}

- (float)checkItemSize
{
    if (self.type == GZ_TYPE_EMOJI) {
        return GZ_EMO_ICON_SIZE;
    } else {
        return GZ_EMO_STICKER_SIZE;
    }
}

- (NSArray*)checkItemsAtIndexedPage:(int)pageIndex
{
    if (pageIndex >= [self checkPageCount]) {
        return [NSArray new];
    }
    
    int numberOfIconPerpage = 0;
    if (self.type == GZ_TYPE_EMOJI) {
        numberOfIconPerpage = [self checkColumnCount] * [self checkRowCount] -1;
    } else {
        numberOfIconPerpage = [self checkColumnCount] * [self checkRowCount];
    }
    
    NSArray* stickerIcons = [NSArray new];
    if (pageIndex == ([self checkPageCount] -1)) {
        stickerIcons = [self.contentArray subarrayWithRange:NSMakeRange(numberOfIconPerpage * pageIndex, self.contentArray.count - numberOfIconPerpage * pageIndex)];
    } else {
        stickerIcons = [self.contentArray subarrayWithRange:NSMakeRange(numberOfIconPerpage * pageIndex, numberOfIconPerpage)];
    }
    
    return stickerIcons;
}

@end

@implementation GZStickerItem

- (int)checkCurrentPageInPackage:(GZStickerPackage*)package
{
    return (int)[package.contentArray indexOfObject:self] / ([package checkRowCount] * [package checkColumnCount]  -1);
}

- (int)checkIndexInPage:(GZStickerPackage*)package
{
    return [package.contentArray indexOfObject:self] % ([package checkRowCount] * [package checkColumnCount]  - 1);
}

@end