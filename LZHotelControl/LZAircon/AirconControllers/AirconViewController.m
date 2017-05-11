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
    
    //添加标题界面
    [self.view addSubview:self.titleBarView];

    //添加整个键盘导航界面
    [self.view addSubview:self.aCNavigationView];
 
    //初始化键盘控制界面
    [self initACNavigationView];
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


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
