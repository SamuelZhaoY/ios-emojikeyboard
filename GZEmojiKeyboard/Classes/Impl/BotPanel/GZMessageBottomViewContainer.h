//
//  GZMessageBottonViewContainer.h
//  MobileFramework
//
//  Created by zhaoy on 21/7/15.
//  Copyright (c) 2015 com.gz. All rights reserved.
//

#import <Foundation/Foundation.h>

#define GZ_MESSAGE_BOT_MENU_PANEL_HEIGHT 114.0f
#define GZ_MESSAGE_BOT_STICKER_PANEL_HEIGHT 178.0f
#define GZ_MESSAGE_BOT_PANEL_ACTION_REQUEST @"request_fund"
#define GZ_MESSAGE_BOT_PANEL_ACTION_NAME_CARD @"name_card"
#define GZ_MESSAGE_BOT_PANEL_ACTION_TRANSFER @"transfer_fund"
#define GZ_MESSAGE_BOT_PANEL_ACTION_FIRE @"bot_action_fired"

@class GZMessageBottomMenu;
@class GZStickerPanelControl;
typedef NS_ENUM(NSUInteger, GZ_BottomPanelMode)
{
    // 1. In display function panel
    GZ_ACTION = 0,
    // 2. In display emoji/sticker browser
    GZ_STICKER,
};

typedef NS_ENUM(NSUInteger, GZ_BottomPanelConfig)
{
    // 1. Individual chat mode
    GZ_INDIVIDUAL = 0,
    // 2. Group chat mode
    GZ_GROUP,
};

@interface GZMessageBottomViewContainer : UIView

@property(strong, nonatomic)NSArray* items;
@property(assign, nonatomic)GZ_BottomPanelMode panelMode;
@property(assign, nonatomic)BOOL isInDisplay;
@property(nonatomic, strong)GZMessageBottomMenu* botMenu;
@property(nonatomic, strong)GZStickerPanelControl* emoControl;

- (instancetype)initWithMenuConfig:(GZ_BottomPanelConfig)config;

@end
