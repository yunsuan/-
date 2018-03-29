//
//  MyBrokerageVC.m
//  云渠道
//
//  Created by 谷治墙 on 2018/3/29.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "MyBrokerageVC.h"
#import "BrokerageTableCell.h"
#import "BankCardListVC.h"
#import "UnpaidBrokerageVC.h"
#import "BrokerageRecordVC.h"
#import "IDcardAuthenticationVC.h"

@interface MyBrokerageVC ()<UITableViewDelegate,UITableViewDataSource>
{
    
    NSArray *_imageArr;
    NSArray *_titleArr;
}
@property (nonatomic, strong) UITableView *brokerTable;

@property (nonatomic, strong) UILabel *priceL;

@end

@implementation MyBrokerageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initDataSource];
    [self initUI];
}

- (void)initDataSource{
    
    _imageArr = @[@"id",@"totalcommission",@"bankcard"];
    _titleArr = @[@"身份证认证",@"累计佣金",@"银行卡"];
}


#pragma mark -- action

- (void)ActionTagBtn:(UIButton *)btn{
    
    switch (btn.tag) {
        case 0:
        {
            IDcardAuthenticationVC *nextVC = [[IDcardAuthenticationVC alloc] init];
            [self.navigationController pushViewController:nextVC animated:YES];
            break;
        }
        case 1:
        {
            break;
        }
        case 2:
        {
            BankCardListVC *nextVC = [[BankCardListVC alloc] init];
            [self.navigationController pushViewController:nextVC animated:YES];
            break;
        }
        default:
            break;
    }
}


#pragma mark -- tableview

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 146 *SIZE;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    BrokerageTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BrokerageTableCell"];
    if (!cell) {
        
        cell = [[BrokerageTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"BrokerageTableCell"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.numL.text = @"23";
    cell.priceL.text = @"￥2800";
    if (indexPath.row == 0) {
        
        cell.backImg.image = [UIImage imageNamed:@"bg_1-1"];
        
    }else{
        
        cell.backImg.image = [UIImage imageNamed:@"bg_2-1"];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
        
        UnpaidBrokerageVC *nextVC = [[UnpaidBrokerageVC alloc] init];
        [self.navigationController pushViewController:nextVC animated:YES];
    }else{
        
        BrokerageRecordVC *nextVC = [[BrokerageRecordVC alloc] init];
        [self.navigationController pushViewController:nextVC animated:YES];
    }
}


#pragma mark -- UI
- (void)initUI{
    
    self.navBackgroundView.hidden = NO;
    self.titleLabel.text = @"我的佣金";
    
    UIView *whiteView = [[UIView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, SCREEN_Width , 133 *SIZE)];
    whiteView.backgroundColor = CH_COLOR_white;
    [self.view addSubview:whiteView];
    
    for (int i = 0; i < 3; i++) {
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(34 *SIZE + i * 120 *SIZE, 17 *SIZE, 53 *SIZE, 53 *SIZE)];
        imageView.image = [UIImage imageNamed:_imageArr[i]];
        [whiteView addSubview:imageView];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(120 *SIZE * i, 88 *SIZE, 120 *SIZE, 11 *SIZE)];
        label.textColor = YJTitleLabColor;
        label.font = [UIFont systemFontOfSize:12 *SIZE];
        label.textAlignment = NSTextAlignmentCenter;
        label.text = _titleArr[i];
        [whiteView addSubview:label];
        
        if (i == 1) {
            
            _priceL = [[UILabel alloc] init];
            _priceL.frame = CGRectMake(120 *SIZE, 108 *SIZE, 120 *SIZE, 10 *SIZE);
            _priceL.font = [UIFont systemFontOfSize:12 *SIZE];
            _priceL.textColor = YJBlueBtnColor;
            _priceL.text = @"￥2300";
            _priceL.textAlignment = NSTextAlignmentCenter;
            [whiteView addSubview:_priceL];
        }
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(120 *SIZE * i, 0, 120 *SIZE, 120 *SIZE);
        btn.tag = i;
        [btn addTarget:self action:@selector(ActionTagBtn:) forControlEvents:UIControlEventTouchUpInside];
        [whiteView addSubview:btn];
    }
    
    _brokerTable = [[UITableView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT + 133 *SIZE, SCREEN_Width, SCREEN_Height - 133 *SIZE - NAVIGATION_BAR_HEIGHT) style:UITableViewStylePlain];
    _brokerTable.backgroundColor = self.view.backgroundColor;
    _brokerTable.delegate = self;
    _brokerTable.dataSource = self;
    _brokerTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    _brokerTable.bounces = NO;
    [self.view addSubview:_brokerTable];
}

@end
