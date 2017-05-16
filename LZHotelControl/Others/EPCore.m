//
//  EPCore.m
//  LZHotelControl
//
//  Created by Jony on 17/5/15.
//  Copyright © 2017年 yavatop. All rights reserved.
//

#import "EPCore.h"

@implementation EPCore

#pragma mark-creating once
static EPCore *sharedEPCore;

+ (instancetype)sharedEPCore{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedEPCore = [[self alloc] init];
    });
    return sharedEPCore;
}

#pragma mark -- 按钮点击处理
+ (void)buttonClickedProcessingWithInfoDictionary:(NSDictionary *)infoDic{
    

    //得到字典中所有的key
    NSEnumerator *enumeratorkey=[infoDic keyEnumerator];
//    //得到字典中所有的value
//    NSEnumerator *enumeratorvalue=[infoDic objectEnumerator];
    NSMutableDictionary *mutInfoDic = [[NSMutableDictionary alloc] init];
    for (NSObject *obj in enumeratorkey) {
        //for循环随机，所以排列顺序未知
//        string = [NSString stringWithFormat:@"%@%@", string, [self oneCharacterToDoubleCharacter:(NSString *)obj]];
        [mutInfoDic setValue:[self oneCharacterToDoubleCharacter:[infoDic objectForKey:obj]] forKey:(NSString *)obj];
 
        
    }
    
    NSString *string = [NSString stringWithFormat:@"%@%@%@%@"
                        , [mutInfoDic objectForKey:@"equipmentNum"]
                        , [mutInfoDic objectForKey:@"viewNum"]
                        , [mutInfoDic objectForKey:@"buttonNum"]
                        , [mutInfoDic objectForKey:@"state"]
                        ];
    NSLog(@"%@", string);
    [[UDPNetwork sharedUDPNetwork] sendDataToRCU:[NSData dataWithBytes:&string length:string.length]];
}

//测试，小于10的编号前面加0
+ (NSString *)oneCharacterToDoubleCharacter:(NSString *)oneStr{
    if (oneStr.length < 2) {
        return [NSString stringWithFormat:@"0%@",oneStr];
    }else{
        return oneStr;
    }
}

#pragma mark -- 接收到的数据处理
+ (void)receiveDataProcessingWithData:(NSData *)data{
    NSString *dataStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    
    if (dataStr.length != 8) {
        NSLog(@"The data format is wrong !");
        return;
    }
    
    NSDictionary *dic = @{@"equipmentNum":[dataStr substringWithRange:NSMakeRange(0, 2)]
                          , @"viewNum":[dataStr substringWithRange:NSMakeRange(2, 2)]
                          , @"buttonNum":[dataStr substringWithRange:NSMakeRange(4, 2)]
                          , @"state":[dataStr substringWithRange:NSMakeRange(6, 2)]
                          };
    
    //根据设备号分类发送通知
    NSNotificationCenter *defaultCenter = [NSNotificationCenter defaultCenter];
    switch ([dic[@"equipmentNum"] integerValue]) {
        case 1:
            [defaultCenter postNotificationName:@"LightsControllerNotification" object:nil userInfo:dic];
            break;
        case 2:
            [defaultCenter postNotificationName:@"AirconControllerNotification" object:nil userInfo:dic];
            break;
        case 3:
            [defaultCenter postNotificationName:@"ServerControllerNotification" object:nil userInfo:dic];
            break;
            
        default:
            break;
    }
    
}

@end
