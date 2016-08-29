//
//  IAPStickerPackagePanel.h
//  MobileFramework
//
//  Created by zhaoy on 14/10/15.
//  Copyright © 2015 Alipay. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol IAPStickerPackagePanelControl <NSObject>

- (void)tapPackagePaneAtIndex:(int)packageIndex;

@end

@interface IAPStickerPackagePanel : UIScrollView

@property(weak, nonatomic)id<IAPStickerPackagePanelControl> controlDelegate;
- (void)updateStickerList:(NSArray*)stickerList;
- (void)refreshContent;

@end