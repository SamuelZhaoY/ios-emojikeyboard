//
//  GZMessageBottomMenu.h
//  MobileFramework
//
//  Created by zhaoy on 5/10/15.
//  Copyright © 2015 com.gz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GZMessageBottomMenuItem : NSObject

@property(strong, nonatomic, nonnull)NSString* itemImage;
@property(strong, nonatomic, nonnull)NSString* itemTitle;
@property(strong, nonatomic, nonnull)UIColor* itemColor;
@property(strong, nonatomic, nonnull)NSString* action;

@end

@interface GZMessageBottomMenu : UIView

- (nonnull instancetype)initWithMenuItem:(nonnull NSArray*)menuItems;

@end

