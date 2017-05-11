//
//  Bedroom.m
//  LZHGRControl
//
//  Created by Jony on 17/4/12.
//  Copyright © 2017年 yavatop. All rights reserved.
//

#import "Bedroom.h"

@implementation Bedroom

- (void)allSwitchIsOpen:(BOOL)isOpen{
    self.lBedLamp = isOpen;
    self.rBedLamp = isOpen;
    self.roomLamp = isOpen;
    self.lReadingLamp = isOpen;
    self.rReadingLamp = isOpen;
}

- (void)romanticModel{
    self.sleep = FALSE;
    self.working = FALSE;
    self.reception = FALSE;
//    self.romantic = TRUE;
}
- (void)sleepModel{
    self.romantic = FALSE;
    self.working = FALSE;
    self.reception = FALSE;
//    self.sleep = TRUE;

}
- (void)workingModel{
    self.romantic = FALSE;
    self.sleep = FALSE;
    self.reception = FALSE;
//    self.working = TRUE;
}
- (void)receptionModel{
    self.romantic = FALSE;
    self.sleep = FALSE;
    self.working = FALSE;
//    self.reception = TRUE;
}

@end
