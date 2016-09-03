//
//  GZMessageEmoControl.h
//  MobileFramework
//
//  Created by zhaoy on 5/10/15.
//  Copyright © 2015 com.gz. All rights reserved.
//

#import <UIKit/UIKit.h>

FOUNDATION_EXPORT const float GZ_EMO_PACK_BAR_HEIGHT;
FOUNDATION_EXPORT const float GZ_EMO_PACK_ITEM_WIDTH;
FOUNDATION_EXPORT const float GZ_EMO_ICON_SIZE;

@interface GZStickerPanelControl : UIView

@property(nonatomic, weak) UITextField* associatedInput;

- (void)checkLayout;

@end
