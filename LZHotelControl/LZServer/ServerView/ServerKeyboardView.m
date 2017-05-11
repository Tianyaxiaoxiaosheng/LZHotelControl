//
//  ServerKeyboardView.m
//  LZHGRControl
//
//  Created by Jony on 17/4/7.
//  Copyright © 2017年 yavatop. All rights reserved.
//

#import "ServerKeyboardView.h"

@interface ServerKeyboardView ()
@end

@implementation ServerKeyboardView

-(instancetype)initWithFrame:(CGRect)frame
{
    if ([super initWithFrame:frame]) {
        self = [[[NSBundle mainBundle] loadNibNamed:@"ServerKeyboardView" owner:nil options:nil] lastObject];
        self.frame = frame;
        self.backgroundColor = [UIColor colorWithRed:192/255 green:192/255 blue:192/255 alpha:0.2];
        self.layer.cornerRadius = 18;
        self.layer.masksToBounds = YES;
        
        for (NSInteger i = 1; i <= 3; i++) {
            UIButton *button = [self viewWithTag:i];
            if (button) {
                [button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
            }
        }
    }
    return self;
}

- (void)buttonClicked:(UIButton *)button{
    button.selected = button.isSelected ? FALSE:TRUE;
}

@end

