//
//  FollowRecordVC.m
//  云渠道
//
//  Created by 谷治墙 on 2018/4/3.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "FollowRecordVC.h"
#import "BorderTF.h"
#import "DropDownBtn.h"
#import "SinglePickView.h"
#import "DateChooseView.h"

@interface FollowRecordVC ()
{
    
    NSArray *_titleArr;
    NSArray *_wayArr;
}

@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) UITextField *nameTF;

@property (nonatomic, strong) UITextField *followTF;

@property (nonatomic, strong) UILabel *timeL;

@property (nonatomic, strong) BorderTF *intentionTF;

@property (nonatomic, strong) BorderTF *urgentTF;

@property (nonatomic, strong) UIButton *phoneBtn;

@property (nonatomic, strong) UIButton *QQBtn;

@property (nonatomic, strong) UIButton *wechatBtn;

@property (nonatomic, strong) UIButton *faceBtn;

@property (nonatomic, strong) UIButton *otherBtn;

@property (nonatomic, strong) UISlider *intentionSlider;

@property (nonatomic, strong) UISlider *urgentSlider;

@property (nonatomic, strong) DropDownBtn *payWayBtn;

@property (nonatomic, strong) UITextView *followTV;

@property (nonatomic, strong) DropDownBtn *nextTimeBtn;

@property (nonatomic, strong) UIButton *confirmBtn;
@end

@implementation FollowRecordVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initDataSource];
    [self initUI];
}

- (void)initDataSource{
    
    _titleArr = @[@"客户名称",@"跟进时间",@"跟进人"];
    _wayArr = @[@"电话",@"QQ",@"微信",@"面谈",@"其他"];

}

-(void)action_pay
{
    SinglePickView *view = [[SinglePickView alloc]initWithFrame:self.view.frame WithData:[self getDetailConfigArrByConfigState:PAY_WAY]];
    view.selectedBlock = ^(NSString *MC, NSString *ID) {
        _payWayBtn.content.text = MC;
    };
    [self.view addSubview:view];

}

-(void)action_nexttime
{
    DateChooseView *view = [[DateChooseView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_Width, SCREEN_Height)];
    view.dateblock = ^(NSDate *date) {
        NSLog(@"%@",[self gettime:date]);
        _nextTimeBtn.content.text = [self gettime:date];
    };
    [self.view addSubview:view];
}

- (void)ActionSelectBtn:(UIButton *)btn{
    
    [_QQBtn setImage:[UIImage imageNamed:@"default"] forState:UIControlStateNormal];
    [_otherBtn setImage:[UIImage imageNamed:@"default"] forState:UIControlStateNormal];
    [_wechatBtn setImage:[UIImage imageNamed:@"default"] forState:UIControlStateNormal];
    [_faceBtn setImage:[UIImage imageNamed:@"default"] forState:UIControlStateNormal];
    [_phoneBtn setImage:[UIImage imageNamed:@"default"] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:@"selected"] forState:UIControlStateNormal];
    
}

- (void)ActionSliderChange:(UIButton *)btn{
    
    
}

- (void)initUI{
    
    self.navBackgroundView.hidden = NO;
    self.titleLabel.text = @"跟进记录";
    
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, SCREEN_Width, SCREEN_Height - NAVIGATION_BAR_HEIGHT)];
//    _scrollView.delegate = self;
    [_scrollView setContentSize:CGSizeMake(SCREEN_Width, 878 *SIZE)];
    [self.view addSubview:_scrollView];
    
    UIView *view1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width, 128 *SIZE)];
    view1.backgroundColor = CH_COLOR_white;
    [_scrollView addSubview:view1];
    
    UIView *view2 = [[UIView alloc] initWithFrame:CGRectMake(0, 136 *SIZE, SCREEN_Width, 591 *SIZE)];
    view2.backgroundColor = CH_COLOR_white;
    [_scrollView addSubview:view2];

    for (int i = 0; i < 3; i++) {
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10 *SIZE, 14 *SIZE + i *43 *SIZE, 60 *SIZE, 13 *SIZE)];
        label.textColor = YJContentLabColor;
        label.font = [UIFont systemFontOfSize:13 *SIZE];
        label.text = _titleArr[i];
        [view1 addSubview:label];
        
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(10 *SIZE, 43 *SIZE * (i + 1), 340 *SIZE, 1)];
        line.backgroundColor = YJBackColor;
        [view1 addSubview:line];
        
        if (i == 1) {
            
            _timeL = [[UILabel alloc] initWithFrame:CGRectMake(78 *SIZE, 60 *SIZE, 200 *SIZE, 13 *SIZE)];
            _timeL.textColor = YJTitleLabColor;
            _timeL.font = [UIFont systemFontOfSize:13 *SIZE];
            [view1 addSubview:_timeL];
        }else{
            
            UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(78 *SIZE , i * 43 *SIZE, 270 *SIZE, 42 *SIZE)];
            textField.font = [UIFont systemFontOfSize:13 *SIZE];
            [view1 addSubview:textField];
        }
    }
    
    UILabel *wayL = [[UILabel alloc] initWithFrame:CGRectMake(9 *SIZE, 20 *SIZE, 60 *SIZE, 11 *SIZE)];
    wayL.textColor = YJTitleLabColor;
    wayL.font = [UIFont systemFontOfSize:12 *SIZE];
    wayL.text = @"跟进方式";
    [view2 addSubview:wayL];
    
    for (int i = 0; i < 5; i++) {
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(71 *SIZE + (i % 2) * 146 *SIZE, 15 *SIZE + (i / 2) * 40 *SIZE, 60 *SIZE, 25 *SIZE);
        btn.tag = i;
        btn.titleLabel.font = [UIFont systemFontOfSize:14 *sIZE];
        [btn addTarget:self action:@selector(ActionSelectBtn:) forControlEvents:UIControlEventTouchUpInside];
        [btn setTitle:_wayArr[i] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"default"] forState:UIControlStateNormal];
        [btn setTitleColor:YJContentLabColor forState:UIControlStateNormal];
        switch (i) {
            case 0:
            {
                _phoneBtn = btn;
                [view2 addSubview:_phoneBtn];
                break;
            }
            case 1:
            {
                _QQBtn = btn;
                [view2 addSubview:_QQBtn];
                break;
            }
            case 2:
            {
                _wechatBtn = btn;
                [view2 addSubview:_wechatBtn];
                break;
            }
            case 3:
            {
                _faceBtn = btn;
                [view2 addSubview:_faceBtn];
                break;
            }
            case 4:
            {
                _otherBtn = btn;
                [view2 addSubview:_otherBtn];
                break;
            }
            default:
                break;
        }
    }
    
    for (int i = 0; i < 2; i++) {
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(9 *SIZE, 156 *SIZE + i * 98 *SIZE, 70 *SIZE, 11 *SIZE)];
        label.textColor = YJTitleLabColor;
        label.font = [UIFont systemFontOfSize:12 *SIZE];
        if (i == 0) {
            
            label.text = @"购房意向度";
        }else{
            
            label.text = @"购房紧迫度";
        }
        [view2 addSubview:label];
        
        BorderTF *TF = [[BorderTF alloc] initWithFrame:CGRectMake(80 *SIZE, 145 *SIZE + i * 95 *SIZE, 258 *SIZE, 33 *SIZE)];
        switch (i) {
            case 0:
            {
                _intentionTF = TF;
                [view2 addSubview:_intentionTF];
                break;
            }
            case 1:
            {
                _urgentTF = TF;
                [view2 addSubview:_urgentTF];
                break;
            }
            default:
                break;
        }
        
        UISlider *slider = [[UISlider alloc] initWithFrame:CGRectMake(11 *SIZE, 203 *SIZE + i * 98 *SIZE, 327 *SIZE, 5 *SIZE)];
        slider.userInteractionEnabled = YES;
        slider.minimumValue = 0.0;
        slider.maximumValue = 100.0;
        slider.maximumTrackTintColor = YJBackColor;
        slider.minimumTrackTintColor = COLOR(255, 224, 177, 1);
        slider.thumbTintColor = COLOR(255, 224, 177, 1);
        [slider setThumbImage:[UIImage imageNamed:@"point"] forState:UIControlStateNormal];
        [slider setThumbImage:[UIImage imageNamed:@"point"] forState:UIControlStateHighlighted];
        [slider addTarget:self action:@selector(ActionSliderChange:) forControlEvents:UIControlEventValueChanged];
        
        UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(11 *SIZE, 214 *SIZE + i * 104 *SIZE, 15 *SIZE, 11 *SIZE)];
        label2.textColor = COLOR(170, 170, 170, 1);
        label2.font = [UIFont systemFontOfSize:12 *SIZE];
        label2.text = @"0";
        [view2 addSubview:label2];
        
        UILabel *label3 = [[UILabel alloc] initWithFrame:CGRectMake(315 *SIZE, 214 *SIZE + i * 104 *SIZE, 30 *SIZE, 11 *SIZE)];
        label3.textColor = COLOR(170, 170, 170, 1);
        label3.font = [UIFont systemFontOfSize:12 *SIZE];
        label3.text = @"100";
        [view2 addSubview:label3];
        if (i == 0) {
            
            _intentionSlider = slider;
            [view2 addSubview:_intentionSlider];
        }else{
            
            _urgentSlider = slider;
            [view2 addSubview:_urgentSlider];
        }
    }

    
    for (int i = 0; i < 3; i++) {
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(9 *SIZE, 356 *SIZE, 70 *SIZE, 13 *SIZE)];
        label.textColor = YJTitleLabColor;
        label.font = [UIFont systemFontOfSize:13 *SIZE];
        if (i == 0) {
            
            label.text = @"付款方式:";
        }else if (i == 1){
            
            label.frame = CGRectMake(9 *SIZE, 418 *SIZE, 70 *SIZE, 10 *SIZE);
            label.text = @"跟进内容:";
        }else{
            
            label.frame = CGRectMake(9 *SIZE, 531 *SIZE, 72 *SIZE, 10 *SIZE);
            label.font = [UIFont systemFontOfSize:10.5 *SIZE];
            label.text = @"下次回访时间:";
        }
        [view2 addSubview:label];
    }
    
    _payWayBtn = [[DropDownBtn alloc] initWithFrame:CGRectMake(80 *SIZE, 345 *SIZE, 258 *SIZE, 33 *SIZE)];
    [view2 addSubview:_payWayBtn];
    [_payWayBtn addTarget:self action:@selector(action_pay) forControlEvents:UIControlEventTouchUpInside];
    
    
    _followTV = [[UITextView alloc] initWithFrame:CGRectMake(80 *SIZE, 408 *SIZE, 258 *SIZE, 77 *SIZE)];
    _followTV.layer.cornerRadius = 5 *SIZE;
    _followTV.layer.borderColor = COLOR(219, 219, 219, 1).CGColor;
    _followTV.layer.borderWidth = SIZE;
    _followTV.clipsToBounds = YES;
    [view2 addSubview:_followTV];
    
    _nextTimeBtn = [[DropDownBtn alloc] initWithFrame:CGRectMake(80 *SIZE, 519 *SIZE, 258 *SIZE, 33 *SIZE)];
    [view2 addSubview:_nextTimeBtn];
    [_nextTimeBtn addTarget:self action:@selector(action_nexttime) forControlEvents:UIControlEventTouchUpInside];
    
    _confirmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _confirmBtn.frame = CGRectMake(22 *SIZE, 846 *SIZE, 317 *SIZE, 40 *SIZE);
    [_confirmBtn setBackgroundColor:YJBlueBtnColor];
    _confirmBtn.layer.cornerRadius = 2 *SIZE;
    _confirmBtn.clipsToBounds = YES;
    [_confirmBtn setTitle:@"下一步" forState:UIControlStateNormal];
    [_scrollView addSubview:_confirmBtn];
}

@end
