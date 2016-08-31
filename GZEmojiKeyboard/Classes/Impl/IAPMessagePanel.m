//
//  IAPMessagePanel.m
//  MobileFramework
//
//  Created by zhaoy on 20/7/15.
//  Copyright (c) 2015 Alipay. All rights reserved.
//

#import "IAPMessagePanel.h"
#import "IAPExpandableInputView.h"
#import "IAPMessageBottomViewContainer.h"
#import "IAPStickerPanelControl.h"
#import "IAPCommonUtils.h"


@interface IAPMessagePanel()

@property(strong, nonatomic)UIView* typingContainer;
@property(strong, nonatomic)IAPMessageBottomViewContainer* expandableContainer;
@property(strong, nonatomic)IAPExpandableInputView* inputView;
@property(strong, nonatomic)UIButton* menuButton;
@property(strong, nonatomic)UIButton* emojiButton;

@end

@implementation IAPMessagePanel

- (instancetype)init
{
    self= [super init];
    return self;
}

- (IAPMessagePanel*)attachToView:(UIView*)superView
{
    if (!superView) {
        return nil;
    }
    [superView addSubview:self];
    
    self.typingContainer = [UIView new];
    
    self.expandableContainer = [[IAPMessageBottomViewContainer alloc] initWithMenuConfig:IAP_INDIVIDUAL];
    
    [self addSubview:self.typingContainer];
    [self addSubview:self.expandableContainer];
    
    
    //Amount expanding text editing
    self.inputView = [IAPExpandableInputView new];
    [self.typingContainer addSubview:self.inputView];
    [self.typingContainer setBackgroundColor:[UIColor colorWithRGB:IAPUIKitUIGrey10]];
    
    self.inputView.layer.cornerRadius = 5.0f;
    self.inputView.layer.borderWidth = 0.5f;
    self.inputView.clipsToBounds = YES;
    self.inputView.layer.borderColor = [UIColor colorWithRGB:IAPUIKitUIGrey8].CGColor;
    self.inputView.parentView = self.typingContainer;
    
    //Add swipe panel switch
    self.menuButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.emojiButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [self.menuButton setImage:[IAPUIKitIconFontHelper imageWithIdentifier:@"e600" tintColor:[UIColor colorWithRGB:IAPUIKitFontGrey3] size:CGSizeMake(IAP_MESSAGE_PLUS_BUTTON_SIZE, IAP_MESSAGE_PLUS_BUTTON_SIZE + 3)] forState:UIControlStateNormal];
    [self.emojiButton setImage:[IAPUIKitIconFontHelper imageWithIdentifier:@"e601" tintColor:[UIColor colorWithRGB:IAPUIKitFontGrey3] size:CGSizeMake(IAP_MESSAGE_PLUS_BUTTON_SIZE, IAP_MESSAGE_PLUS_BUTTON_SIZE + 3)] forState:UIControlStateNormal];
    
    [self.menuButton addTarget:self action:@selector(toggleBottomMenuPanel) forControlEvents:UIControlEventTouchUpInside];
    [self.emojiButton addTarget:self action:@selector(toggleBottonStickerPanel) forControlEvents:UIControlEventTouchUpInside];
    
    [self.typingContainer addSubview:self.emojiButton];
    [self.typingContainer addSubview:self.menuButton];
    
    [self.typingContainer mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.typingContainer.superview.mas_leading);
        make.trailing.equalTo(self.typingContainer.superview.mas_trailing);
        make.bottom.equalTo(self.superview.mas_bottom).offset(-IAP_MESSAGE_BOT_STICKER_PANEL_HEIGHT - [IAPCommonUtils getNavigationHeight]);
        make.height.equalTo([NSNumber numberWithFloat:IAP_MESSAGE_PANEL_HEIGHT]);
    }];
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.typingContainer.mas_top);
        make.bottom.equalTo(self.expandableContainer.mas_bottom);
        make.leading.equalTo(superView.mas_leading);
        make.width.equalTo(superView.mas_width);
    }];

    UIView* line = [UIView new];
    [line setBackgroundColor:[UIColor colorWithRGB:IAPUIKitFontGrey5]];
    [self.typingContainer addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(line.superview.mas_width);
        make.leading.equalTo(line.superview.mas_leading);
        make.height.equalTo(@0.5);
        make.top.equalTo(line.superview.mas_top).offset(-0.5);
    }];

    [self.inputView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.inputView.superview.mas_leading).offset(IAP_MESSAGE_PANEL_INTERNAL_PADDING);
        make.trailing.equalTo(self.inputView.superview.mas_trailing).offset(-(IAP_MESSAGE_PANEL_INTERNAL_PADDING*3+IAP_MESSAGE_PLUS_BUTTON_SIZE*2));
        make.top.equalTo(self.inputView.superview.mas_top).offset(IAP_MESSAGE_PANEL_VERTICAL_PADDING);
        make.bottom.equalTo(self.inputView.superview.mas_bottom).offset(-IAP_MESSAGE_PANEL_VERTICAL_PADDING);
    }];
   
    [self.menuButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(IAP_MESSAGE_PLUS_BUTTON_SIZE+5));
        make.width.equalTo(@IAP_MESSAGE_PLUS_BUTTON_SIZE);
        make.bottom.equalTo(self.menuButton.superview.mas_bottom).offset(-IAP_MESSAGE_PANEL_INTERNAL_PADDING);
        make.trailing.equalTo(self.typingContainer.mas_trailing).offset(-IAP_MESSAGE_PANEL_INTERNAL_PADDING);
    }];
    
    [self.emojiButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(IAP_MESSAGE_PLUS_BUTTON_SIZE+5));
        make.width.equalTo(@IAP_MESSAGE_PLUS_BUTTON_SIZE);
        make.bottom.equalTo(self.menuButton.superview.mas_bottom).offset(-IAP_MESSAGE_PANEL_INTERNAL_PADDING);
        make.trailing.equalTo(self.menuButton.mas_leading).offset(-IAP_MESSAGE_PANEL_INTERNAL_PADDING);
    }];
    
    // Configuration of the bottom message panel
    UIView* botLine = [UIView new];
    [botLine setBackgroundColor:[UIColor colorWithRGB:IAPUIKitFontGrey5]];
    [self.typingContainer addSubview:botLine];
    [botLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(botLine.superview.mas_width);
        make.leading.equalTo(botLine.superview.mas_leading);
        make.height.equalTo(@0.5);
        make.top.equalTo(self.typingContainer.mas_bottom);
    }];
    
    [self.expandableContainer setBackgroundColor:[UIColor colorWithRGB:IAPUIKitUIGrey10]];
    [self.expandableContainer mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(self.expandableContainer.superview.mas_width);
        make.leading.equalTo(self.expandableContainer.superview.mas_leading);
        make.height.equalTo([NSNumber numberWithFloat:IAP_MESSAGE_BOT_STICKER_PANEL_HEIGHT]);
        make.top.equalTo(botLine.mas_bottom);
    }];
    
    self.expandableContainer.emoControl.associatedInput = self.inputView;
    
    // Toggling keybaord control
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboadWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
    return self;
}

- (void)resetPanel
{
    [self.inputView resignFirstResponder];
    
    //Hide panel
    self.expandableContainer.isInDisplay = NO;
    self.expandableContainer.panelMode = IAP_ACTION;
    [self checkBottomLayout];
}

- (void)keyboadWillShow:(NSNotification*)notificaiton
{
    self.expandableContainer.isInDisplay = NO;
    self.expandableContainer.panelMode = IAP_ACTION;
    [self checkEmojiButton];
    
    self.menuButton.transform = CGAffineTransformMakeRotation(0);
    
    CGRect keyboardRect = [[[notificaiton userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGRect frame = self.superview.frame;
    float originalY = frame.origin.y;
    frame.origin.y = /*[IAPCommonUtils getNavigationHeight]*/ - keyboardRect.size.height;
    
    [self postScrollInsetChange:originalY - frame.origin.y];
    self.superview.frame = frame;
}

- (void)keyboardWillHide:(NSNotification*)notification
{
    [self.inputView resignFirstResponder];
    
    //Hide panel
    [self checkBottomLayout];
}

- (void)toggleBottomMenuPanel
{
    if (!self.expandableContainer.isInDisplay) {
        self.expandableContainer.isInDisplay = YES;
    } else {
        if (self.expandableContainer.panelMode == IAP_ACTION) {
            self.expandableContainer.isInDisplay = NO;
        }
    }
    
    self.expandableContainer.panelMode = IAP_ACTION;
    [self.inputView resignFirstResponder];
    [self checkBottomLayout];
}

- (void)toggleBottonStickerPanel
{
    if (!self.expandableContainer.isInDisplay) {
        self.expandableContainer.isInDisplay = YES;
    } else {
        if (self.expandableContainer.panelMode == IAP_STICKER) {
            self.expandableContainer.isInDisplay = NO;
            self.expandableContainer.panelMode = IAP_ACTION;
            [self checkEmojiButton];
            [self toggleKeyboard];
            return;
        }
    }
    self.expandableContainer.panelMode = IAP_STICKER;
    
    [self.inputView resignFirstResponder];
    [self checkBottomLayout];
}

- (void)toggleKeyboard
{
    [self.inputView becomeFirstResponder];
}

- (void)checkEmojiButton
{
    // Check emoji icon status
    if (self.expandableContainer.panelMode == IAP_ACTION) {
        [self.emojiButton setImage:[IAPUIKitIconFontHelper imageWithIdentifier:@"e601" tintColor:[UIColor colorWithRGB:IAPUIKitFontGrey3] size:CGSizeMake(IAP_MESSAGE_PLUS_BUTTON_SIZE, IAP_MESSAGE_PLUS_BUTTON_SIZE+3)] forState:UIControlStateNormal];
    } else {
        [self.emojiButton setImage:[IAPUIKitIconFontHelper imageWithIdentifier:@"e62f" tintColor:[UIColor colorWithRGB:IAPUIKitFontGrey3] size:CGSizeMake(IAP_MESSAGE_PLUS_BUTTON_SIZE, IAP_MESSAGE_PLUS_BUTTON_SIZE+3)] forState:UIControlStateNormal];
    }
}

- (void)checkBottomLayout
{
    [self checkEmojiButton];
    
    // Check offset & expandable rotation
    CGRect frame = self.superview.frame;
    float originalY = frame.origin.y;
    frame.origin.y = [self checkBottomHeight];
    
    [UIView animateWithDuration:0.2f
                          delay:0.0
                        options:UIViewAnimationOptionBeginFromCurrentState
                     animations:^{
                         self.superview.frame = frame;
                         [self postScrollInsetChange:originalY - frame.origin.y];
                     }
                     completion:nil];
    
    if (originalY != frame.origin.y) {
        // Check about rotation state
        NSNumber *rotationAtStart = [self.menuButton.layer valueForKeyPath:@"transform.rotation"];
        BOOL isCurrentExpanding = ((int)([rotationAtStart floatValue]/(45.0f * M_PI/180))%2);
        BOOL needCrossing = NO;
        
        if (self.expandableContainer.panelMode == IAP_ACTION && self.expandableContainer.isInDisplay) {
            needCrossing = YES;
        } else {
            needCrossing = NO;
        }
        
        if (isCurrentExpanding == needCrossing) {
            return;
        }
        
        // Adpot layer animation here, for user view animation will trigger origin change
        CATransform3D myRotationTransform = CATransform3DRotate(self.menuButton.layer.transform, needCrossing ? 45.0f * M_PI/180 : -45.0f * M_PI/180, 0.0, 0.0, 1.0);
        self.menuButton.layer.transform = myRotationTransform;
        CABasicAnimation *myAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
        myAnimation.duration = 0.2f;
        myAnimation.fromValue = rotationAtStart;
        myAnimation.toValue = [NSNumber numberWithFloat:(needCrossing ? 45.0f * M_PI/180 : -45.0f * M_PI/180)];

        [self.menuButton.layer addAnimation:myAnimation forKey:@"transform.rotation"];
    }
}

-(float)checkBottomHeight
{
    float bottomHeight;
    
    // Check expanding state
    if (!self.expandableContainer.isInDisplay) {
        bottomHeight = 0;
    } else {
        bottomHeight = - ((self.expandableContainer.panelMode == IAP_ACTION)? IAP_MESSAGE_BOT_MENU_PANEL_HEIGHT : IAP_MESSAGE_BOT_STICKER_PANEL_HEIGHT);
    }
    
    return bottomHeight;
}

- (void)postScrollInsetChange:(float)deltaChange
{
    [[NSNotificationCenter defaultCenter] postNotificationName:IAP_MESSAGE_PANEL_SCROLL_INSET_CHANGE
                                                        object:self
                                                      userInfo:@{@"insetHeight":[NSNumber numberWithFloat:deltaChange]}];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}


@end
