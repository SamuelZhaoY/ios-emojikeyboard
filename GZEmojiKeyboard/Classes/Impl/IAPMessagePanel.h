//
//  IAPMessagePanel.h
//  MobileFramework
//
//  Created by zhaoy on 20/7/15.
//  Copyright (c) 2015 Alipay. All rights reserved.
//

#import <Foundation/Foundation.h>

#define IAP_MESSAGE_PANEL_HEIGHT 56.0f
#define IAP_MESSAGE_PLUS_BUTTON_SIZE 30.0f
#define IAP_MESSAGE_INPUT_DEFAULT_HEIGHT 42.0f
#define IAP_MESSAGE_PANEL_INTERNAL_PADDING 12.0f
#define IAP_MESSAGE_PANEL_VERTICAL_PADDING 7.0f

#define IAP_MESSAGE_PANEL_SCROLL_INSET_CHANGE @"IAP_Messaging_Inset_Change"

@class IAPMessagingBaseViewController;
@interface IAPMessagePanel : UIView

@property(weak, nonatomic)IAPMessagingBaseViewController* relatedMessageView;

- (IAPMessagePanel*)attachToView:(UIView*)superView;

-(float)checkBottomHeight;

- (void)resetPanel;

@end
