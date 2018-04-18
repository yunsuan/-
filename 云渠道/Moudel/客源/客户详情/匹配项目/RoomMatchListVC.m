//
//  RoomMatchListVC.m
//  云渠道
//
//  Created by 谷治墙 on 2018/4/18.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "RoomMatchListVC.h"
#import "BoxView.h"
#import "MoreView.h"
#import "RoomCollCell.h"
#import "CustomDetailTableCell3.h"

@interface RoomMatchListVC ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UITableViewDelegate,UITableViewDataSource>
{
    NSArray *_arr;
    BOOL _upAndDown;
    NSMutableArray *_dataArr;
}

@property (nonatomic , strong) UITableView *matchListTable;

@property (nonatomic, strong) UICollectionView *matchListColl;

@property (nonatomic, strong) UICollectionViewFlowLayout *flowLayout;

@property (nonatomic, strong) BoxView *boxView;

@property (nonatomic, strong) UIImageView *upImg;

@property (nonatomic, strong) MoreView *moreView;

@end

@implementation RoomMatchListVC

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
//    [self RequestMethod];
}

#pragma mark -- collectionViewDelegate
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


#pragma mark -- tableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
//    return _dataArr.count;
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
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


-(void)initUI
{

    self.navBackgroundView.hidden = NO;
    self.titleLabel.text = @"选择项目";
    
    _flowLayout = [[UICollectionViewFlowLayout alloc] init];
    _flowLayout.minimumLineSpacing = 0;
    _flowLayout.minimumInteritemSpacing = 0;
    _flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    _flowLayout.itemSize = CGSizeMake(81 *SIZE, 40 *SIZE);
    
    _matchListColl = [[UICollectionView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, 324 *SIZE, 40 *SIZE) collectionViewLayout:_flowLayout];
    _matchListColl.backgroundColor = CH_COLOR_white;
    _matchListColl.delegate = self;
    _matchListColl.dataSource = self;
    _matchListColl.bounces = NO;
    [_matchListColl registerClass:[RoomCollCell class] forCellWithReuseIdentifier:@"RoomCollCell"];
    [self.view addSubview:_matchListColl];
    
//    _upImg = [[UIImageView alloc] initWithFrame:CGRectMake(334 *SIZE, 74 *SIZE, 13 *SIZE, 16 *SIZE)];
//    [self.headerView addSubview:_upImg];
//
//    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
//    btn.frame = CGRectMake(329 *SIZE, 69 *SIZE, 23 *SIZE, 26 *SIZE);
//    [btn addTarget:self action:@selector(ActionUpAndDownBtn:) forControlEvents:UIControlEventTouchUpInside];
//    [self.headerView addSubview:btn];
    
    [self.view addSubview:self.matchListTable];
}

#pragma mark  ---  懒加载   ---
-(UITableView *)matchListTable
{
    if(!_matchListTable)
    {
        _matchListTable =   [[UITableView alloc]initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT + 40 *SIZE , 360*SIZE, SCREEN_Height-NAVIGATION_BAR_HEIGHT - 40 *SIZE - TAB_BAR_MORE) style:UITableViewStylePlain];
        _matchListTable.backgroundColor = YJBackColor;
        _matchListTable.delegate = self;
        _matchListTable.dataSource = self;
        [_matchListTable setSeparatorStyle:UITableViewCellSeparatorStyleNone];
        _matchListTable.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            
//            _page = 1;
//            [self RequestMethod];
        }];
        
        _matchListTable.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            
//            [self RequestMethod];
        }];
    }
    return _matchListTable;
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
