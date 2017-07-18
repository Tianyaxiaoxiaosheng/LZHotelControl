//
//  LightsViewController.m
//  LZHGRControl
//
//  Created by Jony on 17/4/1.
//  Copyright © 2017年 yavatop. All rights reserved.
//

#import "LightsViewController.h"

@interface LightsViewController ()<LTNavigationBarViewDelegate, OverAllControlViewDelegate>
//临时uiview
@property (nonatomic, strong) id tempView;

@property (nonatomic, strong) TitleBarView        *titleBarView;
@property (nonatomic, strong) OverAllControlView  *overAllControlView;
@property (nonatomic, strong) LTNavigationBarView *lTnavigationBarView;

//子键盘界面
@property (nonatomic, strong) BedroomLTView       *bedroomLTView;
@property (nonatomic, strong) MainLampLTView      *mainLampLTView;
@property (nonatomic, strong) ToletLTView         *toletLTView;
@property (nonatomic, strong) CloakroomLTView     *cloakroomLTView;
@property (nonatomic, strong) GuestBathroomLTView *guestBathroomLTView;

//test
@property (nonatomic, strong) NSDictionary *lightsDic;

@end

@implementation LightsViewController

- (NSDictionary *)lightsDic{
    if (!_lightsDic) {
        NSMutableDictionary *tempDic = [[NSMutableDictionary alloc] init];
       __block NSInteger lightId = 1;
        
//        for (UIView *view in self.bedroomLTView.subviews) {
//            if ([view isKindOfClass:[UIButton class]]) {
//                NSLog(@"0000 tag :%ld",view.tag);
//                UIButton *button = (UIButton *)view;
//                [tempDic setObject:button forKey:[NSString stringWithFormat:@"%ld",view.tag]];
//            }
//        }
        
        void (^getLightsButton)(UIView*,int) = ^(UIView *view, int count){
            for (int i = 1; i<= count; i++) {
                UIView *subView = [view viewWithTag:i];
                if (subView) {
                    if ([subView isKindOfClass:[UIButton class]]) {
                        UIButton *button = (UIButton *)subView;
                        [tempDic setObject:button forKey:[NSString stringWithFormat:@"%ld",lightId]];
                        lightId++;
                        //test
                        //NSLog(@"lightId: %ld",lightId-1);
                    }
                }
            }
        };
        
        getLightsButton(self.bedroomLTView, 5);
        getLightsButton(self.mainLampLTView, 2);
        getLightsButton(self.toletLTView, 1);
        getLightsButton(self.cloakroomLTView, 2);
        getLightsButton(self.guestBathroomLTView, 3);
        
        _lightsDic = [NSDictionary dictionaryWithDictionary:tempDic];
    }
    return _lightsDic;
}

#pragma mark - lazyload ////////////////////////////////////////////////////////////

- (TitleBarView *)titleBarView{
    if (!_titleBarView) {
        if (self.equipmentInfo) {
             _titleBarView = [[TitleBarView alloc] initWithFrame:CGRectMake(TITLEBAR_VIEW_INIT_X, TITLEBAR_VIEW_INIT_Y, TITLEBAR_VIEW_WIDTH, TITLEBAR_VIEW_HEIGHT) andEquipment:self.equipmentInfo];
        } else {
            NSLog(@"Lights equipmentInfo finding failed in EquipmentInfoManage");
        }
    }
    return _titleBarView;
}

- (OverAllControlView *)overAllControlView{
    if (!_overAllControlView) {
        _overAllControlView = [[OverAllControlView alloc] initWithFrame:CGRectMake(OAC_VIEW_INIT_X, OAC_VIEW_INIT_Y, OAC_VIEW_WIDTH, OAC_VIEW_HEIGHT)];
        _overAllControlView.delegate = self;
    }
    return _overAllControlView;
}

- (LTNavigationBarView *)lTnavigationBarView{
    if (!_lTnavigationBarView) {
        _lTnavigationBarView = [[LTNavigationBarView alloc] initWithFrame:CGRectMake(NB_VIEW_INIT_X, NB_VIEW_INIT_Y, NB_VIEW_WIDTH, NB_VIEW_HEIGHT)];
        _lTnavigationBarView.delegate = self;
    }
    return _lTnavigationBarView;
}

//各个子键盘
- (BedroomLTView *)bedroomLTView{
    if (!_bedroomLTView) {
        _bedroomLTView = [[BedroomLTView alloc] initWithFrame:CGRectMake(LKB_VIEW_INIT_X, LKB_VIEW_INIT_Y, LKB_VIEW_WIDTH, LKB_VIEW_HEIGHT)];
    }
    return _bedroomLTView;
}

- (MainLampLTView *)mainLampLTView{
    if (!_mainLampLTView) {
        _mainLampLTView= [[MainLampLTView alloc] initWithFrame:CGRectMake(LKB_VIEW_INIT_X, LKB_VIEW_INIT_Y, LKB_VIEW_WIDTH, LKB_VIEW_HEIGHT)];
    }
    return _mainLampLTView;
}

- (ToletLTView *)toletLTView{
    if (!_toletLTView) {
        _toletLTView = [[ToletLTView alloc] initWithFrame:CGRectMake(LKB_VIEW_INIT_X, LKB_VIEW_INIT_Y, LKB_VIEW_WIDTH, LKB_VIEW_HEIGHT)];
    }
    return _toletLTView;
}

- (CloakroomLTView *)cloakroomLTView{
    if (!_cloakroomLTView) {
        _cloakroomLTView = [[CloakroomLTView alloc] initWithFrame:CGRectMake(LKB_VIEW_INIT_X, LKB_VIEW_INIT_Y, LKB_VIEW_WIDTH, LKB_VIEW_HEIGHT)];
    }
    return _cloakroomLTView;
}

- (GuestBathroomLTView *)guestBathroomLTView{
    if (!_guestBathroomLTView) {
        _guestBathroomLTView = [[GuestBathroomLTView alloc] initWithFrame:CGRectMake(LKB_VIEW_INIT_X, LKB_VIEW_INIT_Y, LKB_VIEW_WIDTH, LKB_VIEW_HEIGHT)];
    }
    return _guestBathroomLTView;
}

/////////////////////////////////////跟视图加载////////////////////////////////////////////////

- (void)viewDidLoad {
    [super viewDidLoad];
    //测试设备信息
    NSLog(@"equipmentNum : %ld", [self.equipmentInfo.number integerValue]);
    
    //添加标题界面
    [self.view addSubview:self.titleBarView];
    //添加总控界面
    [self.view addSubview:self.overAllControlView];
    //添加键盘控制界面
    [self.view addSubview:self.lTnavigationBarView];
    
    //初始化键盘控制界面
    [self initLTnavigationBarKeyboardView];
    
    //注册通知，死亡时移除
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(controlInformationProcessing:) name:@"Lights" object:nil];
}

- (void)bedroomLTViewControl:(NSDictionary *)dic{
    UIButton *button = [self.bedroomLTView viewWithTag:[dic[@"buttonNum"] integerValue]];
    button.selected = ([dic[@"state"] integerValue] > 0) ? YES:NO;
}

- (void)initLTnavigationBarKeyboardView{
    
    [self.lTnavigationBarView addSubview:self.bedroomLTView];
    self.tempView = self.bedroomLTView;
}

//控制器死亡时移除观察者，
- (void)dealloc{
    //tabbar 切换是不会死亡的
    [[NSNotificationCenter defaultCenter] removeObserver:self];

}

#pragma mark - OverAllControlView delegate /////////////////////////////////////////////////////
-(void)OverAllSwitchONAndOFF:(NSInteger)tag{
    NSLog(@"OverAllSwitchONAndOFF: %ld", tag);
    switch (tag) {
        case 1:
            [self.tempView allLightsSwitchIsOpen:TRUE];
            break;
        case 2:
            [self.tempView allLightsSwitchIsOpen:FALSE];
            break;
            
        default:
            break;
    }

//    for (NSString *lightId in [self.lightsDic allKeys]) {
//        UIButton *button = [self.lightsDic objectForKey:lightId];
//        
//        button.selected = tag == 1 ?true:false;
//    }
//    if ([[self.lightsDic objectForKey:@"1"] isKindOfClass:[UIView class]]){
//        NSLog(@"0000");
//    }
}

#pragma mark - LTNavigationBarView delegate ///////////////////////////////////////////////////
- (void)createdKeyboardWithLTNavigationBarView:(NSInteger)tag{
 
    //tag 和View的tag一一对应
    switch (tag) {
        case 1:
            [self replaceLTnavigationBarViewKeyboardView:self.bedroomLTView];
            break;
        case 2:
            [self replaceLTnavigationBarViewKeyboardView:self.mainLampLTView];
            break;
        case 3:
            [self replaceLTnavigationBarViewKeyboardView:self.toletLTView];
            break;
        case 4:
            [self replaceLTnavigationBarViewKeyboardView:self.cloakroomLTView];
            break;
        case 5:
            [self replaceLTnavigationBarViewKeyboardView:self.guestBathroomLTView];
            break;
            
        default:
            break;
    }
}

//替换界面
- (void)replaceLTnavigationBarViewKeyboardView:(UIView *)view{
    [self.tempView removeFromSuperview];
    self.tempView = view;
    [self.lTnavigationBarView addSubview:view];
//    NSLog(@"view tag: %ld", view.tag);
}

#pragma mark -- 解析信息
- (void)controlInformationProcessing:(NSNotification *)notification{
    
    NSString *string = [notification object];
//    NSLog(@"Lights Notification : %@", string);
    
    //截取字符串
    NSString *typeStr = [string substringToIndex:2];
//    NSString *orderStr = [string substringFromIndex:4];
    if ([typeStr isEqualToString:@"LC"]) {
        NSLog(@"Lights Notification : %@", string);
        NSString *statusStr = [string substringWithRange:NSMakeRange(2, 1)];
        BOOL isOpen = ([statusStr integerValue] == 1)? YES:NO;
        
        if (isOpen) {
            NSLog(@"****open*****");
        }
        
        NSString *orderStr = [string substringFromIndex:4];
        //NSLog(@"orderStr: %@", orderStr);
        NSArray *strArray = [orderStr componentsSeparatedByString:@","];
        //NSLog(@"strArray count: %d", strArray.count);
        
        
        for (NSString *lightId in [self.lightsDic allKeys]) {
            
            UIButton *button = [self.lightsDic objectForKey:lightId];
            
//            if ([strArray containsObject:lightId]) {
//                NSLog(@"lightId = %@",lightId);
//                button.selected = isOpen;
//            }else {
//                button.selected = !isOpen;
//            }
//            button.selected = [strArray containsObject:lightId] ? isOpen : (!isOpen);
            
            //特殊的255
            if ([strArray containsObject:@"255"]) {
                button.selected = isOpen;
            }else {
                button.selected = [strArray containsObject:lightId] ? isOpen : (!isOpen);
            }
        }
        
    }else if ([typeStr isEqualToString:@"DM"]) {
    }
    
}

@end
