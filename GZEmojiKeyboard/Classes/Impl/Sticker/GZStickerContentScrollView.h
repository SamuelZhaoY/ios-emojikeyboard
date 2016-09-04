//
//  UIStickerContentScrollView.h
//  MobileFramework
//
//  Created by zhaoy on 13/10/15.
//  Copyright © 2015 com.gz. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol GZStickerContentScrollViewControl <NSObject>

@required
- (void)onScrolledToNewPackage:(int)index;
- (void)adjustPanelPositionAtIndex:(int)index;

@end

@interface GZStickerContentScrollView : UICollectionView

@property(weak, nonatomic)UIPageControl* pageControl;
@property(weak, nonatomic)id<GZStickerContentScrollViewControl> scrollContentDelegate;

- (void)configAccessoryInput:(UITextField*)input;
- (void)updateContentPanel:(NSArray*)stickerPackages;

@end
