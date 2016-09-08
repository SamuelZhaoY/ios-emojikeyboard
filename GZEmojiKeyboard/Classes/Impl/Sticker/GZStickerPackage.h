//
//  GZStickerPackage.h
//  MobileFramework
//
//  Created by zhaoy on 5/10/15.
//  Copyright © 2015 com.gz. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, GZ_STICKER_TYPE)
{
    // Package is set of emoji
    GZ_TYPE_EMOJI = 0,
    // Package is set of stickers
    GZ_TYPE_STICKER,
};

@interface GZStickerPackage : NSObject

@property(nonatomic, strong)NSArray* contentArray;
@property(nonatomic, assign)GZ_STICKER_TYPE type;
@property(nonatomic, strong)NSString* title;
@property(nonatomic, strong)UIImage* icon;
@property(nonatomic, strong)NSArray* rawSource;

+ (NSArray*)loadPackages;

- (int)checkRowCount;

- (int)checkColumnCount;

- (int)checkPageCount;

- (float)checkHorizontalSpacing;

- (float)checkVerticalSpacing;

- (float)checkItemSize;

- (NSArray*)checkItemsAtIndexedPage:(int)pageIndex;

@end

@interface GZStickerItem : NSObject

@property(strong, nonatomic)NSString* resource;
@property(strong, nonatomic)NSString* name;
@property(assign, nonatomic)GZ_STICKER_TYPE stickerType;

- (int)checkCurrentPageInPackage:(GZStickerPackage*)package;

- (int)checkIndexInPage:(GZStickerPackage*)package;

@end