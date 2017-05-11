//
//  ACNavigationView.h
//  LZHGRControl
//
//  Created by Jony on 17/4/7.
//  Copyright © 2017年 yavatop. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ACNavigationViewDelegate <NSObject>

@optional
-(void)createdKeyboardWithACNavigationView:(NSInteger)tag;

@end

@interface ACNavigationView : UIView
@property (nonatomic, weak) id<ACNavigationViewDelegate>delegate;

@end
