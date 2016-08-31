//
//  UIColor+GZEmoji.m
//  GZEmojiKeyboard
//
//  Created by zhaoy on 31/8/16.
//  Copyright © 2016 com.gz. All rights reserved.
//

#import "UIColor+GZEmoji.h"

// FONT GREY
NSUInteger const IAPUIKitFontGrey1 = 0x000000;
NSUInteger const IAPUIKitFontGrey2 = 0x4A4A4A;
NSUInteger const IAPUIKitFontGrey3 = 0x9B9B9B;
NSUInteger const IAPUIKitFontGrey4 = 0xBBBBBB;
NSUInteger const IAPUIKitFontGrey5 = 0xCCCCCC;
NSUInteger const IAPUIKitFontGrey6 = 0xFFFFFF;

// FONT COLOR
NSUInteger const IAPUIKitFontColor1 = 0x00A0E9;
NSUInteger const IAPUIKitFontColor2 = 0xFF7C00;

// UI GREY
NSUInteger const IAPUIKitUIGrey1 = 0x000000;
NSUInteger const IAPUIKitUIGrey2 = 0x333333;
NSUInteger const IAPUIKitUIGrey3 = 0x4A4A4A;
NSUInteger const IAPUIKitUIGrey4 = 0x6B6B6B;
NSUInteger const IAPUIKitUIGrey5 = 0x9B9B9B;
NSUInteger const IAPUIKitUIGrey6 = 0xCCCCCC;
NSUInteger const IAPUIKitUIGrey7 = 0xD5D5D5;
NSUInteger const IAPUIKitUIGrey8 = 0xDDDDDD;
NSUInteger const IAPUIKitUIGrey9 = 0xE9E9E9;
NSUInteger const IAPUIKitUIGrey10 = 0xEEEEEE;
NSUInteger const IAPUIKitUIGrey11 = 0xF4F4F4;
NSUInteger const IAPUIKitUIGrey12 = 0xFFFFFF;

// UI COLOR
NSUInteger const IAPUIKitUIColor1 = 0x00A0E9;
NSUInteger const IAPUIKitUIColor1_Dark = 0x0078AF;
NSUInteger const IAPUIKitUIColor2 = 0x16CB3B;
NSUInteger const IAPUIKitUIColor3 = 0xFF6262;
NSUInteger const IAPUIKitUIColor4 = 0xFFCD00;
NSUInteger const IAPUIKitUIColor5 = 0xFF7C00;
NSUInteger const IAPUIKitUIColor6 = 0x19D5C7;
NSUInteger const IAPUIKitUIColor7 = 0xA26BF2;
NSUInteger const IAPUIKitUIColor8 = 0x41aaef;
NSUInteger const IAPUIKitUIColor9 = 0xD4F2FF;
NSUInteger const IAPUIKitUIColor10 = 0xE5E5E5;



@implementation UIColor (GZEmoji)


#pragma font grey

+ (UIColor *)iap_FontGrey1
{
    return [UIColor colorWithRGB:IAPUIKitFontGrey1];
}

+ (UIColor *)iap_FontGrey2
{
    return [UIColor colorWithRGB:IAPUIKitFontGrey2];
}

+ (UIColor *)iap_FontGrey3
{
    return [UIColor colorWithRGB:IAPUIKitFontGrey3];
}

+ (UIColor *)iap_FontGrey4
{
    return [UIColor colorWithRGB:IAPUIKitFontGrey4];
}

+ (UIColor *)iap_FontGrey5
{
    return [UIColor colorWithRGB:IAPUIKitFontGrey5];
}

+ (UIColor *)iap_FontGrey6
{
    return [UIColor colorWithRGB:IAPUIKitFontGrey6];
}


#pragma font color

+ (UIColor *)iap_FontColor1
{
    return [UIColor colorWithRGB:IAPUIKitFontColor1];
}

+ (UIColor *)iap_FontColor2
{
    return [UIColor colorWithRGB:IAPUIKitFontColor2];
}



#pragma ui grey

+ (UIColor *)iap_Grey1
{
    return [UIColor colorWithRGB:IAPUIKitUIGrey1];
}

+ (UIColor *)iap_Grey2
{
    return [UIColor colorWithRGB:IAPUIKitUIGrey2];
}

+ (UIColor *)iap_Grey3
{
    return [UIColor colorWithRGB:IAPUIKitUIGrey3];
}

+ (UIColor *)iap_Grey4
{
    return [UIColor colorWithRGB:IAPUIKitUIGrey4];
}

+ (UIColor *)iap_Grey5
{
    return [UIColor colorWithRGB:IAPUIKitUIGrey5];
}

+ (UIColor *)iap_Grey6
{
    return [UIColor colorWithRGB:IAPUIKitUIGrey6];
}

+ (UIColor *)iap_Grey7
{
    return [UIColor colorWithRGB:IAPUIKitUIGrey7];
}

+ (UIColor *)iap_Grey8
{
    return [UIColor colorWithRGB:IAPUIKitUIGrey8];
}

+ (UIColor *)iap_Grey9
{
    return [UIColor colorWithRGB:IAPUIKitUIGrey9];
}

+ (UIColor *)iap_Grey10
{
    return [UIColor colorWithRGB:IAPUIKitUIGrey10];
}

+ (UIColor *)iap_Grey11
{
    return [UIColor colorWithRGB:IAPUIKitUIGrey11];
}

+ (UIColor *)iap_Grey12
{
    return [UIColor colorWithRGB:IAPUIKitUIGrey12];
}


#pragma ui color

+ (UIColor *)iap_Color1
{
    return [UIColor colorWithRGB:IAPUIKitUIColor1];
}

+ (UIColor *)iap_Color1_Dark
{
    return [UIColor colorWithRGB:IAPUIKitUIColor1_Dark];
}

+ (UIColor *)iap_Color2
{
    return [UIColor colorWithRGB:IAPUIKitUIColor2];
}

+ (UIColor *)iap_Color3
{
    return [UIColor colorWithRGB:IAPUIKitUIColor3];
}

+ (UIColor *)iap_Color4
{
    return [UIColor colorWithRGB:IAPUIKitUIColor4];
}

+ (UIColor *)iap_Color5
{
    return [UIColor colorWithRGB:IAPUIKitUIColor5];
}

+ (UIColor *)iap_Color6
{
    return [UIColor colorWithRGB:IAPUIKitUIColor6];
}

+ (UIColor *)iap_Color7
{
    return [UIColor colorWithRGB:IAPUIKitUIColor7];
}



#pragma deprecated color method

+ (UIColor *)iap_C1
{
    return [UIColor colorWithRGB:IAPUIKitFontGrey1];
}

+ (UIColor *)iap_C2
{
    return [UIColor colorWithRGB:IAPUIKit_Color_2];
}

+ (UIColor *)iap_C3
{
    return [UIColor colorWithRGB:IAPUIKit_Color_3];
}

+ (UIColor *)iap_C4
{
    return [UIColor colorWithRGB:IAPUIKit_Color_4];
}

+ (UIColor *)iap_C5
{
    return [UIColor colorWithRGB:IAPUIKit_Color_5];
}

+ (UIColor *)iap_C6
{
    return [UIColor colorWithRGB:IAPUIKit_Color_6];
}

+ (UIColor *)iap_C7
{
    return [UIColor colorWithRGB:IAPUIKit_Color_7];
}
+ (UIColor *)iap_C7Highlight
{
    return [UIColor colorWithRGB:IAPUIKit_Color_7_Highlight];
}

+ (UIColor *)iap_C8
{
    return [UIColor colorWithRGB:IAPUIKit_Color_8];
}

+ (UIColor *)iap_C9
{
    return [UIColor colorWithRGB:IAPUIKit_Color_9];
}

+ (UIColor *)iap_C10
{
    return [UIColor colorWithRGB:IAPUIKit_Color_10];
}
+ (UIColor *)iap_C11
{
    return [UIColor colorWithRGB:IAPUIKit_Color_11];
}
+ (UIColor *)iap_C12
{
    return [UIColor colorWithRGB:IAPUIKit_Color_12];
}
+ (UIColor *)iap_C13
{
    return [UIColor colorWithRGB:IAPUIKit_Color_13];
}
+ (UIColor *)iap_C14
{
    return [UIColor colorWithRGB:IAPUIKit_Color_14];
}
+ (UIColor *)iap_C15
{
    return [UIColor colorWithRGB:IAPUIKit_Color_15];
}

+ (UIColor *)iap_C16
{
    return [UIColor colorWithRGB:IAPUIKit_Color_16];
}

+ (UIColor *)iap_C17
{
    return [UIColor colorWithRGB:IAPUIKit_Color_17];
}

+ (UIColor *)iap_C18
{
    return [UIColor colorWithRGB:IAPUIKit_Color_18];
}

+ (UIColor *)iap_C19
{
    return [UIColor colorWithRGB:IAPUIKit_Color_19];
}


#pragma util method

+ (UIColor *)colorWithRGB:(NSUInteger)rgb
{
    return [UIColor colorWithRGB:rgb alpha:1.0];
}

+ (UIColor *)colorWithRGB:(NSUInteger)rgb alpha:(CGFloat)alpha
{
    return [UIColor colorWithRed:((rgb & 0xFF0000) >> 16) / 255.0f
                           green:((rgb & 0xFF00) >> 8) / 255.0f
                            blue:((rgb & 0xFF)) / 255.0f
                           alpha:alpha];
}


@end
