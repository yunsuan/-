//
//  RoomVC.m
//  云渠道
//
//  Created by xiaoq on 2018/3/13.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "RoomVC.h"
#import "CompanyCell.h"
#import "PeopleCell.h"
#import "BoxView.h"
#import "RoomCollCell.h"

@interface RoomVC ()<UITableViewDelegate,UITableViewDataSource,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UITextFieldDelegate>
{
    NSArray *_arr;
    BOOL _upAndDown;
}

@property (nonatomic , strong) UITableView *MainTableView;
@property (nonatomic , strong) UIView *headerView;

@property (nonatomic, strong) UITextField *searchBar;

@property (nonatomic, strong) UICollectionView *customerColl;
@property (nonatomic, strong) UICollectionViewFlowLayout *flowLayout;
@property (nonatomic, strong) BoxView *boxView;
@property (nonatomic, strong) UIImageView *upImg;


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
    _arr = @[@[@"学区房",@"投资房"],@[@"简单的",@"送礼物",@"欧美风"],@[@"简单的",@"送礼物",@"欧美风"]];
}

-(void)initUI
{
    [self.view addSubview:self.headerView];
    
    _searchBar = [[UITextField alloc] initWithFrame:CGRectMake(58 *SIZE, 13 *SIZE, 292 *SIZE, 33 *SIZE)];
    _searchBar.backgroundColor = YJBackColor;
    _searchBar.leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 11 *SIZE, 0)];
    //设置显示模式为永远显示(默认不显示)
    _searchBar.leftViewMode = UITextFieldViewModeAlways;
    _searchBar.placeholder = @"小区/楼盘/商铺";
    _searchBar.font = [UIFont systemFontOfSize:11 *SIZE];
    _searchBar.returnKeyType = UIReturnKeySearch;
    UIImageView *rightImg = [[UIImageView alloc] initWithFrame:CGRectMake(0 *SIZE, 8 *SIZE, 17 *SIZE, 17 *SIZE)];
    rightImg.backgroundColor = YJGreenColor;
    _searchBar.rightView = rightImg;
    _searchBar.rightViewMode = UITextFieldViewModeUnlessEditing;
    _searchBar.clearButtonMode = UITextFieldViewModeWhileEditing;
    _searchBar.delegate = self;
    [self.headerView addSubview:_searchBar];
    
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
        
        [[[UIApplication sharedApplication] keyWindow] addSubview:self.boxView];
    }else{
        
        [self.boxView removeFromSuperview];
        
    }
}

#pragma mark  ---  delegate   ---

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
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
    
    if (indexPath.row == 1) {
        static NSString *CellIdentifier = @"CompanyCell";
        
        CompanyCell *cell  = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (!cell) {
            cell = [[CompanyCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        //    [cell setTitle:_namelist[indexPath.row] content:@"123" img:@""];
        [cell SetTitle:@"新希望国际" image:@"" contentlab:@"高新区——天府三街" statu:@"在售"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else
    {
        static NSString *CellIdentifier = @"PeopleCell";
        
        PeopleCell *cell  = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (!cell) {
            cell = [[PeopleCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        //    [cell setTitle:_namelist[indexPath.row] content:@"123" img:@""];
        [cell SetTitle:@"新希望国际" image:@"" contentlab:@"高新区——天府三街" statu:@"在售"];
        [cell settagviewWithdata:_arr[indexPath.row]];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
   
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
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

@end
