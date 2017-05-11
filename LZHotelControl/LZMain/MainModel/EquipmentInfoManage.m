//
//  EquipmentInfoManage.m
//  LZHGRControl
//
//  Created by Jony on 17/4/7.
//  Copyright © 2017年 yavatop. All rights reserved.
//

#import "EquipmentInfoManage.h"

@interface EquipmentInfoManage()

@property (nonatomic, strong) NSArray *equipmentInfoList; //设备信息列表

@end



@implementation EquipmentInfoManage
static EquipmentInfoManage *sharedEquipmentInfoManage = nil;

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

//单例
+ (EquipmentInfoManage *)sharedEquipmentInfoTool
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedEquipmentInfoManage = [[self alloc] init];
    });
    return sharedEquipmentInfoManage;
}

-(EquipmentInfo *)findEquipmentInfoWithNumber:(NSInteger)number
{
    for (EquipmentInfo *equipmentInfo in self.equipmentInfoList) {
        if ([equipmentInfo.number integerValue] == number) {
            return equipmentInfo;
        }
    }
    return nil;
}

@end
