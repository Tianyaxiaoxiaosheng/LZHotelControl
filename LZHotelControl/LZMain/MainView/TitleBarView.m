//
//  TitleBarView.m
//  LZHGRControl
//
//  Created by Jony on 17/4/7.
//  Copyright © 2017年 yavatop. All rights reserved.
//

#import "TitleBarView.h"

@implementation TitleBarView

- (instancetype)initWithFrame:(CGRect)frame andEquipment:(EquipmentInfo *)equipmentInfo
{
    UIView * xibViews = [[[NSBundle mainBundle] loadNibNamed:@"TitleBarView" owner:nil options:nil] lastObject];
    
    [[xibViews viewWithTag:1] setText:equipmentInfo.ChineseName];
    [[xibViews viewWithTag:2] setText:equipmentInfo.EnglishName];
    [[xibViews viewWithTag:3] setImage:[UIImage imageNamed:equipmentInfo.icon]];
    
        
     return (TitleBarView *)xibViews;
}


@end
