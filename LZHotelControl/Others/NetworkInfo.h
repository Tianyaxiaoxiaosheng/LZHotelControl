//
//  NetworkInfo.h
//  LZHotelControl
//
//  Created by Jony on 17/6/14.
//  Copyright © 2017年 yavatop. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NetworkInfo : NSObject

@property (nonatomic, strong) NSMutableDictionary *localInfoDic;
@property (nonatomic, strong) NSMutableDictionary *webInfoDic;
@property (nonatomic, strong) NSMutableDictionary *rcuInfoDic;
@property (nonatomic, strong) NSMutableDictionary *userInfoDic;

+ (instancetype)sharedNetworkInfo;
- (BOOL)networkInfoDictionaryWriteToLocatedFile;

- (BOOL)isEqualToTheCurrentIpAddressWithIpAddress:(NSString *)ipAddress;

@end
