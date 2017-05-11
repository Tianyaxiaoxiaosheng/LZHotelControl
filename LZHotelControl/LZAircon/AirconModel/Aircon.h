//
//  Aircon.h
//  LZHGRControl
//
//  Created by Jony on 17/4/7.
//  Copyright © 2017年 yavatop. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum : NSUInteger {
    Heating,
    Cooling,
    Ventilation,
} ModelType;

typedef enum : NSUInteger {
    LowSpeed,
    MediumSpeed,
    HighSpeed,
    AutoSpeed,
    Stop,
} WindType;

@interface Aircon : NSObject

@property (nonatomic, assign) NSInteger temperature;
@property (nonatomic, assign) ModelType modelType;
@property (nonatomic, assign) WindType windType;

@end
