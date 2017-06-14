//
//  RegisterDevice.h
//  LZHotelControl
//
//  Created by Jony on 17/5/18.
//  Copyright © 2017年 yavatop. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RegisterDevice : NSObject

/**
 Query RCU according to room number ,and write to the local IP and port

 @param localInfoDic NSDictionary: serverAddr,localPort,localIP
 @return NSDictionary:rcuIP,rcuPort
 */
+ (NSDictionary *)registerDeviceWithLocalInfo:(NSDictionary *)localInfoDic;

@end
