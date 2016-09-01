//
//  GZStickerScrollPage.h
//  MobileFramework
//
//  Created by zhaoy on 15/10/15.
//  Copyright © 2015 com.gz. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GZStickerPackage;
@class GZExpandableInputView;
@interface GZStickerScrollPage : UICollectionViewCell
@property(weak, nonatomic)GZExpandableInputView* accessoryInput;
- (void)updateStickerPackage:(GZStickerPackage*)stickerPackage atIndex:(int)index;

@end
