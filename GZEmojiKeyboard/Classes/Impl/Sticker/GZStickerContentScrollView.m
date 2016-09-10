//
//  UIStickerContentScrollView.m
//  MobileFramework
//
//  Created by zhaoy on 13/10/15.
//  Copyright © 2015 com.gz. All rights reserved.
//

#import "GZStickerContentScrollView.h"
#import "GZStickerPackage.h"
#import "GZEmojiKeyboardControl.h"
#import "GZStickerScrollPage.h"
#import "GZStickerPackagePanel.h"
#import "GZStickerPanelLayoutStrategy.h"
#import "GZCommonUtils.h"

NSString* const PAGE_INENTIFIER = @"GZ_STICKER_IDENTIFIER";

@interface GZStickerContentScrollView()<UICollectionViewDataSource,GZStickerPackagePanelControl,UICollectionViewDelegate>

@property(weak, nonatomic)UITextField* accessoryInput;
@property(assign, nonatomic)BOOL isInLongPress;
@property(strong, nonatomic)GZStickerPackage* currentPackage;
@property(strong, nonatomic)NSArray* stickerPackages;
@property(strong, nonatomic)NSMutableArray* pageObjects;

@end

@interface GZStickerPage :NSObject

@property(weak, nonatomic)GZStickerPackage* packageInfo;
@property(assign, nonatomic)int pageIndex;
@property(assign, nonatomic)int pageCount;

@end

@implementation GZStickerPage

@end

@implementation GZStickerContentScrollView

- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout
{
    self = [super initWithFrame:frame collectionViewLayout:layout];
    
    self.showsHorizontalScrollIndicator = NO;
    self.pagingEnabled = YES;
    self.backgroundColor = [UIColor clearColor];
    self.showsVerticalScrollIndicator = NO;
    self.dataSource = self;
    self.delegate = self;
    [self registerClass:[GZStickerScrollPage class] forCellWithReuseIdentifier:PAGE_INENTIFIER];
    self.pageObjects = [NSMutableArray new];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(orientationChanged:)
                                                 name:UIDeviceOrientationDidChangeNotification
                                               object:nil];

    return self;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)configAccessoryInput:(UITextField*)input
{
    self.accessoryInput = input;
}

- (void)updateContentPanel:(NSArray*)stickerPackages
{
    [self.pageObjects removeAllObjects];
    
    // Update Data
    self.stickerPackages = stickerPackages;
    for (GZStickerPackage* stickerPackage in self.stickerPackages) {
        for (int pageIndex = 0; pageIndex < [stickerPackage checkPageCount]; pageIndex++) {
            GZStickerPage* pageInfo = [GZStickerPage new];
            pageInfo.packageInfo = stickerPackage;
            pageInfo.pageIndex = pageIndex;
            pageInfo.pageCount = [stickerPackage checkPageCount];
            [self.pageObjects addObject:pageInfo];
        }
    }

    // Update Layout
    [self tapPackagePaneAtIndex:0];
    [((GZStickerPanelLayoutStrategy*)self.collectionViewLayout) updatePageContent:stickerPackages];

    [self reloadData];
}

# pragma mark - Page Control Update

- (void)scrollViewDidScroll:(UIScrollView *)sender {
    // Switch the indicator when more than 50% of the previous/next page is visible
    CGFloat pageWidth = self.frame.size.width;
    int page = floor((self.contentOffset.x - pageWidth/2) / pageWidth) + 1;
    if (page >= self.pageObjects.count) {
        return;
    }
    
    GZStickerPage* pageObject = [self.pageObjects objectAtIndex:page];
    
    [self updatePageControl:pageObject.pageIndex
             totalPageCount:pageObject.pageCount];
    
    if (self.currentPackage != pageObject.packageInfo) {
        [self.scrollContentDelegate onScrolledToNewPackage:(int)[self.stickerPackages indexOfObject:pageObject.packageInfo]];
        self.currentPackage = pageObject.packageInfo;
    }
    
    [self.scrollContentDelegate adjustPanelPositionAtIndex:(int)[self.stickerPackages indexOfObject:pageObject.packageInfo]];
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)view
     numberOfItemsInSection:(NSInteger)section
{
    int pageNumber = 0;
    for (GZStickerPackage* stickerPackage in self.stickerPackages) {
        pageNumber += [stickerPackage checkPageCount];
    };
    return pageNumber;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)cv
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    GZStickerScrollPage *cell = (GZStickerScrollPage *)[cv dequeueReusableCellWithReuseIdentifier:PAGE_INENTIFIER forIndexPath:indexPath];
    
    GZStickerPage* currentPage = [self.pageObjects objectAtIndex:indexPath.row];
    cell.accessoryInput = self.accessoryInput;
    [cell updateStickerPackage:currentPage.packageInfo atIndex:currentPage.pageIndex];
    return cell;
}

-(CGSize)collectionView:(UICollectionView *)collectionView
                 layout:(UICollectionViewLayout *)collectionViewLayout
 sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return self.frame.size;
}

#pragma mark - Cell Padding

- (UIEdgeInsets)collectionView:(UICollectionView*)collectionView
                        layout:(UICollectionViewLayout *)collectionViewLayout
        insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

#pragma mark - Panel Tapping

- (void)tapPackagePaneAtIndex:(int)packageIndex
{
    if ([self.stickerPackages indexOfObject:self.currentPackage] == packageIndex) {
        return;
    }
    
    float scrollX = 0;
    
    for (int index = 0; index < packageIndex; index++) {
        GZStickerPackage* package = [self.stickerPackages objectAtIndex:index];
        scrollX += [package checkPageCount]* [GZCommonUtils getMainScreenWidth];
    }
    self.currentPackage = [self.stickerPackages objectAtIndex:packageIndex];
    [self setContentOffset:CGPointMake(scrollX, 0) animated:NO];
    self.pageControl.currentPage = 0;
    [self updatePageControl:0 totalPageCount:[self.currentPackage checkPageCount]];
}

#pragma mark - Page Control

- (void)updatePageControl:(int)index totalPageCount:(int)totalPageCount
{
    self.pageControl.currentPage = index;
    self.pageControl.numberOfPages = totalPageCount;
}


# pragma mark- Rotation Monitoring
- (void)orientationChanged:(NSNotification *)notification{
    [self reloadData];
    
    float scrollX = 0;
    int packageIndex = 0;
    for (int index = 0; index < packageIndex; index++) {
        GZStickerPackage* package = [self.stickerPackages objectAtIndex:index];
        scrollX += [package checkPageCount]* [GZCommonUtils getMainScreenWidth];
    }
    
    self.currentPackage = [self.stickerPackages objectAtIndex:packageIndex];
    [self setContentOffset:CGPointMake(scrollX, 0) animated:NO];
    self.pageControl.currentPage = 0;
    [self updatePageControl:0 totalPageCount:[self.currentPackage checkPageCount]];
}

@end
