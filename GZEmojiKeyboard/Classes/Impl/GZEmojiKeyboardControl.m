//
//  GZMessageEmoControl.m
//  MobileFramework
//
//  Created by zhaoy on 5/10/15.
//  Copyright © 2015 com.gz. All rights reserved.
//

#import "GZEmojiKeyboardControl.h"
#import <QuartzCore/QuartzCore.h>
#import "GZStickerPackage.h"
#import "GZStickerContentScrollView.h"
#import "GZStickerPackagePanel.h"
#import "GZStickerPanelLayoutStrategy.h"
#import "GZCommonUtils.h"


const float GZ_EMO_PACK_BAR_HEIGHT = 40;
const float GZ_EMO_PACK_ITEM_WIDTH = 45;
const float GZ_EMO_ICON_SIZE = 35;
const float GZ_EMO_STICKER_SIZE = 70;


@interface GZEmojiKeyboardControl()<UIScrollViewDelegate>

@property(strong, nonatomic)GZStickerPackagePanel* packageSelector;
@property(strong, nonatomic)GZStickerContentScrollView* contentScrollView;
@property(strong, nonatomic)NSArray* stickerList;

@end

@implementation GZEmojiKeyboardControl

- (instancetype)init
{
    self = [super init];
    [self setBackgroundColor:[UIColor colorWithRGB:0xEEEEEE]];
    
    // Create Component
    self.packageSelector = [GZStickerPackagePanel new];
    self.contentScrollView = [[GZStickerContentScrollView alloc] initWithFrame:CGRectMake(0,
                                                                                          0,
                                                                                          [GZCommonUtils getMainScreenWidth],
                                                                                          GZ_MESSAGE_BOT_STICKER_PANEL_HEIGHT - 15)
                                                         collectionViewLayout:[GZStickerPanelLayoutStrategy new]];
    UIPageControl* pageControl = [UIPageControl new];
    pageControl.hidesForSinglePage = YES;
    pageControl.enabled = NO;
    pageControl.pageIndicatorTintColor = [UIColor colorWithRGB:0xDDDDDD];
    pageControl.currentPageIndicatorTintColor = [UIColor colorWithRGB:0x9B9B9B];
    
    self.contentScrollView.pageControl = pageControl;
    self.contentScrollView.scrollContentDelegate = (id<GZStickerContentScrollViewControl>)self.packageSelector;
    self.packageSelector.controlDelegate = (id<GZStickerPackagePanelControl>)self.contentScrollView;
    self.userInteractionEnabled = YES;
    
    // Update Content
    self.stickerList = [GZStickerPackage loadPackages];
    [self.packageSelector updateStickerList:self.stickerList];
    [self.contentScrollView updateContentPanel:self.stickerList];
    
    // Update Layout
    [self addSubview:self.packageSelector];
    [self addSubview:self.contentScrollView];
    [self addSubview:pageControl];
    
    [self.packageSelector setBackgroundColor:[UIColor colorWithRGB:0xF4F4F4]];
    [self.packageSelector mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo([NSNumber numberWithInteger:GZ_EMO_PACK_BAR_HEIGHT]);
        make.bottom.equalTo(self.mas_bottom);
        make.leading.equalTo(self.mas_leading);
        make.width.equalTo(self.mas_width);
    }];
    
    [self.contentScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.packageSelector.mas_top).offset(-15);
        make.top.equalTo(self.mas_top);
        make.leading.equalTo(self.mas_leading);
        make.width.equalTo(self.mas_width);
    }];
    
    [pageControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(self.mas_width);
        make.leading.equalTo(self.mas_leading);
        make.height.equalTo(@10);
        make.bottom.equalTo(self.packageSelector.mas_top).offset(-2);
    }];
    
    // Initialization Done
    return self;
}

- (void)showInView:(UIView*)superView
{
    [superView addSubview:self];
    
    [self mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(superView.mas_leading);
        make.bottom.equalTo(superView.mas_bottom);
        make.width.equalTo(superView.mas_width);
        make.height.equalTo([NSNumber numberWithFloat:220.0f]);
    }];
}

- (void)dismiss
{
    [self removeFromSuperview];
}

- (void)setAssociatedInput:(UITextField *)associatedInput
{
    _associatedInput = associatedInput;
    [self.contentScrollView configAccessoryInput:associatedInput];
}

@end
