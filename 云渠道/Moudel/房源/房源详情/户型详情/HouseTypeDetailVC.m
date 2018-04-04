//
//  HouseTypeDetailVC.m
//  云渠道
//
//  Created by 谷治墙 on 2018/4/4.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "HouseTypeDetailVC.h"
#import "RoomDetailTableCell5.h"

@interface HouseTypeDetailVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UIButton *recommendBtn;

@property (nonatomic, strong) UITableView *houseTable;

@end

@implementation HouseTypeDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [self initDataSource];
    [self initUI];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    RoomDetailTableCell5 *cell = [tableView dequeueReusableCellWithIdentifier:@"RoomDetailTableCell5"];
    if (!cell) {
        
        cell = [[RoomDetailTableCell5 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"RoomDetailTableCell5"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.nameL.text = @"张三";
    cell.priceL.text = @"80 - 100";
    cell.typeL.text = @"三室一厅";
    cell.areaL.text = @"郫都区-德源大道";
    cell.intentionRateL.text = @"23";
    cell.urgentRateL.text = @"43";
    cell.matchRateL.text = @"83";
    cell.phoneL.text = @"13438339177";
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
}



- (void)initUI{
    
    self.navBackgroundView.hidden = NO;
    self.titleLabel.text = @"户型详情";
    self.line.hidden = YES;
    
    _recommendBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _recommendBtn.frame = CGRectMake(SCREEN_Width - 35, STATUS_BAR_HEIGHT + 8, 24, 24);
    //    [_recommendBtn setBackgroundColor:YJBlueBtnColor];
    //    [_recommendBtn addTarget:self action:@selector(<#selector#>) forControlEvents:UIControlEventTouchUpInside];
    [_recommendBtn setBackgroundImage:[UIImage imageNamed:@"share"] forState:UIControlStateNormal];
    [self.view addSubview:self.recommendBtn];
    [self.recommendBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.leftButton);
        make.right.equalTo(self.navBackgroundView).offset(- 8 *SIZE);
        make.size.mas_offset(CGSizeMake(22, 22));
    }];
    
    _houseTable = [[UITableView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, SCREEN_Width, SCREEN_Height - NAVIGATION_BAR_HEIGHT) style:UITableViewStyleGrouped];
    _houseTable.backgroundColor = self.view.backgroundColor;
    _houseTable.delegate = self;
    _houseTable.dataSource = self;
    _houseTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_houseTable];
    
}
@end
