//
//  AirconKeyboardView.m
//  LZHGRControl
//
//  Created by Jony on 17/4/7.
//  Copyright © 2017年 yavatop. All rights reserved.
//

#import "AirconKeyboardView.h"

@interface AirconKeyboardView ()
//空调模式显示的数组
@property (nonatomic, strong) NSArray *modeTypeImages;
@property (nonatomic, strong) NSArray *windTypeImages;

//温度数值
@property (nonatomic, assign) NSInteger temperature;
@end

@implementation AirconKeyboardView

#pragma mark-lazyload
//加载空调模式显示的数组
- (NSArray *)modeTypeImages{
    if (!_modeTypeImages) {
        _modeTypeImages = @[@"model_wind", @"model_code", @"model_hot"];
    }
    return _modeTypeImages;
}
- (NSArray *)windTypeImages{
    if (!_windTypeImages) {
        _windTypeImages = @[@"wind_speed4", @"wind_speed1", @"wind_speed2", @"wind_speed3", @"wind_speed0"];
    }
    return _windTypeImages;
}

-(instancetype)initWithFrame:(CGRect)frame
{
    if ([super initWithFrame:frame]) {
        
//        NSLog(@"AirconKeyboardView");
        //设置界面
        self = [[[NSBundle mainBundle] loadNibNamed:@"AirconKeyboardView" owner:nil options:nil] lastObject];
        self.frame = frame;
        
        for (NSInteger i = 1; i <= 10; i++) {
            //无法直接使用UIButton *button in self.subViews,因为有其他控件，可能报错
            UIButton *button = [self viewWithTag:i];
            if (button) {
                [button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
            }
        }
        
        //初始化一个温度值
        self.temperatureLabel.text = [NSString stringWithFormat:@"%ld", self.temperature];

    }
    return self;
}

- (void)buttonClicked:(UIButton *)button{
//    switch (button.tag) {
//        case 1:
//            self.temperatureLabel.text = [NSString stringWithFormat:@"%ld", ++self.temperature];
//            break;
//        case 2:
//            self.temperatureLabel.text = [NSString stringWithFormat:@"%ld", --self.temperature];
//            break;
//        case 3:
//        case 4:
//        case 5:
//            self.modeTypeImage.image = [UIImage imageNamed:self.modeTypeImages[button.tag%3]];
//            break;
//        case 6:
//        case 7:
//        case 8:
//        case 9:
//        case 10:
//            self.windTypeImage.image = [UIImage imageNamed:self.windTypeImages[button.tag%6]];
//            break;
//            
//            
//        default:
//            break;
//    }
}

- (void)setViewInfo:(NSDictionary *)setDic{
    //NSLog(@"setDic: %@", setDic);
    
    //显示实际温度
    //self.temperatureLabel.text = [NSString stringWithFormat:@"%@", [setDic objectForKey:@"aTemp"]];
    
    //显示设置温度
    self.temperatureLabel.text = [NSString stringWithFormat:@"%@", [setDic objectForKey:@"sTemp"]];

    
    NSInteger modeType = [[setDic objectForKey:@"modeType"] integerValue];
    self.modeTypeImage.image = [UIImage imageNamed:self.modeTypeImages[modeType]];
    
    NSInteger windType = [[setDic objectForKey:@"windType"] integerValue];
    self.windTypeImage.image = [UIImage imageNamed:self.windTypeImages[windType]];
}

@end
