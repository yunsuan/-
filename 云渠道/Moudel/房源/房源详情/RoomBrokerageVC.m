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
    NSString *_projectId;
}
@property (nonatomic, strong) UITableView *brokerageTable;

@end

@implementation RoomBrokerageVC

- (instancetype)initWithProjectId:(NSString *)projectId
{
    self = [super init];
    if (self) {
        
        _projectId = projectId;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initDataSource];
    [self initUI];
    [self RequestMethod];
}

- (void)initDataSource{
    
    _selectArr = [@[] mutableCopy];
    _dataArr = [@[] mutableCopy];
    _selectArr = [NSMutableArray arrayWithArray:@[@1,@0,@0]];
}

- (void)RequestMethod{
    
    [BaseRequest GET:GetRule_URL parameters:@{@"project_id":_projectId} success:^(id resposeObject) {
        
        NSLog(@"%@",resposeObject);
        if ([resposeObject[@"code"] integerValue] == 200) {
            
            if ([resposeObject[@"data"][@"basic"] isKindOfClass:[NSArray class]]) {
                
                [self SetData:resposeObject[@"data"][@"basic"]];
            }
        }
    } failure:^(NSError *error) {
        
        NSLog(@"%@",error);
        [self showContent:@"网络错误"];
    }];
}

- (void)SetData:(NSArray *)data{
    
    _dataArr = [NSMutableArray arrayWithArray:data];
//    for (int i = 0; i < data.count; i++) {
//        
//        
//    }
    [_brokerageTable reloadData];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return _dataArr.count;
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
//    header.titleL.text = [NSString stringWithFormat:@"%@至%@",_dataArr[section][@"end_time"],_dataArr[section][@"begin_time"]];//@"2017-07-11至2017-08-10";
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
        
        cell.rankL.text = @"第5名";
        [cell.rankL mas_remakeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(cell.contentView).offset(114 *SIZE);
            make.height.equalTo(@(13 *SIZE));
            make.top.equalTo(cell.contentView).offset(50 *SIZE);
            make.width.equalTo(@(cell.rankL.mj_textWith + 5 *SIZE));
        }];
        cell.ruleView.titleImg.image = [UIImage imageNamed:@"rules"];
        cell.ruleView.titleL.text = @"佣金规则";
//        cell.ruleView.contentL.text = [NSString stringWithFormat:@"1.推荐后，%@分钟内等信息被确认有效，收到腿间有效信息后%@日内结佣;\n\n2.自行%@日内带看客户，填写到访确认单，收到到访有效信息后%@日内结佣;\n\n3.客户%@日内签订合同，收到成交信息后%@日内结佣",_dataArr[indexPath.section][@"visit_confirm_time"],_dataArr[indexPath.section][@"confirm_settle_commission_time"],_dataArr[indexPath.section][@"valid_visit_time"],_dataArr[indexPath.section][@"visit_settle_commission_time"],_dataArr[indexPath.section][@"make_bargain_time"],_dataArr[indexPath.section][@"region_settle_commission_time"]];
        cell.standView.titleImg.image = [UIImage imageNamed:@"commission4"];
        cell.standView.titleL.text = @"结佣标准";
        NSString *_str;
//        for (int i = 0; i < [_dataArr[indexPath.section][@"person"][@"broker"] count]; i++) {
//
//
//        }
        cell.standView.contentL.text = _str;
        
        return cell;
    }else{
        
        RoomBrokerageTableCell2 *cell = [tableView dequeueReusableCellWithIdentifier:@"RoomBrokerageTableCell2"];
        if (!cell) {
            
            cell = [[RoomBrokerageTableCell2 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"RoomBrokerageTableCell2"];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.ruleView.titleImg.image = [UIImage imageNamed:@"rules"];
        cell.ruleView.titleL.text = @"佣金规则";
//        cell.ruleView.contentL.text = [NSString stringWithFormat:@"1.推荐后，%@分钟内等信息被确认有效，收到腿间有效信息后%@日内结佣;\n\n2.自行%@日内带看客户，填写到访确认单，收到到访有效信息后%@日内结佣;\n\n3.客户%@日内签订合同，收到成交信息后%@日内结佣",_dataArr[indexPath.section][@"visit_confirm_time"],_dataArr[indexPath.section][@"confirm_settle_commission_time"],_dataArr[indexPath.section][@"valid_visit_time"],_dataArr[indexPath.section][@"visit_settle_commission_time"],_dataArr[indexPath.section][@"make_bargain_time"],_dataArr[indexPath.section][@"region_settle_commission_time"]];
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
