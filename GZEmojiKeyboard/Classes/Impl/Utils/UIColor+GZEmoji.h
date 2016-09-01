//
//  UIColor+GZEmoji.h
//  GZEmojiKeyboard
//
//  Created by zhaoy on 31/8/16.
//  Copyright © 2016 com.gz. All rights reserved.
//

#import <Foundation/Foundation.h>

#define GZUIKit_Color_1            0x000000
#define GZUIKit_Color_2            0x4a4a4a
#define GZUIKit_Color_3            0x9b9b9b
#define GZUIKit_Color_4            0xbbbbbb
#define GZUIKit_Color_5            0xcccccc
#define GZUIKit_Color_6            0xffffff
#define GZUIKit_Color_7            0x00a0e9
#define GZUIKit_Color_7_Highlight  0x0080ba
#define GZUIKit_Color_8            0xff7c00
#define GZUIKit_Color_9            0xe5e5e5
#define GZUIKit_Color_10           0xebebeb
#define GZUIKit_Color_11           0x535353
#define GZUIKit_Color_12           0xeeeeee
#define GZUIKit_Color_13           0xe9e9e9
#define GZUIKit_Color_14           0x41aaef
#define GZUIKit_Color_15           0xF4F4F4
#define GZUIKit_Color_16           0xdddddd
#define GZUIKit_Color_17           0xfafafa
#define GZUIKit_Color_18           0x16CB3B
#define GZUIKit_Color_19           0xb7b7b7

// FONT GREY
UIKIT_EXTERN NSUInteger const GZUIKitFontGrey1; //000000;
UIKIT_EXTERN NSUInteger const GZUIKitFontGrey2; //4A4A4A;
UIKIT_EXTERN NSUInteger const GZUIKitFontGrey3; //9B9B9B;
UIKIT_EXTERN NSUInteger const GZUIKitFontGrey4; //BBBBBB;
UIKIT_EXTERN NSUInteger const GZUIKitFontGrey5; //CCCCCC;
UIKIT_EXTERN NSUInteger const GZUIKitFontGrey6; //FFFFFF;

// FONT COLOR
UIKIT_EXTERN NSUInteger const GZUIKitFontColor1; //00A0E9;
UIKIT_EXTERN NSUInteger const GZUIKitFontColor2; //FF7C00;

// UI GREY
UIKIT_EXTERN NSUInteger const GZUIKitUIGrey1; //000000;
UIKIT_EXTERN NSUInteger const GZUIKitUIGrey2; //333333;
UIKIT_EXTERN NSUInteger const GZUIKitUIGrey3; //4A4A4A;
UIKIT_EXTERN NSUInteger const GZUIKitUIGrey4; //6B6B6B;
UIKIT_EXTERN NSUInteger const GZUIKitUIGrey5; //9B9B9B;
UIKIT_EXTERN NSUInteger const GZUIKitUIGrey6; //CCCCCC;
UIKIT_EXTERN NSUInteger const GZUIKitUIGrey7; //D5D5D5;
UIKIT_EXTERN NSUInteger const GZUIKitUIGrey8; //DDDDDD;
UIKIT_EXTERN NSUInteger const GZUIKitUIGrey9; //E9E9E9;
UIKIT_EXTERN NSUInteger const GZUIKitUIGrey10; //EEEEEE;
UIKIT_EXTERN NSUInteger const GZUIKitUIGrey11; //F4F4F4;
UIKIT_EXTERN NSUInteger const GZUIKitUIGrey12; //FFFFFF;

// UI COLOR
UIKIT_EXTERN NSUInteger const GZUIKitUIColor1; //00A0E9;
UIKIT_EXTERN NSUInteger const GZUIKitUIColor1_Dark; //0078AF;
UIKIT_EXTERN NSUInteger const GZUIKitUIColor2; //16CB3B;
UIKIT_EXTERN NSUInteger const GZUIKitUIColor3; //FF6262;
UIKIT_EXTERN NSUInteger const GZUIKitUIColor4; //FFCD00;
UIKIT_EXTERN NSUInteger const GZUIKitUIColor5; //FF7C00;
UIKIT_EXTERN NSUInteger const GZUIKitUIColor6; //19D5C7;
UIKIT_EXTERN NSUInteger const GZUIKitUIColor7; //A26BF2;
UIKIT_EXTERN NSUInteger const GZUIKitUIColor8; //41aaef;
UIKIT_EXTERN NSUInteger const GZUIKitUIColor9; //D4F2FF
UIKIT_EXTERN NSUInteger const GZUIKitUIColor10;

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

// GZUI Font Related
+ (UIColor *)GZ_FontGrey1;
+ (UIColor *)GZ_FontGrey2;
+ (UIColor *)GZ_FontGrey3;
+ (UIColor *)GZ_FontGrey4;
+ (UIColor *)GZ_FontGrey5;
+ (UIColor *)GZ_FontGrey6;

+ (UIColor *)GZ_FontColor1;
+ (UIColor *)GZ_FontColor2;

// GZUI UI Grey Levels & Colors
+ (UIColor *)GZ_Grey1;
+ (UIColor *)GZ_Grey2;
+ (UIColor *)GZ_Grey3;
+ (UIColor *)GZ_Grey4;
+ (UIColor *)GZ_Grey5;
+ (UIColor *)GZ_Grey6;
+ (UIColor *)GZ_Grey7;
+ (UIColor *)GZ_Grey8;
+ (UIColor *)GZ_Grey9;
+ (UIColor *)GZ_Grey10;
+ (UIColor *)GZ_Grey11;
+ (UIColor *)GZ_Grey12;

+ (UIColor *)GZ_Color1;
+ (UIColor *)GZ_Color1_Dark;
+ (UIColor *)GZ_Color2;
+ (UIColor *)GZ_Color3;
+ (UIColor *)GZ_Color4;
+ (UIColor *)GZ_Color5;
+ (UIColor *)GZ_Color6;
+ (UIColor *)GZ_Color7;


// Deprecated Colors
+ (UIColor *)GZ_C1 DEPRECATED_MSG_ATTRIBUTE("first deprecated in v1.1");
+ (UIColor *)GZ_C2 DEPRECATED_MSG_ATTRIBUTE("first deprecated in v1.1");
+ (UIColor *)GZ_C3 DEPRECATED_MSG_ATTRIBUTE("first deprecated in v1.1");
+ (UIColor *)GZ_C4 DEPRECATED_MSG_ATTRIBUTE("first deprecated in v1.1");
+ (UIColor *)GZ_C5 DEPRECATED_MSG_ATTRIBUTE("first deprecated in v1.1");
+ (UIColor *)GZ_C6 DEPRECATED_MSG_ATTRIBUTE("first deprecated in v1.1");
+ (UIColor *)GZ_C7 DEPRECATED_MSG_ATTRIBUTE("first deprecated in v1.1");
+ (UIColor *)GZ_C7Highlight DEPRECATED_MSG_ATTRIBUTE("first deprecated in v1.1");
+ (UIColor *)GZ_C8 DEPRECATED_MSG_ATTRIBUTE("first deprecated in v1.1");
+ (UIColor *)GZ_C9 DEPRECATED_MSG_ATTRIBUTE("first deprecated in v1.1");
+ (UIColor *)GZ_C10 DEPRECATED_MSG_ATTRIBUTE("first deprecated in v1.1");
+ (UIColor *)GZ_C11 DEPRECATED_MSG_ATTRIBUTE("first deprecated in v1.1");
+ (UIColor *)GZ_C12 DEPRECATED_MSG_ATTRIBUTE("first deprecated in v1.1");
+ (UIColor *)GZ_C13 DEPRECATED_MSG_ATTRIBUTE("first deprecated in v1.1");
+ (UIColor *)GZ_C14 DEPRECATED_MSG_ATTRIBUTE("first deprecated in v1.1");
+ (UIColor *)GZ_C15 DEPRECATED_MSG_ATTRIBUTE("first deprecated in v1.1");
+ (UIColor *)GZ_C16 DEPRECATED_MSG_ATTRIBUTE("first deprecated in v1.1");
+ (UIColor *)GZ_C17 DEPRECATED_MSG_ATTRIBUTE("first deprecated in v1.1");
+ (UIColor *)GZ_C18 DEPRECATED_MSG_ATTRIBUTE("first deprecated in v1.1");
+ (UIColor *)GZ_C19 DEPRECATED_MSG_ATTRIBUTE("first deprecated in v1.1");

@end
