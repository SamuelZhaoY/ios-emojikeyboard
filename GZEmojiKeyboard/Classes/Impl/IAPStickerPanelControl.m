//
//  IAPMessageEmoControl.m
//  MobileFramework
//
//  Created by zhaoy on 5/10/15.
//  Copyright © 2015 Alipay. All rights reserved.
//

#import "IAPStickerPanelControl.h"
#import <QuartzCore/QuartzCore.h>
#import "IAPStickerPackage.h"
#import "IAPExpandableInputView.h"
#import "IAPMessageBottomViewContainer.h"
#import "IAPStickerContentScrollView.h"
#import "IAPStickerPackagePanel.h"
#import "IAPStickerPanelLayoutStrategy.h"
#import "IAPCommonUtils.h"


const float IAP_EMO_PACK_BAR_HEIGHT = 40;
const float IAP_EMO_PACK_ITEM_WIDTH = 45;
const float IAP_EMO_ICON_SIZE = 35;

@interface IAPStickerPanelControl()<UIScrollViewDelegate>

@property(assign, nonatomic)BOOL needLayout;
@property(strong, nonatomic)IAPStickerPackagePanel* packageSelector;
@property(strong, nonatomic)IAPStickerContentScrollView* contentScroller;
@property(strong, nonatomic)NSMutableArray* stickerList;
@property(strong, nonatomic)UIPageControl* pageControl;
@property(strong, nonatomic)UIButton* returnAccessoryBtn;

@end

@implementation IAPStickerPanelControl

- (instancetype)init
{
    self = [super init];
    self.stickerList = [NSMutableArray new];
    
    self.packageSelector = [IAPStickerPackagePanel new];
    self.contentScroller = [[IAPStickerContentScrollView alloc] initWithFrame:CGRectMake(0, 0, [IAPCommonUtils getMainScreenWidth], IAP_MESSAGE_BOT_STICKER_PANEL_HEIGHT - 15)
                                                         collectionViewLayout:[IAPStickerPanelLayoutStrategy new]];
    self.pageControl = [UIPageControl new];
    self.contentScroller.pageControl = self.pageControl;
    self.contentScroller.scrollContentDelegate = (id<IAPStickerContentScrollViewControl>)self.packageSelector;
    self.packageSelector.controlDelegate = (id<IAPStickerPackagePanelControl>)self.contentScroller;
    self.returnAccessoryBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.userInteractionEnabled = YES;

    [self addSubview:self.packageSelector];
    [self addSubview:self.contentScroller];
    [self addSubview:self.pageControl];
    [self addSubview:self.returnAccessoryBtn];
    
    self.returnAccessoryBtn.enabled = YES;
    [self.returnAccessoryBtn setUserInteractionEnabled:YES];
    
    [self.packageSelector setBackgroundColor:[UIColor colorWithRGB:IAPUIKitUIGrey11]];
    [self.packageSelector mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo([NSNumber numberWithInteger:IAP_EMO_PACK_BAR_HEIGHT]);
        make.bottom.equalTo(self.mas_bottom);
        make.leading.equalTo(self.mas_leading);
        make.width.equalTo(self.mas_width).offset(-IAP_EMO_PACK_ITEM_WIDTH * 1.2);
    }];
    
    [self.contentScroller mas_makeConstraints:^(MASConstraintMaker *make) {
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
    
    [self.returnAccessoryBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self.mas_trailing);
        make.height.equalTo([NSNumber numberWithFloat:IAP_EMO_PACK_BAR_HEIGHT]);
        make.width.equalTo([NSNumber numberWithFloat:IAP_EMO_PACK_ITEM_WIDTH * 1.2]);
        make.bottom.equalTo(self.mas_bottom);
    }];
    
    [self.returnAccessoryBtn setTitle:NSLocalizedString(@"Send", nil) forState:UIControlStateNormal];
    [self.returnAccessoryBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.returnAccessoryBtn.titleLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:14.0]];
    [self.returnAccessoryBtn setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithRGB:IAPUIKitUIColor8]] forState:UIControlStateNormal];
    [self.returnAccessoryBtn setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithRGB:IAPUIKit_Color_14 alpha:0.8]] forState:UIControlStateHighlighted];
    [self.returnAccessoryBtn addTarget:self action:@selector(sendInput:) forControlEvents:UIControlEventTouchUpInside];

    self.returnAccessoryBtn.layer.masksToBounds = NO;
    self.returnAccessoryBtn.layer.shadowOffset = CGSizeMake(-3, 3);
    self.returnAccessoryBtn.layer.shadowRadius = 5.0f;
    self.returnAccessoryBtn.layer.shadowOpacity = 0.3;
    
    self.pageControl.hidesForSinglePage = YES;
    self.pageControl.enabled = NO;
    self.pageControl.pageIndicatorTintColor = [UIColor colorWithRGB:IAPUIKitUIGrey8];
    self.pageControl.currentPageIndicatorTintColor = [UIColor colorWithRGB:IAPUIKitFontGrey3];
    
    // Initialize sticker packages
    self.needLayout = YES;
    self.stickerList = [[IAPStickerPackage loadLocalPackages] mutableCopy];
    
    // Update package panel display
    [self.packageSelector updateStickerList:self.stickerList];
    
    return self;
}

-(void)setNeedsLayout
{
    self.needLayout = YES;
    [super setNeedsLayout];
}

- (void)checkLayout
{
    // Provide content panel lazyloading
    if (self.needLayout) {
        self.needLayout = NO;
        
        [self.contentScroller updateContentPanel:self.stickerList];
    }
}

- (void)setAssociatedInput:(IAPExpandableInputView *)associatedInput
{
    _associatedInput = associatedInput;
    [self.contentScroller configAccessoryInput:associatedInput];
}

- (void)sendInput:(UIView*)responder
{
    [self.associatedInput checkForSubmit:self.associatedInput];
}

- (void)toggleSendKeyAccessory:(BOOL)isOn
{
    float initialValue = 0;
    float destinyValue = 0;
    if (isOn) {
        initialValue = [IAPCommonUtils getMainScreenWidth];
        destinyValue = [IAPCommonUtils getMainScreenWidth] - IAP_EMO_PACK_ITEM_WIDTH * 1.2;
    } else {
        destinyValue = [IAPCommonUtils getMainScreenWidth];
        initialValue = [IAPCommonUtils getMainScreenWidth] - IAP_EMO_PACK_ITEM_WIDTH * 1.2;
    }
    
    self.returnAccessoryBtn.translatesAutoresizingMaskIntoConstraints = YES;
    self.returnAccessoryBtn.frame = CGRectMake(initialValue,
                                               self.returnAccessoryBtn.frame.origin.y,
                                               self.returnAccessoryBtn.frame.size.width,
                                               self.returnAccessoryBtn.frame.size.height);
    
    [UIView animateWithDuration:0.2
                          delay:0
                        options: UIViewAnimationOptionCurveLinear
                     animations:^{
                         self.returnAccessoryBtn.frame = CGRectMake(destinyValue,
                                                                    self.returnAccessoryBtn.frame.origin.y,
                                                                    self.returnAccessoryBtn.frame.size.width,
                                                                    self.returnAccessoryBtn.frame.size.height);                     }
                     completion:^(BOOL finished){
                         self.returnAccessoryBtn.translatesAutoresizingMaskIntoConstraints = NO;
                     }];
}


@end
