//
//  ChangePassWordVC.m
//  云渠道
//
//  Created by 谷治墙 on 2018/3/22.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "ChangePassWordVC.h"

@interface ChangePassWordVC ()<UITextFieldDelegate>
{
    NSInteger surplusTime;//重新发送短信的倒计时时间
    NSTimer *time;
}
@property (nonatomic , strong) UITextField *Account;
@property (nonatomic , strong) UITextField *Code;
@property (nonatomic , strong) UITextField *PassWord;
@property (nonatomic , strong) UIButton *GetCodeBtn;
@property (nonatomic , strong) UIButton *RegisterBtn;
//@property (nonatomic , strong) UIButton *ProtocolBtn;
@property (nonatomic , strong) UITextField *SurePassWord;
@property (nonatomic, strong)  UILabel *timeLabel;

@end

@implementation ChangePassWordVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navBackgroundView.hidden = NO;
    self.navBackgroundView.backgroundColor = YJBackColor;
    [self InitUI];
    
}

-(void)InitUI
{
    [self.view addSubview:self.RegisterBtn];
    [self.view addSubview:self.Account];
    [self.view addSubview:self.Code];
    [self.view addSubview:self.GetCodeBtn];
    [self.view addSubview:self.SurePassWord];
    [self.view addSubview:self.timeLabel];
    [self.view addSubview:self.PassWord];
    [self.view addSubview:self.leftButton];
    [self.view addSubview:self.maskButton];
    
    UILabel  *title = [[UILabel alloc]initWithFrame:CGRectMake(22*SIZE, STATUS_BAR_HEIGHT+53*SIZE, 100*SIZE, 22*SIZE)];
    title.text = @"修改密码";
    title.font = [UIFont systemFontOfSize:21*SIZE];
    title.textColor = YJTitleLabColor;
    [self.view addSubview:title];
    
    for (int i = 0; i<4; i++) {
        UIView *line = [[UIView alloc]initWithFrame:CGRectMake(22*SIZE, STATUS_BAR_HEIGHT+154*SIZE+47*SIZE*i, 316*SIZE, 0.5*SIZE)];
        line.backgroundColor = COLOR(180, 180, 180, 1);
        [self.view addSubview:line];
    }
}

-(void)Register
{
    
    
    if (![self checkTel:_Account.text]) {
        [self showContent:@"请输入正确的电话号码！"];
    }
    if ([_Code.text isEqualToString:@""]) {
        [self showContent:@"请输入验证码！"];
        return;
    }
    if (_PassWord.text.length<6) {
        [self showContent:@"密码长度至少为6位"];
        return;
    }
    if (![self checkPassword:_PassWord.text]) {
        [self showContent:@"密码格式错误,必须包含数字和字母！"];
        return;
    }
    
    if (![_PassWord.text isEqualToString:_SurePassWord.text]) {
        [self showContent:@"两次输入的密码不相同！"];
        return;
    }
    
    
    
    NSDictionary *parameter = @{
                                @"account":_Account.text,
                                @"password":_PassWord.text,
                                @"password_verify":_SurePassWord.text,
                                @"captcha":_Code.text
                                };
    
    [BaseRequest POST:Register_URL parameters:parameter success:^(id resposeObject) {
        NSLog(@"%@",resposeObject);
        [self showContent:resposeObject[@"msg"]];
        if ([resposeObject[@"code"] integerValue] == 200) {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self.navigationController popViewControllerAnimated:YES];
            });
        }
        else{
            
        }
        
    } failure:^(NSError *error) {
        [self showContent:@"网络错误"];
    }];
}

-(void)GetCode{
    //获取验证码
    
    
    _GetCodeBtn.userInteractionEnabled = NO;
    if([self checkTel:_Account.text]) {
    
        NSDictionary *parameter = @{
                                    @"tel":_Account.text
                                    };
        [BaseRequest GET:Captcha_URL parameters:parameter success:^(id resposeObject) {
            NSLog(@"%@",resposeObject);
            if ([resposeObject[@"code"] integerValue] == 200) {
                _GetCodeBtn.hidden = YES;
                _timeLabel.hidden = NO;
                surplusTime = 60;
                _timeLabel.text = [NSString stringWithFormat:@"%ldS", (long)surplusTime];
                //倒计时
                time = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(updateTime) userInfo:nil repeats:YES];
            }
            
            [self showContent:resposeObject[@"msg"]];
            _GetCodeBtn.userInteractionEnabled = YES;
        } failure:^(NSError *error) {
            _GetCodeBtn.userInteractionEnabled = YES;
            [self showContent:@"网络错误"];
        }];
        
    }
    else
    {
        [self showContent:@"请输入正确的电话号码"];
    }
}

- (void)updateTime {
    surplusTime--;
    _timeLabel.text = [NSString stringWithFormat:@"%ldS", (long)surplusTime];
    if (surplusTime == 0) {
        [time invalidate];
        time = nil;
        _timeLabel.hidden = YES;
        _GetCodeBtn.hidden = NO;
    }
}





-(void)Protocol
{
    
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    if (textField == self.Account) {
        
        if (string.length == 0) return YES;
        
        NSInteger existedLength = textField.text.length;
        NSInteger selectedLength = range.length;
        NSInteger replaceLength = string.length;
        if (existedLength - selectedLength + replaceLength > 11) {
            return NO;
        }
    }else if (textField == self.Code){
        
        if (string.length == 0) return YES;
        
        NSInteger existedLength = textField.text.length;
        NSInteger selectedLength = range.length;
        NSInteger replaceLength = string.length;
        if (existedLength - selectedLength + replaceLength > 4) {
            return NO;
        }
    }else if (textField == self.PassWord || textField == self.SurePassWord){
        
        if (string.length == 0) return YES;
        
        NSInteger existedLength = textField.text.length;
        NSInteger selectedLength = range.length;
        NSInteger replaceLength = string.length;
        if (existedLength - selectedLength + replaceLength > 18) {
            return NO;
        }
    }
    return YES;
}

-(UITextField *)Account{
    if (!_Account) {
        _Account = [[UITextField alloc]initWithFrame:CGRectMake(22*SIZE, STATUS_BAR_HEIGHT+119*SIZE, 200*SIZE, 25*SIZE)];
        _Account.placeholder = @"请输入手机号码";
        _Account.keyboardType = UIKeyboardTypePhonePad;
        _Account.delegate = self;
        _Account.font = [UIFont systemFontOfSize:14*SIZE];
        
    }
    return _Account;
}

-(UITextField *)Code{
    if (!_Code) {
        _Code = [[UITextField alloc]initWithFrame:CGRectMake(22*SIZE, STATUS_BAR_HEIGHT+166*SIZE, 200*SIZE, 25*SIZE)];
        _Code.placeholder = @"请输入验证码";
        _Code.keyboardType = UIKeyboardTypeNumberPad;
        _Code.delegate = self;
        _Code.font = [UIFont systemFontOfSize:14*SIZE];
        
    }
    return _Code;
}

-(UITextField *)PassWord
{
    if (!_PassWord) {
        _PassWord = [[UITextField alloc]initWithFrame:CGRectMake(22*SIZE, STATUS_BAR_HEIGHT+213*SIZE, 200*SIZE, 25*SIZE)];
        _PassWord.placeholder = @"请输入新密码";
        _PassWord.keyboardType = UIKeyboardTypeDefault;
        _PassWord.font = [UIFont systemFontOfSize:14*SIZE];
        
    }
    return _PassWord;
}

-(UITextField *)SurePassWord
{
    if (!_SurePassWord) {
        _SurePassWord = [[UITextField alloc]initWithFrame:CGRectMake(22*SIZE, STATUS_BAR_HEIGHT+260*SIZE, 200*SIZE, 25*SIZE)];
        _SurePassWord.placeholder = @"再次输入新密码";
        _SurePassWord.keyboardType = UIKeyboardTypeDefault;
        _SurePassWord.font = [UIFont systemFontOfSize:14*SIZE];
    }
    return _SurePassWord;
}

-(UIButton *)RegisterBtn
{
    if (!_RegisterBtn) {
        _RegisterBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _RegisterBtn.frame = CGRectMake(22*SIZE, 340*SIZE+STATUS_BAR_HEIGHT, 316*SIZE, 41*SIZE);
        _RegisterBtn.layer.masksToBounds = YES;
        _RegisterBtn.layer.cornerRadius = 2*SIZE;
        _RegisterBtn.backgroundColor = YJLoginBtnColor;
        [_RegisterBtn setTitle:@"确认修改" forState:UIControlStateNormal];
        [_RegisterBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _RegisterBtn.titleLabel.font = [UIFont systemFontOfSize:16*SIZE];
        [_RegisterBtn addTarget:self action:@selector(Register) forControlEvents:UIControlEventTouchUpInside];
    }
    return _RegisterBtn;
}

-(UIButton *)GetCodeBtn
{
    if (!_GetCodeBtn) {
        _GetCodeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _GetCodeBtn.frame =  CGRectMake(236*SIZE, 166*SIZE+STATUS_BAR_HEIGHT, 100*SIZE, 25*SIZE);
        [_GetCodeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
        [_GetCodeBtn setTitleColor:YJLoginBtnColor forState:UIControlStateNormal];
        _GetCodeBtn.titleLabel.font = [UIFont systemFontOfSize:14*SIZE];
        [_GetCodeBtn addTarget:self action:@selector(GetCode) forControlEvents:UIControlEventTouchUpInside];
        _GetCodeBtn.contentHorizontalAlignment =UIControlContentHorizontalAlignmentRight;
    }
    return _GetCodeBtn;
}



-(UILabel *)timeLabel
{
    if (!_timeLabel) {
        _timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(247*SIZE, 172*SIZE+STATUS_BAR_HEIGHT, 100*SIZE, 15*SIZE)];
        _timeLabel.textColor = YJContentLabColor;
        _timeLabel.font = [UIFont systemFontOfSize:14 * SIZE];
        _timeLabel.textAlignment = NSTextAlignmentCenter;
        _timeLabel.hidden = YES;
        
    }
    return _timeLabel;
}

@end
