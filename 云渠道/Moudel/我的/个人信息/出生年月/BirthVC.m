//
//  BirthVC.m
//  云渠道
//
//  Created by 谷治墙 on 2018/4/2.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "BirthVC.h"
#import "DateChooseView.h"

@interface BirthVC ()

@property (nonatomic, strong) UILabel *birthL;

@property (nonatomic, strong) UIButton *birthBtn;

@property (nonatomic, strong) DateChooseView *dateView;

@property (nonatomic, strong) NSDateFormatter *formatter;

@end

@implementation BirthVC

- (void)viewDidLoad {
    [super viewDidLoad];
   
    [self initUI];
}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    self.dateView = nil;
}

- (void)ActionBirthBtn:(UIButton *)btn{
    
    [[[UIApplication sharedApplication] keyWindow] addSubview:self.dateView];
    
}

- (void)ActionRightBtn:(UIButton *)btn{
    
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)initUI{
    
    self.navBackgroundView.hidden = NO;
    self.titleLabel.text = @"出生年月";
    
    self.rightBtn.hidden = NO;
    [self.rightBtn setTitle:@"保存" forState:UIControlStateNormal];
    self.rightBtn.titleLabel.font = [UIFont systemFontOfSize:15 *SIZE];
    [self.rightBtn setTitleColor:YJTitleLabColor forState:UIControlStateNormal];
    [self.rightBtn addTarget:self action:@selector(ActionRightBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    _formatter = [[NSDateFormatter alloc] init];
    [_formatter setDateFormat:@"yyyy-MM-dd"];
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT + 12 *SIZE, SCREEN_Width, 50 *SIZE)];
    view.backgroundColor = CH_COLOR_white;
    [self.view addSubview:view];
    
    _birthL = [[UILabel alloc] initWithFrame:CGRectMake(10 *SIZE, 20 *SIZE, 300 *SIZE, 12 *SIZE)];
    _birthL.textColor = YJTitleLabColor;
    _birthL.font = [UIFont systemFontOfSize:13 *SIZE];
    [view addSubview:_birthL];
    
    _birthBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _birthBtn.frame = CGRectMake(0, 0, SCREEN_Width, 50 *SIZE);
    [_birthBtn addTarget:self action:@selector(ActionBirthBtn:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:_birthBtn];
    
}

- (DateChooseView *)dateView{
    
    if (!_dateView) {
        
        _dateView = [[DateChooseView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width, SCREEN_Height)];
        
        __weak __typeof(&*self)weakSelf = self;
        _dateView.timeBlock = ^(NSDate *date) {
          
            weakSelf.birthL.text = [weakSelf.formatter stringFromDate:date];
        };
    }
    return _dateView;
}

@end
