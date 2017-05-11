//
//  MainViewController.m
//  LZHGRControl
//
//  Created by Jony on 17/4/1.
//  Copyright © 2017年 yavatop. All rights reserved.
//

#import "MainViewController.h"

@interface MainViewController ()<WDYTabbarDelegate>
@property (nonatomic, strong) NSArray *equipmentInfoList; //设备信息列表

@end

@implementation MainViewController

//懒加载设备信息
- (NSArray *)equipmentInfoList
{
    //    NSLog(@"懒加载");
    if (!_equipmentInfoList)
    {
        _equipmentInfoList = [EquipmentInfo equipmentInfoList];
    }
    return _equipmentInfoList;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置主界面背景
    self.view.backgroundColor = MAIN_VIEW_BACKGROUND;

    //添加控制器
    [self addControllerForTabBarController];

}

- (void)viewDidLayoutSubviews{
//    NSLog(@"%s",__func__);
    
    //此方法在创建每个子View时都会调用，此类中调用两次，下方代码只需要一次
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        CGRect frame = CGRectMake(0
                                  , self.tabBar.frame.origin.y-41
                                  , self.tabBar.frame.size.width
                                  , 90);
        self.tabBar.frame = frame;
        
        WDYTabbar *wDYTabbar = [[WDYTabbar alloc] initWithFrame:self.tabBar.bounds];
        
        //添加五个按钮
        [wDYTabbar addTabbarBtnWithNormalImg:@"lights0" selImg:@"lights1"];
        [wDYTabbar addTabbarBtnWithNormalImg:@"aircon0" selImg:@"aircon1"];
        [wDYTabbar addTabbarBtnWithNormalImg:@"service0" selImg:@"service1"];
        [wDYTabbar addTabbarBtnWithNormalImg:@"setting0" selImg:@"setting1"];
        
        //设置代理
        wDYTabbar.delegate = self;
        
        //把自定义的tabbar添加到 系统的tabbar上
        [self.tabBar addSubview:wDYTabbar];
    });
 
 
}

//添加控制器
- (void)addControllerForTabBarController{
    
      //灯光控制器
    LightsViewController *lightsViewController = [[LightsViewController alloc] init];
    
    //空调控制器
    AirconViewController *airconViewController = [[AirconViewController alloc] init];
    
    //服务控制器
    ServerViewController *serverViewController = [[ServerViewController alloc] init];
    
    //设置控制器
    SetViewController *setViewController = [[SetViewController alloc] init];
    
    //为控制器的设备信息赋值
    for (EquipmentInfo *equipmentInfo in self.equipmentInfoList) {
        switch ([equipmentInfo.number integerValue]) {
            case 1:
                lightsViewController.equipmentInfo = equipmentInfo;
                break;
            case 2:
                airconViewController.equipmentInfo = equipmentInfo;
                break;
            case 3:
                serverViewController.equipmentInfo = equipmentInfo;
                break;
            case 4:
                setViewController.equipmentInfo = equipmentInfo;
                break;
                
            default:
                NSLog(@"EquipmentInfoList and the Controller match makes a mistake");
                break;
        }
    }
    
    //添加控制器
    self.viewControllers = @[lightsViewController, airconViewController, serverViewController, setViewController];
}

#pragma mark 自定义Tabbar的代理
-(void)tabbar:(WDYTabbar *)tabbar didSelectedFrom:(NSInteger)from to:(NSInteger)to{
    //切换tabbar控制器的子控件器
    self.selectedIndex = to;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
