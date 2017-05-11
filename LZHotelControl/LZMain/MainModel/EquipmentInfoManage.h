//
//  EquipmentInfoManage.h
//  LZHGRControl
//
//  Created by Jony on 17/4/7.
//  Copyright © 2017年 yavatop. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EquipmentInfoManage : NSObject

+(EquipmentInfoManage *)sharedEquipmentInfoTool;
-(EquipmentInfo *)findEquipmentInfoWithNumber:(NSInteger)number;

@end
