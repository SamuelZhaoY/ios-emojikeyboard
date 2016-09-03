//
//  GZMessageEmoControl.m
//  MobileFramework
//
//  Created by zhaoy on 5/10/15.
//  Copyright © 2015 com.gz. All rights reserved.
//

#import "GZStickerPanelControl.h"
#import <QuartzCore/QuartzCore.h>
#import "GZStickerPackage.h"
#import "GZStickerContentScrollView.h"
#import "GZStickerPackagePanel.h"
#import "GZStickerPanelLayoutStrategy.h"
#import "GZCommonUtils.h"


const float GZ_EMO_PACK_BAR_HEIGHT = 40;
const float GZ_EMO_PACK_ITEM_WIDTH = 45;
const float GZ_EMO_ICON_SIZE = 35;

@interface GZStickerPanelControl()<UIScrollViewDelegate>

@property(assign, nonatomic)BOOL needLayout;
@property(strong, nonatomic)GZStickerPackagePanel* packageSelector;
@property(strong, nonatomic)GZStickerContentScrollView* contentScrollView;
@property(strong, nonatomic)NSMutableArray* stickerList;
@property(strong, nonatomic)UIPageControl* pageControl;

@end

@implementation GZStickerPanelControl

- (instancetype)init
{
    self = [super init];
    self.stickerList = [NSMutableArray new];
    
    self.packageSelector = [GZStickerPackagePanel new];
    self.contentScrollView = [[GZStickerContentScrollView alloc] initWithFrame:CGRectMake(0, 0, [GZCommonUtils getMainScreenWidth], GZ_MESSAGE_BOT_STICKER_PANEL_HEIGHT - 15)
                                                         collectionViewLayout:[GZStickerPanelLayoutStrategy new]];
    self.pageControl = [UIPageControl new];
    self.contentScrollView.pageControl = self.pageControl;
    self.contentScrollView.scrollContentDelegate = (id<GZStickerContentScrollViewControl>)self.packageSelector;
    self.packageSelector.controlDelegate = (id<GZStickerPackagePanelControl>)self.contentScrollView;
    self.userInteractionEnabled = YES;

    [self addSubview:self.packageSelector];
    [self addSubview:self.contentScrollView];
    [self addSubview:self.pageControl];
    
    [self.packageSelector setBackgroundColor:[UIColor colorWithRGB:0xF4F4F4]];
    [self.packageSelector mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo([NSNumber numberWithInteger:GZ_EMO_PACK_BAR_HEIGHT]);
        make.bottom.equalTo(self.mas_bottom);
        make.leading.equalTo(self.mas_leading);
        make.width.equalTo(self.mas_width).offset(-GZ_EMO_PACK_ITEM_WIDTH * 1.2);
    }];
    
    [self.contentScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.packageSelector.mas_top).offset(-15);
        make.top.equalTo(self.mas_top);
        make.leading.equalTo(self.mas_leading);
        make.width.equalTo(self.mas_width);
    }];
    
    [self.pageControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(self.mas_width);
        make.leading.equalTo(self.mas_leading);
        make.height.equalTo(@10);
        make.bottom.equalTo(self.packageSelector.mas_top).offset(-2);
    }];
    
    self.pageControl.hidesForSinglePage = YES;
    self.pageControl.enabled = NO;
    self.pageControl.pageIndicatorTintColor = [UIColor colorWithRGB:0xDDDDDD];
    self.pageControl.currentPageIndicatorTintColor = [UIColor colorWithRGB:0x9B9B9B];
    
    
    self.needLayout = YES;
    self.stickerList = [[GZStickerPackage loadLocalPackages] mutableCopy];
    
    [self.packageSelector updateStickerList:self.stickerList];
    
    [self checkLayout];
    
    return self;
}

-(void)setNeedsLayout
{
    self.needLayout = YES;
    [super setNeedsLayout];
}

- (void)checkLayout
{
    if (self.needLayout) {
        self.needLayout = NO;
        [self.contentScrollView updateContentPanel:self.stickerList];
    }
}

- (void)setAssociatedInput:(UITextField *)associatedInput
{
    _associatedInput = associatedInput;
    [self.contentScrollView configAccessoryInput:associatedInput];
}

@end
