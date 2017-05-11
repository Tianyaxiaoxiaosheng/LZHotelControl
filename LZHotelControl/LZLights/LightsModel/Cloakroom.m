//
//  Cloakroom.m
//  LZHGRControl
//
//  Created by Jony on 17/4/12.
//  Copyright © 2017年 yavatop. All rights reserved.
//

#import "Cloakroom.h"

@implementation Cloakroom

- (void)allSwitchIsOpen:(BOOL)isOpen{
    self.topLamp = isOpen;
    self.lightStrip = isOpen;
}

@end
