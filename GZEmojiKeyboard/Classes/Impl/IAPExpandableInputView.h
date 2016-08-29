//
//  IAPExpandingInputView.h
//  MobileFramework
//
//  Created by zhaoy on 20/7/15.
//  Copyright (c) 2015 Alipay. All rights reserved.
//

#import <Foundation/Foundation.h>

#define IAP_EXPANDING_INPUT_SEND @"IAP_FRIEND_MESSAGE_SEND"

@interface IAPExpandableInputView : UITextView

- (BOOL)checkForSubmit:(UITextView*)textView;

@property(weak, nonatomic) UIView* parentView;

@end
