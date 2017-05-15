//
//  RoomInfo.h
//  LZHotelControl
//
//  Created by Jony on 17/5/12.
//  Copyright © 2017年 yavatop. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RoomInfo : NSObject
@property (nonatomic, strong) NSMutableDictionary *roomInfoDic;

+ (instancetype)sharedRoomInfo;
- (BOOL)updateRoomNumber:(NSString *)roomNum andKey:(NSString *)key;

@end
