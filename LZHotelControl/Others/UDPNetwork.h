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

//更新本地网络信息
- (BOOL)renewLocalNetworkInfo;
@end
