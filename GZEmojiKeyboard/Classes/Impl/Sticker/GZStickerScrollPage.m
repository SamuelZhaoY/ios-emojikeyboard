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
    self.text = itemInfo.resource;
    self.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:24.0];
    self.userInteractionEnabled = YES;
    self.textAlignment = NSTextAlignmentCenter;
    self.clipsToBounds = YES;
    self.layer.cornerRadius = 4.0f;
    return self;
}

- (void)setSelected:(BOOL)isSelected
{
    if (isSelected) {
        self.backgroundColor = [UIColor colorWithRGB:GZUIKitFontGrey4];
    } else {
        self.backgroundColor = [UIColor clearColor];
    }
}

@end

const float GZ_EMOJI_LENS_HEIGHT = 55;
const float GZ_EMOJI_LENS_WIDTH = 60;

@interface GZStickerLens : UIView

@property(strong, nonatomic)GZStickerItem* stickerItem;
@property(strong, nonatomic)UILabel* nameLabel;
@property(strong, nonatomic)UILabel* emojiLabel;
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
    self.layer.borderColor = [UIColor colorWithRGB:GZUIKitFontGrey3].CGColor;
    self.backgroundColor = [UIColor colorWithRGB:GZUIKitUIGrey11];
    self.layer.borderWidth = 1.0;
    
    self.nameLabel = [UILabel new];
    self.emojiLabel = [UILabel new];
    self.stickerType = -1; // set to a unknow value
    
    // Set up basic effect of key pop
    self.nameLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:11.0];
    self.emojiLabel.font = [UIFont systemFontOfSize:35];
    
    self.nameLabel.textAlignment = NSTextAlignmentCenter;
    self.emojiLabel.textAlignment = NSTextAlignmentCenter;
    
    [self addSubview:self.nameLabel];
    [self addSubview:self.emojiLabel];
    return self;
}

- (void)updateStickerInfo:(GZStickerItem*) item
{
    self.stickerItem = item;
    if (self.stickerType != self.stickerItem.stickerType) {
        // When type not match with current one, update layout
        self.stickerType = item.stickerType;
        if (self.stickerItem.stickerType == GZ_TYPE_EMOJI) {
            
            [self mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.width.equalTo(@(GZ_EMOJI_LENS_WIDTH));
                make.height.equalTo(@(GZ_EMOJI_LENS_HEIGHT));
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
            
        } else if (self.stickerItem.stickerType == GZ_TYPE_STICKER) {
            
        }
    }
    
    self.emojiLabel.text = item.resource;
    self.nameLabel.text = item.name;
}

- (void)displayOnRectAnchor:(UIView*)anchorView
{
    CGPoint pointInContentView = [anchorView convertPoint:anchorView.frame.origin toView:anchorView.superview.superview.superview.superview];
    
    [self mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@(GZ_EMOJI_LENS_WIDTH));
        make.height.equalTo(@(GZ_EMOJI_LENS_HEIGHT));
        make.leading.equalTo(@(pointInContentView.x/[UIScreen mainScreen].scale - (GZ_EMOJI_LENS_WIDTH - anchorView.frame.size.width)/2));
        make.top.equalTo(@(pointInContentView.y/[UIScreen mainScreen].scale - GZ_EMOJI_LENS_HEIGHT - 5));
    }];
}

@end



@interface GZStickerScrollPage()

@property(strong, nonatomic)UIView* pageContentView;
@property(assign, nonatomic)BOOL isInLongPress;
@property(assign, nonatomic)GZEmojiIcon* pressingView;
@property(strong, nonatomic)GZStickerPackage* currentPackage;
@property(strong, nonatomic)GZStickerLens* popView;

@end

@implementation GZStickerScrollPage

- (instancetype)init
{
    self = [super init];
    [self checkPageView];
    return self;
}

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
    
    UILongPressGestureRecognizer* longPressTrig = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressPop:)];
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
    
    // Need further config the layout for sticker type display -> so far only support emoji
    for (GZStickerItem* emojiItem in stickerIcons) {
        int pageIndex = (int)[stickerIcons indexOfObject:emojiItem];
        int rowPosition = (pageIndex) / coloumnPerpage;
        int coloumnPosition = (pageIndex) % coloumnPerpage;
        
        // Config delete button
        if (stickerPackage.type == GZ_TYPE_EMOJI) {
            UILabel* deleteButton = [GZUIKitIconFontHelper labelWithIdentifier:@"e615" tintColor:[UIColor grayColor] fontSize:18.0];
            deleteButton.textAlignment = NSTextAlignmentCenter;
            deleteButton.userInteractionEnabled = YES;
            [self.pageContentView addSubview:deleteButton];
            
            [deleteButton mas_makeConstraints:^(MASConstraintMaker *make) {
                make.width.equalTo([NSNumber numberWithFloat:GZ_EMO_ICON_SIZE]);
                make.height.equalTo([NSNumber numberWithFloat:GZ_EMO_ICON_SIZE]);
                make.top.equalTo([NSNumber numberWithFloat:(verticalSpacing + (verticalSpacing + GZ_EMO_ICON_SIZE)* 2)]);
                make.leading.equalTo([NSNumber numberWithFloat:(horizontalSpacing + (coloumnPerpage - 1) * (GZ_EMO_ICON_SIZE + horizontalSpacing))]);
            }];
            [deleteButton addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(deleteInputChar)]];
        }
        
        GZEmojiIcon* emojiLabel = [[GZEmojiIcon alloc] initWithStickerInfo:emojiItem];
        emojiLabel.tag = [stickerPackage.contentArray indexOfObject:emojiItem];
        [emojiLabel addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(simpleLabelTapped:)]];
        
        [self.pageContentView addSubview:emojiLabel];
        [emojiLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo([NSNumber numberWithFloat:GZ_EMO_ICON_SIZE]);
            make.height.equalTo([NSNumber numberWithFloat:GZ_EMO_ICON_SIZE]);
            make.leading.equalTo([NSNumber numberWithFloat:(horizontalSpacing + coloumnPosition * (GZ_EMO_ICON_SIZE + horizontalSpacing))]);
            make.top.equalTo([NSNumber numberWithFloat:(verticalSpacing + (verticalSpacing + GZ_EMO_ICON_SIZE)* rowPosition)]);
        }];
    }
}

# pragma mark - keyboard control

- (void)simpleLabelTapped:(UIGestureRecognizer*)recognizer
{
    GZStickerPackage* emojiPack = [GZStickerPackage defaultStickerPackage];
    if ([emojiPack.contentArray count] > (recognizer.view).tag) {
        GZStickerItem* stickerItem = [emojiPack.contentArray objectAtIndex:recognizer.view.tag];
        if (stickerItem.stickerType == GZ_TYPE_EMOJI) {
            // Hanlde emoji input insertion
        } else if (stickerItem.stickerType == GZ_TYPE_STICKER) {
            // Hanlde sticker sending
        }
    }
}

- (void)deleteInputChar
{
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
