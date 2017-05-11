//
//  MainLampLTView.m
//  LZHGRControl
//
//  Created by Jony on 17/4/7.
//  Copyright © 2017年 yavatop. All rights reserved.
//

#import "MainLampLTView.h"

@implementation MainLampLTView

-(instancetype)initWithFrame:(CGRect)frame
{
    if ([super initWithFrame:frame]) {
        //Add View tag
        self.tag = 2;
        
        //设置界面
        self = [[[NSBundle mainBundle] loadNibNamed:@"MainLampLTView" owner:nil options:nil] lastObject];
        self.frame = frame;
        
        for (NSInteger i = 1; i <= 4; i++) {
            UIButton *button =[self viewWithTag:i];
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

- (void)allLightsSwitchIsOpen:(BOOL)isOpen{
    for (NSUInteger i = 1; i <= 2; i++) {
        UIButton *button =[self viewWithTag:i];
        if (button) {
            button.selected = isOpen;
        }
    }

}


@end
