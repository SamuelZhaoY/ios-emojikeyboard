//
//  GZExpandingInputView.m
//  MobileFramework
//
//  Created by zhaoy on 20/7/15.
//  Copyright (c) 2015 com.gz. All rights reserved.
//

#import "GZExpandableInputView.h"
#import "GZMessagePanel.h"
#import "GZMessageBottomViewContainer.h"


#define GZ_PLACE_HOLDER_SIZE 15.0f
#define GZ_MAX_EXPAND_HEIGHT 90.0f
#define GZ_MAX_EXPAND_TEXT_MEASURE_HEIGHT 2000.f
#define GZ_MAX_TEXT_LENGTH  150
#define GZ_EXPAND_INPUTVIEW_MIN_TXT_HEIGHT 42.0f

@interface  GZExpandableInputView()<UITextViewDelegate>

@property(assign, nonatomic)float contentPadding;
@property(assign, nonatomic)float lineHeight;

@end

@implementation GZExpandableInputView

-(instancetype)init
{
    self = [super init];
    
    self.textColor = [UIColor blackColor];
    self.font = [UIFont systemFontOfSize:GZ_PLACE_HOLDER_SIZE];
    self.delegate = self;
    self.bounces = NO;
    self.returnKeyType = UIReturnKeySend;
    self.enablesReturnKeyAutomatically = YES;
    
    //Dafault line height, set to 1
    self.lineHeight = 1;
    
    // Measure initial height and suite the text content center vertical
    CGSize suitableSize = [self sizeThatFits:CGSizeMake(self.contentSize.width, GZ_MAX_EXPAND_TEXT_MEASURE_HEIGHT)];
    self.contentPadding = (GZ_MESSAGE_PANEL_HEIGHT - GZ_MESSAGE_PANEL_VERTICAL_PADDING*2 - suitableSize.height)/2;
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
    float adjustHeight = MAX(GZ_EXPAND_INPUTVIEW_MIN_TXT_HEIGHT, lineHeight);
    adjustHeight = MIN(GZ_MAX_EXPAND_HEIGHT, adjustHeight);
    
    // Only check when line change
    if (lineHeight != self.lineHeight) {
        [self.parentView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo([NSNumber numberWithFloat:(adjustHeight + 2*GZ_MESSAGE_PANEL_VERTICAL_PADDING)]);
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
    
    if (messageString.length >= GZ_MAX_TEXT_LENGTH) {
        NSString* sendingText = [messageString substringToIndex:GZ_MAX_TEXT_LENGTH];
        NSString* remainingText = [messageString substringFromIndex:GZ_MAX_TEXT_LENGTH];
        
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
