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

@end
