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

@property (weak, nonatomic) IBOutlet UITextField *emojiInput;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    GZStickerPanelControl* _emoControl = [GZStickerPanelControl new];
    [self.view addSubview:_emoControl];
    [_emoControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.view.mas_leading);
        make.bottom.equalTo(self.view.mas_bottom);
        make.width.equalTo(self.view.mas_width);
        make.height.equalTo([NSNumber numberWithFloat:178.0f]);
    }];
    
    [_emoControl setBackgroundColor:[UIColor colorWithRed:(float)0xEE/0xFF
                                                    green:(float)0xEE/0xFF
                                                     blue:(float)0xEE/0xFF
                                                    alpha:1.0]];
    _emoControl.associatedInput = self.emojiInput;
    
    self.view.userInteractionEnabled = YES;
    [self.view addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self
                                                                            action:@selector(dismissKeyboard)]];
    
}

- (void)dismissKeyboard
{
    [self.emojiInput resignFirstResponder];
}


@end
