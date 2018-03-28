//
//  CompanyDetailVC.m
//  云渠道
//
//  Created by 谷治墙 on 2018/3/28.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "CompanyDetailVC.h"

@interface CompanyDetailVC ()

@property (nonatomic, strong) UILabel *briefL;

@property (nonatomic, strong) UIView *contentView;

@property (nonatomic, strong) UIButton *selectBtn;

@end

@implementation CompanyDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
   
    [self initUI];
}


- (void)initUI{
    
    self.navBackgroundView.hidden = NO;
    self.titleLabel.text = @"公司详情";
    
    UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT + 2 *SIZE, SCREEN_Width, 100 *SIZE)];
    topView.backgroundColor = CH_COLOR_white;
    [self.view addSubview:topView];
    
    _contentView = [[UIView alloc] init];
    _contentView.backgroundColor = CH_COLOR_white;
    [self.view addSubview:_contentView];
    
    _briefL = [[UILabel alloc] init];
    _briefL.textColor = YJTitleLabColor;
    _briefL.font = [UIFont systemFontOfSize:12 *SIZE];
    _briefL.numberOfLines = 0;
    [_contentView addSubview:_briefL];
    
    _briefL.text = @"房产云算软件专门为房产经纪人研发的房地产软件，能够帮助房产经纪人更好的管理手上的房源信息，并且批量的将房源群发到当地的各大房产网站，省去了大量发布房源的时间，并且能够第一时间从各大房产网上获取最新的房源信息让房产经纪人能够及时的获取第一手资料，并且迅速完成配对，促进交易的完成。";
    
    [_briefL mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.equalTo(_contentView).offset(57 *SIZE);
        make.left.equalTo(_contentView).offset(10 *SIZE);
        make.right.equalTo(_contentView).offset(-14 *SIZE);
        make.bottom.equalTo(_contentView).offset(-48 *SIZE);
    }];
    
    [_contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.navBackgroundView.mas_bottom).offset(108 *SIZE);
        make.left.equalTo(self.view).offset(0);
        make.right.equalTo(self.view).offset(0);
        make.top.equalTo(_briefL.mas_bottom).offset(48 *SIZE);
    }];
    
    _selectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _selectBtn.frame = CGRectMake(0, SCREEN_Height - 43 *SIZE, SCREEN_Width, 43 *SIZE);
    _selectBtn.titleLabel.font = [UIFont systemFontOfSize:14 *sIZE];
//    [_selectBtn addTarget:self action:@selector(<#selector#>) forControlEvents:UIControlEventTouchUpInside];
    [_selectBtn setTitle:@"选择该公司" forState:UIControlStateNormal];
    [_selectBtn setBackgroundColor:COLOR(27, 152, 255, 1)];
    [_selectBtn setTitleColor:CH_COLOR_white forState:UIControlStateNormal];
    [self.view addSubview:_selectBtn];
}

@end
