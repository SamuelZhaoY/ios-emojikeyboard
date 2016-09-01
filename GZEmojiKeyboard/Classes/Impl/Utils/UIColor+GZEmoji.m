//
//  UIColor+GZEmoji.m
//  GZEmojiKeyboard
//
//  Created by zhaoy on 31/8/16.
//  Copyright © 2016 com.gz. All rights reserved.
//

#import "UIColor+GZEmoji.h"

// FONT GREY
NSUInteger const GZUIKitFontGrey1 = 0x000000;
NSUInteger const GZUIKitFontGrey2 = 0x4A4A4A;
NSUInteger const GZUIKitFontGrey3 = 0x9B9B9B;
NSUInteger const GZUIKitFontGrey4 = 0xBBBBBB;
NSUInteger const GZUIKitFontGrey5 = 0xCCCCCC;
NSUInteger const GZUIKitFontGrey6 = 0xFFFFFF;

// FONT COLOR
NSUInteger const GZUIKitFontColor1 = 0x00A0E9;
NSUInteger const GZUIKitFontColor2 = 0xFF7C00;

// UI GREY
NSUInteger const GZUIKitUIGrey1 = 0x000000;
NSUInteger const GZUIKitUIGrey2 = 0x333333;
NSUInteger const GZUIKitUIGrey3 = 0x4A4A4A;
NSUInteger const GZUIKitUIGrey4 = 0x6B6B6B;
NSUInteger const GZUIKitUIGrey5 = 0x9B9B9B;
NSUInteger const GZUIKitUIGrey6 = 0xCCCCCC;
NSUInteger const GZUIKitUIGrey7 = 0xD5D5D5;
NSUInteger const GZUIKitUIGrey8 = 0xDDDDDD;
NSUInteger const GZUIKitUIGrey9 = 0xE9E9E9;
NSUInteger const GZUIKitUIGrey10 = 0xEEEEEE;
NSUInteger const GZUIKitUIGrey11 = 0xF4F4F4;
NSUInteger const GZUIKitUIGrey12 = 0xFFFFFF;

// UI COLOR
NSUInteger const GZUIKitUIColor1 = 0x00A0E9;
NSUInteger const GZUIKitUIColor1_Dark = 0x0078AF;
NSUInteger const GZUIKitUIColor2 = 0x16CB3B;
NSUInteger const GZUIKitUIColor3 = 0xFF6262;
NSUInteger const GZUIKitUIColor4 = 0xFFCD00;
NSUInteger const GZUIKitUIColor5 = 0xFF7C00;
NSUInteger const GZUIKitUIColor6 = 0x19D5C7;
NSUInteger const GZUIKitUIColor7 = 0xA26BF2;
NSUInteger const GZUIKitUIColor8 = 0x41aaef;
NSUInteger const GZUIKitUIColor9 = 0xD4F2FF;
NSUInteger const GZUIKitUIColor10 = 0xE5E5E5;



@implementation UIColor (GZEmoji)


#pragma font grey

+ (UIColor *)GZ_FontGrey1
{
    return [UIColor colorWithRGB:GZUIKitFontGrey1];
}

+ (UIColor *)GZ_FontGrey2
{
    return [UIColor colorWithRGB:GZUIKitFontGrey2];
}

+ (UIColor *)GZ_FontGrey3
{
    return [UIColor colorWithRGB:GZUIKitFontGrey3];
}

+ (UIColor *)GZ_FontGrey4
{
    return [UIColor colorWithRGB:GZUIKitFontGrey4];
}

+ (UIColor *)GZ_FontGrey5
{
    return [UIColor colorWithRGB:GZUIKitFontGrey5];
}

+ (UIColor *)GZ_FontGrey6
{
    return [UIColor colorWithRGB:GZUIKitFontGrey6];
}


#pragma font color

+ (UIColor *)GZ_FontColor1
{
    return [UIColor colorWithRGB:GZUIKitFontColor1];
}

+ (UIColor *)GZ_FontColor2
{
    return [UIColor colorWithRGB:GZUIKitFontColor2];
}



#pragma ui grey

+ (UIColor *)GZ_Grey1
{
    return [UIColor colorWithRGB:GZUIKitUIGrey1];
}

+ (UIColor *)GZ_Grey2
{
    return [UIColor colorWithRGB:GZUIKitUIGrey2];
}

+ (UIColor *)GZ_Grey3
{
    return [UIColor colorWithRGB:GZUIKitUIGrey3];
}

+ (UIColor *)GZ_Grey4
{
    return [UIColor colorWithRGB:GZUIKitUIGrey4];
}

+ (UIColor *)GZ_Grey5
{
    return [UIColor colorWithRGB:GZUIKitUIGrey5];
}

+ (UIColor *)GZ_Grey6
{
    return [UIColor colorWithRGB:GZUIKitUIGrey6];
}

+ (UIColor *)GZ_Grey7
{
    return [UIColor colorWithRGB:GZUIKitUIGrey7];
}

+ (UIColor *)GZ_Grey8
{
    return [UIColor colorWithRGB:GZUIKitUIGrey8];
}

+ (UIColor *)GZ_Grey9
{
    return [UIColor colorWithRGB:GZUIKitUIGrey9];
}

+ (UIColor *)GZ_Grey10
{
    return [UIColor colorWithRGB:GZUIKitUIGrey10];
}

+ (UIColor *)GZ_Grey11
{
    return [UIColor colorWithRGB:GZUIKitUIGrey11];
}

+ (UIColor *)GZ_Grey12
{
    return [UIColor colorWithRGB:GZUIKitUIGrey12];
}


#pragma ui color

+ (UIColor *)GZ_Color1
{
    return [UIColor colorWithRGB:GZUIKitUIColor1];
}

+ (UIColor *)GZ_Color1_Dark
{
    return [UIColor colorWithRGB:GZUIKitUIColor1_Dark];
}

+ (UIColor *)GZ_Color2
{
    return [UIColor colorWithRGB:GZUIKitUIColor2];
}

+ (UIColor *)GZ_Color3
{
    return [UIColor colorWithRGB:GZUIKitUIColor3];
}

+ (UIColor *)GZ_Color4
{
    return [UIColor colorWithRGB:GZUIKitUIColor4];
}

+ (UIColor *)GZ_Color5
{
    return [UIColor colorWithRGB:GZUIKitUIColor5];
}

+ (UIColor *)GZ_Color6
{
    return [UIColor colorWithRGB:GZUIKitUIColor6];
}

+ (UIColor *)GZ_Color7
{
    return [UIColor colorWithRGB:GZUIKitUIColor7];
}



#pragma deprecated color method

+ (UIColor *)GZ_C1
{
    return [UIColor colorWithRGB:GZUIKitFontGrey1];
}

+ (UIColor *)GZ_C2
{
    return [UIColor colorWithRGB:GZUIKit_Color_2];
}

+ (UIColor *)GZ_C3
{
    return [UIColor colorWithRGB:GZUIKit_Color_3];
}

+ (UIColor *)GZ_C4
{
    return [UIColor colorWithRGB:GZUIKit_Color_4];
}

+ (UIColor *)GZ_C5
{
    return [UIColor colorWithRGB:GZUIKit_Color_5];
}

+ (UIColor *)GZ_C6
{
    return [UIColor colorWithRGB:GZUIKit_Color_6];
}

+ (UIColor *)GZ_C7
{
    return [UIColor colorWithRGB:GZUIKit_Color_7];
}
+ (UIColor *)GZ_C7Highlight
{
    return [UIColor colorWithRGB:GZUIKit_Color_7_Highlight];
}

+ (UIColor *)GZ_C8
{
    return [UIColor colorWithRGB:GZUIKit_Color_8];
}

+ (UIColor *)GZ_C9
{
    return [UIColor colorWithRGB:GZUIKit_Color_9];
}

+ (UIColor *)GZ_C10
{
    return [UIColor colorWithRGB:GZUIKit_Color_10];
}
+ (UIColor *)GZ_C11
{
    return [UIColor colorWithRGB:GZUIKit_Color_11];
}
+ (UIColor *)GZ_C12
{
    return [UIColor colorWithRGB:GZUIKit_Color_12];
}
+ (UIColor *)GZ_C13
{
    return [UIColor colorWithRGB:GZUIKit_Color_13];
}
+ (UIColor *)GZ_C14
{
    return [UIColor colorWithRGB:GZUIKit_Color_14];
}
+ (UIColor *)GZ_C15
{
    return [UIColor colorWithRGB:GZUIKit_Color_15];
}

+ (UIColor *)GZ_C16
{
    return [UIColor colorWithRGB:GZUIKit_Color_16];
}

+ (UIColor *)GZ_C17
{
    return [UIColor colorWithRGB:GZUIKit_Color_17];
}

+ (UIColor *)GZ_C18
{
    return [UIColor colorWithRGB:GZUIKit_Color_18];
}

+ (UIColor *)GZ_C19
{
    return [UIColor colorWithRGB:GZUIKit_Color_19];
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
