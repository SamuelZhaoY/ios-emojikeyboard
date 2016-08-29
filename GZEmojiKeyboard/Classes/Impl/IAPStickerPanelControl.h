//
//  IAPMessageEmoControl.h
//  MobileFramework
//
//  Created by zhaoy on 5/10/15.
//  Copyright © 2015 Alipay. All rights reserved.
//

#import <UIKit/UIKit.h>

@class IAPExpandableInputView;

FOUNDATION_EXPORT const float IAP_EMO_PACK_BAR_HEIGHT;
FOUNDATION_EXPORT const float IAP_EMO_PACK_ITEM_WIDTH;
FOUNDATION_EXPORT const float IAP_EMO_ICON_SIZE;

@interface IAPStickerPanelControl : UIView

@property(nonatomic, weak) IAPExpandableInputView* associatedInput;

- (void)checkLayout;

@end
