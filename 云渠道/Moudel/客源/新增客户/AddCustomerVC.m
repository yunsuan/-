//
//  AddCustomerVC.m
//  云渠道
//
//  Created by xiaoq on 2018/3/28.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "AddCustomerVC.h"
#import "SinglePickView.h"
#import "DropDownBtn.h"
#import "BorderTF.h"

@interface AddCustomerVC ()
@property (nonatomic , strong) UIScrollView *scrollview;
@property (nonatomic , strong) DropDownBtn *sex;
@property (nonatomic , strong) BorderTF *name;


-(void)initUI;
-(void)initDataSouce;
@end

@implementation AddCustomerVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navBackgroundView.hidden = NO;
    self.titleLabel.text = @"添加客户";
    [self initDataSouce];
    [self initUI];

}

-(void)initDataSouce
{
    
}

-(void)initUI
{
    
    [self.view addSubview:self.scrollview];
    UIView *backview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 360*SIZE, 53*SIZE)];
    backview.backgroundColor = [UIColor whiteColor];
    UIView * header = [[UIView alloc]initWithFrame:CGRectMake(10*SIZE , 19*SIZE, 6.7*SIZE, 13.3*SIZE)];
    header.backgroundColor = YJBlueBtnColor;
    [backview addSubview:header];
    UILabel * title = [[UILabel alloc]initWithFrame:CGRectMake(27.3*SIZE, 19*SIZE, 300*SIZE, 16*SIZE)];
    title.font = [UIFont systemFontOfSize:15.3*SIZE];
    title.textColor = YJTitleLabColor;
    title.text = @"客户信息";
    [backview addSubview:title];
    [self.scrollview addSubview:backview];
    _name = [[BorderTF alloc]initWithFrame:CGRectMake(80.3*SIZE, 46*SIZE, 116.7*SIZE, 33.3*SIZE)];
    [self.scrollview addSubview:_name];
    _sex = [[DropDownBtn alloc]initWithFrame:CGRectMake(251.3*SIZE, 46*SIZE, 86.7*SIZE, 33.3*SIZE)];
    [_sex addTarget:self action:@selector(action_sex) forControlEvents:UIControlEventTouchUpInside];
    [self.scrollview addSubview:_sex];
}


-(void)action_sex
{
    SinglePickView *view = [[SinglePickView alloc]initWithFrame:self.view.frame WithData:@[@{@"MC":@"男",
                                                                                             @"ID":@"1"
                                                                                             },@{@"MC":@"女",
                                                                                                 @"ID":@"2"
                                                                                                 }]];
    [self.view addSubview:view];
}

-(UIScrollView *)scrollview
{
    if (!_scrollview) {
        _scrollview = [[UIScrollView alloc]initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, 360*SIZE,SCREEN_Height - NAVIGATION_BAR_HEIGHT)];
        _scrollview.contentSize = CGSizeMake(360*SIZE, 500*SIZE);
    }
    return _scrollview;
}



@end
