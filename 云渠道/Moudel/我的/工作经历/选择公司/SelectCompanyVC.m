//
//  SelectCompanyVC.m
//  云渠道
//
//  Created by 谷治墙 on 2018/3/23.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "SelectCompanyVC.h"
#import "SelectCompanyTableCell.h"
#import "SelectCompanyCollCell.h"
#import "BoxView.h"
#import "CompanyDetailVC.h"

@interface SelectCompanyVC ()<UITableViewDelegate,UITableViewDataSource,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UITextFieldDelegate>

@property (nonatomic, strong) UITableView *selecTable;

@property (nonatomic, strong) UITextField *searchBar;
@property (nonatomic, strong) UICollectionView *selectColl;
@property (nonatomic, strong) UICollectionViewFlowLayout *flowLayout;
@property (nonatomic, strong) BoxView *boxView;

@end

@implementation SelectCompanyVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initUI];
}


#pragma mark --coll代理
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return 3;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    SelectCompanyCollCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"SelectCompanyCollCell" forIndexPath:indexPath];
    if (!cell) {
        
        cell = [[SelectCompanyCollCell alloc] initWithFrame:CGRectMake(0, 0, 120 *SIZE, 40 *SIZE)];
    }
    
    cell.typeL.text = @"四川省";
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    [[[UIApplication sharedApplication] keyWindow] addSubview:self.boxView];
}

#pragma mark --table代理
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 100 *SIZE;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString * Identifier = @"SelectCompanyTableCell";
    SelectCompanyTableCell *cell = [tableView dequeueReusableCellWithIdentifier:Identifier];
    if (!cell) {
        
        cell = [[SelectCompanyTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Identifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CompanyDetailVC *nextVC = [[CompanyDetailVC alloc] init];
    nextVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:nextVC animated:YES];
}

- (void)initUI{
    
    
    UIView *whiteView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width, 160 *SIZE)];
    whiteView.backgroundColor = CH_COLOR_white;
    [self.view addSubview:whiteView];
    
    UILabel *titleL = [[UILabel alloc] init];
    titleL.center = CGPointMake(SCREEN_Width / 2, STATUS_BAR_HEIGHT+20 );
    titleL.bounds = CGRectMake(0, 0, 180 * sIZE, 30 * sIZE);
    titleL.textAlignment = NSTextAlignmentCenter;
    titleL.textColor = [UIColor blackColor];
    titleL.font = [UIFont systemFontOfSize:17 * sIZE];
    titleL.text = @"选择公司";
    [whiteView addSubview:titleL];
    
    _searchBar = [[UITextField alloc] initWithFrame:CGRectMake(10 *SIZE, 84 *SIZE, 340 *SIZE, 33 *SIZE)];
    _searchBar.backgroundColor = YJBackColor;
    _searchBar.leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 11 *SIZE, 0)];
    //设置显示模式为永远显示(默认不显示)
    _searchBar.leftViewMode = UITextFieldViewModeAlways;
    _searchBar.placeholder = @"请输入公司名称/营业执照号查询";
    _searchBar.font = [UIFont systemFontOfSize:12 *SIZE];
    _searchBar.layer.cornerRadius = 2 *SIZE;
    _searchBar.returnKeyType = UIReturnKeySearch;
    
    UIImageView *rightImg = [[UIImageView alloc] initWithFrame:CGRectMake(0 *SIZE, 8 *SIZE, 17 *SIZE, 17 *SIZE)];
    rightImg.backgroundColor = YJGreenColor;
    _searchBar.rightView = rightImg;
    _searchBar.rightViewMode = UITextFieldViewModeUnlessEditing;
    _searchBar.clearButtonMode = UITextFieldViewModeWhileEditing;
    _searchBar.delegate = self;
    [whiteView addSubview:_searchBar];
    
    _flowLayout = [[UICollectionViewFlowLayout alloc] init];
    _flowLayout.minimumLineSpacing = 0;
    _flowLayout.minimumInteritemSpacing = 0;
    _flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    _flowLayout.itemSize = CGSizeMake(120 *SIZE, 40 *SIZE);
    
    _selectColl = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 120 *SIZE, SCREEN_Width, 40 *SIZE) collectionViewLayout:_flowLayout];
    _selectColl.backgroundColor = CH_COLOR_white;
    _selectColl.delegate = self;
    _selectColl.dataSource = self;
    _selectColl.bounces = NO;
    [_selectColl registerClass:[SelectCompanyCollCell class] forCellWithReuseIdentifier:@"SelectCompanyCollCell"];
    [whiteView addSubview:_selectColl];
    
    _selecTable = [[UITableView alloc] initWithFrame:CGRectMake(0, STATUS_BAR_HEIGHT + 141 *SIZE, SCREEN_Width, SCREEN_Height - 141 *SIZE - STATUS_BAR_HEIGHT) style:UITableViewStylePlain];
    _selecTable.backgroundColor = self.view.backgroundColor;
    _selecTable.delegate = self;
    _selecTable.dataSource = self;
    _selecTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_selecTable];
}

- (BoxView *)boxView{
    
    if (!_boxView) {
        
        _boxView = [[BoxView alloc] initWithFrame:CGRectMake(0, STATUS_BAR_HEIGHT + 140 *SIZE, SCREEN_Width, SCREEN_Height - STATUS_BAR_HEIGHT - 140 *SIZE)];
    }
    return _boxView;
}

@end
