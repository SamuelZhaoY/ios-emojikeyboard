//
//  ViewController.m
//  GZEmojiKeyboardDemo
//
//  Created by zhaoy on 28/8/16.
//  Copyright © 2016 com.gz. All rights reserved.
//

#import "ViewController.h"
#import <Masonry/Masonry.h>
#import <GZEmojiKeyboard/GZEmojiKeyboardControl.h>

/**
 *  TODO: 1. support screen roration, ipad 2. support gif
 */
@interface ViewController ()

@property (weak, nonatomic) IBOutlet UITextField *emojiInput;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    GZEmojiKeyboardControl* emoControl = [GZEmojiKeyboardControl new];
    emoControl.associatedInput = self.emojiInput;
    [emoControl showInView:self.view];
    
    self.view.userInteractionEnabled = YES;
    [self.view addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self
                                                                            action:@selector(dismissKeyboard)]];
}

- (void)dismissKeyboard
{
    [self.emojiInput resignFirstResponder];
}


@end
