//
//  SetKeyboardView.m
//  LZHGRControl
//
//  Created by Jony on 17/4/7.
//  Copyright © 2017年 yavatop. All rights reserved.
//

#import "SetKeyboardView.h"

@interface SetKeyboardView ()<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *keyTextField;
@property (weak, nonatomic) IBOutlet UITextField *roomNumTextField;
@property (weak, nonatomic) IBOutlet UISwitch *sw;

@end

@implementation SetKeyboardView

-(instancetype)initWithFrame:(CGRect)frame
{
    if ([super initWithFrame:frame]) {
        self = [[[NSBundle mainBundle] loadNibNamed:@"SetKeyboardView" owner:nil options:nil] lastObject];
        self.frame = frame;
        self.backgroundColor = [UIColor colorWithRed:192/255 green:192/255 blue:192/255 alpha:0.2];
        self.layer.cornerRadius = 18;
        self.layer.masksToBounds = YES;
        
        //初始化key文本框显示
        self.keyTextField.clearButtonMode = UITextFieldViewModeAlways;
        self.keyTextField.clearsOnBeginEditing = YES;
        self.keyTextField.keyboardType = UIKeyboardTypeDecimalPad;
        self.keyTextField.placeholder = @"6位字符";
        self.keyTextField.delegate = self;
        self.keyTextField.secureTextEntry = YES;
        
        //房间号文本框
        self.roomNumTextField.text = [RoomInfo sharedRoomInfo].roomInfoDic[@"roomNum"];
        self.roomNumTextField.clearButtonMode = UITextFieldViewModeAlways;
        self.roomNumTextField.clearsOnBeginEditing = YES;
        self.roomNumTextField.keyboardType = UIKeyboardTypeDecimalPad; //数字键盘 有数字和小数点
        self.roomNumTextField.placeholder = @"4位数字"; //水印
        self.roomNumTextField.delegate = self;
        
        //设置开关的初始值
        
//        [SVProgressHUD setMinimumDismissTimeInterval:3];
        [SVProgressHUD setMaximumDismissTimeInterval:1];
//        [SVProgressHUD setFadeInAnimationDuration:0.1];
        [SVProgressHUD setFadeOutAnimationDuration:0.8];
      }
    return self;
}

//switch用于测试网络接收
- (IBAction)swValueChanged:(id)sender{
    if ([(UISwitch *)sender isOn]) {
        [[UDPNetwork sharedUDPNetwork] startReceiveNetworkData];
    }else{
        [[UDPNetwork sharedUDPNetwork] disConnect];
    }
}

#pragma mark - 按钮事件
//取消，使房间号显示为原来
- (IBAction)cancel:(id)sender {
    self.roomNumTextField.text = [RoomInfo sharedRoomInfo].roomInfoDic[@"roomNum"];
    self.keyTextField.text = nil;
}

//保存房间号
- (IBAction)preserve:(id)sender {
    //保存前检查规范
    if (![self isFourBitOfRoomNumbersWithString:self.roomNumTextField.text]) {
        [SVProgressHUD showInfoWithStatus:@"房间号不符合规范！"];
        return;
    }
    
    //更新本地数据
    if ([[RoomInfo sharedRoomInfo] updateRoomNumber:self.roomNumTextField.text andKey:self.keyTextField.text]) {
        [SVProgressHUD showSuccessWithStatus:@"保存成功 !"];
    }else{
        [SVProgressHUD showErrorWithStatus:@"保存失败 !"];
    }

}
- (IBAction)test {
    [[UDPNetwork sharedUDPNetwork] sendDataToRCU:[NSData dataWithBytes:@"Test message" length:12]];
}

#pragma mark - 文本处理
//检查四位的房间号是否符合规范
- (BOOL)isFourBitOfRoomNumbersWithString:(NSString *)string{
    if (string.length != 4) {
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

#pragma mark - textField delegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string;
{
    NSString * toBeString = [textField.text stringByReplacingCharactersInRange:range withString:string];
   
    if (self.keyTextField == textField)
     {
        if ([toBeString length] > 6) {
            [SVProgressHUD showInfoWithStatus:@"字符数超过限制！"];
             return NO;
        }
    }
    
    if (self.roomNumTextField == textField) {
        if ([toBeString length] > 4) {
            [SVProgressHUD showInfoWithStatus:@"字符数超过限制！"];
            return NO;
        }
    }
    return YES;
}



@end
