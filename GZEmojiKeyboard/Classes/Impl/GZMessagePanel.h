//
//  GZMessagePanel.h
//  MobileFramework
//
//  Created by zhaoy on 20/7/15.
//  Copyright (c) 2015 com.gz. All rights reserved.
//

#import <Foundation/Foundation.h>

#define GZ_MESSAGE_PANEL_HEIGHT 56.0f
#define GZ_MESSAGE_PLUS_BUTTON_SIZE 30.0f
#define GZ_MESSAGE_INPUT_DEFAULT_HEIGHT 42.0f
#define GZ_MESSAGE_PANEL_INTERNAL_PADDING 12.0f
#define GZ_MESSAGE_PANEL_VERTICAL_PADDING 7.0f

#define GZ_MESSAGE_PANEL_SCROLL_INSET_CHANGE @"GZ_Messaging_Inset_Change"

@interface GZMessagePanel : UIView

- (GZMessagePanel*)attachToView:(UIView*)superView;

-(float)checkBottomHeight;

- (void)resetPanel;

@end
