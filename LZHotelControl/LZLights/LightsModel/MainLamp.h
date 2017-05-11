//
//  MainLamp.h
//  LZHGRControl
//
//  Created by Jony on 17/4/12.
//  Copyright © 2017年 yavatop. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MainLamp : NSObject

//switch
@property (nonatomic, assign) BOOL roomLamp;
@property (nonatomic, assign) BOOL corridor;

//mode
@property (nonatomic, assign) BOOL working;
@property (nonatomic, assign) BOOL reception;

//对外提供全开全关的模式
- (void)allSwitchIsOpen:(BOOL)isOpen;
@end
