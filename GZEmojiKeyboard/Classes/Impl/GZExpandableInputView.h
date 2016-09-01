//
//  GZExpandingInputView.h
//  MobileFramework
//
//  Created by zhaoy on 20/7/15.
//  Copyright (c) 2015 com.gz. All rights reserved.
//

#import <Foundation/Foundation.h>

#define GZ_EXPANDING_INPUT_SEND @"GZ_FRIEND_MESSAGE_SEND"

@interface GZExpandableInputView : UITextView

- (BOOL)checkForSubmit:(UITextView*)textView;

@property(weak, nonatomic) UIView* parentView;

@end
