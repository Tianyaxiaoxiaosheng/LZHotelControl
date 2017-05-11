//
//  MainLamp.m
//  LZHGRControl
//
//  Created by Jony on 17/4/12.
//  Copyright © 2017年 yavatop. All rights reserved.
//

#import "MainLamp.h"

@implementation MainLamp

- (void)allSwitchIsOpen:(BOOL)isOpen{
    self.roomLamp = isOpen;
    self.corridor = isOpen;
}

@end
