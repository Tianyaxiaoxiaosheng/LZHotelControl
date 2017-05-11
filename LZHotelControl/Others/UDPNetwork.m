//
//  UDPNetwork.m
//  LZHGRControl
//
//  Created by Jony on 17/4/10.
//  Copyright © 2017年 yavatop. All rights reserved.
//

#import "UDPNetwork.h"
@interface UDPNetwork ()<AsyncUdpSocketDelegate>
@property (nonatomic, copy) NSString *path;

@property (nonatomic, assign)   BOOL isReceiveNetworkData;
@property (nonatomic, strong) AsyncUdpSocket *socket;
@end

@implementation UDPNetwork

#pragma mark - lazyload
- (NSString *)path{
    if (!_path) {
        //建立文件管理
//        NSFileManager *fm = [NSFileManager defaultManager];
         //找到Documents文件所在的路径
        NSArray *pathArray = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
        //取得第一个Documents文件夹的路径
        NSString *filePath = [pathArray firstObject];
        //把NetworkInfoDic文件加入
        _path = [filePath stringByAppendingPathComponent:@"NetworkInfoDic.plist"];
    }
    return _path;
}

- (NSDictionary *)networkInfoDic
{
    if (!_networkInfoDic) {
        _networkInfoDic = [NSMutableDictionary dictionaryWithContentsOfFile:self.path];
        //NSLog(@"%@", _networkInfoDic);
        //只有第一次执行该段代码时，_networkInfoDic从文件获取不到数据，执行下方的创建初始化
        if (!_networkInfoDic) {
            //如果没有读取到数据，则从建文件并初始数据
            NSFileManager *fm = [NSFileManager defaultManager];
            [fm createFileAtPath:self.path contents:nil attributes:nil];
            
            //网络初始数据
            NSDictionary *portDic = @{@"1":@"12345", @"2":@"12345", @"3":@"12345"};
            NSDictionary *dic = @{@"host":@"192.168.0.1", @"port":portDic};
            
            [dic writeToFile:self.path atomically:YES];
            _networkInfoDic = [NSMutableDictionary dictionaryWithContentsOfFile:self.path];
            //NSLog(@"%@", _networkInfoDic);
        }
     }
    return _networkInfoDic;
}
- (BOOL)renewLocalNetworkInfo{
    return [self.networkInfoDic writeToFile:self.path atomically:YES];
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
        [_socket bindToPort:6000 error:&error];
        //此错误，未找到解决方案，但不影响发送接收
        //NSLog(@"%@", error);
    }
    return _socket;
}

- (BOOL)isIsReceiveNetworkData{
    if (!_isReceiveNetworkData) {
        _isReceiveNetworkData = FALSE;
    }
    return _isReceiveNetworkData;
}

- (BOOL)startReceiveNetworkData{
    //防止多次启动
    if (self.isReceiveNetworkData) {
        NSLog(@"重复启动接收");
        return FALSE;
 
    }else{
        self.isReceiveNetworkData = TRUE;
        
        //测试发送数据
        [self.socket sendData:[NSData dataWithBytes:@"123456789" length:9] toHost:@"172.144.1.107" port:5188 withTimeout:2.0 tag:1];
        
        //启动接收线程
        [self.socket receiveWithTimeout:-1 tag:0];
        return TRUE;
    }
}

#pragma mark -AsyncUdpSocketDelegate
//UDP接收消息
- (BOOL)onUdpSocket:(AsyncUdpSocket *)sock didReceiveData:(NSData *)data withTag:(long)tag fromHost:(NSString *)host port:(UInt16)port {
    NSLog(@"host----->%@ :%hu", host, port);
    //对接收到的信息处理，如果处理时间过长，会影响接收，可采用GCD进行多任务异步处理
    
    //测试页面的同步更新

    //启动监听下一条消息
    [self.socket receiveWithTimeout:-1 tag:0];
    //这里可以加入你想要的代码
    return YES;
}

@end
