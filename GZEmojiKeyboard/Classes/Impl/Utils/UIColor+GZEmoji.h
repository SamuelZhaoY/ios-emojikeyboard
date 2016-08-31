//
//  UIColor+GZEmoji.h
//  GZEmojiKeyboard
//
//  Created by zhaoy on 31/8/16.
//  Copyright © 2016 com.gz. All rights reserved.
//

#import <Foundation/Foundation.h>

#define IAPUIKit_Color_1            0x000000
#define IAPUIKit_Color_2            0x4a4a4a
#define IAPUIKit_Color_3            0x9b9b9b
#define IAPUIKit_Color_4            0xbbbbbb
#define IAPUIKit_Color_5            0xcccccc
#define IAPUIKit_Color_6            0xffffff
#define IAPUIKit_Color_7            0x00a0e9
#define IAPUIKit_Color_7_Highlight  0x0080ba
#define IAPUIKit_Color_8            0xff7c00
#define IAPUIKit_Color_9            0xe5e5e5
#define IAPUIKit_Color_10           0xebebeb
#define IAPUIKit_Color_11           0x535353
#define IAPUIKit_Color_12           0xeeeeee
#define IAPUIKit_Color_13           0xe9e9e9
#define IAPUIKit_Color_14           0x41aaef
#define IAPUIKit_Color_15           0xF4F4F4
#define IAPUIKit_Color_16           0xdddddd
#define IAPUIKit_Color_17           0xfafafa
#define IAPUIKit_Color_18           0x16CB3B
#define IAPUIKit_Color_19           0xb7b7b7

// FONT GREY
UIKIT_EXTERN NSUInteger const IAPUIKitFontGrey1; //000000;
UIKIT_EXTERN NSUInteger const IAPUIKitFontGrey2; //4A4A4A;
UIKIT_EXTERN NSUInteger const IAPUIKitFontGrey3; //9B9B9B;
UIKIT_EXTERN NSUInteger const IAPUIKitFontGrey4; //BBBBBB;
UIKIT_EXTERN NSUInteger const IAPUIKitFontGrey5; //CCCCCC;
UIKIT_EXTERN NSUInteger const IAPUIKitFontGrey6; //FFFFFF;

// FONT COLOR
UIKIT_EXTERN NSUInteger const IAPUIKitFontColor1; //00A0E9;
UIKIT_EXTERN NSUInteger const IAPUIKitFontColor2; //FF7C00;

// UI GREY
UIKIT_EXTERN NSUInteger const IAPUIKitUIGrey1; //000000;
UIKIT_EXTERN NSUInteger const IAPUIKitUIGrey2; //333333;
UIKIT_EXTERN NSUInteger const IAPUIKitUIGrey3; //4A4A4A;
UIKIT_EXTERN NSUInteger const IAPUIKitUIGrey4; //6B6B6B;
UIKIT_EXTERN NSUInteger const IAPUIKitUIGrey5; //9B9B9B;
UIKIT_EXTERN NSUInteger const IAPUIKitUIGrey6; //CCCCCC;
UIKIT_EXTERN NSUInteger const IAPUIKitUIGrey7; //D5D5D5;
UIKIT_EXTERN NSUInteger const IAPUIKitUIGrey8; //DDDDDD;
UIKIT_EXTERN NSUInteger const IAPUIKitUIGrey9; //E9E9E9;
UIKIT_EXTERN NSUInteger const IAPUIKitUIGrey10; //EEEEEE;
UIKIT_EXTERN NSUInteger const IAPUIKitUIGrey11; //F4F4F4;
UIKIT_EXTERN NSUInteger const IAPUIKitUIGrey12; //FFFFFF;

// UI COLOR
UIKIT_EXTERN NSUInteger const IAPUIKitUIColor1; //00A0E9;
UIKIT_EXTERN NSUInteger const IAPUIKitUIColor1_Dark; //0078AF;
UIKIT_EXTERN NSUInteger const IAPUIKitUIColor2; //16CB3B;
UIKIT_EXTERN NSUInteger const IAPUIKitUIColor3; //FF6262;
UIKIT_EXTERN NSUInteger const IAPUIKitUIColor4; //FFCD00;
UIKIT_EXTERN NSUInteger const IAPUIKitUIColor5; //FF7C00;
UIKIT_EXTERN NSUInteger const IAPUIKitUIColor6; //19D5C7;
UIKIT_EXTERN NSUInteger const IAPUIKitUIColor7; //A26BF2;
UIKIT_EXTERN NSUInteger const IAPUIKitUIColor8; //41aaef;
UIKIT_EXTERN NSUInteger const IAPUIKitUIColor9; //D4F2FF
UIKIT_EXTERN NSUInteger const IAPUIKitUIColor10;

@interface UIColor (GZEmoji)

/**
 *  a category method to create UIColor with rgb values
 *
 *  @param rgb rgb value like 0xRRGGBB
 *
 *  @return an UIColor instance
 */
+ (UIColor *)colorWithRGB:(NSUInteger)rgb;

/**
 *  a category method to create UIColor with rgb values and alpha
 *
 *  @param rgb   rgb value like 0xRRGGBB
 *  @param alpha alpha value like 0xRRGGBB
 *
 *  @return an UIColor instance
 */
+ (UIColor *)colorWithRGB:(NSUInteger)rgb alpha:(CGFloat)alpha;

// IAPUI Font Related
+ (UIColor *)iap_FontGrey1;
+ (UIColor *)iap_FontGrey2;
+ (UIColor *)iap_FontGrey3;
+ (UIColor *)iap_FontGrey4;
+ (UIColor *)iap_FontGrey5;
+ (UIColor *)iap_FontGrey6;

+ (UIColor *)iap_FontColor1;
+ (UIColor *)iap_FontColor2;

// IAPUI UI Grey Levels & Colors
+ (UIColor *)iap_Grey1;
+ (UIColor *)iap_Grey2;
+ (UIColor *)iap_Grey3;
+ (UIColor *)iap_Grey4;
+ (UIColor *)iap_Grey5;
+ (UIColor *)iap_Grey6;
+ (UIColor *)iap_Grey7;
+ (UIColor *)iap_Grey8;
+ (UIColor *)iap_Grey9;
+ (UIColor *)iap_Grey10;
+ (UIColor *)iap_Grey11;
+ (UIColor *)iap_Grey12;

+ (UIColor *)iap_Color1;
+ (UIColor *)iap_Color1_Dark;
+ (UIColor *)iap_Color2;
+ (UIColor *)iap_Color3;
+ (UIColor *)iap_Color4;
+ (UIColor *)iap_Color5;
+ (UIColor *)iap_Color6;
+ (UIColor *)iap_Color7;


// Deprecated Colors
+ (UIColor *)iap_C1 DEPRECATED_MSG_ATTRIBUTE("first deprecated in v1.1");
+ (UIColor *)iap_C2 DEPRECATED_MSG_ATTRIBUTE("first deprecated in v1.1");
+ (UIColor *)iap_C3 DEPRECATED_MSG_ATTRIBUTE("first deprecated in v1.1");
+ (UIColor *)iap_C4 DEPRECATED_MSG_ATTRIBUTE("first deprecated in v1.1");
+ (UIColor *)iap_C5 DEPRECATED_MSG_ATTRIBUTE("first deprecated in v1.1");
+ (UIColor *)iap_C6 DEPRECATED_MSG_ATTRIBUTE("first deprecated in v1.1");
+ (UIColor *)iap_C7 DEPRECATED_MSG_ATTRIBUTE("first deprecated in v1.1");
+ (UIColor *)iap_C7Highlight DEPRECATED_MSG_ATTRIBUTE("first deprecated in v1.1");
+ (UIColor *)iap_C8 DEPRECATED_MSG_ATTRIBUTE("first deprecated in v1.1");
+ (UIColor *)iap_C9 DEPRECATED_MSG_ATTRIBUTE("first deprecated in v1.1");
+ (UIColor *)iap_C10 DEPRECATED_MSG_ATTRIBUTE("first deprecated in v1.1");
+ (UIColor *)iap_C11 DEPRECATED_MSG_ATTRIBUTE("first deprecated in v1.1");
+ (UIColor *)iap_C12 DEPRECATED_MSG_ATTRIBUTE("first deprecated in v1.1");
+ (UIColor *)iap_C13 DEPRECATED_MSG_ATTRIBUTE("first deprecated in v1.1");
+ (UIColor *)iap_C14 DEPRECATED_MSG_ATTRIBUTE("first deprecated in v1.1");
+ (UIColor *)iap_C15 DEPRECATED_MSG_ATTRIBUTE("first deprecated in v1.1");
+ (UIColor *)iap_C16 DEPRECATED_MSG_ATTRIBUTE("first deprecated in v1.1");
+ (UIColor *)iap_C17 DEPRECATED_MSG_ATTRIBUTE("first deprecated in v1.1");
+ (UIColor *)iap_C18 DEPRECATED_MSG_ATTRIBUTE("first deprecated in v1.1");
+ (UIColor *)iap_C19 DEPRECATED_MSG_ATTRIBUTE("first deprecated in v1.1");

@end
