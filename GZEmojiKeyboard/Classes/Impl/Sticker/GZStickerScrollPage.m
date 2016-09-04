//
//  GZStickerScrollPage.m
//  MobileFramework
//
//  Created by zhaoy on 15/10/15.
//  Copyright © 2015 com.gz. All rights reserved.
//

#import "GZStickerScrollPage.h"
#import "GZStickerPackage.h"
#import "GZStickerPanelControl.h"
#import "GZCommonUtils.h"
#import "UIImage+animatedGIF.h"

@interface GZEmojiIcon : UILabel

@property(strong, nonatomic)GZStickerItem* item;

- (instancetype)initWithStickerInfo:(GZStickerItem*)itemInfo;

- (void)setSelected:(BOOL)isSelected;

@end

@implementation GZEmojiIcon

- (instancetype)initWithStickerInfo:(GZStickerItem*)itemInfo
{
    self = [super init];
    self.item = itemInfo;
    self.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:24.0];
    self.userInteractionEnabled = YES;
    self.textAlignment = NSTextAlignmentCenter;
    self.clipsToBounds = YES;
    self.layer.cornerRadius = 4.0f;
    [self checkContent];
    return self;
}

- (void)checkContent
{
    if (self.item.stickerType == GZ_TYPE_EMOJI) {
        self.text = self.item.resource;
    } else {
        UIImageView* stickerCanvass = [UIImageView new];
        stickerCanvass.layer.cornerRadius = self.layer.cornerRadius;
        stickerCanvass.contentMode = UIViewContentModeScaleToFill;

        [self addSubview:stickerCanvass];
        [stickerCanvass mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(self.mas_width);
            make.height.equalTo(self.mas_height);
            make.centerX.equalTo(self.mas_centerX);
            make.centerY.equalTo(self.mas_centerY);
        }];
        
        [stickerCanvass setImage:[UIImage imageWithContentsOfFile:self.item.resource]];
    }
}

- (void)setSelected:(BOOL)isSelected
{
    if (isSelected) {
        self.backgroundColor = [UIColor colorWithRGB:0xBBBBBB];
    } else {
        self.backgroundColor = [UIColor clearColor];
    }
}

@end

const float GZ_EMOJI_LENS_HEIGHT = 55;
const float GZ_EMOJI_LENS_WIDTH = 60;
const float GZ_STICKER_LENS_WIDTH = 150;
const float GZ_STICKER_LENS_HEIGHT = 160;


@interface GZStickerLens : UIView

@property(strong, nonatomic)GZStickerItem* stickerItem;
@property(strong, nonatomic)UILabel* nameLabel;
@property(strong, nonatomic)UILabel* emojiLabel;
@property(strong, nonatomic)UIImageView* stickerDemo;
@property(assign, nonatomic)GZ_STICKER_TYPE stickerType;

- (void)updateStickerInfo:(GZStickerItem*) item;
- (void)displayOnRectAnchor:(UIView*)anchorView;

@end

@implementation GZStickerLens

- (instancetype)init
{
    self = [super init];
    
    self.clipsToBounds = YES;
    self.layer.cornerRadius = 4.0;
    self.layer.borderColor = [UIColor colorWithRGB:0x9B9B9B].CGColor;
    self.backgroundColor = [UIColor colorWithRGB:0xF4F4F4];
    self.layer.borderWidth = 1.0;
    
    self.nameLabel = [UILabel new];
    self.emojiLabel = [UILabel new];
    self.stickerType = -1; 
    
    // Set up basic effect of key pop
    self.nameLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:11.0];
    self.emojiLabel.font = [UIFont systemFontOfSize:35];
    
    self.nameLabel.textAlignment = NSTextAlignmentCenter;
    self.emojiLabel.textAlignment = NSTextAlignmentCenter;
    self.stickerDemo = [UIImageView new];
    
    [self addSubview:self.nameLabel];
    [self addSubview:self.emojiLabel];
    [self addSubview:self.stickerDemo];
    
    return self;
}

- (void)updateStickerInfo:(GZStickerItem*)item
{
    self.stickerItem = item;
    // When type not match with current one, update layout
    self.stickerType = item.stickerType;
    
    
    float lensWidth = item.stickerType==GZ_TYPE_EMOJI?GZ_EMOJI_LENS_WIDTH:GZ_STICKER_LENS_WIDTH;
    float lensHeight= item.stickerType==GZ_TYPE_EMOJI?GZ_EMOJI_LENS_HEIGHT:GZ_STICKER_LENS_HEIGHT;
    
    [self.stickerDemo setHidden:item.stickerType==GZ_TYPE_EMOJI];
    [self.emojiLabel setHidden:item.stickerType!=GZ_TYPE_EMOJI];
    
    [self mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@(lensWidth));
        make.height.equalTo(@(lensHeight));
        make.centerX.equalTo(@(0));
        make.bottom.equalTo(@(0));
    }];
    
    [self.emojiLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.emojiLabel.superview.mas_leading).offset(5);
        make.trailing.equalTo(self.emojiLabel.superview.mas_trailing).offset(-5);
        make.top.equalTo(self.emojiLabel.superview.mas_top).offset(5);
        make.bottom.equalTo(self.emojiLabel.superview.mas_bottom).offset(-20);
    }];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.nameLabel.superview.mas_leading);
        make.trailing.equalTo(self.nameLabel.superview.mas_trailing);
        make.bottom.equalTo(self.nameLabel.superview.mas_bottom).offset(-5);
        make.height.equalTo(@(12));
    }];
  
    [self.stickerDemo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.emojiLabel.superview.mas_leading).offset(5);
        make.trailing.equalTo(self.emojiLabel.superview.mas_trailing).offset(-5);
        make.top.equalTo(self.emojiLabel.superview.mas_top).offset(5);
        make.bottom.equalTo(self.emojiLabel.superview.mas_bottom).offset(-20);
    }];

    
    self.stickerDemo.image = [UIImage animatedImageWithAnimatedGIFURL:[NSURL fileURLWithPath:item.resource]];
    self.emojiLabel.text = item.resource;
    self.nameLabel.text = item.name;
}

- (void)displayOnRectAnchor:(UIView*)anchorView
{
    CGPoint pointInContentView = [anchorView convertPoint:anchorView.frame.origin toView:anchorView.superview.superview.superview.superview];
    
    float lensWidth = self.stickerItem.stickerType==GZ_TYPE_EMOJI?GZ_EMOJI_LENS_WIDTH:GZ_STICKER_LENS_WIDTH;
    float lensHeight= self.stickerItem.stickerType==GZ_TYPE_EMOJI?GZ_EMOJI_LENS_HEIGHT:GZ_STICKER_LENS_HEIGHT;
    
    [self mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@(lensWidth));
        make.height.equalTo(@(lensHeight));
        make.leading.equalTo(@(pointInContentView.x/[UIScreen mainScreen].scale - (lensWidth - anchorView.frame.size.width)/2));
        make.top.equalTo(@(pointInContentView.y/[UIScreen mainScreen].scale - lensHeight - 5));
    }];
}

@end


@interface GZStickerScrollPage()

@property(strong, nonatomic)UIView* pageContentView;
@property(assign, nonatomic)BOOL isInLongPress;
@property(assign, nonatomic)GZEmojiIcon* pressingView;
@property(strong, nonatomic)GZStickerLens* popView;

@end

@implementation GZStickerScrollPage

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    [self checkPageView];
    return self;
}

- (void)checkPageView
{
    if (self.pageContentView) {
        [[self.pageContentView subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
        [self.pageContentView removeFromSuperview];
    }
    
    self.pageContentView = [UIView new];
    [self addSubview:self.pageContentView];
    
    [self.pageContentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(self.mas_width);
        make.height.equalTo(self.mas_height);
        make.leading.equalTo(self.mas_leading);
        make.top.equalTo(self.mas_top);
    }];
    
    UILongPressGestureRecognizer* longPressTrig = [[UILongPressGestureRecognizer alloc] initWithTarget:self
                                                                                                action:@selector(longPressPop:)];
        longPressTrig.minimumPressDuration = 0.2f;
        longPressTrig.cancelsTouchesInView = NO;
        [self addGestureRecognizer:longPressTrig];
}

- (void)updateStickerPackage:(GZStickerPackage*)stickerPackage atIndex:(int)index
{
    [[self.pageContentView subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    NSArray* stickerIcons = [stickerPackage checkItemsAtIndexedPage:index];
    int coloumnPerpage =  [stickerPackage checkColumnCount];
    float horizontalSpacing = [stickerPackage checkHorizontalSpacing];
    float verticalSpacing = [stickerPackage checkVerticalSpacing];
    float itemSize = [stickerPackage checkItemSize];
    
    for (GZStickerItem* stickerItem in stickerIcons) {
        int pageIndex = (int)[stickerIcons indexOfObject:stickerItem];
        int rowPosition = (pageIndex) / coloumnPerpage;
        int coloumnPosition = (pageIndex) % coloumnPerpage;
        
        
        GZEmojiIcon* stickerLabel = [[GZEmojiIcon alloc] initWithStickerInfo:stickerItem];
        stickerLabel.tag = [stickerPackage.contentArray indexOfObject:stickerItem];
        [stickerLabel addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                 action:@selector(simpleLabelTapped:)]];
        
        [self.pageContentView addSubview:stickerLabel];
        
        
        [stickerLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo([NSNumber numberWithFloat:itemSize]);
            make.height.equalTo([NSNumber numberWithFloat:itemSize]);
            make.leading.equalTo([NSNumber numberWithFloat:(horizontalSpacing + coloumnPosition * (itemSize + horizontalSpacing))]);
            make.top.equalTo([NSNumber numberWithFloat:(verticalSpacing + (verticalSpacing + itemSize)* rowPosition)]);
        }];
    }
    
    if (stickerPackage.type == GZ_TYPE_EMOJI) {
        UILabel* deleteButton = [UILabel new];
        deleteButton.font = [UIFont systemFontOfSize:18.0];
        deleteButton.text = @"X";
        deleteButton.textAlignment = NSTextAlignmentCenter;
        deleteButton.userInteractionEnabled = YES;
        [self.pageContentView addSubview:deleteButton];
        
        [deleteButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo([NSNumber numberWithFloat:itemSize]);
            make.height.equalTo([NSNumber numberWithFloat:itemSize]);
            make.top.equalTo([NSNumber numberWithFloat:(verticalSpacing + (verticalSpacing + itemSize)* ([stickerPackage checkRowCount] - 1))]);
            make.leading.equalTo([NSNumber numberWithFloat:(horizontalSpacing + (coloumnPerpage - 1) * (itemSize + horizontalSpacing))]);
        }];
        [deleteButton addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                   action:@selector(deleteInputChar)]];
    }
}

# pragma mark - keyboard control

- (void)simpleLabelTapped:(UIGestureRecognizer*)recognizer
{
    GZStickerPackage* emojiPack = [GZStickerPackage defaultEmojiPackage];
    if ([emojiPack.contentArray count] > (recognizer.view).tag) {
        GZStickerItem* stickerItem = [emojiPack.contentArray objectAtIndex:recognizer.view.tag];
        if (stickerItem.stickerType == GZ_TYPE_EMOJI) {
            self.accessoryInput.text = [self.accessoryInput.text stringByAppendingString:stickerItem.resource];
        } else if (stickerItem.stickerType == GZ_TYPE_STICKER) {
            
        }
    }
}

- (void)deleteInputChar
{
    // Each emoji icon occupies length of 2
    long textLength = self.accessoryInput.text.length;
    int backDeleteDistance;
    if (textLength == 1) {
        
        backDeleteDistance = 1;
        
    } else if (textLength > 1) {
        NSString* emojiContent = [self.accessoryInput.text substringWithRange:NSMakeRange(textLength - 2, 2)];
        
        if ([[GZStickerPackage rawEmoji] indexOfObject:emojiContent] != NSNotFound) {
            backDeleteDistance = 2;
        } else {
            backDeleteDistance = 1;
        }
    }
    
    self.accessoryInput.text = [self.accessoryInput.text substringToIndex:textLength - backDeleteDistance];
}

# pragma mark -  Popup view on drag

- (void)longPressPop:(UIGestureRecognizer*)recognizer
{
    if (recognizer.state == UIGestureRecognizerStateBegan)
    {
        [self togglePopLens:YES];
        CGPoint currentlocation = [recognizer locationInView:self];
        UIView* targetView = [self hitTest:currentlocation withEvent:nil];
        [self updatePressPop:(GZEmojiIcon*)targetView];
    }
    else
    {
        if (recognizer.state == UIGestureRecognizerStateCancelled
            || recognizer.state == UIGestureRecognizerStateFailed
            || recognizer.state == UIGestureRecognizerStateEnded)
        {
            // Long press ended, stop the timer
            [self togglePopLens:NO];
        }
    }
}

- (void)togglePopLens:(BOOL)isOn
{
    self.isInLongPress = isOn;
    
    // Control of sticker lens
    if (isOn) {
        self.popView = [GZStickerLens new];
        [self.superview.superview addSubview:self.popView];
    } else {
        [self.popView removeFromSuperview];
        [self.pressingView setSelected:NO];
        self.pressingView = nil;
        self.popView = nil;
    }
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    if (self.isInLongPress) {
        UITouch* touch = [touches anyObject];
        CGPoint point = [touch locationInView:self];
        UIView* targetView = [self hitTest:point withEvent:event];
        if ([targetView isKindOfClass:[GZEmojiIcon class]]) {
            GZEmojiIcon* iconView = (GZEmojiIcon*)targetView;
            if (self.pressingView != iconView) {
                [self updatePressPop:iconView];
            }
        }
    }
}

- (void)updatePressPop:(GZEmojiIcon*)pressingView
{
    if (!pressingView || ![pressingView isKindOfClass:[GZEmojiIcon class]]) {
        return;
    }
    
    if (self.pressingView == pressingView) {
        return;
    } else {
        [self.pressingView setSelected:NO];
        [pressingView setSelected:YES];
    }
    
    self.pressingView = pressingView;
    [self.popView updateStickerInfo:pressingView.item];
    [self.popView displayOnRectAnchor:self.pressingView];
}

@end
