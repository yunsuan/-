//
//  ChangeAddessVC.m
//  云渠道
//
//  Created by 谷治墙 on 2018/4/2.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "ChangeAddessVC.h"
#import "AdressChooseView.h"

@interface ChangeAddessVC ()

@property (nonatomic, strong) UILabel *addressL;

@property (nonatomic, strong) UIButton *addressBtn;

@property (nonatomic, strong) UIView *whiteView;

@property (nonatomic, strong) UIImageView *dropImg;

@property (nonatomic, strong) UITextView *detailTV;

//@property (nonatomic, strong) AdressChooseView *adressView;

@end

@implementation ChangeAddessVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initUI];
}

- (void)initUI{
    
    self.navBackgroundView.hidden = NO;
    
    _whiteView = [[UIView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, SCREEN_Width, 50 *SIZE)];
    _whiteView.backgroundColor = CH_COLOR_white;
    [self.view addSubview:_whiteView];
    
    _addressL = [[UILabel alloc] initWithFrame:CGRectMake(10 *SIZE, 18 *SIZE, 200 *SIZE, 13 *SIZE)];
    _addressL.textColor = YJTitleLabColor;
    _addressL.font = [UIFont systemFontOfSize:13 *SIZE];
    [_whiteView addSubview:_addressL];
    
    _addressL.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(action_address)];
    [_addressL addGestureRecognizer:tap];
    
    _dropImg = [[UIImageView alloc] initWithFrame:CGRectMake(342 *SIZE, 23 *SIZE, 8 *SIZE, 8 *SIZE)];
    _dropImg.image = [UIImage imageNamed:@"downarrow1"];
    [_whiteView addSubview:_dropImg];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10 *SIZE , 60 *SIZE + NAVIGATION_BAR_HEIGHT, 100 *SIZE, 12 *SIZE)];
    label.textColor = YJContentLabColor;
    label.font = [UIFont systemFontOfSize:13 *SIZE];
    label.text = @"具体地址";
    [self.view addSubview:label];
    
    _detailTV = [[UITextView alloc] initWithFrame:CGRectMake(0, 85 *SIZE + NAVIGATION_BAR_HEIGHT, SCREEN_Width, 117 *SIZE)];
    _detailTV.contentInset = UIEdgeInsetsMake(13 *SIZE, 10 *SIZE, 13 *SIZE, 10 *SIZE);
    _detailTV.font = [UIFont systemFontOfSize:13 *SIZE];
    [self.view addSubview:_detailTV];
}

-(void)action_address
{
    AdressChooseView *view = [[AdressChooseView alloc]initWithFrame:self.view.frame withdata:@[]];
    [self.view addSubview:view];
    view.selectedBlock = ^(NSString *province, NSString *city, NSString *area, NSString *proviceid, NSString *cityid, NSString *areaid) {
        _addressL.text = [NSString stringWithFormat:@"%@/%@/%@",province,city,area];
//        _Customerinfomodel.province = proviceid;
//        _Customerinfomodel.city = cityid;
//        _Customerinfomodel.district = areaid;
    };
}

@end
