//
//  LTNavigationBarView.m
//  LZHGRControl
//
//  Created by Jony on 17/4/7.
//  Copyright © 2017年 yavatop. All rights reserved.
//

#import "LTNavigationBarView.h"

@interface LTNavigationBarView ()
//无法使用数组存储按钮后再次修改
//@property (nonatomic, strong) NSMutableArray *buttonArray;
@end

@implementation LTNavigationBarView

-(instancetype)initWithFrame:(CGRect)frame
{
    if ([super initWithFrame:frame]) {
        self = [[[NSBundle mainBundle] loadNibNamed:@"LTNavigationBarView" owner:nil options:nil] lastObject];
        self.frame = frame;
        self.backgroundColor = [UIColor colorWithRed:192/255 green:192/255 blue:192/255 alpha:0.2];
        self.layer.cornerRadius = 18;
        self.layer.masksToBounds = YES;
        
        for (NSInteger i = 1; i <= 5; i++) {
            //无法直接使用UIButton *button in self.subViews,因为有其他控件，可能报错
            UIButton *button = [self viewWithTag:i];
            if (button) {
                [button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
            }
         }
    }
    
    //初始化
    //初始化在此，导致初始过程代理协议无法执行，解决方案：代理不可行，因为需要controller那边触发，通知也可解决，最直接的方法，在那边初始化另一部分
    [self buttonClicked:[self viewWithTag:1]];
    
    return self;
}

- (void)buttonClicked:(UIButton *)button{
    [self goalButtonColorTransparent:button];
    if (self.delegate && [self.delegate respondsToSelector:@selector(createdKeyboardWithLTNavigationBarView:)]) {
        [self.delegate createdKeyboardWithLTNavigationBarView:button.tag];
    }
    
}
- (void)goalButtonColorTransparent:(UIButton *)button{
    for (NSInteger i = 1; i <= 5; i++){
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

