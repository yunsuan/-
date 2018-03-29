//
//  BrokerageDetailVC.m
//  云渠道
//
//  Created by 谷治墙 on 2018/3/29.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "BrokerageDetailVC.h"
#import "BrokerageDetailTableCell.h"
#import "BrokerageDetailTableCell2.h"
#import "BrokerageDetailTableCell3.h"
#import "BrokerageDetailTableCell4.h"
#import "BrokerDetailHeader.h"

@interface BrokerageDetailVC ()<UITableViewDelegate,UITableViewDataSource>
{
    
    BOOL _drop;
}

@property (nonatomic, strong) UITableView *brokerTable;

@end

@implementation BrokerageDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initUI];
    
}



#pragma mark -- Tableview
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section == 2) {
        
        if (!_drop) {
            
            return 6;
        }
        return 0;
    }
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    if (section == 2) {
        
        return 50 *SIZE;
    }
    return CGFLOAT_MIN;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 6 *SIZE;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    if (section == 2) {
        
        BrokerDetailHeader *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"BrokerDetailHeader"];
        if (!header) {
            
            header = [[BrokerDetailHeader alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width, 50 *SIZE)];
        }
        header.titleL.text = @"当前项目进度";
        header.dropBtnBlock = ^{
            
            _drop = !_drop;
            [tableView reloadData];
        };
        
        return header;
    }
    return [[UIView alloc] init];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        
        BrokerageDetailTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BrokerageDetailTableCell"];
        if (!cell) {
            
            cell = [[BrokerageDetailTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"BrokerageDetailTableCell"];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.titleL.text = @"推荐客户";
        cell.nameL.text = @"冷月英";
        cell.genderL.text = @"男";
        cell.phoneL.text = @"1231238123123";
        return cell;
    }else{
        
        if (indexPath.section == 1) {
            
            BrokerageDetailTableCell2 *cell = [tableView dequeueReusableCellWithIdentifier:@"BrokerageDetailTableCell2"];
            if (!cell) {
                
                cell = [[BrokerageDetailTableCell2 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"BrokerageDetailTableCell2"];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            cell.titleL.text = @"推荐项目";
            cell.codeL.text = @"推荐编号：TJBHNO1";
            cell.nameL.text = @"项目名称：凤凰国际";
            cell.houseTypeL.text = @"物业类型：住宅";
            cell.addressL.text = @"项目地址：郫都区德源镇大禹东路项目地址：郫都区德源镇大禹东路项目地址：郫都区德源镇大禹东路";
            cell.unitL.text = @"成交房号：1批次 - 1栋 -1单元 - 102";
            cell.contactL.text = @"置业顾问：张三";
            cell.brokerTypeL.text = @"佣金类型：成交佣金";
            cell.priceL.text = @"佣金金额：50000元";
            cell.timeL.text = @"成交时间：2018-02-10";
            cell.companyL.text = @"结算单位：云算平台";
            cell.endTimeL.text = @"结佣时间：2018-02-10";
            cell.statusImg.image = [UIImage imageNamed:@"seal_knot"];
            return cell;
        }else{
            
            if (indexPath.row == 5) {
                
                BrokerageDetailTableCell4 *cell = [tableView dequeueReusableCellWithIdentifier:@"BrokerageDetailTableCell4"];
                if (!cell) {
                    
                    cell = [[BrokerageDetailTableCell4 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"BrokerageDetailTableCell4"];
                }
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                return cell;
            }else{
                
                BrokerageDetailTableCell3 *cell = [tableView dequeueReusableCellWithIdentifier:@"BrokerageDetailTableCell3"];
                if (!cell) {
                    
                    cell = [[BrokerageDetailTableCell3 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"BrokerageDetailTableCell3"];
                }
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                
                cell.titleL.text = @"推荐  ——  推荐时间：2017-10-08 18:00";
                if (indexPath.row == 0) {
                    
                    cell.upLine.hidden = YES;
                }else{
                    
                    cell.upLine.hidden = NO;
                }
                if (indexPath.row == 4) {
                    
                    cell.downLine.hidden = YES;
                }else{
                    
                    cell.downLine.hidden = NO;
                }
                return cell;
            }
        }
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    return [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width, 6 *SIZE)];
}

- (void)initUI{
    
    self.navBackgroundView.hidden = NO;
    self.titleLabel.text = @"已结佣金详情";
    
    _brokerTable.rowHeight = 397 *SIZE;
    _brokerTable.estimatedRowHeight = UITableViewAutomaticDimension;
    
    _brokerTable = [[UITableView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, SCREEN_Width, SCREEN_Height - NAVIGATION_BAR_HEIGHT) style:UITableViewStyleGrouped];
    _brokerTable.backgroundColor = self.view.backgroundColor;
    _brokerTable.delegate = self;
    _brokerTable.dataSource = self;
    _brokerTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_brokerTable];
}

@end
