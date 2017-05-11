//
//  GuestBathroom.m
//  LZHGRControl
//
//  Created by Jony on 17/4/12.
//  Copyright © 2017年 yavatop. All rights reserved.
//

#import "GuestBathroom.h"

@implementation GuestBathroom

- (void)allSwitchIsOpen:(BOOL)isOpen{
    self.topLamp = isOpen;
    self.lightStrip = isOpen;
    self.wallLamp = isOpen;
 }

@end
