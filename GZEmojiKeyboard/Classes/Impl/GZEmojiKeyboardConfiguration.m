//
//  GZStickerConfiguration.m
//  GZEmojiKeyboard
//
//  Created by zhaoy on 10/9/16.
//  Copyright © 2016 com.gz. All rights reserved.
//

#import "GZEmojiKeyboardConfiguration.h"
#import "GZStickerPackage.h"
#import "GZCommonUtils.h"

@implementation GZEmojiKeyboardConfiguration

+ (GZEmojiKeyboardConfiguration*) defaultInstance
{
    static GZEmojiKeyboardConfiguration* config;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        config = [GZEmojiKeyboardConfiguration new];
    });
    
    return config;
}

- (instancetype)init
{
    self = [super init];

    [self useDefaultPackages];
    
    return self;
}

- (void)useDefaultPackages
{
    self.stickerPackageList = [NSMutableArray new];
    [self.stickerPackageList addObject:[self defaultEmojiPackage]];
    [self.stickerPackageList addObject:[self defaultStickerPackage]];
}

#pragma mark - Config default emoji

- (GZStickerPackage*)defaultEmojiPackage
{
    GZStickerPackage* emojiPack = [GZStickerPackage new];
    NSArray* rawEmoji = [self rawEmoji];
    
    // Check about rawCodes
    NSMutableArray* emojiItems = [NSMutableArray new];
    for (NSString* rawCode in rawEmoji) {
        GZStickerItem* emojiItem = [GZStickerItem new];
        emojiItem.resource = rawCode;
        emojiItem.name = [NSString stringWithFormat:@"emoji #%lu",(unsigned long)[rawEmoji indexOfObject:rawCode]];
        emojiItem.stickerType = GZ_TYPE_EMOJI;
        [emojiItems addObject:emojiItem];
    }
    
    emojiPack.title = @"Emoji";
    emojiPack.icon = [GZCommonUtils imageFromString:@"\U0001F603"
                                          tintColor:[UIColor blackColor]
                                               size:CGSizeMake(25, 25)];
    emojiPack.contentArray = [emojiItems copy];
    emojiPack.rawSource = rawEmoji;
    
    return emojiPack;
}

- (GZStickerPackage*)defaultStickerPackage
{
    GZStickerPackage* stickerPack = [GZStickerPackage new];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSURL *bundleURL = [[NSBundle mainBundle] URLForResource:@"Sticker" withExtension:@".bundle"];
    NSArray *contents = [fileManager contentsOfDirectoryAtURL:bundleURL
                                   includingPropertiesForKeys:@[]
                                                      options:NSDirectoryEnumerationSkipsHiddenFiles
                                                        error:nil];
    
    NSMutableArray* stickerItems = [NSMutableArray new];
    for (NSURL *path in contents) {
        GZStickerItem* stickerItem = [GZStickerItem new];
        stickerItem.resource = [path path];
        stickerItem.name = [NSString stringWithFormat:@"stickerItems #%lu",(unsigned long)[contents indexOfObject:path]];
        stickerItem.stickerType = GZ_TYPE_STICKER;
        [stickerItems addObject:stickerItem];
    }
    
    stickerPack.title = @"Sticker";
    stickerPack.icon = [GZCommonUtils imageFromString:@"\U0001F680"
                                            tintColor:[UIColor blackColor]
                                                 size:CGSizeMake(25, 25)];
    stickerPack.contentArray = stickerItems;
    stickerPack.type = GZ_TYPE_STICKER;
    return stickerPack;
}

- (NSArray*)rawEmoji
{
    static dispatch_once_t token;
    static NSArray* rawEmoji;
    dispatch_once(&token, ^{
        rawEmoji = @[@"\U0001F600",
                     @"\U0001F601",
                     @"\U0001F602",
                     @"\U0001F603",
                     @"\U0001F604",
                     @"\U0001F605",
                     @"\U0001F606",
                     @"\U0001F607",
                     @"\U0001F608",
                     @"\U0001F609",
                     @"\U0001F60A",
                     @"\U0001F60B",
                     @"\U0001F60C",
                     @"\U0001F60D",
                     @"\U0001F60E",
                     @"\U0001F60F",
                     @"\U0001F610",
                     @"\U0001F611",
                     @"\U0001F612",
                     @"\U0001F613",
                     @"\U0001F614",
                     @"\U0001F615",
                     @"\U0001F616",
                     @"\U0001F617",
                     @"\U0001F618",
                     @"\U0001F619",
                     @"\U0001F61A",
                     @"\U0001F61B",
                     @"\U0001F61C",
                     @"\U0001F61D",
                     @"\U0001F61E",
                     @"\U0001F61F",
                     @"\U0001F620",
                     @"\U0001F630",
                     @"\U0001F631",
                     @"\U0001F632",
                     @"\U0001F633",
                     @"\U0001F634",
                     @"\U0001F635",
                     @"\U0001F636",
                     @"\U0001F637",
                     @"\U0001F638",
                     @"\U0001F639",
                     @"\U0001F63A",
                     @"\U0001F63B",
                     @"\U0001F63C",
                     @"\U0001F63D",
                     @"\U0001F63E",
                     @"\U0001F63F",
                     @"\U0001F640",
                     @"\U0001F641",
                     @"\U0001F642",
                     @"\U0001F643",
                     @"\U0001F644",
                     @"\U0001F645",
                     @"\U0001F646",
                     @"\U0001F647",
                     @"\U0001F648",
                     @"\U0001F649",
                     @"\U0001F64A",
                     @"\U0001F64B",
                     @"\U0001F64C",
                     @"\U0001F64D",
                     @"\U0001F64E",
                     @"\U0001F64F"];
    });
    
    return rawEmoji;
}

@end