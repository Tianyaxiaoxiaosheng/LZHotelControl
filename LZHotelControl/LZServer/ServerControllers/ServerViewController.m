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

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
