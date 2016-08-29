//
//  IAPMessagePanelScroller.m
//  MobileFramework
//
//  Created by zhaoy on 1/10/15.
//  Copyright © 2015 Alipay. All rights reserved.
//

#import "IAPMessagePanelScroller.h"
#import "IAPMessagingLoadingHost.h"

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

+ (void)scrollToPreviousPosition:(int)mountIndex inTable:(UITableView*)tableView
{
    if (!tableView) {
        return;
    }
    
    // Keep current scrolling index
    NSArray* visiblePaths = [tableView indexPathsForVisibleRows];
    float originOffset = tableView.contentOffset.y;
    [tableView reloadData];
    
    if (visiblePaths.count) {
        NSIndexPath* indexpath = [NSIndexPath indexPathForRow:(((NSIndexPath*)visiblePaths[0]).row + mountIndex) inSection:0];
        [tableView scrollToRowAtIndexPath:indexpath atScrollPosition:UITableViewScrollPositionTop animated:NO];
        
        if (mountIndex) {
            // Adhere the offset here
            CGPoint newPoint = CGPointMake(tableView.contentOffset.x,
                                           tableView.contentOffset.y - IAP_LOADING_CELL_HEIGHT + originOffset);
            [tableView setContentOffset:newPoint animated:NO];
        }
    } else {
        // Now consider for the initial loading situation, scroll to button
        if (mountIndex != 0) {
            [IAPMessagePanelScroller scrollToBottom:tableView];
        }
    }
}

@end
