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
//        self.tag = 2;
        
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
    
    if ((button.tag >= 3) && (button.tag <= 4)) {
        [self otherSceneSettingIsNonSelect:button.tag];
    }
    
    NSString *stateStr = button.isSelected ? @"01":@"00";
    NSDictionary *dic = @{@"equipmentNum":@"1"
                          , @"viewNum":@"02"
                          , @"buttonNum":[NSString stringWithFormat:@"%ld",button.tag]
                          , @"state":stateStr
                          };
    [EPCore buttonClickedProcessingWithInfoDictionary:dic];
}

- (void)allLightsSwitchIsOpen:(BOOL)isOpen{
    for (NSUInteger i = 1; i <= 2; i++) {
        UIButton *button =[self viewWithTag:i];
        if (button) {
            button.selected = isOpen;
        }
    }

}

//所有模式置为非选择状态
- (void)otherSceneSettingIsNonSelect:(NSInteger)tag{
    for (NSUInteger i = 3; i <= 4; i++) {
        UIButton *button =[self viewWithTag:i];
        if ((i != tag) && button) {
            button.selected = FALSE;
        }
    }
}



@end
