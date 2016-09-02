//
//  GZMessageEmoControl.h
//  MobileFramework
//
//  Created by zhaoy on 5/10/15.
//  Copyright © 2015 com.gz. All rights reserved.
//

#import <UIKit/UIKit.h>


/**
 
 // config emoji& sticker control
 _emoControl = [GZStickerPanelControl new];
 [self addSubview:_emoControl];
 [_emoControl mas_makeConstraints:^(MASConstraintMaker *make) {
 make.leading.equalTo(self.mas_leading);
 make.top.equalTo(self.mas_top);
 make.width.equalTo(self.mas_width);
 make.height.equalTo([NSNumber numberWithFloat:GZ_MESSAGE_BOT_STICKER_PANEL_HEIGHT]);
 }];
 
 [_emoControl setBackgroundColor:[UIColor colorWithRGB:GZUIKitUIGrey10]];
 */

@class GZExpandableInputView;

FOUNDATION_EXPORT const float GZ_EMO_PACK_BAR_HEIGHT;
FOUNDATION_EXPORT const float GZ_EMO_PACK_ITEM_WIDTH;
FOUNDATION_EXPORT const float GZ_EMO_ICON_SIZE;

@interface GZStickerPanelControl : UIView

@property(nonatomic, weak) GZExpandableInputView* associatedInput;

- (void)checkLayout;

@end
