//
//  SetKeyboardView.m
//  LZHGRControl
//
//  Created by Jony on 17/4/7.
//  Copyright © 2017年 yavatop. All rights reserved.
//

#import "SetKeyboardView.h"
//#define IP_TEXT @”.0123456789”
//#define ROOMNUBER @”0123456789”

@interface SetKeyboardView ()<UITextFieldDelegate>
@property (nonatomic, strong) MBProgressHUD *HUD;

@property (nonatomic, strong) UDPNetwork *sharedUDPNetwork;

@property (weak, nonatomic) IBOutlet UITextField *ipTextField;
@property (weak, nonatomic) IBOutlet UITextField *roomNumTextField;
@property (weak, nonatomic) IBOutlet UISwitch *sw;

@end

@implementation SetKeyboardView
- (UDPNetwork *)sharedUDPNetwork{
    if (!_sharedUDPNetwork) {
        _sharedUDPNetwork = [UDPNetwork sharedUDPNetwork];
    }
    return _sharedUDPNetwork;
}

-(instancetype)initWithFrame:(CGRect)frame
{
    if ([super initWithFrame:frame]) {
        self = [[[NSBundle mainBundle] loadNibNamed:@"SetKeyboardView" owner:nil options:nil] lastObject];
        self.frame = frame;
        self.backgroundColor = [UIColor colorWithRed:192/255 green:192/255 blue:192/255 alpha:0.2];
        self.layer.cornerRadius = 18;
        self.layer.masksToBounds = YES;
        
        //初始化ip文本框显示
        self.ipTextField.text = [self.sharedUDPNetwork.networkInfoDic objectForKey:@"host"];
        self.ipTextField.clearButtonMode = UITextFieldViewModeAlways;
        self.ipTextField.clearsOnBeginEditing = YES;
        self.ipTextField.keyboardType = UIKeyboardTypeDecimalPad;
        self.ipTextField.delegate = self;
        
        //房间号文本框
        self.roomNumTextField.clearButtonMode = UITextFieldViewModeAlways;
        self.roomNumTextField.clearsOnBeginEditing = YES;
        self.roomNumTextField.keyboardType = UIKeyboardTypeDecimalPad; //数字键盘 有数字和小数点
        self.roomNumTextField.placeholder = @"4位数字"; //水印
        self.roomNumTextField.delegate = self;
      }
    return self;
}

//switch用于测试网络接收
- (IBAction)swValueChanged:(id)sender{
//    [DMCore sharedDMCore].PLAircon.temperature++;
    if ([(UISwitch *)sender isOn]) {
        
        NSLog(@"switch ON");
//        [[UDPNetwork sharedUDPNetwork] startReceiveNetworkData];
        
     }else{
        NSLog(@"switch OFF");
    }
}

#pragma mark - 按钮事件
//取消，使IP地址显示为原来的ip地址
- (IBAction)cancel:(id)sender {
      self.ipTextField.text = [self.sharedUDPNetwork.networkInfoDic objectForKey:@"host"];
}

//保存ip输入框中的ip地址
- (IBAction)preserve:(id)sender {
    //保存前检查IP地址规范
    if (![self isIPAddressWithString:self.ipTextField.text]) {
        NSLog(@"IP地址不符合规范");
        [self showMessage:@"IP地址不符合规范！"];
        return;
    }
    
    //更新正在使用的ip地址
    [self.sharedUDPNetwork.networkInfoDic setValue:self.ipTextField.text forKey:@"host"];
    
    //更新存储的ip地址
    if ([self.sharedUDPNetwork renewLocalNetworkInfo]) {
        NSLog(@"保存成功");
        [self showMessage:@"保存成功！"];
    }else{
        NSLog(@"保存失败");
        [self showMessage:@"保存失败！"];
    }

}

#pragma mark - 文本处理
//根据四位房间号，构建ip地址
- (NSString *)buildIPStringWithString:(NSString *)string{
   
    //检查房间号规范
    if (![self isFourBitOfRoomNumbersWithString:string]) {
        return [self.sharedUDPNetwork.networkInfoDic objectForKey:@"host"];
    }
    
    //分别截取房间号的前两位和后两位，作为ip地址的最后两格
    NSString *precedTwoSubStr = [string substringToIndex:2];
    NSString *backTwoSubStr = [string substringFromIndex:2];
    
    return [NSString stringWithFormat:@"192.168.%@.%@", precedTwoSubStr, backTwoSubStr];
    
}

//检查四位的房间号是否符合规范
- (BOOL)isFourBitOfRoomNumbersWithString:(NSString *)string{
    if (string.length > 4) {
        return false;
    }
    
    //检查输入的房间号是否都是数字
    for (NSInteger i = 0; i < string.length; i++) {
        unichar charactor = [string characterAtIndex:i];
        if (!(charactor  >= 48 && charactor  <=57)) {
            return false;
        }
    }
    return true;
}

//检查ip地址是否符合规范
- (BOOL)isIPAddressWithString:(NSString *)string{
    if (string.length > 15) {
        return false;
    }
    
    NSInteger from = 0; //记录截取的初始位置
    NSInteger cutCount = 0; //记录截取次数
    NSInteger length = string.length;
//    NSInteger to   = 0; //截取长度i-from+1
    
    for (NSInteger i = 0; i < length; i++) {
        unichar charactor = [string characterAtIndex:i];
        
        //判断字符规范
        if ( !((charactor>= 48 && charactor<=57) || charactor==46) ) {
            return false;
        }
        
        //截取，判读是否在ip地址范围
        if ((charactor==46) || (i==length-1)) {
            NSInteger tempInt = [[string substringWithRange:NSMakeRange(from, (i-from+1))] integerValue];
            //NSLog(@"%ld", tempInt);
            if (!(tempInt >= 0 && tempInt <= 255)) {
                return false;
            }
            from = i+1;
            cutCount++;
        }
    }
    
    //判断截取次数是否满足
    if (cutCount != 4) {
        return false;
    }
    
    //通过所有检测
    return true;
}

//提示信息
- (void)showMessage:(NSString *)string{
    
    //此方法，如果在用户快速连续操作下，可能导致页面上有多余的提示未被清除，
    //解决方案1：采用后台,采用后台时与下方的延迟执行冲突,如改为全局线程后台执行，亦不能解决
    //解决方案2：把原本的类属性HUB改为，此方法中的局部变量，当此方法执行完后，所有的都会由ARC自动释放，用户操作如何快速都不会导致有未被清除的提示

    //self本身就是View
    MBProgressHUD *HUD = [[MBProgressHUD alloc] initWithView:self];
    [self addSubview:HUD];
    
    HUD.labelText = string;
    HUD.mode = MBProgressHUDModeText;
    
    //指定距离中心点的X轴和Y轴的偏移量，如果不指定则在屏幕中间显示
    HUD.yOffset = -100.0f;
    HUD.xOffset = 0.0f;
    
    //采用GCD延迟1S，直接取消提示
    [HUD showAnimated:YES];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [HUD removeFromSuperview];
//        HUD = nil;
    });
    
    
}

#pragma mark - textField delegate

/**
 textField 的代理方法

 @param textField 正在操作的文本框
 @param range 正在输入的字符添加的范围，location一般已输入的字符最后一个位置，length一直为0
 @param string 正在输入的字符
 @return 是否可以继续输入，如果返回FALSE则当前输入的字符不被加入到文本内容
 */
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string;
{
    NSString * toBeString = [textField.text stringByReplacingCharactersInRange:range withString:string]; //得到当前输入的字符输入后，输入框的全部内容内容
//    NSLog(@"rang: from %ld  to %ld ",range.location, range.length);
    
    //ip地址输入框
    if (self.ipTextField == textField)  //判断是否时我们想要限定的那个输入框
     {
        if ([toBeString length] > 15) { //如果输入框内容大于14则弹出警告
            NSLog(@"ipTextField 超过最大数");
            [self showMessage:@"IP地址超过限制！"];
             return NO;
        }
    }
    
    //房间号输入框
    if (self.roomNumTextField == textField) {
        if ([toBeString length] == 4) {
            self.ipTextField.text = [self buildIPStringWithString:toBeString];
        }
        
        if ([toBeString length] > 4) { //如果输入框内容大于3则弹出警告
            NSLog(@"roomNumTextField 超过最大数");
            [self showMessage:@"房间号超过限制！"];
            return NO;
        }
    }
    return YES;
}



@end
