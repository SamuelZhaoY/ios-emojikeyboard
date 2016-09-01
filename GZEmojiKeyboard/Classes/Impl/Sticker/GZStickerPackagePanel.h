//
//  GZStickerPackagePanel.h
//  MobileFramework
//
//  Created by zhaoy on 14/10/15.
//  Copyright © 2015 com.gz. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol GZStickerPackagePanelControl <NSObject>

- (void)tapPackagePaneAtIndex:(int)packageIndex;

@end

@interface GZStickerPackagePanel : UIScrollView

@property(weak, nonatomic)id<GZStickerPackagePanelControl> controlDelegate;
- (void)updateStickerList:(NSArray*)stickerList;
- (void)refreshContent;

@end