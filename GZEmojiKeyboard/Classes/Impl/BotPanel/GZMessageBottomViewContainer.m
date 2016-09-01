//
//  GZMessageBottonViewContainer.m
//  MobileFramework
//
//  Created by zhaoy on 21/7/15.
//  Copyright (c) 2015 com.gz. All rights reserved.
//

#import "GZMessageBottomViewContainer.h"
#import "GZMessageBottomMenu.h"
#import "GZStickerPanelControl.h"

@interface GZMessageBottomViewContainer()

@property(assign, nonatomic)GZ_BottomPanelConfig config;

@end

@implementation GZMessageBottomViewContainer

- (instancetype)initWithMenuConfig:(GZ_BottomPanelConfig)config
{
    self = [super init];
    self.config = config;
    [self addObserver:self
           forKeyPath:@"panelMode"
              options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld
              context:nil];
    
    return self;
}

- (GZStickerPanelControl*)emoControl
{
    if (!_emoControl) {
        // config emoji& sticker control
        _emoControl = [GZStickerPanelControl new];
        [self addSubview:_emoControl];
        [_emoControl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(self.mas_leading);
            make.top.equalTo(self.mas_top);
            make.width.equalTo(self.mas_width);
            make.height.equalTo([NSNumber numberWithFloat:GZ_MESSAGE_BOT_STICKER_PANEL_HEIGHT]);
        }];
        
        [_emoControl setBackgroundColor:[UIColor colorWithRGB:GZUIKitUIGrey10]];
    }
   
    return _emoControl;
}

- (GZMessageBottomMenu*)botMenu
{
    if (!_botMenu) {
        // config & set bot menu
        _botMenu = [[GZMessageBottomMenu alloc] initWithMenuItem:[self checkMenuConfig:self.config]];
        [self addSubview:_botMenu];
        [_botMenu mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(self.mas_leading);
            make.top.equalTo(self.mas_top);
            make.width.equalTo(self.mas_width);
            make.height.equalTo([NSNumber numberWithFloat:GZ_MESSAGE_BOT_MENU_PANEL_HEIGHT]);
        }];
        
        [_botMenu setBackgroundColor:[UIColor colorWithRGB:GZUIKitUIGrey10]];
    }
    
    return _botMenu;
}

- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary<NSString *,id> *)change
                       context:(void *)context
{
    if ([object isKindOfClass:[GZMessageBottomViewContainer class]]) {
        if ([keyPath isEqualToString:NSStringFromSelector(@selector(panelMode))]) {
            NSNumber* newState = [change objectForKey:NSKeyValueChangeNewKey];
            
            if ([newState integerValue] == GZ_ACTION && [self.subviews lastObject] == self.botMenu) {
                return;
            } else if ([newState integerValue] == GZ_STICKER && [self.subviews lastObject] == self.emoControl) {
                [self.emoControl checkLayout];
                return;
            }
            
            if (!self.isInDisplay) {
                return;
            }
            
            //bring panel to front & animation
            if ([newState intValue] == GZ_STICKER) {
                self.emoControl.translatesAutoresizingMaskIntoConstraints = YES;
                self.emoControl.frame = CGRectMake(self.emoControl.frame.origin.x,
                                                   GZ_MESSAGE_BOT_MENU_PANEL_HEIGHT,
                                                   self.emoControl.frame.size.width,
                                                   self.emoControl.frame.size.height);
                [self bringSubviewToFront:self.emoControl];

                [UIView animateWithDuration:0.1
                                      delay:0
                                    options: UIViewAnimationOptionCurveLinear
                                 animations:^{
                                     self.emoControl.frame = CGRectMake(self.emoControl.frame.origin.x,
                                                                        0,
                                                                        self.emoControl.frame.size.width,
                                                                        self.emoControl.frame.size.height);                                 }
                                 completion:^(BOOL finished){
                                     self.emoControl.translatesAutoresizingMaskIntoConstraints = NO;
                                     [self.emoControl checkLayout];
                                 }];
            } else {
                self.botMenu.translatesAutoresizingMaskIntoConstraints = YES;
                self.botMenu.frame = CGRectMake(self.botMenu.frame.origin.x,
                                                   GZ_MESSAGE_BOT_STICKER_PANEL_HEIGHT,
                                                   self.botMenu.frame.size.width,
                                                   self.botMenu.frame.size.height);
                [self bringSubviewToFront:self.botMenu];

                [UIView animateWithDuration:0.1
                                      delay:0
                                    options: UIViewAnimationOptionCurveLinear
                                 animations:^{
                                     self.botMenu.frame = CGRectMake(self.botMenu.frame.origin.x,
                                                                     0,
                                                                     self.botMenu.frame.size.width,
                                                                     self.botMenu.frame.size.height);                                 }
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
- (NSArray*)checkMenuConfig:(GZ_BottomPanelConfig)config
{
    NSArray *actionItems = [NSArray new];
    if (config == GZ_INDIVIDUAL) {
        GZMessageBottomMenuItem* transferItem = [GZMessageBottomMenuItem new];
        transferItem.itemTitle = NSLocalizedString(@"Feature 1", nil);
        transferItem.itemImage = @"e647;";
        transferItem.itemColor = [UIColor colorWithRGB:GZUIKitUIColor8];
        transferItem.action = GZ_MESSAGE_BOT_PANEL_ACTION_TRANSFER;
        
        GZMessageBottomMenuItem* requestItem = [GZMessageBottomMenuItem new];
        requestItem.itemTitle = NSLocalizedString(@"Feature 2", nil);
        requestItem.itemImage = @"e648";
        requestItem.itemColor = [UIColor colorWithRGB:GZUIKitUIColor2];
        requestItem.action = GZ_MESSAGE_BOT_PANEL_ACTION_REQUEST;
        
        GZMessageBottomMenuItem* nameCardItem = [GZMessageBottomMenuItem new];
        nameCardItem.itemTitle = NSLocalizedString(@"Feature 3", nil);
        nameCardItem.itemImage = @"e668";
        nameCardItem.itemColor = [UIColor colorWithRGB:GZUIKit_Color_8];
        nameCardItem.action = GZ_MESSAGE_BOT_PANEL_ACTION_NAME_CARD;

        actionItems = @[transferItem, requestItem, nameCardItem];

    } else if (config == GZ_GROUP) {
        
        
        GZMessageBottomMenuItem* nameCardItem = [GZMessageBottomMenuItem new];
        nameCardItem.itemTitle = NSLocalizedString(@"Feature 1", nil);
        nameCardItem.itemImage = @"e668";
        nameCardItem.itemColor = [UIColor colorWithRGB:GZUIKit_Color_8];
        nameCardItem.action = GZ_MESSAGE_BOT_PANEL_ACTION_NAME_CARD;
        
        actionItems = @[nameCardItem];
    }
    
    return actionItems;
}

- (void)dealloc
{
    [self removeObserver:self forKeyPath:@"panelMode"];
}

@end
