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
@property (nonatomic , strong) DropDownBtn *brith;


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
//    backview.backgroundColor = [UIColor whiteColor];
    UIView * header = [[UIView alloc]initWithFrame:CGRectMake(10*SIZE , 19*SIZE, 6.7*SIZE, 13.3*SIZE)];
    header.backgroundColor = YJBlueBtnColor;
    [backview addSubview:header];
    UILabel * title = [[UILabel alloc]initWithFrame:CGRectMake(27.3*SIZE, 19*SIZE, 300*SIZE, 16*SIZE)];
    title.font = [UIFont systemFontOfSize:15.3*SIZE];
    title.textColor = YJTitleLabColor;
    title.text = @"客户信息";
    [backview addSubview:title];
    [self.scrollview addSubview:backview];
    UILabel *namelab = [[UILabel alloc]initWithFrame:CGRectMake(10*SIZE, 56.3*SIZE, 100*SIZE, 14*SIZE)];
    namelab.text = @"姓名:";
    namelab.font = [UIFont systemFontOfSize:13.3*SIZE];
    namelab.textColor = YJTitleLabColor;
    [self.scrollview addSubview:namelab];
    _name = [[BorderTF alloc]initWithFrame:CGRectMake(80.3*SIZE, 46*SIZE, 116.7*SIZE, 33.3*SIZE)];
    [self.scrollview addSubview:_name];
    UILabel *sexlab = [[UILabel alloc]initWithFrame:CGRectMake(208.7*SIZE, 56.3*SIZE, 100*SIZE, 14*SIZE)];
    sexlab.text = @"性别:";
    sexlab.font = [UIFont systemFontOfSize:13.3*SIZE];
    sexlab.textColor = YJTitleLabColor;
    [self.scrollview addSubview:sexlab];
    _sex = [[DropDownBtn alloc]initWithFrame:CGRectMake(251.3*SIZE, 46*SIZE, 86.7*SIZE, 33.3*SIZE)];
    [_sex addTarget:self action:@selector(action_sex) forControlEvents:UIControlEventTouchUpInside];
    [self.scrollview addSubview:_sex];
    UILabel *brithlab = [[UILabel alloc]initWithFrame:CGRectMake(10*SIZE, 108.7*SIZE, 100*SIZE, 14*SIZE)];
    brithlab.text = @"性别:";
    brithlab.font = [UIFont systemFontOfSize:13.3*SIZE];
    brithlab.textColor = YJTitleLabColor;
    [self.scrollview addSubview:brithlab];
    _brith = [[DropDownBtn alloc]initWithFrame:CGRectMake(80.3*SIZE, 98.3*SIZE, 257.7*SIZE, 33.3*SIZE)];
    [_brith addTarget:self action:@selector(action_brith) forControlEvents:UIControlEventTouchUpInside];
    [self.scrollview addSubview:_brith];
    
}


-(void)action_sex
{
    SinglePickView *view = [[SinglePickView alloc]initWithFrame:self.view.frame WithData:@[@{@"MC":@"男",
                                                                                             @"ID":@"1"
                                                                                             },@{@"MC":@"女",
                                                                                                 @"ID":@"2"
                                                                                                 }]];
    
    view.selectedBlock = ^(NSString *MC, NSString *ID) {
        _sex.content.text = MC;
    };
    [self.view addSubview:view];
}

-(void)action_brith
{
    UIDatePicker *myDatePicker = [[UIDatePicker alloc]initWithFrame:CGRectMake(0, SCREEN_Height-300, [UIScreen mainScreen].bounds.size.width, 300)];
    myDatePicker.datePickerMode = UIDatePickerModeDate;
    // 设置日期选择控件的地区
    [myDatePicker setLocale:[[NSLocale alloc]initWithLocaleIdentifier:@"zh_Hans_CN"]];
    //默认为当天。
    [myDatePicker setCalendar:[NSCalendar currentCalendar]];
    

    [self.view addSubview:myDatePicker];

}

-(UIScrollView *)scrollview
{
    if (!_scrollview) {
        _scrollview = [[UIScrollView alloc]initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, 360*SIZE,SCREEN_Height - NAVIGATION_BAR_HEIGHT)];
        _scrollview.contentSize = CGSizeMake(360*SIZE, 500*SIZE);
        _scrollview.backgroundColor = [UIColor whiteColor];
    }
    return _scrollview;
}



@end
