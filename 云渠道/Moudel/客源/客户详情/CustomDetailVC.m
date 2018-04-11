//
//  CustomDetailVC.m
//  云渠道
//
//  Created by 谷治墙 on 2018/3/22.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "CustomDetailVC.h"
#import "CustomDetailTableCell.h"
#import "CustomDetailTableCell2.h"
#import "CustomDetailTableCell3.h"
#import "CustomTableHeader.h"
#import "CustomTableHeader2.h"
#import "CustomTableHeader3.h"
#import "CustomTableHeader4.h"
#import "AddRequireMentVC.h"
#import "FollowRecordVC.h"
#import "AddCustomerVC.h"

@interface CustomDetailVC ()<UITableViewDelegate,UITableViewDataSource,CustomTableHeaderDelegate,CustomTableHeader2Delegate,CustomTableHeader3Delegate>
{
    
    NSArray *_arr;
    NSInteger _item;
    NSMutableArray *_showArr;
}
@property (nonatomic, strong) UITableView *customDetailTable;

@end

@implementation CustomDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initDataSource];
    [self initUI];
}

- (void)initDataSource{
    
    _showArr = [@[] mutableCopy];
    for ( int i = 0; i < 3; i++) {
        
        [_showArr addObject:@1];
    }
    _arr = @[@[@[@"住宅",@"写字楼",@"商铺",@"别墅",@"公寓"],@[@"学区房",@"投资房"]],@[@[@"住宅",@"写字楼",@"商铺",@"别墅",@"公寓"],@[@"学区dd房",@"投资房"]],@[@[@"住宅",@"写字楼",@"商铺",@"别墅",@"公寓"],@[@"学区房",@"投资房的"]]];
}

- (void)head1collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    _item = indexPath.item;
    [_customDetailTable reloadData];
    NSLog(@"%@",indexPath);
}

- (void)head2collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    _item = indexPath.item;
    [_customDetailTable reloadData];
    NSLog(@"%@",indexPath);
}

- (void)DGActionAddBtn:(UIButton *)btn{
    
    AddRequireMentVC *nextVC = [[AddRequireMentVC alloc] init];
    [self.navigationController pushViewController:nextVC animated:YES];
}

- (void)DG2ActionAddBtn:(UIButton *)btn{
    
    FollowRecordVC *nextVC = [[FollowRecordVC alloc] init];
    [self.navigationController pushViewController:nextVC animated:YES];
}

- (void)DGActionEditBtn:(UIButton *)btn{
    
    NSLog(@"%ld",_item);
    CustomerModel *model = [[CustomerModel alloc] init];
    AddCustomerVC *nextVC = [[AddCustomerVC alloc] initWithModel:model];
    [self.navigationController pushViewController:nextVC animated:YES];
}


- (void)head3collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    _item = indexPath.item;
    [_customDetailTable reloadData];
    NSLog(@"%@",indexPath);
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    if (_item == 0) {
        
        return 3;
    }
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (_item == 0) {
        
        if (section == 0) {
            
            return 0;
        }else{
            
            if ([_showArr[section] integerValue] == 1) {
                
                return 1;
            }else{
                
                return 0;
            }
        }
        
    }
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    if (!_item) {
        
        if (section == 0) {
            
            return 407 *SIZE;
        }
        return 40 *SIZE;
    }else{
        
        if (_item == 1) {
            
            return 417 *SIZE;
        }else{
            
            return 435 *SIZE;
        }
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return CGFLOAT_MIN;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    return [[UIView alloc] init];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    if (!_item) {
        
        if (section == 0) {
            
            CustomTableHeader *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"CustomTableHeader"];
            if (!header) {
                
                header = [[CustomTableHeader alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width, 368 *SIZE)];
                header.delegate = self;
                [header.headerColl selectItemAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:0] animated:YES scrollPosition:UICollectionViewScrollPositionNone];
            }
            header.nameL.text = @"姓名：张三";
            header.genderL.text = @"性别：男";
            header.birthL.text = @"出生年月：1994-12-12";
            header.phoneL.text = @"联系电话：18745564523";
            header.phone2L.text = @"联系电话：15983804766";
            header.certL.text = @"证件类型：身份证";
            header.numL.text = @"证件号：510623187876891234";
            header.addressL.text = @"地址：四川 - 成都 - 郫都区 - 大禹东路108号";
            
            return header;
        }
        CustomTableHeader4 *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"CustomTableHeader4"];
        if (!header) {
            
            header = [[CustomTableHeader4 alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width, 40 *SIZE)];
            
        }
        header.typeL.text = @"物业类型：住宅";
        header.showBtn.tag = section;
        header.showBtnBlock = ^(NSInteger index) {
          
            if ([_showArr[index] integerValue] == 1) {
                
                [_showArr replaceObjectAtIndex:index withObject:@0];
            }else{
                
                [_showArr replaceObjectAtIndex:index withObject:@1];
            }
            [tableView reloadSections:[NSIndexSet indexSetWithIndex:index] withRowAnimation:UITableViewRowAnimationNone];
        };
        return header;
    }else{
        
        if (_item == 1) {
            
            CustomTableHeader2 *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"CustomTableHeader2"];
            if (!header) {
                
                header = [[CustomTableHeader2 alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width, 418 *SIZE)];
                header.delegate = self;
                [header.headerColl selectItemAtIndexPath:[NSIndexPath indexPathForItem:1 inSection:0] animated:YES scrollPosition:UICollectionViewScrollPositionNone];
            }
            header.nameL.text = @"姓名：张三";
            header.genderL.text = @"性别：男";
            header.birthL.text = @"出生年月：1994-12-12";
            header.phoneL.text = @"联系电话：18745564523";
            header.phone2L.text = @"联系电话：15983804766";
            header.certL.text = @"证件类型：身份证";
            header.numL.text = @"证件号：510623187876891234";
            header.addressL.text = @"地址：四川 - 成都 - 郫都区 - 大禹东路108号";
            
            return header;
        }else{
            
            CustomTableHeader3 *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"CustomTableHeader3"];
            if (!header) {
                
                header = [[CustomTableHeader3 alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width, 435 *SIZE)];
                header.delegate = self;
                [header.headerColl selectItemAtIndexPath:[NSIndexPath indexPathForItem:2 inSection:0] animated:YES scrollPosition:UICollectionViewScrollPositionNone];
            }
            header.nameL.text = @"姓名：张三";
            header.genderL.text = @"性别：男";
            header.birthL.text = @"出生年月：1994-12-12";
            header.phoneL.text = @"联系电话：18745564523";
            header.phone2L.text = @"联系电话：15983804766";
            header.certL.text = @"证件类型：身份证";
            header.numL.text = @"证件号：510623187876891234";
            header.addressL.text = @"地址：四川 - 成都 - 郫都区 - 大禹东路108号";
            
            header.numListL.text = @"匹配项目列表(3)";
            header.recommendListL.text = @"已推荐项目数(2)";
            
            return header;
        }
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (_item == 0) {
        
        NSString * Identifier = @"CustomDetailTableCell";
        CustomDetailTableCell *cell = [tableView dequeueReusableCellWithIdentifier:Identifier];
        if (!cell) {
            
            cell = [[CustomDetailTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Identifier];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.cellView.tag = indexPath.row;
        cell.cellView.editBlock = ^(NSInteger index) {
            
            
//            AddRequireMentVC *nextVC = [[AddRequireMentVC alloc] initWithCustomRequireModel:<#(CustomRequireModel *)#>];
//            [self.navigationController pushViewController:nextVC animated:YES];
        };
        
        cell.cellView.deleteBtnBlock = ^(NSInteger index) {
            
            
        };
        
        cell.cellView.addressL.text = @"区域：成都 - 郫都区   成都 -高新区";
        cell.cellView.priceL.text = @"总价：80万-100万";
        cell.cellView.areaL.text = @"面积：80㎡-120㎡";
        cell.cellView.houseTypeL.text = @"房型：三室一厅一卫、两室一厅一卫";
        cell.cellView.faceL.text = @"朝向：西南";
        cell.cellView.floorL.text = @"楼层：6层-12层";
        cell.cellView.standardL.text = @"装修标准：毛胚、简装";
        cell.cellView.purposeL.text = @"置业目的：安家置业";
        cell.cellView.payWayL.text = @"付款方式：全款";
        cell.cellView.intentionL.text = @"购房意向度：45";
        cell.cellView.urgentL.text = @"购房紧迫度：45";
        cell.requireL.text = @"不要顶层和底层，希望小区绿化较好。不要顶层和底层，希望小区绿化较好。不要顶层和底层，希望小区绿化较好。不要顶层和底层，希望小区绿化较好。不要顶层和底层，希望小区绿化较好。不要顶层和底层，希望小区绿化较好。不要顶层和底层，希望小区绿化较好。不要顶层和底层，希望小区绿化较好。";
        
        return cell;
    }else{
        
        if (_item == 1) {
            
            NSString * Identifier = @"CustomDetailTableCell2";
            CustomDetailTableCell2 *cell = [tableView dequeueReusableCellWithIdentifier:Identifier];
            if (!cell) {
                
                cell = [[CustomDetailTableCell2 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Identifier];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.wayL.text = @"跟进方式:电话跟进";
            cell.intentionL.text = @"购买意向度：45";
            cell.urgentL.text = @"购买意向度：45";
            cell.contentL.text = @"12月12日带客户看了样板间，客户表示比较满意，后期会继续跟进。12月12日带客户看了样板间，客户表示比较满意，后期会继续跟进。12月12日带客户看了样板间，客户表示比较满意，后期会继续跟进。";
            cell.timeL.text = @"跟进时间：2017-12-15";
            
            return cell;
        }else{
            
            NSString * Identifier = @"CustomDetailTableCell3";
            CustomDetailTableCell3 *cell = [tableView dequeueReusableCellWithIdentifier:Identifier];
            if (!cell) {
                
                cell = [[CustomDetailTableCell3 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Identifier];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            [cell settagviewWithdata:_arr[indexPath.row]];
            cell.headImg.backgroundColor = YJGreenColor;
            cell.titleL.text = @"新希望国际大厦";
            cell.rateL.text = @"匹配度：80%";
            cell.addressL.text = @"高新区-天府三街";
            
            return cell;
        }
    }
}


- (void)initUI{
    
    self.navBackgroundView.hidden = NO;
    self.titleLabel.text = @"客户详情";

    _customDetailTable.estimatedRowHeight = 174 *SIZE;
    _customDetailTable.rowHeight = UITableViewAutomaticDimension;
    
    _customDetailTable = [[UITableView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, SCREEN_Width, SCREEN_Height - NAVIGATION_BAR_HEIGHT - TAB_BAR_MORE) style:UITableViewStyleGrouped];
    _customDetailTable.backgroundColor = YJBackColor;
    _customDetailTable.delegate = self;
    _customDetailTable.dataSource = self;
    _customDetailTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_customDetailTable];
}


@end
