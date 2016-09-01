//
//  GZMessageBottomMenu.m
//  MobileFramework
//
//  Created by zhaoy on 5/10/15.
//  Copyright © 2015 com.gz. All rights reserved.
//

#import "GZMessageBottomMenu.h"
#import "GZMessageBottomViewContainer.h"
#import "GZCommonUtils.h"


#define GZ_MESSAGE_BOTTOM_ITEM_SIZE 58.0f
#define GZ_MESSAGE_BOTTOM_TOP_PADDING 14.0f
#define GZ_MESSAGE_BOTTOM_TOP_ITEM_TITLE_SPACING 4.0f

@implementation GZMessageBottomMenuItem
@end

@interface GZMessageBottomMenu()<UIScrollViewDelegate>

@property(nonatomic, strong)NSArray* itemArray;
@property(nonatomic, strong)UIScrollView* scroller;
@property(nonatomic, strong)UIPageControl* pageControl;
@property(nonatomic, assign)BOOL pageControlBeingUsed;

@end

@implementation GZMessageBottomMenu

- (instancetype)initWithMenuItem:(nonnull NSArray*)menuItems
{
    self = [super init];
    
    if (!menuItems.count) {
        return self;
    }
    
    self.itemArray = menuItems;
    self.scroller = [UIScrollView new];
    self.scroller.pagingEnabled = YES;
    self.scroller.scrollEnabled = YES;
    [self.scroller setShowsHorizontalScrollIndicator:NO];
    [self.scroller setShowsVerticalScrollIndicator:NO];
    self.pageControlBeingUsed = NO;
    self.scroller.delegate = self;
    [self addSubview:self.scroller];
    [self.scroller mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(self.mas_width);
        make.height.equalTo(self.mas_height);
        make.top.equalTo(self.mas_top);
        make.leading.equalTo(self.mas_leading);
    }];
    
    
    // Check horizon spacing
    float horizontalSpacing;
    UIWindow* currentWindow = [[UIApplication sharedApplication].delegate window];
    horizontalSpacing = (currentWindow.frame.size.width - 4*GZ_MESSAGE_BOTTOM_ITEM_SIZE)/5;
    
    int pageCount = ceilf(((float)self.itemArray.count)/4);

    if (pageCount > 1) {
        self.pageControl = [UIPageControl new];
        [self addSubview:self.pageControl];
        [self.pageControl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(self.mas_width);
            make.bottom.equalTo(self.mas_bottom).offset(-5);
            make.height.equalTo(@10);
            make.leading.equalTo(self.mas_leading);
        }];
        
        self.pageControl.pageIndicatorTintColor = [UIColor colorWithRGB:GZUIKitUIGrey8];
        self.pageControl.currentPageIndicatorTintColor = [UIColor colorWithRGB:GZUIKitFontGrey3];
        self.pageControl.numberOfPages = pageCount;
        self.pageControl.currentPage = 0;
        self.pageControl.enabled = NO;
    }
    
    // Calculate the layout
    float buffOffsetX = 0;
    for (GZMessageBottomMenuItem* item in menuItems) {
        UIButton* itemButton = [UIButton buttonWithType:UIButtonTypeCustom];
        itemButton.layer.borderColor = [UIColor colorWithRGB:GZUIKitFontGrey4].CGColor;
        itemButton.layer.borderWidth = 0.5f;
        itemButton.layer.cornerRadius = 5.0f;
        
        UILabel* label = [UILabel new];
        label.font = [UIFont systemFontOfSize:10.0];
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = [UIColor colorWithRGB:GZUIKitFontGrey3];
        label.text = item.itemTitle;
        
        [self.scroller addSubview:itemButton];
        [self.scroller addSubview:label];
        
        itemButton.clipsToBounds = YES;
        itemButton.contentMode = UIViewContentModeCenter;
        [itemButton setImage:[GZUIKitIconFontHelper imageWithIdentifier:item.itemImage tintColor:item.itemColor size:CGSizeMake(40, 41)] forState:UIControlStateNormal];
        [itemButton setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithRGB:GZUIKitFontGrey5]] forState:UIControlStateHighlighted];
        [itemButton setBackgroundImage:[UIImage imageWithColor:[UIColor clearColor]] forState:UIControlStateNormal];
        
        [itemButton addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
        
        itemButton.tag = [menuItems indexOfObject:item];
        itemButton.userInteractionEnabled = NO;
        
        if ([menuItems indexOfObject:item]%4 == 0) {
            buffOffsetX += horizontalSpacing;
        }
        
        [itemButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo([NSNumber numberWithFloat:GZ_MESSAGE_BOTTOM_ITEM_SIZE]);
            make.height.equalTo([NSNumber numberWithFloat:GZ_MESSAGE_BOTTOM_ITEM_SIZE]);
            make.leading.equalTo([NSNumber numberWithFloat:buffOffsetX]);
            make.top.equalTo(itemButton.superview.mas_top).offset(GZ_MESSAGE_BOTTOM_TOP_PADDING);
        }];
        
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(itemButton.mas_bottom).offset(GZ_MESSAGE_BOTTOM_TOP_ITEM_TITLE_SPACING);
            make.centerX.equalTo(itemButton.mas_centerX);
            make.width.equalTo(@80);
            make.height.equalTo(@20);
        }];
        
        buffOffsetX += (GZ_MESSAGE_BOTTOM_ITEM_SIZE + horizontalSpacing);
    }
    
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // Check page number & adjust scroll content size
    int pageCount = ceilf(((float)self.itemArray.count)/4);
    self.scroller.contentSize = CGSizeMake(pageCount * [GZCommonUtils getMainScreenWidth] , GZ_MESSAGE_BOT_MENU_PANEL_HEIGHT);
}

- (void)click:(UIView*)responder
{
    if (responder.tag < self.itemArray.count && responder.tag >= 0) {
        [[NSNotificationCenter defaultCenter] postNotificationName:GZ_MESSAGE_BOT_PANEL_ACTION_FIRE
                                                            object:self
                                                          userInfo:@{@"action":((GZMessageBottomMenuItem*)self.itemArray[responder.tag]).action}];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)sender {
    // Switch the indicator when more than 50% of the previous/next page is visible
    CGFloat pageWidth = self.scroller.frame.size.width;
    int page = floor((self.scroller.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    self.pageControl.currentPage = page;
}

@end
