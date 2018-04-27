//
//  HouseSearchVC.m
//  云渠道
//
//  Created by 谷治墙 on 2018/4/10.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "HouseSearchVC.h"
#import "CompanyCell.h"
#import "PeopleCell.h"
#import "RoomDetailVC.h"
#import "RoomListModel.h"

@interface HouseSearchVC ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
{
    
    NSInteger _page;
    NSArray *_arr;
    NSMutableArray *_dataArr;
    NSString *_city;
}
@property (nonatomic , strong) UITableView *searchTable;

@end

@implementation HouseSearchVC

- (instancetype)initWithTitle:(NSString *)str city:(NSString *)city
{
    self = [super init];
    if (self) {
        
        self.title = str;
        _city = city;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _page = 1;
    _dataArr = [@[] mutableCopy];
//    _arr = @[@[@[@"住宅",@"写字楼",@"商铺",@"别墅",@"公寓"],@[@"学区房",@"投资房"]],@[@[@"住宅",@"写字楼",@"商铺",@"别墅",@"公寓"],@[@"学区dd房",@"投资房"]],@[@[@"住宅",@"写字楼",@"商铺",@"别墅",@"公寓"],@[@"学区房",@"投资房的"]]];
    [self initUI];
    [self RequestMethod];
}

- (void)RequestMethod{
    
    if (_page == 1) {
        
        [_dataArr removeAllObjects];
        self.searchTable.mj_footer.state = MJRefreshStateIdle;
    }
    
   
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithDictionary:@{@"page":@(_page),@"city":_city}];
    
    if (self.title.length) {
        
        [dic setObject:self.title forKey:@"project_name"];
    }
    
    [BaseRequest GET:ProjectList_URL parameters:dic success:^(id resposeObject) {
        
        [self.searchTable.mj_header endRefreshing];
        NSLog(@"%@",resposeObject);
        [self showContent:resposeObject[@"msg"]];
        if ([resposeObject[@"code"] integerValue] == 200) {
            
            if ([resposeObject[@"data"] isKindOfClass:[NSDictionary class]]) {
                
                if ([resposeObject[@"data"][@"data"] isKindOfClass:[NSArray class]]) {
                    
                    [self SetData:resposeObject[@"data"][@"data"]];
                    if (_page == [resposeObject[@"data"][@"last_page"] integerValue]) {
                        
                        self.searchTable.mj_footer.state = MJRefreshStateNoMoreData;
                    }
                }else{
                    
//                    [self showContent:@"暂无数据"];
                }
            }else{
                
//                [self showContent:resposeObject[@"msg"]];
            }
        }else{
            
            
        }
    } failure:^(NSError *error) {
        
        [self.searchTable.mj_header endRefreshing];
        [self.searchTable.mj_footer endRefreshing];
        NSLog(@"%@",error.localizedDescription);
    }];
    
}

- (void)SetData:(NSArray *)data{
    
    for (int i = 0; i < data.count; i++) {
        
        NSMutableDictionary *tempDic = [[NSMutableDictionary alloc] initWithDictionary:data[i]];
        [tempDic enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
            
            if ([obj isKindOfClass:[NSNull class]]) {
                
                [tempDic setObject:@"" forKey:key];
            }
        }];
        
        RoomListModel *model = [[RoomListModel alloc] initWithDictionary:tempDic];
        
        [_dataArr addObject:model];
    }
    
    [_searchTable reloadData];
}


#pragma mark  ---  delegate   ---

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArr.count;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 120*SIZE;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *CellIdentifier = @"PeopleCell";
    
    PeopleCell *cell  = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[PeopleCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    RoomListModel *model = _dataArr[indexPath.row];
    [cell SetTitle:model.project_name image:model.img_url contentlab:@"高新区——天府三街" statu:model.sale_state];
    
    
    NSMutableArray *tempArr = [@[] mutableCopy];
    for (int i = 0; i < model.property_tags.count; i++) {
        
        [[self getDetailConfigArrByConfigState:PROPERTY_TYPE] enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            if ([obj[@"id"] integerValue] == [model.property_tags[i] integerValue]) {
                
                [tempArr addObject:obj[@"param"]];
                *stop = YES;
            }
        }];
    }
    
    NSArray *tempArr1 = [model.project_tags componentsSeparatedByString:@","];
    NSMutableArray *tempArr2 = [@[] mutableCopy];
    for (int i = 0; i < tempArr1.count; i++) {
        
        [[self getDetailConfigArrByConfigState:PROJECT_TAGS_DEFAULT] enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            if ([obj[@"id"] integerValue] == [tempArr1[i] integerValue]) {
                
                [tempArr2 addObject:obj[@"param"]];
                *stop = YES;
            }
        }];
    }
    NSArray *tempArr3 = @[tempArr,tempArr2.count == 0 ? @[]:tempArr2];
    [cell settagviewWithdata:tempArr3];
    [cell.getLevel SetImage:[UIImage imageNamed:@"lightning_1"] selectImg:[UIImage imageNamed:@"lightning"] num:3];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    RoomDetailVC *nextVC = [[RoomDetailVC alloc] init];
    nextVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:nextVC animated:YES];
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

- (void)initUI{
    
    _searchTable = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, 360*SIZE, SCREEN_Height - STATUS_BAR_HEIGHT) style:UITableViewStylePlain];
    _searchTable.backgroundColor = YJBackColor;
    _searchTable.delegate = self;
    _searchTable.dataSource = self;
    [_searchTable setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.view addSubview:_searchTable];
}

@end
