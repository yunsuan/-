//
//  RoomVC.m
//  云渠道
//
//  Created by xiaoq on 2018/3/13.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "RoomVC.h"
#import "RoomDetailVC1.h"
#import "CompanyCell.h"
#import "PeopleCell.h"
#import "BoxAddressView.h"
#import "BoxView.h"
#import "RoomCollCell.h"
#import "HouseSearchVC.h"
#import "PYSearchViewController.h"
#import "MoreView.h"
#import "RoomListModel.h"
#import "AdressChooseView.h"
#import "CityVC.h"

#import<BaiduMapAPI_Location/BMKLocationService.h>

#import<BaiduMapAPI_Search/BMKGeocodeSearch.h>

#import<BaiduMapAPI_Map/BMKMapComponent.h>

#import<BaiduMapAPI_Search/BMKPoiSearchType.h>


@interface RoomVC ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,BMKLocationServiceDelegate,BMKGeoCodeSearchDelegate,PYSearchViewControllerDelegate>
{
    NSArray *_arr;
    BOOL _upAndDown;
    BMKLocationService *_locService;  //定位
    BMKGeoCodeSearch *_geocodesearch; //地理编码主类，用来查询、返回结果信息
    NSInteger _page;
    NSMutableDictionary *_parameter;
    NSMutableArray *_dataArr;
    NSString *_provice;
    NSString *_city;
    NSString *_cityName;
    NSString *_district;
    NSString *_price;
    NSString *_type;
    NSString *_more;
    NSString *_tag;
    NSString *_houseType;
    NSString *_status;
    NSMutableArray *_searchArr;
    NSString *_asc;
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

@property (nonatomic, strong) BoxAddressView *areaView;

@property (nonatomic, strong) BoxView *priceView;

@property (nonatomic, strong) BoxView *typeView;

@property (nonatomic, strong) UIImageView *upImg;

@property (nonatomic, strong) MoreView *moreView;


-(void)initUI;
-(void)initDateSouce;
@end

@implementation RoomVC
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
    _asc = @"asc";
    _geocodesearch = [[BMKGeoCodeSearch alloc] init];
    _geocodesearch.delegate = self;
    [self startLocation];//开始定位方法
    [self SearchRequest];
}

- (void)SearchRequest{
    
    [BaseRequest GET:@"user/project/hotSearch" parameters:nil success:^(id resposeObject) {
        
        if ([resposeObject[@"code"] integerValue] == 200) {
            
            if ([resposeObject[@"data"] isKindOfClass:[NSDictionary class]]) {
                
                [self SetSearch:resposeObject[@"data"]];
            }
        }
    } failure:^(NSError *error) {
        
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
    if (![_district isEqualToString:@"0"] && _district.length) {
        
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
    [dic setObject:_asc forKey:@"sort_type"];
    
    [BaseRequest GET:ProjectList_URL parameters:dic success:^(id resposeObject) {
        
        [self.MainTableView.mj_header endRefreshing];
        
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
        [self showContent:@"网络错误"];
    }];

}

- (void)RequestAddMethod{
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithDictionary:@{@"page":@(_page)}];
    if (_city.length) {
        
        [dic setObject:_city forKey:@"city"];
    }
    if (_district.length && [_district isEqualToString:@"0"]) {
        
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
    [dic setObject:_asc forKey:@"sort_type"];
    
    [BaseRequest GET:ProjectList_URL parameters:dic success:^(id resposeObject) {
        
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
    }];
    
}

#pragma mark -- Method

- (void)ActionTagBtn:(UIButton *)btn{
    
    btn.selected = !btn.selected;
    
    switch (btn.tag) {
        case 1:
        {
            _is2 = NO;
            _is3 = NO;
            _is4 = NO;
            _priceBtn.selected = NO;
            _typeBtn.selected = NO;
            _moreBtn.selected = NO;
            [self.priceView removeFromSuperview];
            [self.typeView removeFromSuperview];
            [self.moreView removeFromSuperview];
            if (_is1) {

                _is1 = !_is1;
                [_areaView removeFromSuperview];
            }else{

                _is1 = YES;
                _district = @"0";

                NSData *JSONData = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"region" ofType:@"json"]];
                
                NSError *err;
                NSArray *pro = [NSJSONSerialization JSONObjectWithData:JSONData
                                                              options:NSJSONReadingMutableContainers
                                                                error:&err];
                NSMutableArray * tempArr;
                for (NSDictionary *proDic in pro) {
                    
                    for (NSDictionary *cityDic in proDic[@"city"]) {
                        
                        if ([cityDic[@"code"] integerValue] == [_city integerValue]) {
                            
                            tempArr = [NSMutableArray arrayWithArray:cityDic[@"district"]];
                            break;
                        }
                    }
                }
                [tempArr insertObject:@{@"code":@"0",@"name":@"不限"} atIndex:0];
                self.areaView.dataArr = [NSMutableArray arrayWithArray:tempArr];
                [tempArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                   
                    if (idx == 0) {
                        
                        [tempArr replaceObjectAtIndex:idx withObject:@(1)];
                    }else{
                        
                        [tempArr replaceObjectAtIndex:idx withObject:@(0)];
                    }

                }];
                self.areaView.selectArr = [NSMutableArray arrayWithArray:tempArr];
                [self.areaView.mainTable reloadData];
                [[UIApplication sharedApplication].keyWindow addSubview:self.areaView];
            }
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
            if ([_asc isEqualToString:@"asc"]) {
                
                _asc = @"desc";
            }else{
                
                _asc = @"asc";
            }
            _page = 1;
            [self RequestMethod];
            break;
        }
        default:
            break;
    }
}


#pragma mark -- 百度SDK
-(void)startLocation

{
    
    //初始化BMKLocationService
    
    _locService = [[BMKLocationService alloc]init];
    
    _locService.delegate = self;
    
    _locService.desiredAccuracy = kCLLocationAccuracyNearestTenMeters;
    
    //启动LocationService
    
    [_locService startUserLocationService];
    
}

- (void)didUpdateUserHeading:(BMKUserLocation *)userLocation
{
//    NSLog(@"heading is %@",userLocation.heading);
    
}

//处理位置坐标更新

- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation
{
//    NSLog(@"didUpdateUserLocation lat %f,long %f",userLocation.location.coordinate.latitude,userLocation.location.coordinate.longitude);
    //地理反编码
    
    BMKReverseGeoCodeOption *reverseGeocodeSearchOption = [[BMKReverseGeoCodeOption alloc]init];
    
    reverseGeocodeSearchOption.reverseGeoPoint = userLocation.location.coordinate;
    
    BOOL flag = [_geocodesearch reverseGeoCode:reverseGeocodeSearchOption];
    
    if(flag){
        
//        NSLog(@"反geo检索发送成功");
        
        [_locService stopUserLocationService];
        
    }else{
        
//        NSLog(@"反geo检索发送失败");
        
    }
    
}

#pragma mark -------------地理反编码的delegate---------------

-(void)onGetReverseGeoCodeResult:(BMKGeoCodeSearch *)searcher result:(BMKReverseGeoCodeResult *)result errorCode:(BMKSearchErrorCode)error

{
    
//    NSLog(@"address:%@----%@",result.addressDetail,result.address);
    [_cityBtn setTitle:result.addressDetail.city forState:UIControlStateNormal];
    NSInteger disInteger = [result.addressDetail.adCode integerValue];
    NSInteger cityInteger = disInteger / 100 * 100;
    _city = [NSString stringWithFormat:@"%ld",cityInteger];
    _cityName = result.addressDetail.city;
    [self RequestMethod];
}

//定位失败

- (void)didFailToLocateUserWithError:(NSError *)error{
    
//    NSLog(@"error:%@",error);
    [self alertControllerWithNsstring:@"定位失败" And:@"请检查定位设置"];
    
}



- (void)ActionSearchBtn:(UIButton *)btn{
    
    // 1.创建热门搜索
//    NSArray *hotSeaches = @[@"Java", @"Python", @"Objective-C", @"Swift", @"C", @"C++", @"PHP", @"C#", @"Perl", @"Go", @"JavaScript", @"R", @"Ruby", @"MATLAB"];
    
    // 2. 创建控制器

    PYSearchViewController *searchViewController = [PYSearchViewController searchViewControllerWithHotSearches:_searchArr searchBarPlaceholder:@"请输入楼盘名或地址" didSearchBlock:^(PYSearchViewController *searchViewController, UISearchBar *searchBar, NSString *searchText) {
        // 开始搜索执行以下代码
        // 如：跳转到指定控制器
     
        HouseSearchVC *nextVC = [[HouseSearchVC alloc] initWithTitle:searchText city:_city];
//        nextVC.hidesBottomBarWhenPushed = YES;
        [searchViewController.navigationController pushViewController:nextVC animated:YES];
    }];
    // 3. 设置风格
    searchViewController.searchBar.returnKeyType = UIReturnKeySearch;
    searchViewController.hotSearchStyle = 3; // 热门搜索风格根据选择
    searchViewController.searchHistoryStyle = PYHotSearchStyleDefault; // 搜索历史风格为
    // 4. 设置代理
    searchViewController.delegate = self;
    // 5. 跳转到搜索控制器
//    [self.navigationController pushViewController:searchViewController animated:YES];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:searchViewController];
////    nav.hidesBottomBarWhenPushed = YES;
//    [self.navigationController pushViewController:nav animated:YES];
    [self.navigationController presentViewController:nav  animated:NO completion:nil];
}


- (void)ActionCityBtn:(UIButton *)btn{
    
    if (_city) {
        
        CityVC *nextVC = [[CityVC alloc] initWithLabel:_cityName];
        nextVC.cityVCSaveBlock = ^(NSString *code, NSString *city) {
            
            [_cityBtn setTitle:city forState:UIControlStateNormal];
            _city = [NSString stringWithFormat:@"%@",code];
            [self RequestMethod];
        };
        nextVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:nextVC animated:YES];
    }else{
        
        [self showContent:@"正在定位中,请稍后"];
    }
//
//    [BaseRequest GET:OpenCity_URL parameters:nil success:^(id resposeObject) {
//
//        NSLog(@"%@",resposeObject);
//
//    } failure:^(NSError *error) {
//
//        NSLog(@"%@",error);
//    }];
//    AdressChooseView *view = [[AdressChooseView alloc]initWithFrame:self.view.frame withdata:@[]];
//    [[UIApplication sharedApplication].keyWindow addSubview:view];
//    view.selectedBlock = ^(NSString *province, NSString *city, NSString *area, NSString *proviceid, NSString *cityid, NSString *areaid) {
//
//        if (![area isEqualToString:@"市辖区"]) {
//
//            [_cityBtn setTitle:area forState:UIControlStateNormal];
//        }else{
//
//            if (![city isEqualToString:@"市辖区"]) {
//
//                [_cityBtn setTitle:city forState:UIControlStateNormal];
//            }else{
//
//                [_cityBtn setTitle:province forState:UIControlStateNormal];
//            }
//        }
//
//    };
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
        
        NSArray *arr2 = [self getDetailConfigArrByConfigState:PROJECT_TAGS_DEFAULT];
        [arr2 enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            if ([obj[@"id"] integerValue] == [tempArr1[i] integerValue]) {
                
                [tempArr2 addObject:obj[@"param"]];
                *stop = YES;
            }
        }];
    }
    NSArray *tempArr3 = @[tempArr,tempArr2.count == 0 ? @[]:tempArr2];
    [cell settagviewWithdata:tempArr3];
    
    
    if (model.sort) {
        
        cell.rankView.rankL.text = [NSString stringWithFormat:@"佣金:第%@名",model.sort];
    }else{
        
        cell.rankView.rankL.text = [NSString stringWithFormat:@"佣金:无排名"];
    }
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
    RoomListModel *model = _dataArr[indexPath.row];
    RoomDetailVC1 *nextVC = [[RoomDetailVC1 alloc] initWithModel:model];
    nextVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:nextVC animated:YES];

        switch (indexPath.row) {
            case 0:
            {
                
                
            }
                break;
            case 1:
            {
//                NSLog(@"");
            }

            default:
                break;
        }
}

-(void)initUI
{
    [self.view addSubview:self.headerView];
    
    _cityBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _cityBtn.frame = CGRectMake(0, 19 *SIZE, 50 *SIZE, 21 *SIZE);
    _cityBtn.titleLabel.font = [UIFont systemFontOfSize:12 *sIZE];
    [_cityBtn addTarget:self action:@selector(ActionCityBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_cityBtn setTitleColor:YJ86Color forState:UIControlStateNormal];
    [_cityBtn setTitle:@"定位中" forState:UIControlStateNormal];
    [self.headerView addSubview:_cityBtn];
    
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
                [btn setImage:[UIImage imageNamed:@"reverseorder"] forState:UIControlStateNormal];
                [btn setImage:[UIImage imageNamed:@"reverseorder"] forState:UIControlStateSelected];
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
        _MainTableView =   [[UITableView alloc]initWithFrame:CGRectMake(0, STATUS_BAR_HEIGHT + 105*SIZE, 360*SIZE, SCREEN_Height-STATUS_BAR_HEIGHT-105*SIZE-TAB_BAR_HEIGHT) style:UITableViewStylePlain];
        _MainTableView.backgroundColor = YJBackColor;
        _MainTableView.delegate = self;
        _MainTableView.dataSource = self;
        [_MainTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
//        _MainTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
//
//            _page = 1;
//            [self RequestMethod];
//        }];
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

- (BoxAddressView *)areaView{
    
    if (!_areaView) {
        
        _areaView = [[BoxAddressView alloc] initWithFrame:CGRectMake(0, STATUS_BAR_HEIGHT + 102 *SIZE, SCREEN_Width, SCREEN_Height - 102 *SIZE)];
        WS(weakSelf);
        _areaView.boxAddressComfirmBlock = ^(NSString *ID, NSString *str, NSInteger index) {
            
            if ([str isEqualToString:@"不限"]) {
                
                [weakSelf.areaBtn setTitle:@"区域" forState:UIControlStateNormal];
                _district = @"";
            }else{
                
                if (str.length) {
                    
                    [weakSelf.areaBtn setTitle:str forState:UIControlStateNormal];
                }else{
                    
                    [weakSelf.areaBtn setTitle:@"区域" forState:UIControlStateNormal];
                }
                if ([ID integerValue]) {
                    
                    _district = [NSString stringWithFormat:@"%@",ID];
                }
            }
            _is1 = NO;
            weakSelf.areaBtn.selected = NO;
            [weakSelf.areaView removeFromSuperview];
            [weakSelf RequestMethod];
        };
        
        _areaView.boxAddressCancelBlock = ^{
            
            _is1 = NO;
            weakSelf.areaBtn.selected = NO;
        };
    }
    return _areaView;
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
        
        _moreView.moreViewClearBlock = ^{
            
            _tag = @"";
            _status = @"";
            _houseType = @"";
            [weakSelf RequestMethod];
        };
    }
    return _moreView;
}

@end
