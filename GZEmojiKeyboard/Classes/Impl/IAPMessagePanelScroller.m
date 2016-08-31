//
//  IAPMessagePanelScroller.m
//  MobileFramework
//
//  Created by zhaoy on 1/10/15.
//  Copyright © 2015 Alipay. All rights reserved.
//

#import "IAPMessagePanelScroller.h"

@implementation IAPMessagePanelScroller

+ (void)scrollToBottom:(UITableView*)tableView
{
    if (!tableView) {
        return;
    }
    
    long lastSection = tableView.numberOfSections - 1;
    // check whether has section
    if (lastSection < 0) {
        return;
    }
    
    long lastRow = [tableView numberOfRowsInSection:lastSection] - 1;
    // check last row index
    if (lastRow < 0) {
        return;
    }
    
    // scroll to bottom
    NSIndexPath* indexpath = [NSIndexPath indexPathForRow:lastRow inSection:lastSection];
    [tableView scrollToRowAtIndexPath:indexpath atScrollPosition:UITableViewScrollPositionTop animated:NO];
}



@end
