//
//  UIStickerContentScrollView.h
//  MobileFramework
//
//  Created by zhaoy on 13/10/15.
//  Copyright © 2015 Alipay. All rights reserved.
//

#import <UIKit/UIKit.h>
@class IAPExpandableInputView;

@protocol IAPStickerContentScrollViewControl <NSObject>

- (void)onScrolledToNewPackage:(int)index;

- (void)adjustPanelPositionAtIndex:(int)index;

@end

@interface IAPStickerContentScrollView : UICollectionView

@property(weak, nonatomic)UIPageControl* pageControl;
@property(weak, nonatomic)id<IAPStickerContentScrollViewControl> scrollContentDelegate;

- (void)configAccessoryInput:(IAPExpandableInputView*)input;

- (void)updateContentPanel:(NSArray*)stickerPackages;

@end
