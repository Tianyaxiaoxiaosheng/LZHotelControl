//
//  WebConnect.h
//  LZHotelControl
//
//  Created by Jony on 17/6/15.
//  Copyright © 2017年 yavatop. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WebConnect : NSObject
+ (instancetype)sharedWebConnect;


/**
 Register in web server

 @param infoDic local info and rcu info
 @return Dictionary with status and data
 */
//- (NSDictionary *)registerWithInfoDic:(NSDictionary *)infoDic;


/**
 网络请求

 @param infoDic 参数
 @param complete 回调
 */
- (void )registerWithInfoDic:(NSDictionary *)infoDic complet:(void (^)(NSDictionary *netObject, BOOL isSeccuss))complete;
@end
