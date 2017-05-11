//
//  LTNavigationBarView.h
//  LZHGRControl
//
//  Created by Jony on 17/4/7.
//  Copyright © 2017年 yavatop. All rights reserved.
//

#import <UIKit/UIKit.h>

//Class LTNavigationBarView;
@protocol LTNavigationBarViewDelegate <NSObject>

@optional
-(void)createdKeyboardWithLTNavigationBarView:(NSInteger)tag;

@end

@interface LTNavigationBarView : UIView
@property (nonatomic, weak) id<LTNavigationBarViewDelegate>delegate;

@end

