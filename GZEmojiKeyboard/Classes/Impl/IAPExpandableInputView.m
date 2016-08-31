//
//  IAPExpandingInputView.m
//  MobileFramework
//
//  Created by zhaoy on 20/7/15.
//  Copyright (c) 2015 Alipay. All rights reserved.
//

#import "IAPExpandableInputView.h"
#import "IAPMessagePanel.h"
#import "IAPMessageBottomViewContainer.h"


#define IAP_PLACE_HOLDER_SIZE 15.0f
#define IAP_MAX_EXPAND_HEIGHT 90.0f
#define IAP_MAX_EXPAND_TEXT_MEASURE_HEIGHT 2000.f
#define IAP_MAX_TEXT_LENGTH  150
#define IAP_EXPAND_INPUTVIEW_MIN_TXT_HEIGHT 42.0f

@interface  IAPExpandableInputView()<UITextViewDelegate>

@property(assign, nonatomic)float contentPadding;
@property(assign, nonatomic)float lineHeight;

@end

@implementation IAPExpandableInputView

-(instancetype)init
{
    self = [super init];
    
    self.textColor = [UIColor blackColor];
    self.font = [UIFont systemFontOfSize:IAP_PLACE_HOLDER_SIZE];
    self.delegate = self;
    self.bounces = NO;
    self.returnKeyType = UIReturnKeySend;
    self.enablesReturnKeyAutomatically = YES;
    
    //Dafault line height, set to 1
    self.lineHeight = 1;
    
    // Measure initial height and suite the text content center vertical
    CGSize suitableSize = [self sizeThatFits:CGSizeMake(self.contentSize.width, IAP_MAX_EXPAND_TEXT_MEASURE_HEIGHT)];
    self.contentPadding = (IAP_MESSAGE_PANEL_HEIGHT - IAP_MESSAGE_PANEL_VERTICAL_PADDING*2 - suitableSize.height)/2;
    self.contentInset = UIEdgeInsetsMake(self.contentPadding, 0, 0, 0);
    self.bounces = NO;
    return self;
}

#pragma mark Delegate related method

- (void)textViewDidChange:(UITextView *)textView
{
    self.parentView.autoresizesSubviews = NO;
    
    // Measure lines in textview:
    CGSize size = [self sizeThatFits:CGSizeMake(self.contentSize.width, 10000)];
    float lineHeight = size.height;
    
    // Check the range of input
    float adjustHeight = MAX(IAP_EXPAND_INPUTVIEW_MIN_TXT_HEIGHT, lineHeight);
    adjustHeight = MIN(IAP_MAX_EXPAND_HEIGHT, adjustHeight);
    
    // Only check when line change
    if (lineHeight != self.lineHeight) {
        [self.parentView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo([NSNumber numberWithFloat:(adjustHeight + 2*IAP_MESSAGE_PANEL_VERTICAL_PADDING)]);
        }];
        
        [self scrollRangeToVisible:self.selectedRange];

        self.lineHeight = lineHeight;
    }
}

#pragma mark Fire message

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    if ([text isEqualToString:@"\n"]) {
        return [self checkForSubmit:textView];
    }
    return YES;
}

- (BOOL)checkForSubmit:(UITextView*)textView
{
    if (!textView.text.length) {
        return NO;
    }
    
    // Checkout is string is empty
    if ([[textView.text stringByReplacingOccurrencesOfString:@" " withString:@""] stringByReplacingOccurrencesOfString:@"\n" withString:@""].length == 0) {
        textView.text = nil;
        return NO;
    }
    
    NSString* messageString = [textView.text copy];
    
    if (messageString.length >= IAP_MAX_TEXT_LENGTH) {
        NSString* sendingText = [messageString substringToIndex:IAP_MAX_TEXT_LENGTH];
        NSString* remainingText = [messageString substringFromIndex:IAP_MAX_TEXT_LENGTH];
        
        // Send out the first part of the message, put the remaining component in the text field
        messageString = sendingText;
        if (!remainingText.length) {
            textView.text = nil;
        } else {
            textView.text = remainingText;
        }
    } else {
        textView.text = nil;
    }
    
    [self textViewDidChange:textView];
    
    return NO;
}

@end
