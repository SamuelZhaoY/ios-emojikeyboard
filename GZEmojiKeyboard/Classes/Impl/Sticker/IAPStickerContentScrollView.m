//
//  UIStickerContentScrollView.m
//  MobileFramework
//
//  Created by zhaoy on 13/10/15.
//  Copyright © 2015 Alipay. All rights reserved.
//

#import "IAPStickerContentScrollView.h"
#import "IAPStickerPackage.h"
#import "IAPMessageBottomViewContainer.h"
#import "IAPExpandableInputView.h"
#import "IAPStickerPanelControl.h"
#import "IAPStickerScrollPage.h"
#import "IAPStickerPackagePanel.h"
#import "IAPStickerPanelLayoutStrategy.h"

NSString* const PAGE_INENTIFIER = @"IAP_STICKER_IDENTIFIER";

@interface IAPStickerContentScrollView()<UICollectionViewDataSource,IAPStickerPackagePanelControl,UICollectionViewDelegate>

@property(weak, nonatomic)IAPExpandableInputView* accessoryInput;
@property(assign, nonatomic)BOOL isInLongPress;
@property(strong, nonatomic)IAPStickerPackage* currentPackage;
@property(strong, nonatomic)NSArray* stickerPackages;
@property(strong, nonatomic)NSMutableArray* pageObjects;

@end

@interface IAPStickerPage :NSObject

@property(weak, nonatomic)IAPStickerPackage* packageInfo;
@property(assign, nonatomic)int pageIndex;
@property(assign, nonatomic)int pageCount;

@end

@implementation IAPStickerPage
@end

@implementation IAPStickerContentScrollView

- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout
{
    self = [super initWithFrame:frame collectionViewLayout:layout];
    
    self.showsHorizontalScrollIndicator = NO;
    self.pagingEnabled = YES;
    self.backgroundColor = [UIColor clearColor];
    self.showsVerticalScrollIndicator = NO;
    self.dataSource = self;
    self.delegate = self;
    self.pageObjects = [NSMutableArray new];
    [self registerClass:[IAPStickerScrollPage class] forCellWithReuseIdentifier:PAGE_INENTIFIER];

    return self;
}

- (void)configAccessoryInput:(IAPExpandableInputView*)input
{
    self.accessoryInput = input;
}

- (void)updateContentPanel:(NSArray*)stickerPackages
{
    [self.pageObjects removeAllObjects];
    
    self.stickerPackages = stickerPackages;
    self.pageControl.currentPage = 0;
    
    // Calculate total page number 
    int pageNumber = 0;
    for (IAPStickerPackage* stickerPackage in self.stickerPackages) {
        pageNumber += [stickerPackage checkPageCount];
    }
    
    // Check about the overall content width
    self.contentSize = CGSizeMake(pageNumber * [IAPCommonUtils getMainScreenWidth], IAP_MESSAGE_BOT_STICKER_PANEL_HEIGHT - IAP_EMO_PACK_BAR_HEIGHT - 15);
    ((IAPStickerPanelLayoutStrategy*)self.collectionViewLayout).numberOfPage = pageNumber;
    
    // Initialize page count
    IAPStickerPackage* emojiPack = [IAPStickerPackage defaultStickerPackage];
    self.pageControl.numberOfPages = [emojiPack checkPageCount];
    
    // Load paging object, calculate total page count
    for (IAPStickerPackage* stickerPackage in self.stickerPackages) {
        for (int pageIndex = 0; pageIndex < [stickerPackage checkPageCount]; pageIndex++) {
            IAPStickerPage* pageInfo = [IAPStickerPage new];
            pageInfo.packageInfo = stickerPackage;
            pageInfo.pageIndex = pageIndex;
            pageInfo.pageCount = [stickerPackage checkPageCount];
            [self.pageObjects addObject:pageInfo];
        }
    }
    
    [self reloadData];
}

# pragma mark - page control status update

- (void)scrollViewDidScroll:(UIScrollView *)sender {
    // Switch the indicator when more than 50% of the previous/next page is visible
    CGFloat pageWidth = self.frame.size.width;
    int page = floor((self.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    
    // Check about page tag
    if (page >= self.pageObjects.count) {
        return;
    }
    
    IAPStickerPage* pageObject = [self.pageObjects objectAtIndex:page];
    self.pageControl.currentPage = pageObject.pageIndex;
    self.pageControl.numberOfPages = pageObject.pageCount;
    
    // Notify change of delegate event
    if (self.currentPackage != pageObject.packageInfo) {
        [self.scrollContentDelegate onScrolledToNewPackage:(int)[self.stickerPackages indexOfObject:pageObject.packageInfo]];
        self.currentPackage = pageObject.packageInfo;
    }
    
    // Adjust panel position
    [self.scrollContentDelegate adjustPanelPositionAtIndex:(int)[self.stickerPackages indexOfObject:pageObject.packageInfo]];
}

#pragma mark - UICollectionViewDataSource

// Check about total page numbers
- (NSInteger)collectionView:(UICollectionView *)view numberOfItemsInSection:(NSInteger)section {
    int pageNumber = 0;
    for (IAPStickerPackage* stickerPackage in self.stickerPackages) {
        pageNumber += [stickerPackage checkPageCount];
    };
    return pageNumber;
}

// Check about number of sections
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

// Check about cell layout
- (UICollectionViewCell *)collectionView:(UICollectionView *)cv cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    IAPStickerScrollPage *cell = (IAPStickerScrollPage *)[cv dequeueReusableCellWithReuseIdentifier:PAGE_INENTIFIER forIndexPath:indexPath];
    // Index raw indicates the page number
    IAPStickerPage* currentPage = [self.pageObjects objectAtIndex:indexPath.row];
    cell.accessoryInput = self.accessoryInput;
    [cell updateStickerPackage:currentPage.packageInfo atIndex:currentPage.pageIndex];
    return cell;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return self.frame.size;
}

#pragma mark - collection view cell paddings

- (UIEdgeInsets)collectionView:(UICollectionView*)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

#pragma mark - handling tapping events

- (void)tapPackagePaneAtIndex:(int)packageIndex
{
    if ([self.stickerPackages indexOfObject:self.currentPackage] == packageIndex) {
        return;
    }
    
    float scrollX = 0;
    // Scroll to page, calc offset
    for (int index = 0; index < packageIndex; index++) {
        IAPStickerPackage* package = [self.stickerPackages objectAtIndex:index];
        scrollX += [package checkPageCount]* [IAPCommonUtils getMainScreenWidth];
    }
    
    self.currentPackage = [self.stickerPackages objectAtIndex:packageIndex];
    [self setContentOffset:CGPointMake(scrollX, 0) animated:NO];
    self.pageControl.currentPage = 0;
    self.pageControl.numberOfPages = [self.currentPackage checkPageCount];
}

@end
