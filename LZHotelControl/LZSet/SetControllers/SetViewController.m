//
//  SetViewController.m
//  LZHGRControl
//
//  Created by Jony on 17/4/1.
//  Copyright © 2017年 yavatop. All rights reserved.
//

#import "SetViewController.h"

@interface SetViewController ()

@property (nonatomic, strong) TitleBarView *titleBarView;
@property (nonatomic, strong) SetKeyboardView *setKeyboardView;

@end

@implementation SetViewController

#pragma mark - lazyload
- (TitleBarView *)titleBarView{
    if (!_titleBarView) {
        if (self.equipmentInfo) {
              _titleBarView = [[TitleBarView alloc] initWithFrame:CGRectMake(TITLEBAR_VIEW_INIT_X, TITLEBAR_VIEW_INIT_Y, TITLEBAR_VIEW_WIDTH, TITLEBAR_VIEW_HEIGHT) andEquipment:self.equipmentInfo];
        } else {
            NSLog(@"Set equipmentInfo finding failed in EquipmentInfoManage");
        }
      
    }
    return _titleBarView;
}

- (SetKeyboardView *)setKeyboardView{
    if (!_setKeyboardView) {
        _setKeyboardView = [[SetKeyboardView alloc] initWithFrame:CGRectMake(SET_VIEW_INIT_X, SET_VIEW_INIT_Y, SET_VIEW_WIDTH, SET_VIEW_HEIGHT)];
    }
    return _setKeyboardView;
}

//////////////////////////////////////////////////////////////////////////////////////

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //添加标题栏
    [self.view addSubview:self.titleBarView];
//
    //添加键盘
    [self.view addSubview:self.setKeyboardView];
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
