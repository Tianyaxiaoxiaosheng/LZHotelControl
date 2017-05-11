//
//  WDYTabbar.m
//  LZHGRControl
//
//  Created by Jony on 17/4/23.
//  Copyright © 2017年 yavatop. All rights reserved.
//

#import "WDYTabbar.h"

@interface WDYTabbar ()
/**
 * 当前选中的按钮
 */
@property (nonatomic, weak) UIButton *selectedBtn;

@end

@implementation WDYTabbar

/*
 *自定义控件
 1.在initWithFrame初始化的方法，添加子控件
 2.layoutSubviews 布局子控件frm
 */

/*
 //调用控件的init方法【[[UIView alloc] init]】 的时候被调用  接着还会调用initWithFrame
 //-(instancetype)init
 
 
 //调用控件的init方法【[[UIView alloc] initWithFrame]】 的时候被调用
 //-(instancetype)initWithFrame:(CGRect)frame
 
 
 //调用控件的创建从xib/storybaord 的时候被调用
 -(id)initWithCoder:(NSCoder *)aDecoder
 */

- (instancetype)initWithFrame:(CGRect)frame{
//    NSLog(@"%lf, %lf, %lf, %lf,", frame.origin.x, frame.origin.y, frame.size.width, frame.size.height);
//    
    if (self = [super initWithFrame:frame]) {
//        self.backgroundColor = [UIColor grayColor];
           self.backgroundColor = [UIColor colorWithRed:192/255 green:192/255 blue:192/255 alpha:0.4];
        
    }
    return  self;
}

#pragma mark 初始化按钮
-(void)addTabbarBtnWithNormalImg:(NSString *)normalImg selImg:(NSString *)selImg{
    UIButton *btn = [CZButton buttonWithType:UIButtonTypeCustom];
    [btn setBackgroundImage:[UIImage imageNamed:normalImg] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageNamed:selImg] forState:UIControlStateSelected];
    
    
    //监听事件
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchDown];
    //绑定tag
//#warning tag绑定要在addSubview的方法之前
    btn.tag = self.subviews.count;
    
    [self addSubview:btn];
    
    //设置默认选中
    if (btn.tag == 0) {
        [self btnClick:btn];
    }
    
    
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
//    NSInteger count = self.subviews.count;
    //布局子控件
    //按钮宽度与高度
    CGFloat btnW = 80;
    CGFloat btnH = self.bounds.size.height-10;
    CGFloat initialX  = self.bounds.size.width/4 + 50;
  
    for (UIButton *btn in self.subviews) {
        CGFloat btnIntX = (btnW+20) * btn.tag + initialX;
        btn.frame = CGRectMake(btnIntX, 10.0, btnW, btnH);
    }
    
}

-(void)btnClick:(UIButton *)btn{
    
    //一点击通知代理
    if ([self.delegate respondsToSelector:@selector(tabbar:didSelectedFrom:to:)]) {
        [self.delegate tabbar:self didSelectedFrom:self.selectedBtn.tag to:btn.tag];
    }
    
//#warning 开发过程，首先针对64位开发，苹果开发的应用上架，必需支持64位
//    NSLog(@"%ld",btn.tag);
//    
    //取消之前选中
    self.selectedBtn.selected = NO;
    
    //设置当前选中
    btn.selected = YES;
    self.selectedBtn = btn;
    
    
}


@end

