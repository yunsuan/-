//
//  MyCodeVC.m
//  云渠道
//
//  Created by 谷治墙 on 2018/4/10.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "MyCodeVC.h"

@interface MyCodeVC ()

@property (nonatomic, strong) UIImageView *headImg;

@property (nonatomic, strong) UIImageView *tagImg;

@property (nonatomic, strong) UIImageView *genderImg;

@property (nonatomic, strong) UILabel *nameL;

@property (nonatomic, strong) UIImageView *codeImg;

@property (nonatomic, strong) UIView *whiteView;

@end

@implementation MyCodeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initUI];
}

- (void)ActionRightBtn:(UIButton *)btn{
    
    
}

- (void)initUI{
    
    self.titleLabel.text = @"我的二维码";
    self.rightBtn.hidden = NO;
    [self.rightBtn setTitle:@"分享" forState:UIControlStateNormal];
    self.rightBtn.titleLabel.font = [UIFont systemFontOfSize:15 *SIZE];
    [self.rightBtn setTitleColor:YJTitleLabColor forState:UIControlStateNormal];
    [self.rightBtn addTarget:self action:@selector(ActionRightBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    self.view.backgroundColor = COLOR(67, 67, 67, 1);
    
    _whiteView = [[UIView alloc] initWithFrame:CGRectMake(46 *SIZE, 37 *SIZE + NAVIGATION_BAR_HEIGHT, 267 *SIZE, 333 *SIZE)];
    _whiteView.backgroundColor = CH_COLOR_white;
    [self.view addSubview:_whiteView];
    
    _headImg = [[UIImageView alloc] initWithFrame:CGRectMake(100 *SIZE, 24 *SIZE, 67 *SIZE, 67 *SIZE)];
    _headImg.backgroundColor = YJGreenColor;
    _headImg.layer.cornerRadius = 33.5 *SIZE;
    _headImg.clipsToBounds = YES;
    _headImg.contentMode = UIViewContentModeScaleAspectFit;
    [_whiteView addSubview:_headImg];
    
    
    _tagImg = [[UIImageView alloc] initWithFrame:CGRectMake(90 *SIZE, 101 *SIZE, 88 *SIZE, 34 *SIZE)];
    _tagImg.image = [UIImage imageNamed:@""];
    [_whiteView addSubview:_tagImg];
    
    _genderImg = [[UIImageView alloc] initWithFrame:CGRectMake(19 *SIZE, 11 *SIZE, 12 *SIZE, 12 *SIZE)];
    _genderImg.image = [UIImage imageNamed:@"man"];
    [_tagImg addSubview:_genderImg];
    
    _nameL = [[UILabel alloc] initWithFrame:CGRectMake(36 *SIZE, 11 *SIZE, 50 *SIZE, 12 *SIZE)];
    _nameL.textColor = CH_COLOR_white;
    _nameL.font = [UIFont systemFontOfSize:13 *SIZE];
    [_tagImg addSubview:_nameL];
    
    _codeImg = [[UIImageView alloc] initWithFrame:CGRectMake(50 *SIZE, 148 *SIZE, 167 *SIZE, 167 *SIZE)];
    _codeImg.backgroundColor = [UIColor blackColor];
    [_whiteView addSubview:_codeImg];
}

@end
