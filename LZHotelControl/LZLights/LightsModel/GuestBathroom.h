//
//  GuestBathroom.h
//  LZHGRControl
//
//  Created by Jony on 17/4/12.
//  Copyright © 2017年 yavatop. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GuestBathroom : NSObject

//switch
@property (nonatomic, assign) BOOL topLamp;
@property (nonatomic, assign) BOOL lightStrip;
@property (nonatomic, assign) BOOL wallLamp;

//对外提供全开全关的模式
- (void)allSwitchIsOpen:(BOOL)isOpen;
@end
