//
//  EPCore.h
//  LZHotelControl
//
//  Created by Jony on 17/5/15.
//  Copyright © 2017年 yavatop. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EPCore : NSObject

+ (instancetype)sharedEPCore;

+ (void) buttonClickedProcessingWithInfoDictionary:(NSDictionary *)infoDic;
+ (void) receiveDataProcessingWithData:(NSData *)data;
@end
