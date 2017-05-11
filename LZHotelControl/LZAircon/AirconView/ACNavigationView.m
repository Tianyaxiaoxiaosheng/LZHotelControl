//
//  ACNavigationView.m
//  LZHGRControl
//
//  Created by Jony on 17/4/7.
//  Copyright © 2017年 yavatop. All rights reserved.
//

#import "ACNavigationView.h"

@implementation ACNavigationView

- (instancetype)initWithFrame:(CGRect)frame{
    if ([super initWithFrame:frame]) {
        //设置界面
        self = [[[NSBundle mainBundle] loadNibNamed:@"ACNavigationView" owner:nil options:nil] lastObject];
        self.frame = frame;
        self.backgroundColor = [UIColor colorWithRed:192/255 green:192/255 blue:192/255 alpha:0.2];
        self.layer.cornerRadius = 18;
        self.layer.masksToBounds = YES;
        
        for (NSInteger i = 1; i <= 2; i++) {
            //无法直接使用UIButton *button in self.subViews,因为有其他控件，可能报错
            UIButton *button = [self viewWithTag:i];
            if (button) {
                [button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
            }
        }

    }
    
    //初始化
    [self buttonClicked:[self viewWithTag:1]];
    
    return self;
}

- (void)buttonClicked:(UIButton *)button{
    [self goalButtonColorTransparent:button];
    if (self.delegate && [self.delegate respondsToSelector:@selector(createdKeyboardWithACNavigationView:)]) {
        [self.delegate createdKeyboardWithACNavigationView:button.tag];
    }
    
}
- (void)goalButtonColorTransparent:(UIButton *)button{
    for (NSInteger i = 1; i <= 2; i++){
        UIButton *tempButton = [self viewWithTag:i];
        if (tempButton) {
            if (tempButton.tag != button.tag){
                tempButton.backgroundColor = [UIColor colorWithRed:192/255 green:192/255 blue:192/255 alpha:0.2];
                tempButton.enabled = YES;
            }else{
                tempButton.backgroundColor = [UIColor colorWithRed:192/255 green:192/255 blue:192/255 alpha:0.0];
                tempButton.enabled = NO;
            }
        }
    }
}


@end
