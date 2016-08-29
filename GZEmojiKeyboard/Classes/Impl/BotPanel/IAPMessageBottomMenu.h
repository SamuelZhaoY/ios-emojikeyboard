//
//  IAPMessageBottomMenu.h
//  MobileFramework
//
//  Created by zhaoy on 5/10/15.
//  Copyright © 2015 Alipay. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IAPMessageBottomMenuItem : NSObject

@property(strong, nonatomic, nonnull)NSString* itemImage;
@property(strong, nonatomic, nonnull)NSString* itemTitle;
@property(strong, nonatomic, nonnull)UIColor* itemColor;
@property(strong, nonatomic, nonnull)NSString* action;

@end

@interface IAPMessageBottomMenu : UIView

- (nonnull instancetype)initWithMenuItem:(nonnull NSArray*)menuItems;

@end

