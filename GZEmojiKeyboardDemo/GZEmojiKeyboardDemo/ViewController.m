//
//  ViewController.m
//  GZEmojiKeyboardDemo
//
//  Created by zhaoy on 28/8/16.
//  Copyright © 2016 com.gz. All rights reserved.
//

#import "ViewController.h"
#import <Masonry/Masonry.h>
#import <GZEmojiKeyboard/GZStickerPanelControl.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // config emoji& sticker control
    GZStickerPanelControl* _emoControl = [GZStickerPanelControl new];
    [self.view addSubview:_emoControl];
    [_emoControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.view.mas_leading);
        make.bottom.equalTo(self.view.mas_bottom);
        make.width.equalTo(self.view.mas_width);
        make.height.equalTo([NSNumber numberWithFloat:178.0f]);
    }];
    
    [_emoControl setBackgroundColor:[UIColor grayColor]];
    
}

@end
