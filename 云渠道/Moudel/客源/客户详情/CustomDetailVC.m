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
    NSString *_clientId;
    
    CustomerModel *_customModel;//客户信息
    NSMutableArray *_dataArr;//需求信息
}
@property (nonatomic, strong) UITableView *customDetailTable;

@end

@implementation CustomDetailVC

- (instancetype)initWithClientId:(NSString *)clientId
{
    self = [super init];
    if (self) {
        
        _clientId = clientId;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initDataSource];
    [self initUI];
}

- (void)initDataSource{
    
    _customModel = [[CustomerModel alloc] init];
    _dataArr = [@[] mutableCopy];
    _arr = @[@[@[@"住宅",@"写字楼",@"商铺",@"别墅",@"公寓"],@[@"学区房",@"投资房"]],@[@[@"住宅",@"写字楼",@"商铺",@"别墅",@"公寓"],@[@"学区dd房",@"投资房"]],@[@[@"住宅",@"写字楼",@"商铺",@"别墅",@"公寓"],@[@"学区房",@"投资房的"]]];
    [self RequestMethod];
}

- (void)RequestMethod{
    
    [BaseRequest GET:GetCliendInfo_URL parameters:@{@"client_id":_clientId} success:^(id resposeObject) {
        
        NSLog(@"%@",resposeObject);
        if ([resposeObject[@"code"] integerValue] == 200) {
            
            if ([resposeObject[@"data"] isKindOfClass:[NSDictionary class]]) {
                
                if ([resposeObject[@"data"][@"basic"] isKindOfClass:[NSDictionary class]]) {
                    
                    [self setCustomModel:resposeObject[@"data"][@"basic"]];
                }
                if ([resposeObject[@"data"][@"need_info"] isKindOfClass:[NSArray class]]) {
                    
                    [self setData:resposeObject[@"data"][@"need_info"]];
                }
                [_customDetailTable reloadData];
            }else{
                
                [self showContent:@"暂无客户信息"];
            }
        }else{
            
            [self showContent:resposeObject[@"msg"]];
        }
    } failure:^(NSError *error) {
       
        NSLog(@"%@",error);
    }];
}

- (void)setCustomModel:(NSDictionary *)dic{
    
    NSMutableDictionary *tempDic = [NSMutableDictionary dictionaryWithDictionary:dic];
    [tempDic enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
       
        if ([obj isKindOfClass:[NSNull class]]) {
            
            [tempDic setObject:@"" forKey:key];
        }
    }];
    _customModel = [[CustomerModel alloc] initWithDictionary:tempDic];
}

- (void)setData:(NSArray *)data{
    
    for (int i = 0; i < data.count; i++) {
        
        if ([data[i] isKindOfClass:[NSDictionary class]]) {
            
            NSMutableDictionary *tempDic = [NSMutableDictionary dictionaryWithDictionary:data[i]];
            [tempDic enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
                
                if ([obj isKindOfClass:[NSNull class]]) {
                    
                    [tempDic setObject:@"" forKey:key];
                }
            }];
            
            CustomRequireModel *model = [[CustomRequireModel alloc] initWithDictionary:tempDic];
            [_dataArr addObject:model];
        }
    }
}


#pragma mark -- TableDelegate
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

    AddCustomerVC *nextVC = [[AddCustomerVC alloc] initWithModel:_customModel];
    [self.navigationController pushViewController:nextVC animated:YES];
}


- (void)head3collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    _item = indexPath.item;
    [_customDetailTable reloadData];
    NSLog(@"%@",indexPath);
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    if (_item == 0) {
        
        return 1;
    }
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (_item == 0) {
        
        return _dataArr.count;
    }
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    if (!_item) {
        
        return 367 *SIZE;
    }else{
        
        if (_item == 1) {
            
            return 417 *SIZE;
        }else{
            
            return 485 *SIZE;
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
        
        CustomTableHeader *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"CustomTableHeader"];
        if (!header) {
            
            header = [[CustomTableHeader alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width, 368 *SIZE)];
            header.delegate = self;
            [header.headerColl selectItemAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:0] animated:YES scrollPosition:UICollectionViewScrollPositionNone];
        }
        header.model = _customModel;
        
        return header;
    }else{
        
        if (_item == 1) {
            
            CustomTableHeader2 *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"CustomTableHeader2"];
            if (!header) {
                
                header = [[CustomTableHeader2 alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width, 418 *SIZE)];
                header.delegate = self;
                [header.headerColl selectItemAtIndexPath:[NSIndexPath indexPathForItem:1 inSection:0] animated:YES scrollPosition:UICollectionViewScrollPositionNone];
            }

            header.model = _customModel;
            
            return header;
        }else{
            
            CustomTableHeader3 *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"CustomTableHeader3"];
            if (!header) {
                
                header = [[CustomTableHeader3 alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width, 485 *SIZE)];
                header.delegate = self;
                [header.headerColl selectItemAtIndexPath:[NSIndexPath indexPathForItem:2 inSection:0] animated:YES scrollPosition:UICollectionViewScrollPositionNone];
            }

            header.model = _customModel;
            
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
            
            
            AddRequireMentVC *nextVC = [[AddRequireMentVC alloc] initWithCustomRequireModel:_dataArr[index]];
            [self.navigationController pushViewController:nextVC animated:YES];
        };
        cell.model = _dataArr[indexPath.row];
        
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
