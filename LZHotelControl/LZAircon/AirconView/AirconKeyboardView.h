//
//  AirconKeyboardView.h
//  LZHGRControl
//
//  Created by Jony on 17/4/7.
//  Copyright © 2017年 yavatop. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AirconKeyboardView : UIView
@property (weak, nonatomic) IBOutlet UILabel *temperatureLabel;
@property (weak, nonatomic) IBOutlet UIImageView *windTypeImage;
@property (weak, nonatomic) IBOutlet UIImageView *modeTypeImage;

//界面信息修改
- (void)setViewInfo:(NSDictionary *)setDic;

@end
