//
//  AddCustomerVC.m
//  云渠道
//
//  Created by xiaoq on 2018/3/28.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "AddCustomerVC.h"
#import "SinglePickView.h"

@interface AddCustomerVC ()
@property (nonatomic , strong) UIScrollView *scrollview;

-(void)initUI;
-(void)initDataSouce;
@end

@implementation AddCustomerVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navBackgroundView.hidden = NO;
    self.titleLabel.text = @"添加客户";
    [self initUI];
    [self initDataSouce];
}

-(void)initUI
{
//    SinglePickView *view = [[SinglePickView alloc]initWithFrame:self.view.frame WithData:@[@{@"MC":@"男",
//                                                                                             @"ID":@"1"
//                                                                                             },@{@"MC":@"女",
//                                                                                                 @"ID":@"2"
//                                                                                                 }]];
//    [self.view addSubview:view];
}

-(void)initDataSouce
{
    
}


@end
