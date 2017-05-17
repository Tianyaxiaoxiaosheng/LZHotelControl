//
//  UDPNetwork.m
//  LZHGRControl
//
//  Created by Jony on 17/4/10.
//  Copyright © 2017年 yavatop. All rights reserved.
//

#import "UDPNetwork.h"
@interface UDPNetwork ()<AsyncUdpSocketDelegate>

@property (nonatomic, assign)   BOOL isReceiveNetworkData;
@property (nonatomic, strong) AsyncUdpSocket *socket;

@property (nonatomic, strong) NSDictionary *roomInfoDic;
@end

@implementation UDPNetwork

#pragma mark - lazyload
- (NSDictionary *)roomInfoDic{
    if (!_roomInfoDic) {
        _roomInfoDic = [RoomInfo sharedRoomInfo].roomInfoDic;
    }
    return _roomInfoDic;
}


#pragma mark-确保被创建一次
static UDPNetwork *sharedUDPNetwork = nil;

+ (instancetype)sharedUDPNetwork{
    return [[self alloc] init];
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedUDPNetwork = [super allocWithZone:zone];
    });
    return sharedUDPNetwork;
}

- (instancetype)init{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedUDPNetwork = [super init];
    });
    return sharedUDPNetwork;
}

- (id)copyWithZone:(NSZone *)zone{
    return  sharedUDPNetwork;
}
+ (id)copyWithZone:(struct _NSZone *)zone{
    return  sharedUDPNetwork;
}
+ (id)mutableCopyWithZone:(struct _NSZone *)zone{
    return sharedUDPNetwork;
}
- (id)mutableCopyWithZone:(NSZone *)zone{
    return sharedUDPNetwork;
}

#pragma mark-接收网络数据
//初始化socket通信
- (AsyncUdpSocket *)socket{
    if (!_socket) {
        _socket = [[AsyncUdpSocket alloc] initWithDelegate:self];
        //绑定端口
        NSError *error = nil;
        if ([_socket bindToPort:[self.roomInfoDic[@"localPort"] integerValue] error:&error]){
            NSLog(@"socket bind success!");
        }else{
            NSLog(@"socket bind failed!");
        }
        //此错误，未找到解决方案，但不影响发送接收
        //NSLog(@"%@", error);
    }
    return _socket;
}

- (BOOL)isIsReceiveNetworkData{
    if (!_isReceiveNetworkData) {
        //启动时不接收数据
        _isReceiveNetworkData = FALSE;
    }
    return _isReceiveNetworkData;
}

//启动接收网络
- (BOOL)startReceiveNetworkData{
    //防止多次启动
    if (self.isReceiveNetworkData) {
        NSLog(@"重复启动接收");
        return FALSE;
 
    }else{
       
        
//        //连接网络
//        NSError *error = [[NSError alloc] init];
//        if ([self.socket connectToHost:[self.roomInfoDic objectForKey:@"rcuIp"] onPort:[[self.roomInfoDic objectForKey:@"rcuPort"] intValue] error:&error]){
//            
//            //发送一个确认信息
//            [sharedUDPNetwork sendDataToRCU:[NSData dataWithBytes:@"ACK" length:3]];
//            
//            NSLog(@"connectToHost Success!");
//        }else{
//            NSLog(@"connectToHost failed!");
//            
//        }
        
        //rcu连接数据从设置中读取,如果没有设置，就采用默认值
        NSError *error = [[NSError alloc] init];
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        NSString *rcuIp = (NSString *)[defaults stringForKey:@"rcuIp"];
        if (!rcuIp) {
            rcuIp = [self.roomInfoDic objectForKey:@"rcuIp"];
        }
        NSString *rcuPort = (NSString *)[defaults stringForKey:@"rcuPort"];
        if (!rcuPort) {
            rcuPort = [self.roomInfoDic objectForKey:@"rcuPort"];
        }
        NSLog(@"RCU: %@:%@", rcuIp, rcuPort);
        
        if ([self.socket connectToHost:rcuIp onPort:[rcuPort intValue] error:&error]){

            //发送一个确认信息
            [sharedUDPNetwork sendDataToRCU:[NSData dataWithBytes:@"ACK" length:3]];

            NSLog(@"connectToHost Success!");
            //成功后再设置
            self.isReceiveNetworkData = TRUE;
        }else{
            NSLog(@"connectToHost failed!");
            
        }
        
        //启动接收线程
        [self.socket receiveWithTimeout:-1 tag:0];
        return TRUE;
    }
}

- (BOOL)disConnect{
    self.isReceiveNetworkData = FALSE;
    return false;
}

//发送数据方法
- (BOOL)sendDataToRCU:(NSData *)data{
    
    // This method is only for connected sockets
    if ([self.socket sendData:data withTimeout:2.0 tag:0]){
        
        NSLog(@"sending data success !");
        return true;
    }
    NSLog(@"sending data failed !");
    return false;
}

#pragma mark -AsyncUdpSocketDelegate
//UDP接收消息
- (BOOL)onUdpSocket:(AsyncUdpSocket *)sock didReceiveData:(NSData *)data withTag:(long)tag fromHost:(NSString *)host port:(UInt16)port {
    
    NSString *recStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@"host----->%@ :%hu\ndata----->%@", host, port, recStr);
    //对接收到的信息处理，如果处理时间过长，会影响接收，可采用GCD进行多任务异步处理
    
    //接收到的信息交由处理中心处理
    [EPCore receiveDataProcessingWithData:data];
 

    //启动监听下一条消息
    [self.socket receiveWithTimeout:-1 tag:0];
    //这里可以加入你想要的代码
    return YES;
}

@end
