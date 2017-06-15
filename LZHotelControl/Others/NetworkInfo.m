//
//  NetworkInfo.m
//  LZHotelControl
//
//  Created by Jony on 17/6/14.
//  Copyright © 2017年 yavatop. All rights reserved.
//
#import "NetworkInfo.h"

@interface NetworkInfo ()
@property (nonatomic, strong) NSMutableDictionary *networkInfoDic;
@property (nonatomic, copy)   NSString            *networkInfoDicPlistPath;

@property (nonatomic, copy)   NSString            *currentIpAddress;

@end

@implementation NetworkInfo

#pragma mark - lazy load
- (NSString *)currentIpAddress{
    if (!_currentIpAddress) {
        NSString *address = @"error";
        struct ifaddrs *interfaces = NULL;
        struct ifaddrs *temp_addr = NULL;
        int success = 0;
        // retrieve the current interfaces - returns 0 on success
        success = getifaddrs(&interfaces);
        if (success == 0) {
            // Loop through linked list of interfaces
            temp_addr = interfaces;
            while(temp_addr != NULL) {
                if(temp_addr->ifa_addr->sa_family == AF_INET) {
                    // Check if interface is en0 which is the wifi connection on the iPhone
                    if([[NSString stringWithUTF8String:temp_addr->ifa_name] isEqualToString:@"en0"]) {
                        // Get NSString from C String
                        address = [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)temp_addr->ifa_addr)->sin_addr)];
                    }
                }
                temp_addr = temp_addr->ifa_next;
            }
        }
        // Free memory  
        freeifaddrs(interfaces);  
        _currentIpAddress = address;
    }
    return _currentIpAddress;
}

- (NSString *)networkInfoDicPlistPath{
    if (!_networkInfoDicPlistPath) {
        NSArray *documentDirectoryArray = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
        NSString *myDocumentDirectory = [documentDirectoryArray firstObject];
        _networkInfoDicPlistPath = [myDocumentDirectory stringByAppendingPathComponent:@"NetworkInfoDic.plist"];
    }

    return _networkInfoDicPlistPath;
}

- (NSMutableDictionary *)NetworkInfoDic{
    if (!_networkInfoDic) {
        _networkInfoDic = [NSMutableDictionary dictionaryWithContentsOfFile:self.networkInfoDicPlistPath];
        if (!_networkInfoDic) {
            NSFileManager *fileManager = [NSFileManager defaultManager];
            [fileManager createFileAtPath:self.networkInfoDicPlistPath contents:nil attributes:nil];
            NSDictionary *dic = [NSDictionary dictionary];
            [dic writeToFile:self.networkInfoDicPlistPath atomically:YES];
            //_networkInfoDic = [NSMutableDictionary dictionaryWithContentsOfFile:self.networkInfoDicPlistPath];
        }
    }
    return _networkInfoDic;
}

- (NSMutableDictionary *)localInfoDic{
    if (!_localInfoDic) {
        _localInfoDic = [[NSMutableDictionary alloc] initWithDictionary:[self.networkInfoDic objectForKey:@"localInfo"]];
    }
    return _localInfoDic;
}
- (NSMutableDictionary *)webInfoDic{
    if (!_webInfoDic) {
        _webInfoDic = [[NSMutableDictionary alloc] initWithDictionary:[self.networkInfoDic objectForKey:@"webInfo"]];
    }
    return _webInfoDic;
}
- (NSMutableDictionary *)rcuInfoDic{
    if (!_rcuInfoDic) {
        _rcuInfoDic = [[NSMutableDictionary alloc] initWithDictionary:[self.networkInfoDic objectForKey:@"rcuInfo"]];
    }
    return _rcuInfoDic;
}
- (NSMutableDictionary *)userInfoDic{
    if (!_userInfoDic) {
        _userInfoDic = [[NSMutableDictionary alloc] initWithDictionary:[self.networkInfoDic objectForKey:@"userInfo"]];
    }
    return _userInfoDic;
}

#pragma mark-creating once
static NetworkInfo *sharedNetworkInfo = nil;

+ (instancetype)sharedNetworkInfo{
    return [[self alloc] init];
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedNetworkInfo = [super allocWithZone:zone];
    });
    return sharedNetworkInfo;
}

- (instancetype)init{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedNetworkInfo = [super init];
    });
    return sharedNetworkInfo;
}

- (id)copyWithZone:(NSZone *)zone{
    return  sharedNetworkInfo;
}
+ (id)copyWithZone:(struct _NSZone *)zone{
    return  sharedNetworkInfo;
}
+ (id)mutableCopyWithZone:(struct _NSZone *)zone{
    return sharedNetworkInfo;
}
- (id)mutableCopyWithZone:(NSZone *)zone{
    return sharedNetworkInfo;
}

#pragma mark - method
- (BOOL)networkInfoDictionaryWriteToLocatedFile{
    [self.networkInfoDic setObject:self.localInfoDic forKey:@"localInfo"];
    [self.networkInfoDic setObject:self.webInfoDic forKey:@"webInfo"];
    [self.networkInfoDic setObject:self.rcuInfoDic forKey:@"rcuInfo"];
    [self.networkInfoDic setObject:self.userInfoDic forKey:@"userInfo"];
    
    if ([self.networkInfoDic writeToFile:self.networkInfoDicPlistPath atomically:YES]){
        return true;
    }else{
        return false;
    }
    
}
- (BOOL)isEqualToTheCurrentIpAddressWithIpAddress:(NSString *)ipAddress{
    return [self.currentIpAddress isEqualToString:ipAddress];
}

@end
