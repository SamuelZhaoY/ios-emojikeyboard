//
//  GZStickerPackagePanel.m
//  MobileFramework
//
//  Created by zhaoy on 14/10/15.
//  Copyright © 2015 com.gz. All rights reserved.
//

#import "GZStickerPackagePanel.h"
#import "GZStickerPanelControl.h"
#import "GZStickerPackage.h"
#import "GZStickerContentScrollView.h"

@interface GZStickerPackagePanel()<GZStickerContentScrollViewControl>

@property(strong, nonatomic)NSArray* stickerList;
@property(strong, nonatomic)UIView* currentHighlightView;

@end

@implementation GZStickerPackagePanel

- (instancetype)init
{
    self = [super init];
    
    self.alwaysBounceHorizontal = NO;
    self.bounces = NO;
    self.showsHorizontalScrollIndicator = NO;
    self.showsVerticalScrollIndicator = NO;
    
    return self;
}

- (void)updateStickerList:(NSArray*)stickerList
{
    // Check data validity
    if (!stickerList.count) {
        return;
    }
    
    self.stickerList = stickerList;
    [self refreshContent];
}

- (void)refreshContent
{
    // Check data validity
    if (!self.stickerList.count) {
        return;
    }
    
    [[self subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    self.tag = -1;
    
    float offsetX = 0;
    for (GZStickerPackage* stickerPackage in self.stickerList) {
        UILabel* stickerTab = [UILabel new];
        [self addSubview:stickerTab];
        stickerTab.text = stickerPackage.icon;
        stickerTab.textAlignment = NSTextAlignmentCenter;
        stickerTab.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:24.0];
        stickerTab.userInteractionEnabled = YES;
        stickerTab.tag = [self.stickerList indexOfObject:stickerPackage];
        [stickerTab addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onStickerTabTapped:)]];
        [stickerTab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo([NSNumber numberWithInteger:GZ_EMO_PACK_ITEM_WIDTH]);
            make.height.equalTo([NSNumber numberWithInteger:GZ_EMO_PACK_BAR_HEIGHT]);
            make.leading.equalTo([NSNumber numberWithInteger:offsetX]);
            make.top.equalTo(self.mas_top);
        }];
        
        offsetX += GZ_EMO_PACK_ITEM_WIDTH;
        
         // by default make first sticker package
        if ([self.stickerList firstObject] == stickerPackage) {
            [self selectTag:stickerTab fireDelegate:YES];
        }
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.contentSize = CGSizeMake(self.stickerList.count *  GZ_EMO_PACK_ITEM_WIDTH, GZ_EMO_PACK_BAR_HEIGHT);
}

#pragma mark - Panel Click

- (void)selectTag:(UIView*)stickerTab fireDelegate:(BOOL)needFire
{
    // Check about tag index
    if (stickerTab.tag >= self.stickerList.count) {
        return;
    }
    
    // Avoid duplicate operation
    if (stickerTab == self.currentHighlightView) {
        return;
    }

    [self.currentHighlightView setBackgroundColor:[UIColor clearColor]];
    [stickerTab setBackgroundColor:[UIColor colorWithRGB:0xBBBBBB]];
    self.currentHighlightView = stickerTab;
    
    // Scroll rect to visible
    [self scrollRectToVisible:stickerTab.frame animated:YES];
    
    if (needFire) {
        // Update pressing event
        [self.controlDelegate tapPackagePaneAtIndex:(int)stickerTab.tag];
    }
}

- (void)onStickerTabTapped:(UIGestureRecognizer*)recognizer
{
    [self selectTag:recognizer.view fireDelegate:YES];
}

#pragma mark Scroll Content Delegate

- (void)onScrolledToNewPackage:(int)index
{
    UIView* tab = [self viewWithTag:index];
    [self selectTag:tab fireDelegate:NO];
}

- (void)adjustPanelPositionAtIndex:(int)index
{
    // Scroll rect to visible
    UIView* tab = [self viewWithTag:index];
    [self scrollRectToVisible:tab.frame animated:YES];
}

@end
