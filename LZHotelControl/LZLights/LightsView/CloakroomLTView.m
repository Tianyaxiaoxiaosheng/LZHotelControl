//
//  CloakroomLTView.m
//  LZHGRControl
//
//  Created by Jony on 17/4/7.
//  Copyright © 2017年 yavatop. All rights reserved.
//

#import "CloakroomLTView.h"

@implementation CloakroomLTView

-(instancetype)initWithFrame:(CGRect)frame
{
    if ([super initWithFrame:frame]) {
        
        //设置界面
        self = [[[NSBundle mainBundle] loadNibNamed:@"CloakroomLTView" owner:nil options:nil] lastObject];
        self.frame = frame;
        
         for (NSInteger i = 1; i <= 2; i++) {
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
    
    NSString *stateStr = button.isSelected ? @"01":@"00";
    NSDictionary *dic = @{@"equipmentNum":@"01"
                          , @"viewNum":@"04"
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

@end
