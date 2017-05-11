//
//  WDYTabbar.h
//  LZHGRControl
//
//  Created by Jony on 17/4/23.
//  Copyright © 2017年 yavatop. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WDYTabbar;
@protocol  WDYTabbarDelegate<NSObject>

- (void)tabbar:(WDYTabbar *)tabbar didSelectedFrom:(NSInteger)from to:(NSInteger)to;

@end



@interface WDYTabbar : UIView

@property (nonatomic, weak) id<WDYTabbarDelegate> delegate;
/**
 * 传普通状态和选中状态的图片，内部就帮你添加一个按钮
 */
-(void)addTabbarBtnWithNormalImg:(NSString *)normalImg selImg:(NSString *)selImg;


@end

