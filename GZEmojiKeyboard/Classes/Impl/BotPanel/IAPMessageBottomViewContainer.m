//
//  IAPMessageBottonViewContainer.m
//  MobileFramework
//
//  Created by zhaoy on 21/7/15.
//  Copyright (c) 2015 Alipay. All rights reserved.
//

#import "IAPMessageBottomViewContainer.h"
#import "IAPMessageBottomMenu.h"
#import "IAPStickerPanelControl.h"

@interface IAPMessageBottomViewContainer()

@property(assign, nonatomic)IAP_BottomPanelConfig config;

@end

@implementation IAPMessageBottomViewContainer

- (instancetype)initWithMenuConfig:(IAP_BottomPanelConfig)config
{
    self = [super init];
    self.config = config;
    [self addObserver:self
           forKeyPath:@"panelMode"
              options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld
              context:nil];
    
    return self;
}

- (IAPStickerPanelControl*)emoControl
{
    if (!_emoControl) {
        // config emoji& sticker control
        _emoControl = [IAPStickerPanelControl new];
        [self addSubview:_emoControl];
        [_emoControl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(self.mas_leading);
            make.top.equalTo(self.mas_top);
            make.width.equalTo(self.mas_width);
            make.height.equalTo([NSNumber numberWithFloat:IAP_MESSAGE_BOT_STICKER_PANEL_HEIGHT]);
        }];
        
        [_emoControl setBackgroundColor:[UIColor colorWithRGB:IAPUIKitUIGrey10]];
    }
   
    return _emoControl;
}

- (IAPMessageBottomMenu*)botMenu
{
    if (!_botMenu) {
        // config & set bot menu
        _botMenu = [[IAPMessageBottomMenu alloc] initWithMenuItem:[self checkMenuConfig:self.config]];
        [self addSubview:_botMenu];
        [_botMenu mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(self.mas_leading);
            make.top.equalTo(self.mas_top);
            make.width.equalTo(self.mas_width);
            make.height.equalTo([NSNumber numberWithFloat:IAP_MESSAGE_BOT_MENU_PANEL_HEIGHT]);
        }];
        
        [_botMenu setBackgroundColor:[UIColor colorWithRGB:IAPUIKitUIGrey10]];
    }
    
    return _botMenu;
}

- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary<NSString *,id> *)change
                       context:(void *)context
{
    if ([object isKindOfClass:[IAPMessageBottomViewContainer class]]) {
        if ([keyPath isEqualToString:NSStringFromSelector(@selector(panelMode))]) {
            NSNumber* newState = [change objectForKey:NSKeyValueChangeNewKey];
            
            if ([newState integerValue] == IAP_ACTION && [self.subviews lastObject] == self.botMenu) {
                return;
            } else if ([newState integerValue] == IAP_STICKER && [self.subviews lastObject] == self.emoControl) {
                [self.emoControl checkLayout];
                return;
            }
            
            if (!self.isInDisplay) {
                return;
            }
            
            //bring panel to front & animation
            if ([newState intValue] == IAP_STICKER) {
                self.emoControl.translatesAutoresizingMaskIntoConstraints = YES;
                self.emoControl.y = IAP_MESSAGE_BOT_MENU_PANEL_HEIGHT;
                [self bringSubviewToFront:self.emoControl];

                [UIView animateWithDuration:0.1
                                      delay:0
                                    options: UIViewAnimationOptionCurveLinear
                                 animations:^{
                                     self.emoControl.y = 0;
                                 }
                                 completion:^(BOOL finished){
                                     self.emoControl.translatesAutoresizingMaskIntoConstraints = NO;
                                     [self.emoControl checkLayout];
                                 }];
            } else {
                self.botMenu.translatesAutoresizingMaskIntoConstraints = YES;
                self.botMenu.y = IAP_MESSAGE_BOT_STICKER_PANEL_HEIGHT;
                [self bringSubviewToFront:self.botMenu];

                [UIView animateWithDuration:0.1
                                      delay:0
                                    options: UIViewAnimationOptionCurveLinear
                                 animations:^{
                                     self.botMenu.y = 0;
                                 }
                                 completion:^(BOOL finished){
                                     self.botMenu.translatesAutoresizingMaskIntoConstraints = NO;
                                     [self bringSubviewToFront:self.botMenu];
                                 }];
                
                self.botMenu.translatesAutoresizingMaskIntoConstraints = NO;
            }
        }
    }
}

// Check menu item according to conversation config
- (NSArray*)checkMenuConfig:(IAP_BottomPanelConfig)config
{
    NSArray *actionItems = [NSArray new];
    if (config == IAP_INDIVIDUAL) {
        IAPMessageBottomMenuItem* transferItem = [IAPMessageBottomMenuItem new];
        transferItem.itemTitle = NSLocalizedString(@"Feature 1", nil);
        transferItem.itemImage = @"e647;";
        transferItem.itemColor = [UIColor colorWithRGB:IAPUIKitUIColor8];
        transferItem.action = IAP_MESSAGE_BOT_PANEL_ACTION_TRANSFER;
        
        IAPMessageBottomMenuItem* requestItem = [IAPMessageBottomMenuItem new];
        requestItem.itemTitle = NSLocalizedString(@"Feature 2", nil);
        requestItem.itemImage = @"e648";
        requestItem.itemColor = [UIColor colorWithRGB:IAPUIKitUIColor2];
        requestItem.action = IAP_MESSAGE_BOT_PANEL_ACTION_REQUEST;
        
        IAPMessageBottomMenuItem* nameCardItem = [IAPMessageBottomMenuItem new];
        nameCardItem.itemTitle = NSLocalizedString(@"Feature 3", nil);
        nameCardItem.itemImage = @"e668";
        nameCardItem.itemColor = [UIColor colorWithRGB:IAPUIKit_Color_8];
        nameCardItem.action = IAP_MESSAGE_BOT_PANEL_ACTION_NAME_CARD;

        actionItems = @[transferItem, requestItem, nameCardItem];

    } else if (config == IAP_GROUP) {
        
        
        IAPMessageBottomMenuItem* nameCardItem = [IAPMessageBottomMenuItem new];
        nameCardItem.itemTitle = NSLocalizedString(@"Feature 1", nil);
        nameCardItem.itemImage = @"e668";
        nameCardItem.itemColor = [UIColor colorWithRGB:IAPUIKit_Color_8];
        nameCardItem.action = IAP_MESSAGE_BOT_PANEL_ACTION_NAME_CARD;
        
        actionItems = @[nameCardItem];
    }
    
    return actionItems;
}

- (void)dealloc
{
    [self removeObserver:self forKeyPath:@"panelMode"];
}

@end
