//
//  BrokerageRecordVC.m
//  云渠道
//
//  Created by xiaoq on 2018/3/21.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "BrokerageRecordVC.h"
#import "BrokerageCell.h"

@interface BrokerageRecordVC ()<UITableViewDelegate,UITableViewDataSource>
{
    NSArray *_arr;
}
@property (nonatomic , strong) UITableView *MainTableView;


-(void)initUI;
-(void)initDateSouce;

@end

@implementation BrokerageRecordVC
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = YJBackColor;
    self.navBackgroundView.hidden = NO;
    [self.leftButton addTarget:self action:@selector(action_back) forControlEvents:UIControlEventTouchUpInside];
    self.titleLabel.text = @"已结列表";
    [self initDateSouce];
    [self initUI];
    
}

-(void)initDateSouce
{
    _arr = @[@[@"学区房",@"投资房"],@[@"简单的",@"送礼物",@"欧美风"],@[@"简单的",@"送礼物",@"欧美风"]];
}

-(void)initUI
{
    
    [self.view addSubview:self.MainTableView];
}

-(void)action_back
{
    
}

#pragma mark  ---  delegate   ---

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 134*SIZE;
}



-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *CellIdentifier = @"BrokerageCell";
    
    BrokerageCell *cell  = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[BrokerageCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    cell.nameL.text = @"冷月英";
    cell.phoneL.text = @"18745564512";
    cell.unitL.text = @"云算公馆  1批次 - 1栋 -1单元 -102";
    cell.codeL.text = @"推荐编号：TJBHNO1";
    cell.typeL.text = @"类型：推荐佣金";
    cell.timeL.text = @"推荐时间：2018-02-10";
    cell.endTimeL.text = @"结佣时间：2018-02-10";
    cell.priceL.text = @"2800";
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case 0:
        {
            
        }
            break;
        case 1:
        {
            NSLog(@"");
        }
            
        default:
            break;
    }
}



#pragma mark  ---  懒加载   ---
-(UITableView *)MainTableView
{
    if(!_MainTableView)
    {
        _MainTableView =   [[UITableView alloc]initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, 360*SIZE, SCREEN_Height-NAVIGATION_BAR_HEIGHT) style:UITableViewStylePlain];
        _MainTableView.backgroundColor = YJBackColor;
        _MainTableView.delegate = self;
        _MainTableView.dataSource = self;
        //        _MainTableView.
        [_MainTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    }
    return _MainTableView;
}

@end
