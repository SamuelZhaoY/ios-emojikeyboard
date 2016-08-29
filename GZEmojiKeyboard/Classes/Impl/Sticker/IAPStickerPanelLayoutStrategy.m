//
//  IAPStickerPanelLayoutStrategy.m
//  MobileFramework
//
//  Created by zhaoy on 15/10/15.
//  Copyright © 2015 Alipay. All rights reserved.
//

#import "IAPStickerPanelLayoutStrategy.h"
#import "IAPMessageBottomViewContainer.h"
#import "IAPStickerPanelControl.h"

@implementation IAPStickerPanelLayoutStrategy

- (instancetype)init{
    self = [super init];
    self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.itemSize = CGSizeMake([IAPCommonUtils getMainScreenWidth], IAP_MESSAGE_BOT_STICKER_PANEL_HEIGHT - 15);
    self.sectionInset = UIEdgeInsetsZero;
    self.minimumInteritemSpacing = 0.0;
    self.minimumLineSpacing = 0.0;
    return self;
}

- (CGSize)collectionViewContentSize{
    
    return  CGSizeMake(self.numberOfPage * [IAPCommonUtils getMainScreenWidth], IAP_MESSAGE_BOT_STICKER_PANEL_HEIGHT - IAP_EMO_PACK_BAR_HEIGHT - 15);
}

@end
