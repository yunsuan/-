//
//  AddBankCardVC.m
//  云渠道
//
//  Created by 谷治墙 on 2018/3/22.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "AddBankCardVC.h"

@interface AddBankCardVC ()<UITextFieldDelegate>
{
    NSInteger surplusTime;//重新发送短信的倒计时时间
    NSTimer *time;
}

@property (nonatomic, strong) UITextField *peopleTF;

@property (nonatomic, strong) UITextField *cardNumTF;

@property (nonatomic, strong) UITextField *cardTypeTF;

@property (nonatomic, strong) UITextField *phoneTF;

@property (nonatomic, strong) UITextField *codeTF;

@property (nonatomic, strong) UIButton *GetCodeBtn;

@property (nonatomic, strong) UIButton *addBtn;

@property (nonatomic, strong) UILabel *timeLabel;

@end

@implementation AddBankCardVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initUI];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    if (textField == self.cardNumTF) {
        
        if (string.length == 0) return YES;
        
        NSInteger existedLength = textField.text.length;
        NSInteger selectedLength = range.length;
        NSInteger replaceLength = string.length;
        if (existedLength - selectedLength + replaceLength > 11) {
            return NO;
        }
    }else if (textField == self.codeTF){
        
        if (string.length == 0) return YES;
        
        NSInteger existedLength = textField.text.length;
        NSInteger selectedLength = range.length;
        NSInteger replaceLength = string.length;
        if (existedLength - selectedLength + replaceLength > 4) {
            return NO;
        }
    }else if (textField == self.phoneTF){
        
        if (string.length == 0) return YES;
        
        NSInteger existedLength = textField.text.length;
        NSInteger selectedLength = range.length;
        NSInteger replaceLength = string.length;
        if (existedLength - selectedLength + replaceLength > 11) {
            return NO;
        }
    }
    return YES;
}

- (void)ActionAddBtn:(UIButton *)btn{
    
    
}

-(void)ActionGetBtn:(UIButton *)btn{
    //获取验证码
    
    
    _GetCodeBtn.userInteractionEnabled = NO;
    if([self checkTel:_phoneTF.text]) {
        
        //        NetConfitModel *model = [[NetConfitModel alloc]init];
        //
        //        [BaseNetRequest startpost:@"/TelService.ashx" parameters:[model configgetCodebyphone:@"13438339177"] success:^(id resposeObject) {
        //
        //            NSLog(@"%@",resposeObject);
        //            [self showContent:[NSString stringWithFormat:@"%@",resposeObject[0][@"content"]]];
        //            if ([resposeObject[0][@"state"] isEqualToString:@"1"])
        //            {
        _GetCodeBtn.hidden = YES;
        _timeLabel.hidden = NO;
        surplusTime = 60;
        _timeLabel.text = [NSString stringWithFormat:@"%ldS", (long)surplusTime];
        //倒计时
        time = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(updateTime) userInfo:nil repeats:YES];
        _GetCodeBtn.userInteractionEnabled = YES;
        
        //            }
        //
        //
        //        } failure:^(NSError *error) {
        //            NSLog(@"%@",error);
        //            _codebtn.userInteractionEnabled = YES;
        //
        //        }];
        //
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

- (void)initUI{
    
    self.navBackgroundView.hidden = NO;
    self.titleLabel.text = @"添加银行卡";
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT + 40 *SIZE, SCREEN_Width, 260 *SIZE)];
    view.backgroundColor = CH_COLOR_white;
    [self.view addSubview:view];
    
    NSArray *titleArr = @[@"持卡人",@"卡号",@"卡类型",@"手机号",@"验证码"];
    
    for (int i = 0; i < 5; i++) {
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(9 *SIZE, 19 *SIZE + i * 52 *SIZE, 50 *SIZE, 12 *SIZE)];
        label.textColor = YJContentLabColor;
        label.font = [UIFont systemFontOfSize:13 *SIZE];
        label.text = titleArr[i];
        [view addSubview:label];
        
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 52 *SIZE * (i + 1) - 2 *SIZE, SCREEN_Width, 2 *SIZE)];
        line.backgroundColor = YJBackColor;
        [view addSubview:line];
        
        UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(87 *SIZE, 14 *SIZE + i * 52 *SIZE, 150 *SIZE, 22 *SIZE)];
        textField.font = [UIFont systemFontOfSize:13 *SIZE];
        textField.delegate = self;
        switch (i) {
            case 0:
            {
                _peopleTF = textField;
                [view addSubview:_peopleTF];
                break;
            }
            case 1:
            {
                _cardNumTF = textField;
                _cardNumTF.keyboardType = UIKeyboardTypeNumberPad;
                [view addSubview:_cardNumTF];
                break;
            }
            case 2:
            {
                _cardTypeTF = textField;
                _cardTypeTF.userInteractionEnabled = NO;
                [view addSubview:_cardTypeTF];
                break;
            }
            case 3:
            {
                _phoneTF = textField;
                _phoneTF.keyboardType = UIKeyboardTypePhonePad;
                [view addSubview:_phoneTF];
                
                _GetCodeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
                _GetCodeBtn.frame =  CGRectMake(274*SIZE, 14 *SIZE + i * 52 *SIZE, 72*SIZE, 21*SIZE);
                [_GetCodeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
                [_GetCodeBtn setTitleColor:YJLoginBtnColor forState:UIControlStateNormal];
                _GetCodeBtn.titleLabel.font = [UIFont systemFontOfSize:14*SIZE];
                [_GetCodeBtn addTarget:self action:@selector(ActionGetBtn:) forControlEvents:UIControlEventTouchUpInside];
                _GetCodeBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
                [view addSubview:_GetCodeBtn];
                break;
            }
            case 4:
            {
                _codeTF = textField;
                _codeTF.keyboardType = UIKeyboardTypeNumberPad;
                [view addSubview:_codeTF];
                break;
            }
            default:
                break;
        }
    }
    
    _addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _addBtn.frame = CGRectMake(22 *SIZE, 473*SIZE + NAVIGATION_BAR_HEIGHT, 316 *SIZE, 41 *SIZE);
    _addBtn.layer.masksToBounds = YES;
    _addBtn.layer.cornerRadius = 2 *SIZE;
    _addBtn.backgroundColor = YJLoginBtnColor;
    [_addBtn setTitle:@"确认" forState:UIControlStateNormal];
    [_addBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _addBtn.titleLabel.font = [UIFont systemFontOfSize:16*SIZE];
    [_addBtn addTarget:self action:@selector(ActionAddBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_addBtn];
}

@end
