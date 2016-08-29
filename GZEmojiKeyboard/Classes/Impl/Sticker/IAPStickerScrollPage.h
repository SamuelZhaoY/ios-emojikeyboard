//
//  IAPStickerScrollPage.h
//  MobileFramework
//
//  Created by zhaoy on 15/10/15.
//  Copyright © 2015 Alipay. All rights reserved.
//

#import <UIKit/UIKit.h>

@class IAPStickerPackage;
@class IAPExpandableInputView;
@interface IAPStickerScrollPage : UICollectionViewCell
@property(weak, nonatomic)IAPExpandableInputView* accessoryInput;
- (void)updateStickerPackage:(IAPStickerPackage*)stickerPackage atIndex:(int)index;

@end
