//
//  RoomInfo.m
//  LZHotelControl
//
//  Created by Jony on 17/5/12.
//  Copyright © 2017年 yavatop. All rights reserved.
//

#import "RoomInfo.h"

@interface RoomInfo()
@property (nonatomic, copy) NSString *roomInfoPlistPath;

@end

@implementation RoomInfo

#pragma mark -- lazyload
- (NSString *)roomInfoPlistPath{
    if (!_roomInfoPlistPath) {
        NSArray *documentDirectoryArray = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
        NSString *myDocumentDirectory = [documentDirectoryArray firstObject];
        _roomInfoPlistPath = [myDocumentDirectory stringByAppendingPathComponent:@"RoomInfo.plist"];
    }
    return _roomInfoPlistPath;
}
- (NSDictionary *)roomInfoDic
{
    if (!_roomInfoDic) {
        _roomInfoDic = [NSMutableDictionary dictionaryWithContentsOfFile:self.roomInfoPlistPath];
        //测试阶段，先每次进入初始化，此配置可以选择应用程序设置
        if (_roomInfoDic) {
            //building initial dictionary when not data.
            NSFileManager *fm = [NSFileManager defaultManager];
            [fm createFileAtPath:self.roomInfoPlistPath contents:nil attributes:nil];
            
            //initial data
            NSDictionary *dic = @{@"roomNum":@"0000", @"key":@"123456", @"localPort":@"12345", @"rcuIp":@"172.144.1.102" , @"rcuPort":@"9990"};
            
            [dic writeToFile:self.roomInfoPlistPath atomically:YES];
            _roomInfoDic = [NSMutableDictionary dictionaryWithContentsOfFile:self.roomInfoPlistPath];
        }
    }
    return _roomInfoDic;
}

#pragma mark-creating once
static RoomInfo *sharedRoomInfo = nil;

+ (instancetype)sharedRoomInfo{
    return [[self alloc] init];
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedRoomInfo = [super allocWithZone:zone];
    });
    return sharedRoomInfo;
}

- (instancetype)init{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedRoomInfo = [super init];
    });
    return sharedRoomInfo;
}

- (id)copyWithZone:(NSZone *)zone{
    return  sharedRoomInfo;
}
+ (id)copyWithZone:(struct _NSZone *)zone{
    return  sharedRoomInfo;
}
+ (id)mutableCopyWithZone:(struct _NSZone *)zone{
    return sharedRoomInfo;
}
- (id)mutableCopyWithZone:(NSZone *)zone{
    return sharedRoomInfo;
}

#pragma mark -- methed
- (BOOL)roomInfoDictionaryWriteToLocatedFile{
    [self.roomInfoDic writeToFile:self.roomInfoPlistPath atomically:YES];
    return true;
}
- (BOOL)updateRoomNumber:(NSString *)roomNum andKey:(NSString *)key{
    if ([self.roomInfoDic[@"key"] isEqualToString:key]) {
        [self.roomInfoDic setValue:roomNum forKey:@"roomNum"];
        [self roomInfoDictionaryWriteToLocatedFile];
        return true;
    }
    return false;
}

@end
