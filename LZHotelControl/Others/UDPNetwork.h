//
//  UDPNetwork.h
//  LZHGRControl
//
//  Created by Jony on 17/4/10.
//  Copyright © 2017年 yavatop. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UDPNetwork : NSObject

@property (nonatomic, strong) NSMutableDictionary *networkInfoDic;

+ (instancetype)sharedUDPNetwork;

//启动网络接收
- (BOOL)startReceiveNetworkData;

//断开连接
- (BOOL)disConnect;

//发送数据
- (BOOL)sendDataToRCU:(NSData *)data;

@end
