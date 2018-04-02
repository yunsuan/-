//
//  DateChooseView.m
//  云渠道
//
//  Created by xiaoq on 2018/4/2.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "DateChooseView.h"

@interface DateChooseView()
{

    NSDate *_date;
}
@end

@implementation DateChooseView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        _date = [NSDate date];
        [self initUI];
    }
    return self;
}

- (void)ActionTap{
    
    [self removeFromSuperview];
}

- (void)dateChange:(UIDatePicker *)date
{
    
    _date = date.date;
    NSLog(@"%@", date.date);
    
}

- (void)ActionCancelBtn:(UIButton *)btn{
    
    [self removeFromSuperview];
//    self = nil;
}

- (void)ActionConfirmBtn:(UIButton *)btn{
    
    if (self.timeBlock) {
        
        self.timeBlock(_date);
        [self removeFromSuperview];
//        self = nil;
    }
}

- (void)initUI{
    
    UIView *alphaView = [[UIView alloc] initWithFrame:self.bounds];
    alphaView.backgroundColor = [UIColor blackColor];
    alphaView.alpha = 0.3;
    alphaView.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(ActionTap)];
    [alphaView addGestureRecognizer:tap];
    [self addSubview:alphaView];
    
    UIView *whiteView = [[UIView alloc] initWithFrame:CGRectMake(0, self.bounds.size.height - 230 *SIZE, SCREEN_Width, 230 *SIZE)];
    whiteView.backgroundColor = CH_COLOR_white;
    [self addSubview:whiteView];
    
    
    
    _cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _cancelBtn.frame = CGRectMake(10 *SIZE, 0, 50 *SIZE, 30 *SIZE);
    _cancelBtn.titleLabel.font = [UIFont systemFontOfSize:14 *sIZE];
    [_cancelBtn addTarget:self action:@selector(ActionCancelBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [_cancelBtn setTitleColor:YJContentLabColor forState:UIControlStateNormal];
    [whiteView addSubview:_cancelBtn];
    
    _confirmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _confirmBtn.frame = CGRectMake(SCREEN_Width - 50 *SIZE, 0, 50 *SIZE, 30 *SIZE);
    _confirmBtn.titleLabel.font = [UIFont systemFontOfSize:14 *sIZE];
    [_confirmBtn addTarget:self action:@selector(ActionConfirmBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_confirmBtn setTitle:@"确定" forState:UIControlStateNormal];
    [_confirmBtn setTitleColor:YJContentLabColor forState:UIControlStateNormal];
    [whiteView addSubview:_confirmBtn];
    
    _dataPicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, 30 *SIZE, SCREEN_Width, 200 *SIZE)];
    [_dataPicker setLocale:[[NSLocale alloc]initWithLocaleIdentifier:@"zh_Hans_CN"]];
    
    
    [_dataPicker setCalendar:[NSCalendar currentCalendar]];
    
    [_dataPicker setDate:[NSDate date]];

    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    
    NSDate *currentDate = [NSDate date];

    NSDate * dateNow =[NSDate date];
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyy-MM-dd";
    
    NSDate *minDate = [fmt dateFromString:@"1949-10-1"];
    //设置日期最大及最小值
    _dataPicker.maximumDate = dateNow;
    _dataPicker.minimumDate = minDate;

    
    [_dataPicker setDatePickerMode:UIDatePickerModeDate];
    
    [_dataPicker addTarget:self action:@selector(dateChange:) forControlEvents:UIControlEventValueChanged];
    [whiteView addSubview:_dataPicker];
}

@end
