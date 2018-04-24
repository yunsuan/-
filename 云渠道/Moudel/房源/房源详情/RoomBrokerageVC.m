//
//  RoomBrokerageVC.m
//  云渠道
//
//  Created by 谷治墙 on 2018/4/17.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "RoomBrokerageVC.h"
#import "RoomBrokerageTableCell.h"
#import "RoomBrokerageTableCell2.h"
#import "RoomBrokerageTableHeader.h"

@interface RoomBrokerageVC ()<UITableViewDelegate,UITableViewDataSource>
{
    
    NSMutableArray *_dataArr;
    NSMutableArray *_selectArr;
}
@property (nonatomic, strong) UITableView *brokerageTable;

@end

@implementation RoomBrokerageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initDataSource];
    [self initUI];
}

- (void)initDataSource{
    
    _selectArr = [@[] mutableCopy];
    _dataArr = [@[] mutableCopy];
    _selectArr = [NSMutableArray arrayWithArray:@[@1,@0,@0]];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    if (section == 0) {
        
        return 0;
    }
    return 51 *SIZE;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if ([_selectArr[section] integerValue]) {
        
        return 1;
    }
    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    if (section == 0) {
        
        return nil;
    }
    RoomBrokerageTableHeader *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"RoomBrokerageTableHeader"];
    if (!header) {
        
        header = [[RoomBrokerageTableHeader alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width, 51 *SIZE)];
    }
    header.titleL.text = @"2017-07-11至2017-08-10";
    header.dropBtn.tag = section;
    if ([_selectArr[section] integerValue]) {
        
        [header.dropBtn setImage:[UIImage imageNamed:@"uparrow"] forState:UIControlStateNormal];
    }else{
        
        [header.dropBtn setImage:[UIImage imageNamed:@"downarrow"] forState:UIControlStateNormal];
    }
    header.dropBtnBlock = ^(NSInteger index) {
        
        if ([_selectArr[index] integerValue]) {
            
            [_selectArr replaceObjectAtIndex:index withObject:@0];
        }else{
            
            [_selectArr replaceObjectAtIndex:index withObject:@1];
        }
        [tableView reloadData];
    };
    
    return header;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        
        RoomBrokerageTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RoomBrokerageTableCell"];
        if (!cell) {
            
            cell = [[RoomBrokerageTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"RoomBrokerageTableCell"];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.ruleView.titleImg.image = [UIImage imageNamed:@"rules"];
        cell.ruleView.titleL.text = @"佣金规则";
        cell.ruleView.contentL.text = @"1.推荐后，60分钟内等信息被确认有效，收到腿间有效信息后7日内结佣;\n\n2.自行7日内带看客户，填写到访确认单，收到到访有效信息后7日内结佣;\n\n3.客户30日内签订合同，收到成交信息后7日内结佣;";
        cell.standView.titleImg.image = [UIImage imageNamed:@"commission4"];
        cell.standView.titleL.text = @"结佣标准";
        cell.standView.contentL.text = @"结佣佣金：1000元\n\n到访佣金：售价X2%\n\n成交佣金：住宅 面积X100m2                             别墅 面积X100m2";
        
        return cell;
    }else{
        
        RoomBrokerageTableCell2 *cell = [tableView dequeueReusableCellWithIdentifier:@"RoomBrokerageTableCell2"];
        if (!cell) {
            
            cell = [[RoomBrokerageTableCell2 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"RoomBrokerageTableCell2"];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.ruleView.titleImg.image = [UIImage imageNamed:@"rules"];
        cell.ruleView.titleL.text = @"佣金规则";
        cell.ruleView.contentL.text = @"1.推荐后，60分钟内等信息被确认有效，收到腿间有效信息后7日内结佣;\n\n2.自行7日内带看客户，填写到访确认单，收到到访有效信息后7日内结佣;\n\n3.客户30日内签订合同，收到成交信息后7日内结佣;";
        cell.standView.titleImg.image = [UIImage imageNamed:@"commission4"];
        cell.standView.titleL.text = @"结佣标准";
        cell.standView.contentL.text = @"结佣佣金：1000元\n\n到访佣金：售价X2%\n\n成交佣金：住宅 面积X100m2                             别墅 面积X100m2";
        
        return cell;
    }
}

- (void)initUI{
    
    _brokerageTable.rowHeight = UITableViewAutomaticDimension;
    _brokerageTable.estimatedRowHeight = 214 *SIZE;
    
    _brokerageTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width, self.view.frame.size.height - NAVIGATION_BAR_HEIGHT - TAB_BAR_MORE) style:UITableViewStylePlain];
    _brokerageTable.backgroundColor = CH_COLOR_white;;
    _brokerageTable.delegate = self;
    _brokerageTable.dataSource = self;
    _brokerageTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_brokerageTable];
}



@end
