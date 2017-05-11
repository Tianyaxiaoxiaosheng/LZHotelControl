//
//  EquipmentInfo.m
//  LZHGRControl
//
//  Created by Jony on 17/2/17.
//  Copyright © 2017年 yavatop. All rights reserved.
//

#import "EquipmentInfo.h"

@implementation EquipmentInfo

//加载数据
- (instancetype)initWithDic:(NSDictionary *)dic
{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dic];
    }
    return self;
}

+ (instancetype)equipmentInfoWithDic:(NSDictionary *)dic
{
    return [[self alloc] initWithDic:dic];
}
+ (NSArray *)equipmentInfoList
{
    //loading plist
    NSString *path = [[NSBundle mainBundle] pathForResource:@"EquipmentInfoList" ofType:@"plist"];
    NSArray *dicArray = [NSArray arrayWithContentsOfFile:path];
    
    //The dictionary transfers the model
    NSMutableArray *tmpArray = [NSMutableArray array];
    for (NSDictionary *dic in dicArray){
        EquipmentInfo *equipmentInfo = [EquipmentInfo equipmentInfoWithDic:dic];
        [tmpArray addObject:equipmentInfo];
    }
    
     return tmpArray;
}

@end
