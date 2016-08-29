//
//  IAPStickerPackage.h
//  MobileFramework
//
//  Created by zhaoy on 5/10/15.
//  Copyright © 2015 Alipay. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, IAP_STICKER_TYPE)
{
    // package is set of emoji
    IAP_TYPE_EMOJI = 0,
    
    // package is set of stickers
    IAP_TYPE_STICKER,
};

@interface IAPStickerPackage : NSObject

@property(nonatomic, strong)NSArray* contentArray;
@property(nonatomic, assign)IAP_STICKER_TYPE type;
@property(nonatomic, strong)NSString* title;
@property(nonatomic, strong)NSString* icon;

+ (IAPStickerPackage*)defaultStickerPackage;

+ (NSArray*)loadLocalPackages;

- (int)checkRowCount;

- (int)checkColumnCount;

- (int)checkPageCount;

- (float)checkHorizontalSpacing;

- (float)checkVerticalSpacing;

- (NSArray*)checkItemsAtIndexedPage:(int)pageIndex;

@end

@interface IAPStickerItem : NSObject

@property(strong, nonatomic)NSString* resource;
@property(strong, nonatomic)NSString* name;
@property(assign, nonatomic)IAP_STICKER_TYPE stickerType;

- (int)checkCurrentPageInPackage:(IAPStickerPackage*)package;

- (int)checkIndexInPage:(IAPStickerPackage*)package;

@end