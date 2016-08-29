//
//  IAPMessagePanelScroller.h
//  MobileFramework
//
//  Created by zhaoy on 1/10/15.
//  Copyright © 2015 Alipay. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IAPMessagePanelScroller : NSObject

+ (void)scrollToBottom:(UITableView*)tableView;

+ (void)scrollToPreviousPosition:(int)mountIndex inTable:(UITableView*)tableView;

@end
