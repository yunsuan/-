//
//  HouseTypeDetailVC.m
//  云渠道
//
//  Created by 谷治墙 on 2018/4/4.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "HouseTypeDetailVC.h"
#import "RoomDetailTableCell5.h"
#import "HouseTypeTableCell.h"
#import "HouseTypeTableCell2.h"
#import "HouseTypeDetailVC.h"
#import "HouseTypeTableHeader.h"
#import "HouseTypeTableHeader2.h"
#import "BuildingAlbumVC.h"

@interface HouseTypeDetailVC ()<UITableViewDelegate,UITableViewDataSource>
{
    
    NSString *_houseTypeId;
    NSMutableDictionary *_baseInfoDic;
    NSMutableArray *_imgArr;
    NSMutableArray *_houseArr;
}
@property (nonatomic, strong) UIButton *recommendBtn;

@property (nonatomic, strong) UITableView *houseTable;

@end

@implementation HouseTypeDetailVC

- (instancetype)initWithHouseTypeId:(NSString *)houseTypeId index:(NSInteger)index dataArr:(NSArray *)dataArr
{
    self = [super init];
    if (self) {
        
        _houseTypeId = houseTypeId;
        _imgArr = [@[] mutableCopy];
        self.dataArr = [NSMutableArray arrayWithArray:dataArr];
        _houseArr = [NSMutableArray arrayWithArray:self.dataArr];
        [_houseArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            if ([[NSString stringWithFormat:@"%@",obj[@"id"]] isEqualToString:houseTypeId]) {
                
                [_houseArr removeObjectAtIndex:idx];
                *stop = YES;
            }
        }];
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:YES]; //设置隐藏
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self initUI];
    [self RequestMethod];
}

- (void)RequestMethod{
    
    [BaseRequest GET:HouseTypeDetail_URL parameters:@{@"id":_houseTypeId} success:^(id resposeObject) {
        
        NSLog(@"%@",resposeObject);
        if ([resposeObject[@"code"] integerValue] == 200) {
            
            if (![resposeObject[@"data"] isKindOfClass:[NSNull class]]) {
                
                [self SetData:resposeObject[@"data"]];
            }else{
                
                [self showContent:@"暂无信息"];
            }
        }
    } failure:^(NSError *error) {
        
        NSLog(@"%@",error);
        [self showContent:@"网络错误"];
    }];
}

- (void)SetData:(NSDictionary *)data{
    
    if ([data[@"baseInfo"] isKindOfClass:[NSDictionary class]]) {
        
        _baseInfoDic = [NSMutableDictionary dictionaryWithDictionary:data[@"baseInfo"]];
        [_baseInfoDic enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
           
            if ([obj isKindOfClass:[NSNull class]]) {
                
                [_baseInfoDic setObject:@"" forKey:key];
            }
        }];
    }
    
    if ([data[@"imgInfo"] isKindOfClass:[NSArray class]]) {
        
        NSArray *arr = data[@"imgInfo"];
        for ( int i = 0; i < arr.count; i++) {
            
            if ([arr[i] isKindOfClass:[NSDictionary class]]) {
                
                NSMutableDictionary *tempDic = [[NSMutableDictionary alloc] initWithDictionary:arr[i]];
                
                [_imgArr addObject:tempDic];
            }
        }
    }
    
    [_houseTable reloadData];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 8 *SIZE;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    if (section == 0) {
        
        return 366 *SIZE;
    }
    return 33 *SIZE;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    if (section == 0) {
        
        HouseTypeTableHeader *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"HouseTypeTableHeader"];
        if (!header) {
            
            header = [[HouseTypeTableHeader alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width, 366 *SIZE)];
        }
        header.imgArr = [NSMutableArray arrayWithArray:_imgArr];
        
        return header;
    }else{
        
        HouseTypeTableHeader2 *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"HouseTypeTableHeader2"];
        if (!header) {
            
            header = [[HouseTypeTableHeader2 alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width, 33 *SIZE)];
        }
        if (section == 1) {
            
            header.titleL.font = [UIFont systemFontOfSize:15 *SIZE];
            header.titleL.text = @"本楼盘其他户型";
        }else{
            
            header.titleL.font = [UIFont systemFontOfSize:13 *SIZE];
            header.titleL.text = @"匹配的客户(23)";
        }
        return header;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        
        HouseTypeTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HouseTypeTableCell"];
        if (!cell) {
            
            cell = [[HouseTypeTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"HouseTypeTableCell"];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.typeL.text = _baseInfoDic[@"house_type_name"];
        cell.areaL.text = [NSString stringWithFormat:@"建筑面积：%@㎡-%@㎡",_baseInfoDic[@"property_area_min"],_baseInfoDic[@"property_area_max"]];
        cell.houseDisL.text = @"户型分布：1栋、3栋";
        cell.titleL.text = @"户型卖点";
        cell.contentL.text = _baseInfoDic[@"sell_point"];
        
        return cell;
    }else{
        if (indexPath.section == 1) {
            
            HouseTypeTableCell2 *cell = [tableView dequeueReusableCellWithIdentifier:@"HouseTypeTableCell2"];
            if (!cell) {
                
                cell = [[HouseTypeTableCell2 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"HouseTypeTableCell2"];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.num = _houseArr.count;
            if (_houseArr.count) {
                
                cell.dataArr = [NSMutableArray arrayWithArray:_houseArr];
                [cell.cellColl reloadData];
            }
            cell.collCellBlock = ^(NSInteger index) {
              
                HouseTypeDetailVC *nextVC = [[HouseTypeDetailVC alloc] initWithHouseTypeId:[NSString stringWithFormat:@"%@",_houseArr[index][@"id"]] index:index dataArr:self.dataArr];
//                nextVC.dataArr = _houseArr;
                [self.navigationController pushViewController:nextVC animated:YES];
            };
            
            return cell;
        }else{
            
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
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    return [[UIView alloc] init];
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
    
//    _houseTable.estimatedRowHeight = 172 *SIZE;
//    _houseTable.rowHeight = UITableViewAutomaticDimension;
    _houseTable = [[UITableView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, SCREEN_Width, SCREEN_Height - NAVIGATION_BAR_HEIGHT) style:UITableViewStyleGrouped];
    _houseTable.backgroundColor = self.view.backgroundColor;
    _houseTable.delegate = self;
    _houseTable.dataSource = self;
    _houseTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_houseTable];
    
}
@end
