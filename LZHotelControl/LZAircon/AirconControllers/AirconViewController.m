//
//  AirconViewController.m
//  LZHGRControl
//
//  Created by Jony on 17/4/1.
//  Copyright © 2017年 yavatop. All rights reserved.
//

#import "AirconViewController.h"

@interface AirconViewController ()<ACNavigationViewDelegate>
//临时uiview
@property (nonatomic, strong) id tempView;

@property (nonatomic, strong) TitleBarView *titleBarView;            //标题视图
@property (nonatomic, strong) ACNavigationView *aCNavigationView;    //键盘导航视图（包括键盘显示区域）
@property (nonatomic, strong) AirconKeyboardView *PLAirconKeyboardView; //客厅空调键盘视图
@property (nonatomic, strong) AirconKeyboardView *BRAirconKeyboardView;  //卧室空调键盘视图

@end

@implementation AirconViewController
///////////////////////////////////////////////////////////////////////////
#pragma mark-lazyload

//懒加载标题视图
- (TitleBarView *)titleBarView{
    if (!_titleBarView) {
        if (self.equipmentInfo) {
            _titleBarView = [[TitleBarView alloc] initWithFrame:CGRectMake(TITLEBAR_VIEW_INIT_X, TITLEBAR_VIEW_INIT_Y, TITLEBAR_VIEW_WIDTH, TITLEBAR_VIEW_HEIGHT) andEquipment:self.equipmentInfo];
        }else{
            NSLog(@"Aircon equipmentInfo finding failed in EquipmentInfoManage");
        }
    }
    return _titleBarView;
}

//懒加载客厅空调键盘
- (AirconKeyboardView *)PLAirconKeyboardView{
    if (!_PLAirconKeyboardView) {
        _PLAirconKeyboardView = [[AirconKeyboardView alloc] initWithFrame:CGRectMake(ACKB_VIEW_INIT_X, ACKB_VIEW_INIT_Y, ACKB_VIEW_WIDTH, ACKB_VIEW_HEIGHT)];
    }
    return _PLAirconKeyboardView;
}
//懒加载卧室空调键盘
- (AirconKeyboardView *)BRAirconKeyboardView{
    if (!_BRAirconKeyboardView) {
        _BRAirconKeyboardView = [[AirconKeyboardView alloc] initWithFrame:CGRectMake(ACKB_VIEW_INIT_X, ACKB_VIEW_INIT_Y, ACKB_VIEW_WIDTH, ACKB_VIEW_HEIGHT)];
    }
    return _BRAirconKeyboardView;
}
//懒加载导航视图
- (ACNavigationView *)aCNavigationView{
    if (!_aCNavigationView) {
        _aCNavigationView = [[ACNavigationView alloc] initWithFrame:CGRectMake(AIRCON_VIEW_INIT_X, AIRCON_VIEW_INIT_Y, AIRCON_VIEW_WIDTH, AIRCON_VIEW_HEIGHT)];
        _aCNavigationView.delegate = self;
    }
    return _aCNavigationView;
}


////////////////////////////////////////////////////////////////////////////////////////////

- (void)viewDidLoad {
    [super viewDidLoad];
    //测试设备信息
    NSLog(@"equipmentNum : %ld", [self.equipmentInfo.number integerValue]);
    
    //添加标题界面
    [self.view addSubview:self.titleBarView];

    //添加整个键盘导航界面
    [self.view addSubview:self.aCNavigationView];
 
    //初始化键盘控制界面
    [self initACNavigationView];
    
    //注册通知，死亡时移除
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(controlInformationProcessing:) name:@"Aircon" object:nil];
}

//控制器死亡时移除观察者，
- (void)dealloc{
    //tabbar 切换是不会死亡的
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
}


- (void)initACNavigationView{
    
    [self.aCNavigationView addSubview:self.PLAirconKeyboardView];
    self.tempView = self.PLAirconKeyboardView;
}


#pragma mark -- ACNavigationViewDelegate
- (void)createdKeyboardWithACNavigationView:(NSInteger)tag{
    switch (tag) {
        case 1:
            [self replaceACNavigationViewKeyboardView:self.PLAirconKeyboardView];
            break;
        case 2:
            [self replaceACNavigationViewKeyboardView:self.BRAirconKeyboardView];
            break;
            
        default:
            break;
    }
}

//替换界面
- (void)replaceACNavigationViewKeyboardView:(UIView *)view{
    [self.tempView removeFromSuperview];
    self.tempView = view;
    [self.aCNavigationView addSubview:view];
}

#pragma mark - 处理接收到的通知
- (void)controlInformationProcessing:(NSNotification *)notification{
    
    NSString *string = [notification object];
    NSLog(@"Aircon Notification : %@", string);
    
    //先判断下字符串合法性
    if (string.length != 15) {
        NSLog(@"AC order erorr !");
        return;
    }

    
    //截取字符串
    NSString *typeStr = [string substringToIndex:3];
    NSString *orderStr = [string substringFromIndex:4];
    
    //命令字符串解析成字典
    NSDictionary *orderDic = @{@"aTemp":[orderStr substringWithRange:NSMakeRange(0, 2)]
                               ,@"sTemp":[orderStr substringWithRange:NSMakeRange(3, 2)]
                               ,@"modeType":[orderStr substringWithRange:NSMakeRange(6, 2)]
                               ,@"windType":[orderStr substringWithRange:NSMakeRange(9, 2)]
                               };

    
    //NSLog(@"%@",typeStr);
    //判断界面，并设置
    if ([typeStr isEqualToString:@"AC1"]) {
        [self.PLAirconKeyboardView setViewInfo:orderDic];
    }else if ([typeStr isEqualToString:@"AC2"]) {
        [self.BRAirconKeyboardView setViewInfo:orderDic];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
