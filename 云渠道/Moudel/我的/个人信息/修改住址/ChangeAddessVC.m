//
//  ChangeAddessVC.m
//  云渠道
//
//  Created by 谷治墙 on 2018/4/2.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "ChangeAddessVC.h"

@interface ChangeAddessVC ()

@property (nonatomic, strong) UILabel *addressL;

@property (nonatomic, strong) UIButton *addressBtn;

@property (nonatomic, strong) UIView *whiteView;

@property (nonatomic, strong) UIImageView *dropImg;

@end

@implementation ChangeAddessVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initUI];
}

- (void)initUI{
    
    _whiteView = [[UIView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, SCREEN_Width, 50 *SIZE)];
    _whiteView.backgroundColor = CH_COLOR_white;
    [self.view addSubview:_whiteView];
    
    _addressL = [[UILabel alloc] initWithFrame:CGRectMake(10 *SIZE, 18 *SIZE, 200 *SIZE, 13 *SIZE)];
    _addressL.textColor = YJTitleLabColor;
    _addressL.font = [UIFont systemFontOfSize:13 *SIZE];
    [self.view addSubview:_addressL];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10 *SIZE , 60 *SIZE + NAVIGATION_BAR_HEIGHT, 100 *SIZE, 12 *SIZE)];
    label.textColor = YJContentLabColor;
    label.font = [UIFont systemFontOfSize:13 *SIZE];
    label.text = @"具体地址";
    [self.view addSubview:label];
    
    
}

@end
