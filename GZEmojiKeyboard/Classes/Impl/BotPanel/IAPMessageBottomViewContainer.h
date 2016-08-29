//
//  IAPMessageBottonViewContainer.h
//  MobileFramework
//
//  Created by zhaoy on 21/7/15.
//  Copyright (c) 2015 Alipay. All rights reserved.
//

#import <Foundation/Foundation.h>

#define IAP_MESSAGE_BOT_MENU_PANEL_HEIGHT 114.0f
#define IAP_MESSAGE_BOT_STICKER_PANEL_HEIGHT 178.0f
#define IAP_MESSAGE_BOT_PANEL_ACTION_REQUEST @"request_fund"
#define IAP_MESSAGE_BOT_PANEL_ACTION_NAME_CARD @"name_card"
#define IAP_MESSAGE_BOT_PANEL_ACTION_TRANSFER @"transfer_fund"
#define IAP_MESSAGE_BOT_PANEL_ACTION_FIRE @"bot_action_fired"

@class IAPMessageBottomMenu;
@class IAPStickerPanelControl;
typedef NS_ENUM(NSUInteger, IAP_BottomPanelMode)
{
    // 1. In display function panel
    IAP_ACTION = 0,
    // 2. In display emoji/sticker browser
    IAP_STICKER,
};

typedef NS_ENUM(NSUInteger, IAP_BottomPanelConfig)
{
    // 1. Individual chat mode
    IAP_INDIVIDUAL = 0,
    // 2. Group chat mode
    IAP_GROUP,
};

@interface IAPMessageBottomViewContainer : UIView

@property(strong, nonatomic)NSArray* items;
@property(assign, nonatomic)IAP_BottomPanelMode panelMode;
@property(assign, nonatomic)BOOL isInDisplay;
@property(nonatomic, strong)IAPMessageBottomMenu* botMenu;
@property(nonatomic, strong)IAPStickerPanelControl* emoControl;

- (instancetype)initWithMenuConfig:(IAP_BottomPanelConfig)config;

@end
