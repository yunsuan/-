//
//  RoomVC.m
//  云渠道
//
//  Created by xiaoq on 2018/3/13.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "RoomVC.h"
#import "RoomDetailVC.h"
#import "CompanyCell.h"
#import "PeopleCell.h"
#import "BoxView.h"
#import "RoomCollCell.h"
#import "HouseSearchVC.h"
#import "PYSearchViewController.h"
#import "MoreView.h"
#import "RoomListModel.h"

#import<BaiduMapAPI_Location/BMKLocationService.h>

#import<BaiduMapAPI_Search/BMKGeocodeSearch.h>

#import<BaiduMapAPI_Map/BMKMapComponent.h>

#import<BaiduMapAPI_Search/BMKPoiSearchType.h>


@interface RoomVC ()<UITableViewDelegate,UITableViewDataSource,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UITextFieldDelegate,BMKLocationServiceDelegate,BMKGeoCodeSearchDelegate,PYSearchViewControllerDelegate>
{
    NSArray *_arr;
    BOOL _upAndDown;
    BMKLocationService *_locService;  //定位
    BMKGeoCodeSearch *_geocodesearch; //地理编码主类，用来查询、返回结果信息
    NSInteger _page;
    NSMutableDictionary *_parameter;
    NSMutableArray *_dataArr;
}

@property (nonatomic , strong) UITableView *MainTableView;
@property (nonatomic , strong) UIView *headerView;

@property (nonatomic, strong) UIButton *cityBtn;

@property (nonatomic, strong) UIView *searchBar;

@property (nonatomic, strong) UICollectionView *customerColl;
@property (nonatomic, strong) UICollectionViewFlowLayout *flowLayout;
@property (nonatomic, strong) BoxView *boxView;
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

-(void)initDateSouce
{
    
    _dataArr = [@[] mutableCopy];
    _arr = @[@[@[@"住宅",@"写字楼",@"商铺",@"别墅",@"公寓"],@[@"学区房",@"投资房"]],@[@[@"住宅",@"写字楼",@"商铺",@"别墅",@"公寓"],@[@"学区dd房",@"投资房"]],@[@[@"住宅",@"写字楼",@"商铺",@"别墅",@"公寓"],@[@"学区房",@"投资房的"]]];
    _page = 1;
    _geocodesearch = [[BMKGeoCodeSearch alloc] init];
    _geocodesearch.delegate = self;
    [self startLocation];//开始定位方法
    [self RequestMethod];
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
        
        [_dataArr removeAllObjects];
        self.MainTableView.mj_footer.state = MJRefreshStateIdle;
    }
    
    NSDictionary *dic = @{@"city":@"510100",@"page":@(_page)};
    [BaseRequest GET:ProjectList_URL parameters:dic success:^(id resposeObject) {
        
        [self.MainTableView.mj_header endRefreshing];
//        [self.MainTableView.mj_footer endRefreshing];
        NSLog(@"%@",resposeObject);
        if ([resposeObject[@"code"] integerValue] == 200) {
            
            if ([resposeObject[@"data"] isKindOfClass:[NSDictionary class]]) {
                
                if ([resposeObject[@"data"][@"data"] isKindOfClass:[NSArray class]]) {
                    
                    [self SetData:resposeObject[@"data"][@"data"]];
                    if (_page == [resposeObject[@"data"][@"last_page"] integerValue]) {
                        
                        self.MainTableView.mj_footer.state = MJRefreshStateNoMoreData;
                    }
                }else{
                    
                    [self showContent:@"暂无数据"];
                }
            }else{
                
                [self showContent:resposeObject[@"msg"]];
            }
        }else{
            
            [self showContent:resposeObject[@"msg"]];
        }
    } failure:^(NSError *error) {
        
        [self.MainTableView.mj_header endRefreshing];
        [self.MainTableView.mj_footer endRefreshing];
        NSLog(@"%@",error.localizedDescription);
    }];

}

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
    
    NSLog(@"heading is %@",userLocation.heading);
    
}

//处理位置坐标更新

- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation

{
    
    NSLog(@"didUpdateUserLocation lat %f,long %f",userLocation.location.coordinate.latitude,userLocation.location.coordinate.longitude);
    //地理反编码
    
    BMKReverseGeoCodeOption *reverseGeocodeSearchOption = [[BMKReverseGeoCodeOption alloc]init];
    
    reverseGeocodeSearchOption.reverseGeoPoint = userLocation.location.coordinate;
    
    BOOL flag = [_geocodesearch reverseGeoCode:reverseGeocodeSearchOption];
    
    if(flag){
        
        NSLog(@"反geo检索发送成功");
        
        [_locService stopUserLocationService];
        
    }else{
        
        NSLog(@"反geo检索发送失败");
        
    }
    
}

#pragma mark -------------地理反编码的delegate---------------

-(void)onGetReverseGeoCodeResult:(BMKGeoCodeSearch *)searcher result:(BMKReverseGeoCodeResult *)result errorCode:(BMKSearchErrorCode)error

{
    
    NSLog(@"address:%@----%@",result.addressDetail,result.address);
    [_cityBtn setTitle:result.addressDetail.city forState:UIControlStateNormal];
}

//定位失败

- (void)didFailToLocateUserWithError:(NSError *)error{
    
    NSLog(@"error:%@",error);
    
}

- (void)ActionSearchBtn:(UIButton *)btn{
    
    // 1.创建热门搜索
    NSArray *hotSeaches = @[@"Java", @"Python", @"Objective-C", @"Swift", @"C", @"C++", @"PHP", @"C#", @"Perl", @"Go", @"JavaScript", @"R", @"Ruby", @"MATLAB"];
    // 2. 创建控制器
    PYSearchViewController *searchViewController = [PYSearchViewController searchViewControllerWithHotSearches:hotSeaches searchBarPlaceholder:@"请输入楼盘名或地址" didSearchBlock:^(PYSearchViewController *searchViewController, UISearchBar *searchBar, NSString *searchText) {
        // 开始搜索执行以下代码
        // 如：跳转到指定控制器
        [searchViewController.navigationController pushViewController:[[HouseSearchVC alloc] initWithTitle:searchText] animated:YES];
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

}

- (void)ActionCityBtn:(UIButton *)btn{
    
    
}

-(void)initUI
{
    [self.view addSubview:self.headerView];
    
    _cityBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _cityBtn.frame = CGRectMake(0, 19 *SIZE, 50 *SIZE, 21 *SIZE);
    _cityBtn.titleLabel.font = [UIFont systemFontOfSize:12 *sIZE];
    [_cityBtn addTarget:self action:@selector(ActionCityBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_cityBtn setTitleColor:YJ86Color forState:UIControlStateNormal];
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

    
    _flowLayout = [[UICollectionViewFlowLayout alloc] init];
    _flowLayout.minimumLineSpacing = 0;
    _flowLayout.minimumInteritemSpacing = 0;
    _flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    _flowLayout.itemSize = CGSizeMake(81 *SIZE, 40 *SIZE);
    
    _customerColl = [[UICollectionView alloc] initWithFrame:CGRectMake(0, STATUS_BAR_HEIGHT + 62 *SIZE, 324 *SIZE, 40 *SIZE) collectionViewLayout:_flowLayout];
    _customerColl.backgroundColor = CH_COLOR_white;
    _customerColl.delegate = self;
    _customerColl.dataSource = self;
    _customerColl.bounces = NO;
    [_customerColl registerClass:[RoomCollCell class] forCellWithReuseIdentifier:@"RoomCollCell"];
    [self.view addSubview:_customerColl];
    
    _upImg = [[UIImageView alloc] initWithFrame:CGRectMake(334 *SIZE, 74 *SIZE, 13 *SIZE, 16 *SIZE)];
    [self.headerView addSubview:_upImg];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(329 *SIZE, 69 *SIZE, 23 *SIZE, 26 *SIZE);
    [btn addTarget:self action:@selector(ActionUpAndDownBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.headerView addSubview:btn];
    
    [self.view addSubview:self.MainTableView];
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

//collectionViewDelegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return 4;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    RoomCollCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"RoomCollCell" forIndexPath:indexPath];
    if (!cell) {
        
        cell = [[RoomCollCell alloc] initWithFrame:CGRectMake(0, 0, 81 *SIZE, 40 *SIZE)];
    }
    cell.typeL.text = @"区域";
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.item < 2) {
        
        [[[UIApplication sharedApplication] keyWindow] addSubview:self.moreView];
    }else{
        
        [self.moreView removeFromSuperview];
        
    }
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
    [cell settagviewWithdata:_arr[indexPath.row]];
//    [cell settagviewWithdata:([model.project_tags componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@","]])];
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
//    {
//        static NSString *CellIdentifier = @"PeopleCell";
//
//        PeopleCell *cell  = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
//        if (!cell) {
//            cell = [[PeopleCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
//        }
//        //    [cell setTitle:_namelist[indexPath.row] content:@"123" img:@""];
//        [cell SetTitle:@"新希望国际" image:@"" contentlab:@"高新区——天府三街" statu:@"在售"];
//        [cell settagviewWithdata:_arr[indexPath.row]];
//        cell.selectionStyle = UITableViewCellSelectionStyleNone;
//        return cell;
//    }
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



#pragma mark  ---  懒加载   ---
-(UITableView *)MainTableView
{
    if(!_MainTableView)
    {
        _MainTableView =   [[UITableView alloc]initWithFrame:CGRectMake(0, STATUS_BAR_HEIGHT+105*SIZE, 360*SIZE, SCREEN_Height-STATUS_BAR_HEIGHT-105*SIZE-TAB_BAR_HEIGHT) style:UITableViewStylePlain];
        _MainTableView.backgroundColor = YJBackColor;
        _MainTableView.delegate = self;
        _MainTableView.dataSource = self;
        [_MainTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
        _MainTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            
            _page = 1;
            [self RequestMethod];
        }];
        
        _MainTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            
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

- (BoxView *)boxView{
    
    if (!_boxView) {
        
        _boxView = [[BoxView alloc] initWithFrame:CGRectMake(0, STATUS_BAR_HEIGHT + 102 *SIZE, SCREEN_Width, SCREEN_Height - STATUS_BAR_HEIGHT - 102 *SIZE)];
    }
    return _boxView;
}

- (MoreView *)moreView{
    
    if (!_moreView) {
        
        _moreView = [[MoreView alloc] initWithFrame:CGRectMake(0, STATUS_BAR_HEIGHT + 102 *SIZE, SCREEN_Width, SCREEN_Height - 102 *SIZE)];
    }
    return _moreView;
}

@end
