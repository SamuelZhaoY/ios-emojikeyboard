//
//  IAPStickerScrollPage.m
//  MobileFramework
//
//  Created by zhaoy on 15/10/15.
//  Copyright © 2015 Alipay. All rights reserved.
//

#import "IAPStickerScrollPage.h"
#import "IAPStickerPackage.h"
#import "IAPExpandableInputView.h"
#import "IAPStickerPanelControl.h"

@interface IAPEmojiIcon : UILabel

@property(strong, nonatomic)IAPStickerItem* item;

- (instancetype)initWithStickerInfo:(IAPStickerItem*)itemInfo;

- (void)setSelected:(BOOL)isSelected;

@end

@implementation IAPEmojiIcon

- (instancetype)initWithStickerInfo:(IAPStickerItem*)itemInfo
{
    self = [super init];
    self.item = itemInfo;
    self.text = itemInfo.resource;
    self.font = [UIFont iap_T1B];
    self.userInteractionEnabled = YES;
    self.textAlignment = NSTextAlignmentCenter;
    self.clipsToBounds = YES;
    self.layer.cornerRadius = 4.0f;
    return self;
}

- (void)setSelected:(BOOL)isSelected
{
    if (isSelected) {
        self.backgroundColor = [UIColor colorWithRGB:IAPUIKitFontGrey4];
    } else {
        self.backgroundColor = [UIColor clearColor];
    }
}

@end

const float IAP_EMOJI_LENS_HEIGHT = 55;
const float IAP_EMOJI_LENS_WIDTH = 60;

@interface IAPStickerLens : UIView

@property(strong, nonatomic)IAPStickerItem* stickerItem;
@property(strong, nonatomic)UILabel* nameLabel;
@property(strong, nonatomic)UILabel* emojiLabel;
@property(assign, nonatomic)IAP_STICKER_TYPE stickerType;


- (void)updateStickerInfo:(IAPStickerItem*) item;
- (void)displayOnRectAnchor:(UIView*)anchorView;

@end

@implementation IAPStickerLens

- (instancetype)init
{
    self = [super init];
    
    self.clipsToBounds = YES;
    self.layer.cornerRadius = 4.0;
    self.layer.borderColor = [UIColor colorWithRGB:IAPUIKitFontGrey3].CGColor;
    self.backgroundColor = [UIColor colorWithRGB:IAPUIKitUIGrey11];
    self.layer.borderWidth = 1.0;
    
    self.nameLabel = [UILabel new];
    self.emojiLabel = [UILabel new];
    self.stickerType = -1; // set to a unknow value
    
    // Set up basic effect of key pop
    self.nameLabel.font = [UIFont iap_T7L];
    self.emojiLabel.font = [UIFont systemFontOfSize:35];
    
    self.nameLabel.textAlignment = NSTextAlignmentCenter;
    self.emojiLabel.textAlignment = NSTextAlignmentCenter;
    
    [self addSubview:self.nameLabel];
    [self addSubview:self.emojiLabel];
    return self;
}

- (void)updateStickerInfo:(IAPStickerItem*) item
{
    self.stickerItem = item;
    if (self.stickerType != self.stickerItem.stickerType) {
        // When type not match with current one, update layout
        self.stickerType = item.stickerType;
        if (self.stickerItem.stickerType == IAP_TYPE_EMOJI) {
            
            [self mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.width.equalTo(@(IAP_EMOJI_LENS_WIDTH));
                make.height.equalTo(@(IAP_EMOJI_LENS_HEIGHT));
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
            
        } else if (self.stickerItem.stickerType == IAP_TYPE_STICKER) {
            
        }
    }
    
    self.emojiLabel.text = item.resource;
    self.nameLabel.text = item.name;
}

- (void)displayOnRectAnchor:(UIView*)anchorView
{
    [self mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@(IAP_EMOJI_LENS_WIDTH));
        make.height.equalTo(@(IAP_EMOJI_LENS_HEIGHT));
        make.leading.equalTo(@(anchorView.origin.x - (IAP_EMOJI_LENS_WIDTH - anchorView.frame.size.width)/2));
        make.top.equalTo(@(anchorView.origin.y - IAP_EMOJI_LENS_HEIGHT - 5));
    }];
}

@end



@interface IAPStickerScrollPage()

@property(strong, nonatomic)UIView* pageContentView;
@property(assign, nonatomic)BOOL isInLongPress;
@property(assign, nonatomic)IAPEmojiIcon* pressingView;
@property(strong, nonatomic)IAPStickerPackage* currentPackage;
@property(strong, nonatomic)IAPStickerLens* popView;

@end

@implementation IAPStickerScrollPage

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

- (void)updateStickerPackage:(IAPStickerPackage*)stickerPackage atIndex:(int)index
{
    [[self.pageContentView subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    NSArray* stickerIcons = [stickerPackage checkItemsAtIndexedPage:index];
    int coloumnPerpage =  [stickerPackage checkColumnCount];
    float horizontalSpacing = [stickerPackage checkHorizontalSpacing];
    float verticalSpacing = [stickerPackage checkVerticalSpacing];
    
    // Need further config the layout for sticker type display -> so far only support emoji
    for (IAPStickerItem* emojiItem in stickerIcons) {
        int pageIndex = (int)[stickerIcons indexOfObject:emojiItem];
        int rowPosition = (pageIndex) / coloumnPerpage;
        int coloumnPosition = (pageIndex) % coloumnPerpage;
        
        // Config delete button
        if (stickerPackage.type == IAP_TYPE_EMOJI) {
            UILabel* deleteButton = [IAPUIKitIconFontHelper labelWithIdentifier:@"e615" tintColor:[UIColor grayColor] fontSize:18.0];
            deleteButton.textAlignment = NSTextAlignmentCenter;
            deleteButton.userInteractionEnabled = YES;
            [self.pageContentView addSubview:deleteButton];
            
            [deleteButton mas_makeConstraints:^(MASConstraintMaker *make) {
                make.width.equalTo([NSNumber numberWithFloat:IAP_EMO_ICON_SIZE]);
                make.height.equalTo([NSNumber numberWithFloat:IAP_EMO_ICON_SIZE]);
                make.top.equalTo([NSNumber numberWithFloat:(verticalSpacing + (verticalSpacing + IAP_EMO_ICON_SIZE)* 2)]);
                make.leading.equalTo([NSNumber numberWithFloat:(horizontalSpacing + (coloumnPerpage - 1) * (IAP_EMO_ICON_SIZE + horizontalSpacing))]);
            }];
            [deleteButton addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(deleteInputChar)]];
        }
        
        IAPEmojiIcon* emojiLabel = [[IAPEmojiIcon alloc] initWithStickerInfo:emojiItem];
        emojiLabel.tag = [stickerPackage.contentArray indexOfObject:emojiItem];
        [emojiLabel addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(simpleLabelTapped:)]];
        
        [self.pageContentView addSubview:emojiLabel];
        [emojiLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo([NSNumber numberWithFloat:IAP_EMO_ICON_SIZE]);
            make.height.equalTo([NSNumber numberWithFloat:IAP_EMO_ICON_SIZE]);
            make.leading.equalTo([NSNumber numberWithFloat:(horizontalSpacing + coloumnPosition * (IAP_EMO_ICON_SIZE + horizontalSpacing))]);
            make.top.equalTo([NSNumber numberWithFloat:(verticalSpacing + (verticalSpacing + IAP_EMO_ICON_SIZE)* rowPosition)]);
        }];
    }
}

# pragma mark - keyboard control

- (void)simpleLabelTapped:(UIGestureRecognizer*)recognizer
{
    IAPStickerPackage* emojiPack = [IAPStickerPackage defaultStickerPackage];
    if ([emojiPack.contentArray count] > (recognizer.view).tag) {
        IAPStickerItem* stickerItem = [emojiPack.contentArray objectAtIndex:recognizer.view.tag];
        if (stickerItem.stickerType == IAP_TYPE_EMOJI) {
            // Hanlde emoji input insertion
            [self.accessoryInput insertText:stickerItem.resource];
        } else if (stickerItem.stickerType == IAP_TYPE_STICKER) {
            // Hanlde sticker sending
        }
    }
}

- (void)deleteInputChar
{
    [self.accessoryInput deleteBackward];
}

# pragma mark -  Popup view on drag

- (void)longPressPop:(UIGestureRecognizer*)recognizer
{
    if (recognizer.state == UIGestureRecognizerStateBegan)
    {
        [self togglePopLens:YES];
        CGPoint currentlocation = [recognizer locationInView:self];
        UIView* targetView = [self hitTest:currentlocation withEvent:nil];
        [self updatePressPop:(IAPEmojiIcon*)targetView];
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
        self.popView = [IAPStickerLens new];
        [self.superview.superview.superview addSubview:self.popView];
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
        if ([targetView isKindOfClass:[IAPEmojiIcon class]]) {
            IAPEmojiIcon* iconView = (IAPEmojiIcon*)targetView;
            if (self.pressingView != iconView) {
                [self updatePressPop:iconView];
            }
        }
    }
}

- (void)updatePressPop:(IAPEmojiIcon*)pressingView
{
    if (!pressingView || ![pressingView isKindOfClass:[IAPEmojiIcon class]]) {
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
