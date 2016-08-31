//
//  IAPStickerPackage.m
//  MobileFramework
//
//  Created by zhaoy on 5/10/15.
//  Copyright © 2015 Alipay. All rights reserved.
//

#import "IAPStickerPackage.h"
#import "IAPStickerPanelControl.h"
#import "IAPCommonUtils.h"


@implementation IAPStickerPackage

+ (IAPStickerPackage*)defaultStickerPackage
{
    IAPStickerPackage* emojiPack = [IAPStickerPackage new];
    NSArray* rawEmoji      = @[ @"\U0001f38c",
                                @"\U0001f3c1",
                                @"\U0001f488",
                                @"\U0001f68f",
                                @"\U0001f3b0",
                                @"\U0001f530",
                                @"\U0001f6a7",
                                @"\U0001f6a5",
                                @"\U0001f3ab",
                                @"\U0001f685",
                                @"\U0001f684",
                                @"\U0001f689",
                                @"\U0001f683",
                                @"\U0001f69a",
                                @"\U0001f691",
                                @"\U0001f692",
                                @"\U0001f693",
                                @"\U0001f68c",
                                @"\U0001f695",
                                @"\U0001f697",
                                @"\U0001f699",
                                @"\U0001f6b2",
                                @"\U0001f680",
                                @"\U0001f6a4",
                                @"\U0001f6a2",
                                @"\U0001f3a2",
                                @"\U0001f3a1",
                                @"\U0001f308",
                                @"\U0001f5fd",
                                @"\U0001f303",
                                @"\U0001f305",
                                @"\U0001f304",
                                @"\U0001f5fb",
                                @"\U0001f5fc",
                                @"\U0001f3ed",
                                @"\U0001f3f0",
                                @"\U0001f3ef",
                                @"\U0001f3e7",
                                @"\U0001f306",
                                @"\U0001f307",
                                @"\U0001f3ec",
                                @"\U0001f492",
                                @"\U0001f3e8",
                                @"\U0001f3e9",
                                @"\U0001f3ea",
                                @"\U0001f3e6",
                                @"\U0001f3e5",
                                @"\U0001f3e3",
                                @"\U0001f3e2",
                                @"\U0001f3eb",
                                @"\U0001f3e0",
                                @"\U0001f55a",
                                @"\U0001f559",
                                @"\U0001f558",
                                @"\U0001f557",
                                @"\U0001f556",
                                @"\U0001f555",
                                @"\U0001f554",
                                @"\U0001f553",
                                @"\U0001f552",
                                @"\U0001f551",
                                @"\U0001f550",
                                @"\U0001f55b",
                                @"\U0001f533",
                                @"\U0001f534",
                                @"\U0001f532",
                                @"\U0001f17e",
                                @"\U0001f18e",
                                @"\U0001f171",
                                @"\U0001f170",
                                @"\U0001f52f",
                                @"\U0001f4b1",
                                @"\U0001f4b9",
                                @"\U0001f4f4",
                                @"\U0001f4f3",
                                @"\U0001f19a",
                                @"\U0001f49f",
                                @"\U0001f194",
                                @"\U0001f51e",
                                @"\U0001f6be",
                                @"\U0001f687"];
    
    // Check about rawCodes
    NSMutableArray* emojiItems = [NSMutableArray new];
    for (NSString* rawCode in rawEmoji) {
        IAPStickerItem* emojiItem = [IAPStickerItem new];
        emojiItem.resource = rawCode;
        emojiItem.name = [NSString stringWithFormat:@"emoji #%lu",(unsigned long)[rawEmoji indexOfObject:rawCode]];
        emojiItem.stickerType = IAP_TYPE_EMOJI;
        [emojiItems addObject:emojiItem];
    }
    
    emojiPack.title = @"Emoji";
    emojiPack.icon = @"\U0001F603";
    emojiPack.contentArray = [emojiItems copy];

    
    return emojiPack;
}

+ (NSArray*)loadLocalPackages
{
    NSMutableArray* stickerPackages = [NSMutableArray new];
    for (int i = 0; i < 4 ; i++) {
        [stickerPackages addObject:[IAPStickerPackage defaultStickerPackage]];
    }
    
    return [stickerPackages copy];
}

#pragma mark - Display config

- (int)checkRowCount
{
    if (self.type == IAP_TYPE_EMOJI) {
        return 3;
    } else {
        return 2;
    }
}

- (int)checkColumnCount
{
    if (self.type == IAP_TYPE_EMOJI) {
        return 7;
    } else {
        return 4;
    }
}

- (int)checkPageCount
{
    return ceilf((float)(self.contentArray.count) / ([self checkColumnCount] * [self checkRowCount]));
}

- (float)checkHorizontalSpacing
{
    if (self.type == IAP_TYPE_EMOJI) {
        return ([IAPCommonUtils getMainScreenWidth] - [self checkColumnCount] * IAP_EMO_ICON_SIZE)/ ([self checkColumnCount] + 1);
    } else {
        return 5.0f;
    }
}

- (float)checkVerticalSpacing
{
    if (self.type == IAP_TYPE_EMOJI) {
        return 5.0f;
    } else {
        return 5.0f;
    }
}

- (NSArray*)checkItemsAtIndexedPage:(int)pageIndex
{
    if (pageIndex >= [self checkPageCount]) {
        return [NSArray new];
    }
    
    int numberOfIconPerpage = 0;
    if (self.type == IAP_TYPE_EMOJI) {
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

@implementation IAPStickerItem

- (int)checkCurrentPageInPackage:(IAPStickerPackage*)package
{
    return (int)[package.contentArray indexOfObject:self] / ([package checkRowCount] * [package checkColumnCount]  -1);
}

- (int)checkIndexInPage:(IAPStickerPackage*)package
{
    return [package.contentArray indexOfObject:self] % ([package checkRowCount] * [package checkColumnCount]  - 1);
}

@end