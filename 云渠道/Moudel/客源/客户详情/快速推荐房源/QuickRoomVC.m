//
//  QuickRoomVC.m
//  云渠道
//
//  Created by 谷治墙 on 2018/5/5.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "QuickRoomVC.h"
#import "RoomDetailVC1.h"
#import "CompanyCell.h"
#import "PeopleCell.h"
#import "BoxView.h"
#import "RoomCollCell.h"
#import "QuickSearchVC.h"
#import "PYSearchViewController.h"
#import "MoreView.h"
#import "RoomListModel.h"
#import "AdressChooseView.h"
#import "CustomDetailVC.h"

@interface QuickRoomVC ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,BMKLocationServiceDelegate,PYSearchViewControllerDelegate>
{
    CustomRequireModel *_model;
    NSArray *_arr;
    BOOL _upAndDown;
    NSInteger _page;
    NSMutableDictionary *_parameter;
    NSMutableArray *_dataArr;
    NSString *_provice;
    NSString *_city;
    NSString *_district;
    NSString *_price;
    NSString *_type;
    NSString *_more;
    NSString *_tag;
    NSString *_houseType;
    NSString *_status;
    NSMutableArray *_searchArr;
    BOOL _is1;
    BOOL _is2;
    BOOL _is3;
    BOOL _is4;
}

@property (nonatomic , strong) UITableView *MainTableView;

@property (nonatomic , strong) UIView *headerView;

@property (nonatomic, strong) UIButton *cityBtn;

@property (nonatomic, strong) UIView *searchBar;

@property (nonatomic, strong) UIButton *areaBtn;

@property (nonatomic, strong) UIButton *priceBtn;

@property (nonatomic, strong) UIButton *typeBtn;

@property (nonatomic, strong) UIButton *moreBtn;

@property (nonatomic, strong) UIButton *sortBtn;

@property (nonatomic, strong) BoxView *areaView;

@property (nonatomic, strong) BoxView *priceView;

@property (nonatomic, strong) BoxView *typeView;

@property (nonatomic, strong) UIImageView *upImg;

@property (nonatomic, strong) MoreView *moreView;

@end

@implementation QuickRoomVC

- (instancetype)initWithModel:(CustomRequireModel *)model
{
    self = [super init];
    if (self) {
        
        _city = @"510100";
        _model = model;
    }
    return self;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.view.backgroundColor = YJBackColor;
    self.navBackgroundView.hidden = NO;
    [self initDateSouce];
    [self initUI];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

-(void)initDateSouce
{
    
    _searchArr = [@[] mutableCopy];
    _dataArr = [@[] mutableCopy];
    _page = 1;
    [self RequestMethod];
}

- (void)SearchRequest{
    
    [BaseRequest GET:@"user/project/hotSearch" parameters:nil success:^(id resposeObject) {
        
        NSLog(@"%@",resposeObject);
        if ([resposeObject[@"code"] integerValue] == 200) {
            
            
            [self SetSearch:resposeObject[@"data"]];
        }
    } failure:^(NSError *error) {
        
        NSLog(@"%@",error);
    }];
}

- (void)SetSearch:(NSDictionary *)data{
    
    [_searchArr removeAllObjects];
    [data enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        
        [_searchArr addObject:key];
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
    
    [_MainTableView reloadData];
}

- (void)RequestMethod{
    
    if (_page == 1) {
        
        self.MainTableView.mj_footer.state = MJRefreshStateIdle;
    }
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithDictionary:@{@"page":@(_page)}];
    if (_city.length) {
        
        [dic setObject:_city forKey:@"city"];
    }
    if (_district.length) {
        
        [dic setObject:_district forKey:@"district"];
    }
    if (![_price isEqualToString:@"0"] && _price) {
        
        [dic setObject:[NSString stringWithFormat:@"%@",_price] forKey:@"average_price"];
    }
    if (![_type isEqualToString:@"0"] && _type) {
        
        [dic setObject:[NSString stringWithFormat:@"%@",_type] forKey:@"property_id"];
    }
    if (_tag.length) {
        
        [dic setObject:[NSString stringWithFormat:@"%@",_tag] forKey:@"project_tags"];
    }
    if (_houseType.length) {
        
        [dic setObject:[NSString stringWithFormat:@"%@",_houseType] forKey:@"house_type"];
    }
    
    [BaseRequest GET:ProjectList_URL parameters:dic success:^(id resposeObject) {
        
        [self.MainTableView.mj_header endRefreshing];
        NSLog(@"%@",resposeObject);
      
        if ([resposeObject[@"code"] integerValue] == 200) {
            
            if ([resposeObject[@"data"] isKindOfClass:[NSDictionary class]]) {
                
                if ([resposeObject[@"data"][@"data"] isKindOfClass:[NSArray class]]) {
                    
                    [_dataArr removeAllObjects];
                    [self SetData:resposeObject[@"data"][@"data"]];
                    if (_page >= [resposeObject[@"data"][@"last_page"] integerValue]) {
                        
                        self.MainTableView.mj_footer.state = MJRefreshStateNoMoreData;
                    }
                }else{
                    
                }
            }else{
                
            }
        }else{
           
                [self showContent:resposeObject[@"msg"]];
            
        }
    } failure:^(NSError *error) {
        
        [self.MainTableView.mj_header endRefreshing];
        [self showContent:@"网路错误"];
        NSLog(@"%@",error.localizedDescription);
    }];
    
}

- (void)RequestAddMethod{
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithDictionary:@{@"page":@(_page)}];
    if (_city.length) {
        
        [dic setObject:_city forKey:@"city"];
    }
    if (_district.length) {
        
        [dic setObject:_district forKey:@"district"];
    }
    if (![_price isEqualToString:@"0"] && _price) {
        
        [dic setObject:[NSString stringWithFormat:@"%@",_price] forKey:@"average_price"];
    }
    if (![_type isEqualToString:@"0"] && _type) {
        
        [dic setObject:[NSString stringWithFormat:@"%@",_type] forKey:@"property_id"];
    }
    if (_tag.length) {
        
        [dic setObject:[NSString stringWithFormat:@"%@",_type] forKey:@"project_tags"];
    }
    if (_houseType.length) {
        
        [dic setObject:[NSString stringWithFormat:@"%@",_houseType] forKey:@"house_type"];
    }
    
    [BaseRequest GET:ProjectList_URL parameters:dic success:^(id resposeObject) {
        
        NSLog(@"%@",resposeObject);
       
        if ([resposeObject[@"code"] integerValue] == 200) {
            
            if ([resposeObject[@"data"] isKindOfClass:[NSDictionary class]]) {
                
                if ([resposeObject[@"data"][@"data"] isKindOfClass:[NSArray class]]) {
                    
                    [self SetData:resposeObject[@"data"][@"data"]];
                    if (_page == [resposeObject[@"data"][@"last_page"] integerValue]) {
                        
                        self.MainTableView.mj_footer.state = MJRefreshStateNoMoreData;
                    }
                }else{
                    
                    self.MainTableView.mj_footer.state = MJRefreshStateNoMoreData;
                }
            }else{
                
                [self.MainTableView.mj_footer endRefreshing];
            }
        }else{
       
                [self showContent:resposeObject[@"msg"]];
           
            [self.MainTableView.mj_footer endRefreshing];
        }
    } failure:^(NSError *error) {
        
        [self showContent:@"网路错误"];
        [self.MainTableView.mj_footer endRefreshing];
        NSLog(@"%@",error.localizedDescription);
    }];
    
}

#pragma mark -- Method

- (void)ActionTagBtn:(UIButton *)btn{
    
    btn.selected = !btn.selected;
    
    switch (btn.tag) {
        case 1:
        {
            //            _is2 = NO;
            //            _is3 = NO;
            //            _is4 = NO;
            //            _priceBtn.selected = NO;
            //            _typeBtn.selected = NO;
            //            _moreBtn.selected = NO;
            //            [self.priceView removeFromSuperview];
            //            [self.typeView removeFromSuperview];
            //            [self.moreView removeFromSuperview];
            //            if (_is1) {
            //
            //                _is1 = !_is1;
            //                [self.areaView removeFromSuperview];
            //            }else{
            //
            //                _is1 = YES;
            //                _type = @"0";
            //                NSArray *array = [self getDetailConfigArrByConfigState:PROPERTY_TYPE];
            //                NSMutableArray * tempArr = [NSMutableArray arrayWithArray:array];
            //                [tempArr insertObject:@{@"id":@"0",@"param":@"不限"} atIndex:0];
            //                self.boxView.dataArr = [NSMutableArray arrayWithArray:tempArr];
            //                [tempArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            //
            //                    if (idx == 0) {
            //
            //                        [tempArr replaceObjectAtIndex:idx withObject:@(1)];
            //                    }else{
            //
            //                        [tempArr replaceObjectAtIndex:idx withObject:@(0)];
            //                    }
            //                }];
            //                self.boxView.selectArr = [NSMutableArray arrayWithArray:tempArr];
            //                [self.boxView.mainTable reloadData];
            //                [self.view addSubview:self.boxView];
            //            }
            break;
        }
        case 2:
        {
            _is1 = NO;
            _is3 = NO;
            _is4 = NO;
            _areaBtn.selected = NO;
            _typeBtn.selected = NO;
            _moreBtn.selected = NO;
            [self.areaView removeFromSuperview];
            [self.typeView removeFromSuperview];
            [self.moreView removeFromSuperview];
            if (_is2) {
                
                _is2 = !_is2;
                [self.priceView removeFromSuperview];
            }else{
                
                _is2 = YES;
                _price = @"0";
                NSArray *array = [self getDetailConfigArrByConfigState:AVERAGE];
                NSMutableArray * tempArr = [NSMutableArray arrayWithArray:array];
                [tempArr insertObject:@{@"id":@"0",@"param":@"不限"} atIndex:0];
                self.priceView.dataArr = [NSMutableArray arrayWithArray:tempArr];
                [tempArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    
                    if (idx == 0) {
                        
                        [tempArr replaceObjectAtIndex:idx withObject:@(1)];
                    }else{
                        
                        [tempArr replaceObjectAtIndex:idx withObject:@(0)];
                    }
                }];
                self.priceView.selectArr = [NSMutableArray arrayWithArray:tempArr];
                [self.priceView.mainTable reloadData];
                [[UIApplication sharedApplication].keyWindow addSubview:self.priceView];
            }
            break;
        }
        case 3:
        {
            _is1 = NO;
            _is2 = NO;
            _is4 = NO;
            _areaBtn.selected = NO;
            _priceBtn.selected = NO;
            _moreBtn.selected = NO;
            [self.areaView removeFromSuperview];
            [self.priceView removeFromSuperview];
            [self.moreView removeFromSuperview];
            if (_is3) {
                
                _is3 = !_is3;
                [self.typeView removeFromSuperview];
            }else{
                
                _is3 = YES;
                _type = @"0";
                NSArray *array = [self getDetailConfigArrByConfigState:PROPERTY_TYPE];
                NSMutableArray * tempArr = [NSMutableArray arrayWithArray:array];
                [tempArr insertObject:@{@"id":@"0",@"param":@"不限"} atIndex:0];
                self.typeView.dataArr = [NSMutableArray arrayWithArray:tempArr];
                [tempArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    
                    if (idx == 0) {
                        
                        [tempArr replaceObjectAtIndex:idx withObject:@(1)];
                    }else{
                        [tempArr replaceObjectAtIndex:idx withObject:@(0)];
                    }
                }];
                self.typeView.selectArr = [NSMutableArray arrayWithArray:tempArr];
                [self.typeView.mainTable reloadData];
                [[UIApplication sharedApplication].keyWindow addSubview:self.typeView];
            }
            break;
        }
        case 4:
        {
            _is1 = NO;
            _is2 = NO;
            _is3 = NO;
            _areaBtn.selected = NO;
            _priceBtn.selected = NO;
            _typeBtn.selected = NO;
            [self.areaView removeFromSuperview];
            [self.priceView removeFromSuperview];
            [self.typeView removeFromSuperview];
            if (_is4) {
                
                _is4 = !_is4;
                [self.moreView removeFromSuperview];
            }else{
                
                _is4 = YES;
                _more = @"0";
                
                [self.moreView.moreColl reloadData];
                [[UIApplication sharedApplication].keyWindow addSubview:self.moreView];
            }
            break;
        }
        case 5:
        {
            break;
        }
        default:
            break;
    }
}


- (void)ActionSearchBtn:(UIButton *)btn{
    
    // 1.创建热门搜索
    //    NSArray *hotSeaches = @[@"Java", @"Python", @"Objective-C", @"Swift", @"C", @"C++", @"PHP", @"C#", @"Perl", @"Go", @"JavaScript", @"R", @"Ruby", @"MATLAB"];
    
    // 2. 创建控制器
    
    PYSearchViewController *searchViewController = [PYSearchViewController searchViewControllerWithHotSearches:_searchArr searchBarPlaceholder:@"请输入楼盘名或地址" didSearchBlock:^(PYSearchViewController *searchViewController, UISearchBar *searchBar, NSString *searchText) {
        // 开始搜索执行以下代码
        // 如：跳转到指定控制器
        
        [searchViewController.navigationController pushViewController:[[QuickSearchVC alloc] initWithTitle:searchText city:_city model:_model] animated:YES];
    }];
    // 3. 设置风格
    searchViewController.searchBar.returnKeyType = UIReturnKeySearch;
    searchViewController.hotSearchStyle = 3; // 热门搜索风格根据选择
    searchViewController.searchHistoryStyle = PYHotSearchStyleDefault; // 搜索历史风格为
    // 4. 设置代理
    searchViewController.delegate = self;
    // 5. 跳转到搜索控制器
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:searchViewController];
    [self presentViewController:nav  animated:NO completion:nil];
//    [self.navigationController presentViewController:nav animated:NO completion:nil];
//    [self.navigationController pushViewController:nav animated:NO];
}


- (void)ActionCityBtn:(UIButton *)btn{
    
    AdressChooseView *view = [[AdressChooseView alloc]initWithFrame:self.view.frame withdata:@[]];
    [[UIApplication sharedApplication].keyWindow addSubview:view];
    view.selectedBlock = ^(NSString *province, NSString *city, NSString *area, NSString *proviceid, NSString *cityid, NSString *areaid) {
        
        if (![area isEqualToString:@"市辖区"]) {
            
            [_cityBtn setTitle:area forState:UIControlStateNormal];
        }else{
            
            if (![city isEqualToString:@"市辖区"]) {
                
                [_cityBtn setTitle:city forState:UIControlStateNormal];
            }else{
                
                [_cityBtn setTitle:province forState:UIControlStateNormal];
            }
        }
        
    };
}

- (void)ActionUpAndDownBtn:(UIButton *)btn{
    
    _upAndDown = !_upAndDown;
    if (_upAndDown) {
        
        
    }else{
        
        
    }
}

//textfieldDelegate;
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    return YES;
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
    [cell SetTitle:model.project_name image:model.img_url contentlab:model.absolute_address statu:model.sale_state];
    
    
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
    
    cell.rankView.rankL.text = [NSString stringWithFormat:@"佣金:第%@名",model.sort];
    [cell.rankView.rankL mas_remakeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(cell.rankView).offset(0);
        make.top.equalTo(cell.rankView).offset(0);
        make.height.equalTo(@(10 *SIZE));
        make.width.equalTo(@(cell.rankView.rankL.mj_textWith + 5 *SIZE));
    }];
    if ([model.brokerSortCompare integerValue] == 0) {
        
        cell.rankView.statusImg.image = [UIImage imageNamed:@""];
    }else if ([model.brokerSortCompare integerValue] == 1){
        
        cell.rankView.statusImg.image = [UIImage imageNamed:@"rising"];
    }else if ([model.brokerSortCompare integerValue] == 2){
        
        cell.rankView.statusImg.image = [UIImage imageNamed:@"falling"];
    }
    [cell.getLevel SetImage:[UIImage imageNamed:@"lightning_1"] selectImg:[UIImage imageNamed:@"lightning"] num:[model.cycle integerValue]];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
    
    //    if (indexPath.row == 1) {
    //        static NSString *CellIdentifier = @"CompanyCell";
    //
    //        CompanyCell *cell  = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    //        if (!cell) {
    //            cell = [[CompanyCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    //        }
    //        //    [cell setTitle:_namelist[indexPath.row] content:@"123" img:@""];
    //        [cell SetTitle:@"新希望国际" image:@"" contentlab:@"高新区——天府三街" statu:@"在售"];
    //        [cell settagviewWithdata:_arr[indexPath.row]];
    //        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    //        return cell;
    //    }else
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([[UserModel defaultModel].agent_identity integerValue] == 1) {
        
        RoomListModel *model = _dataArr[indexPath.row];
        [BaseRequest POST:RecommendClient_URL parameters:@{@"project_id":model.project_id,@"client_need_id":_model.need_id,@"client_id":_model.client_id} success:^(id resposeObject) {
            
            NSLog(@"%@",resposeObject);
        
            if ([resposeObject[@"code"] integerValue] == 200) {
                
                [self alertControllerWithNsstring:@"推荐成功" And:nil WithDefaultBlack:^{
                    
                    for (UIViewController *vc in self.navigationController.viewControllers) {
                        
                        if ([vc isKindOfClass:[CustomDetailVC class]]) {
                            
                            [self.navigationController popToViewController:vc animated:YES];
                        }
                    }
                }];
            }
            else{
                
                [self alertControllerWithNsstring:@"温馨提示" And:resposeObject[@"msg"]];
            }
        } failure:^(NSError *error) {
            
            NSLog(@"%@",error);
            [self showContent:@"网络错误"];
        }];
    }else{
        
        
    }
}

-(void)initUI
{
    [self.view addSubview:self.headerView];
    
//    _cityBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    _cityBtn.frame = CGRectMake(0, 19 *SIZE, 50 *SIZE, 21 *SIZE);
//    _cityBtn.titleLabel.font = [UIFont systemFontOfSize:12 *sIZE];
//    [_cityBtn addTarget:self action:@selector(ActionCityBtn:) forControlEvents:UIControlEventTouchUpInside];
//    [_cityBtn setTitleColor:YJ86Color forState:UIControlStateNormal];
//    [self.headerView addSubview:_cityBtn];
    self.leftButton.center = CGPointMake(25 * sIZE,  30 *SIZE);
    self.leftButton.bounds = CGRectMake(0, 0, 80 * sIZE, 33 * sIZE);
    self.maskButton.frame = CGRectMake(0, 0, 60 * sIZE, 44 *SIZE);
    
    [self.headerView addSubview:self.leftButton];
    [self.headerView addSubview:self.maskButton];
    
    _searchBar = [[UIView alloc] initWithFrame:CGRectMake(58 *SIZE, 13 *SIZE, 292 *SIZE, 33 *SIZE)];
    _searchBar.backgroundColor = YJBackColor;
    [self.headerView addSubview:_searchBar];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(11 *SIZE, 11 *SIZE, 100 *SIZE, 12 *SIZE)];
    label.textColor = COLOR(147, 147, 147, 1);
    label.text = @"小区/楼盘/商铺";
    label.font = [UIFont systemFontOfSize:11 *SIZE];
    [_searchBar addSubview:label];
    
    UIImageView *rightImg = [[UIImageView alloc] initWithFrame:CGRectMake(256 *SIZE, 8 *SIZE, 17 *SIZE, 17 *SIZE)];
    rightImg.image = [UIImage imageNamed:@"search_2"];
    [_searchBar addSubview:rightImg];
    
    UIButton *searchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    searchBtn.frame = _searchBar.bounds;
    [searchBtn addTarget:self action:@selector(ActionSearchBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_searchBar addSubview:searchBtn];
    
    for (int i = 0; i < 5; i++) {
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(80 * i, 62 *SIZE, 80 *SIZE, 40 *SIZE);
        btn.tag = i + 1;
        [btn setBackgroundColor:CH_COLOR_white];
        [btn addTarget:self action:@selector(ActionTagBtn:) forControlEvents:UIControlEventTouchUpInside];
        
        switch (i) {
            case 0:
            {
                [btn setTitle:@"区域" forState:UIControlStateNormal];
                [btn setTitleColor:YJ86Color forState:UIControlStateNormal];
                btn.titleLabel.font = [UIFont systemFontOfSize:12 *SIZE];
                [btn setImage:[UIImage imageNamed:@"downarrow1"] forState:UIControlStateNormal];
                [btn setImage:[UIImage imageNamed:@"uparrow2"] forState:UIControlStateSelected];
                _areaBtn = btn;
                [self.headerView addSubview:_areaBtn];
                break;
            }
            case 1:
            {
                [btn setTitle:@"均价" forState:UIControlStateNormal];
                [btn setTitleColor:YJ86Color forState:UIControlStateNormal];
                btn.titleLabel.font = [UIFont systemFontOfSize:12 *SIZE];
                [btn setImage:[UIImage imageNamed:@"downarrow1"] forState:UIControlStateNormal];
                [btn setImage:[UIImage imageNamed:@"uparrow2"] forState:UIControlStateSelected];
                _priceBtn = btn;
                [self.headerView addSubview:_priceBtn];
                break;
            }
            case 2:
            {
                [btn setTitle:@"类型" forState:UIControlStateNormal];
                [btn setTitleColor:YJ86Color forState:UIControlStateNormal];
                btn.titleLabel.font = [UIFont systemFontOfSize:12 *SIZE];
                [btn setImage:[UIImage imageNamed:@"downarrow1"] forState:UIControlStateNormal];
                [btn setImage:[UIImage imageNamed:@"uparrow2"] forState:UIControlStateSelected];
                _typeBtn = btn;
                [self.headerView addSubview:_typeBtn];
                break;
            }
            case 3:
            {
                [btn setTitle:@"更多" forState:UIControlStateNormal];
                [btn setTitleColor:YJ86Color forState:UIControlStateNormal];
                btn.titleLabel.font = [UIFont systemFontOfSize:12 *SIZE];
                [btn setImage:[UIImage imageNamed:@"downarrow1"] forState:UIControlStateNormal];
                [btn setImage:[UIImage imageNamed:@"uparrow2"] forState:UIControlStateSelected];
                _moreBtn = btn;
                [self.headerView addSubview:_moreBtn];
                break;
            }
            case 4:
            {
                btn.frame = CGRectMake(80 * i, 62 *SIZE, 40 *SIZE, 40 *SIZE);
                [btn setImage:[UIImage imageNamed:@"downarrow1"] forState:UIControlStateNormal];
                [btn setImage:[UIImage imageNamed:@"uparrow2"] forState:UIControlStateSelected];
                _sortBtn = btn;
                [self.headerView addSubview:_sortBtn];
                break;
            }
            default:
                break;
        }
    }
    
    _upImg = [[UIImageView alloc] initWithFrame:CGRectMake(334 *SIZE, 74 *SIZE, 13 *SIZE, 16 *SIZE)];
    [self.headerView addSubview:_upImg];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(329 *SIZE, 69 *SIZE, 23 *SIZE, 26 *SIZE);
    [btn addTarget:self action:@selector(ActionUpAndDownBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.headerView addSubview:btn];
    
    [self.view addSubview:self.MainTableView];
}

#pragma mark  ---  懒加载   ---
-(UITableView *)MainTableView
{
    if(!_MainTableView)
    {
        _MainTableView =   [[UITableView alloc]initWithFrame:CGRectMake(0, STATUS_BAR_HEIGHT + 105*SIZE, 360*SIZE, SCREEN_Height-STATUS_BAR_HEIGHT-105*SIZE) style:UITableViewStylePlain];
        _MainTableView.backgroundColor = YJBackColor;
        _MainTableView.delegate = self;
        _MainTableView.dataSource = self;
        [_MainTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
        _MainTableView.mj_header = [GZQGifHeader headerWithRefreshingBlock:^{
            
            _page = 1;
            [self RequestMethod];
        }];
        
        _MainTableView.mj_footer = [GZQGifFooter footerWithRefreshingBlock:^{
            
            [self RequestMethod];
        }];
    }
    return _MainTableView;
}

-(UIView *)headerView
{
    if (!_headerView ) {
        _headerView = [[UIView alloc ]initWithFrame:CGRectMake(0, STATUS_BAR_HEIGHT,360*SIZE , 102*SIZE)];
        _headerView.backgroundColor = [UIColor whiteColor];
    }
    return _headerView;
}

- (BoxView *)priceView{
    
    if (!_priceView) {
        
        _priceView = [[BoxView alloc] initWithFrame:CGRectMake(0, STATUS_BAR_HEIGHT + 102 *SIZE, SCREEN_Width, SCREEN_Height - 102 *SIZE)];
        WS(weakSelf);
        _priceView.confirmBtnBlock = ^(NSString *ID, NSString *str) {
            
            if ([str isEqualToString:@"不限"]) {
                
                [weakSelf.priceBtn setTitle:@"均价" forState:UIControlStateNormal];
            }else{
                
                [weakSelf.priceBtn setTitle:str forState:UIControlStateNormal];
            }
            _is2 = NO;
            _price = [NSString stringWithFormat:@"%@",ID];
            weakSelf.priceBtn.selected = NO;
            [weakSelf.priceView removeFromSuperview];
            [weakSelf RequestMethod];
        };
        
        _priceView.cancelBtnBlock = ^{
            
            _is2 = NO;
            weakSelf.priceBtn.selected = NO;
        };
    }
    return _priceView;
}

- (BoxView *)typeView{
    
    if (!_typeView) {
        
        _typeView = [[BoxView alloc] initWithFrame:CGRectMake(0, STATUS_BAR_HEIGHT + 102 *SIZE, SCREEN_Width, SCREEN_Height - 102 *SIZE)];
        WS(weakSelf);
        _typeView.confirmBtnBlock = ^(NSString *ID, NSString *str) {
            
            if ([str isEqualToString:@"不限"]) {
                
                [weakSelf.typeBtn setTitle:@"类型" forState:UIControlStateNormal];
            }else{
                
                [weakSelf.typeBtn setTitle:str forState:UIControlStateNormal];
            }
            _is3 = NO;
            _type = [NSString stringWithFormat:@"%@",ID];
            weakSelf.typeBtn.selected = NO;
            [weakSelf.typeView removeFromSuperview];
            [weakSelf RequestMethod];
        };
        
        _typeView.cancelBtnBlock = ^{
            
            _is3 = NO;
            weakSelf.typeBtn.selected = NO;
        };
    }
    return _typeView;
}

- (MoreView *)moreView{
    
    if (!_moreView) {
        
        _moreView = [[MoreView alloc] initWithFrame:CGRectMake(0, STATUS_BAR_HEIGHT + 103 *SIZE, SCREEN_Width, SCREEN_Height - 103 *SIZE - STATUS_BAR_HEIGHT - TAB_BAR_MORE)];
        
        WS(weakSelf);
        _moreView.moreBtnBlock = ^(NSString *tag, NSString *houseType, NSString *status) {
            
            if (tag) {
                
                _tag = [NSString stringWithFormat:@"%@",tag];
            }
            
            if (houseType) {
                
                _houseType = [NSString stringWithFormat:@"%@",houseType];
            }
            
            if (status) {
                
                _status = [NSString stringWithFormat:@"%@",status];
            }
            
            [weakSelf RequestMethod];
        };
        
    }
    return _moreView;
}

@end
