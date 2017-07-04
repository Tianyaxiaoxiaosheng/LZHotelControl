//
//  ServerViewController.m
//  LZHGRControl
//
//  Created by Jony on 17/4/1.
//  Copyright © 2017年 yavatop. All rights reserved.
//

#import "ServerViewController.h"

@interface ServerViewController ()
@property (nonatomic, strong) TitleBarView *titleBarView;
@property (nonatomic, strong) ServerKeyboardView *serverKeyboardView;

@end

@implementation ServerViewController

#pragma mark - lazyload
- (TitleBarView *)titleBarView{
    if (!_titleBarView) {
        if (self.equipmentInfo) {
             _titleBarView = [[TitleBarView alloc] initWithFrame:CGRectMake(TITLEBAR_VIEW_INIT_X, TITLEBAR_VIEW_INIT_Y, TITLEBAR_VIEW_WIDTH, TITLEBAR_VIEW_HEIGHT) andEquipment:self.equipmentInfo];
        } else {
            NSLog(@"Aircon equipmentInfo finding failed in EquipmentInfoManage");
        }
    }
    return _titleBarView;
}

- (ServerKeyboardView *)serverKeyboardView{
    if (!_serverKeyboardView) {
        _serverKeyboardView = [[ServerKeyboardView alloc] initWithFrame:CGRectMake(SERVER_VIEW_INIT_X, SERVER_VIEW_INIT_Y, SERVER_VIEW_WIDTH, SERVER_VIEW_HEIGHT)];
    }
    return _serverKeyboardView;
}

///////////////////////////////////////////////////////////////////////////////

- (void)viewDidLoad {
    [super viewDidLoad];
    //测试设备信息
    NSLog(@"equipmentNum : %ld", [self.equipmentInfo.number integerValue]);
    
    //添加标题
    [self.view addSubview:self.titleBarView];

    //添加键盘区
    [self.view addSubview:self.serverKeyboardView];
    
    //注册通知，死亡时移除
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(controlInformationProcessing:) name:@"Server" object:nil];

}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark -- 解析信息
- (void)controlInformationProcessing:(NSNotification *)notification{
    
    NSString *string = [notification object];
    NSLog(@"Server Notification : %@", string);
    
}

@end
