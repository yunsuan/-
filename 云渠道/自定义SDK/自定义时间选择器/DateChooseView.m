//
//  DateChooseView.m
//  云渠道
//
//  Created by xiaoq on 2018/4/2.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "DateChooseView.h"

<<<<<<< HEAD

#define PICKERHEIGHT 216
#define BGHEIGHT     256

#define KEY_WINDOW_HEIGHT [UIApplication sharedApplication].keyWindow.frame.size.height
@interface DateChooseView()
@property(nonatomic, strong) UIDatePicker * pickerView;
/**
 bgView
 */
@property(nonatomic, strong) UIView * bgView;

/**
 toolBar
 */
@property(nonatomic, strong) UIView * toolBar;

/**
 取消按钮
 */
@property(nonatomic, strong) UIButton * cancleBtn;

/**
 确定按钮
 */
@property(nonatomic, strong) UIButton * sureBtn;

@property(nonatomic, strong) NSDate *date;




/**
 记录选中的位置
 */
@property(nonatomic, assign) NSInteger selected;
=======
@interface DateChooseView()
{

    NSDate *_date;
}
>>>>>>> f2d235867233a0d11eb8d9530a8a9bcd47906949
@end

@implementation DateChooseView

<<<<<<< HEAD
#pragma mark -- lazy
- (UIButton *)cancleBtn
{
    if (!_cancleBtn) {
        _cancleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _cancleBtn.frame = CGRectMake(10, 5, 50, BGHEIGHT - PICKERHEIGHT - 10);
        
        [_cancleBtn setTitle:@"取消" forState:UIControlStateNormal];
        [_cancleBtn setTitleColor:YJBlueBtnColor forState:UIControlStateNormal];
        _cancleBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        _cancleBtn.backgroundColor = [UIColor clearColor];
        [_cancleBtn addTarget:self action:@selector(cancleBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancleBtn;
}

- (UIButton *)sureBtn
{
    if (!_sureBtn) {
        _sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _sureBtn.frame = CGRectMake(self.frame.size.width - 60, 5, 50, BGHEIGHT - PICKERHEIGHT - 10);
        [_sureBtn setTitle:@"确定" forState:UIControlStateNormal];
        [_sureBtn setTitleColor:YJBlueBtnColor forState:UIControlStateNormal];
        _sureBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        _sureBtn.backgroundColor = [UIColor clearColor];
        [_sureBtn addTarget:self action:@selector(sureBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _sureBtn;
}

- (UIView *)toolBar
{
    if (!_toolBar) {
        _toolBar = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, BGHEIGHT - PICKERHEIGHT)];
        _toolBar.backgroundColor = [UIColor groupTableViewBackgroundColor];
    }
    return _toolBar;
}
- (UIView *)bgView  //主视图
{
    if (!_bgView) {
        _bgView = [[UIView alloc] initWithFrame:CGRectMake(0, self.frame.size.height , self.frame.size.width, BGHEIGHT)];
        _bgView.backgroundColor = [UIColor whiteColor];
    }
    return _bgView;
}



- (UIDatePicker *)pickerView
{
    if (!_pickerView) {
        _pickerView = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, BGHEIGHT - PICKERHEIGHT, self.frame.size.width, PICKERHEIGHT)];
        _pickerView.datePickerMode = UIDatePickerModeDate;
        // 设置日期选择控件的地区
        [_pickerView setLocale:[[NSLocale alloc]initWithLocaleIdentifier:@"zh_Hans_CN"]];
        //默认为当天。
        [_pickerView setCalendar:[NSCalendar currentCalendar]];
        [_pickerView setMaximumDate:[NSDate date]];
         NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
        NSDateComponents *comps = [[NSDateComponents alloc] init];
        [comps setYear:60];//设置最大时间为：当前时间推后10天
        [_pickerView setMinimumDate:[calendar dateByAddingComponents:comps toDate:[NSDate date] options:0]];
        [_pickerView addTarget:self action:@selector(dateChange:)forControlEvents:UIControlEventValueChanged];
    }
    return _pickerView;
}

#pragma mark -- init
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        _date =  [NSDate date];
        [self initSuViews];
=======
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        _date = [NSDate date];
        [self initUI];
>>>>>>> f2d235867233a0d11eb8d9530a8a9bcd47906949
    }
    return self;
}

<<<<<<< HEAD
#pragma mark -- 从plist里面读数据





#pragma mark -- loadSubViews
- (void)initSuViews
{
    [self addSubview:self.bgView];
    [self.bgView addSubview:self.toolBar];
    [self.bgView addSubview:self.pickerView];
    [self.toolBar addSubview:self.cancleBtn];
    [self.toolBar addSubview:self.sureBtn];
    [self showPickerView];
}

#pragma mark -- showPickerView
- (void)showPickerView
{
    [UIView animateWithDuration:0.3 animations:^{
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
        _bgView.frame = CGRectMake(0, self.frame.size.height - BGHEIGHT, self.frame.size.width, BGHEIGHT);
    }];
}


- (void)hidePickerView
{
    [UIView animateWithDuration:0.3 animations:^{
        _bgView.frame = CGRectMake(0, self.frame.size.height , self.frame.size.width, BGHEIGHT);
        
        self.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}


- (void)dateChange:(UIDatePicker *)date
{
    
    NSLog(@"%@", date.date);
    _date = date.date;
    
}

#pragma mark -- Button
- (void)cancleBtnClick
{
    [self hidePickerView];
}

- (void)sureBtnClick
{
    [self hidePickerView];
    if (self.dateblock != nil) {
        self.dateblock(_date);
    }
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    if ([touches.anyObject.view isKindOfClass:[self class]]) {
        [self hidePickerView];
    }
=======
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
>>>>>>> f2d235867233a0d11eb8d9530a8a9bcd47906949
}

@end
