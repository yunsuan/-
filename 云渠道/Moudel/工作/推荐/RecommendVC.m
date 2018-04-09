//
//  RecommendVC.m
//  云渠道
//
//  Created by xiaoq on 2018/3/28.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "RecommendVC.h"
#import "RecommendCell.h"
#import "RecommendCell3.h"
#import "RecommendCell5.h"
#import "RecommendCollCell.h"
#import "UnconfirmDetailVC.h"


@interface RecommendVC ()<UITableViewDelegate,UITableViewDataSource,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
{
    
    NSInteger _index;
    NSArray *_titleArr;
}
@property (nonatomic , strong) UITableView *MainTableView;

@property (nonatomic, strong) UICollectionView *recommendColl;

@property (nonatomic, strong) UICollectionViewFlowLayout *flowLayout;

-(void)initUI;
-(void)initDateSouce;

@end

@implementation RecommendVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = YJBackColor;
    self.navBackgroundView.hidden = NO;
    self.leftButton.hidden = YES;
    self.titleLabel.text = @"推荐";
    self.leftButton.hidden = YES;
    [self initDateSouce];
    [self initUI];
    
}

-(void)initDateSouce
{
    
    _titleArr = @[@"未确认",@"已确认",@"有效",@"无效",@"申诉"];
}

-(void)initUI
{
    _flowLayout = [[UICollectionViewFlowLayout alloc] init];
    _flowLayout.minimumLineSpacing = 0;
    _flowLayout.minimumInteritemSpacing = 0;
    _flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    _flowLayout.itemSize = CGSizeMake(SCREEN_Width / 5, 40 *SIZE);
    
    _recommendColl = [[UICollectionView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, SCREEN_Width, 40 *SIZE) collectionViewLayout:_flowLayout];
    _recommendColl.backgroundColor = CH_COLOR_white;
    _recommendColl.delegate = self;
    _recommendColl.dataSource = self;
    _recommendColl.bounces = NO;
    [_recommendColl registerClass:[RecommendCollCell class] forCellWithReuseIdentifier:@"RecommendCollCell"];
    [self.view addSubview:_recommendColl];
    [_recommendColl selectItemAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:0] animated:YES scrollPosition:0];
    
    [self.view addSubview:self.MainTableView];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return 5;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    RecommendCollCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"RecommendCollCell" forIndexPath:indexPath];
    if (!cell) {

        cell = [[RecommendCollCell alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width /5, 40 *SIZE)];
    }
    cell.titleL.text = _titleArr[indexPath.item];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    _index = indexPath.item;
    [self.MainTableView reloadData];
}


#pragma mark  ---  delegate   ---

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (_index < 2) {
        
        return 127*SIZE;
        
    }else if (_index < 4){
        
        return 113 *SIZE;
    }else{
        
        return 108 *SIZE;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_index < 2) {
        
        static NSString *CellIdentifier = @"RecommendCell";
        
        RecommendCell *cell  = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (!cell) {
            cell = [[RecommendCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.nameL.text = @"张三";
        cell.projectL.text = @"推荐项目：云算公馆";
        cell.codeL.text = @"推荐编号：456522312";
        cell.confirmL.text = @"到访确认人：李四";
        cell.addressL.text = @"项目地址：四川-成都-郫都区";
        cell.timeL.text = @"失效截止时间：2017-12-15  13:00:00";
        
        return cell;
    }else if (_index < 4){
        
        static NSString *CellIdentifier = @"RecommendCell3";
        
        RecommendCell3 *cell  = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (!cell) {
            cell = [[RecommendCell3 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.nameL.text = @"张三";
        cell.codeL.text = @"推荐编号：456522312";
        cell.confirmL.text = @"到访确认人：李四";
        cell.timeL.text = @"失效截止时间：2017-12-15  13:00:00";
        cell.phoneL.text = @"18725455623";
        cell.statusL.text = @"已来访";
        
        return cell;
    }else{
        
        static NSString *CellIdentifier = @"RecommendCell5";
        
        RecommendCell5 *cell  = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (!cell) {
            cell = [[RecommendCell5 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.nameL.text = @"张三";
        cell.codeL.text = @"推荐编号：456522312";
        cell.confirmL.text = @"到访确认人：李四";
        cell.phoneL.text = @"联系电话：18789455612";
        cell.statusL.text = @"处理完成";
        cell.recomTimeL.text = @"推荐日期：2017-12-15";
        cell.timeL.text = @"申诉日期：2017-12-15  13:00:00";
        
        return cell;
    }
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
   
    if (_index == 0) {
        
        UnconfirmDetailVC *nextVC = [[UnconfirmDetailVC alloc] init];
        [self.navigationController pushViewController:nextVC animated:YES];
    }
}



#pragma mark  ---  懒加载   ---
-(UITableView *)MainTableView
{
    if(!_MainTableView)
    {
        _MainTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT + 41 *SIZE, 360*SIZE, SCREEN_Height-NAVIGATION_BAR_HEIGHT - 41 *SIZE) style:UITableViewStylePlain];
        _MainTableView.backgroundColor = YJBackColor;
        _MainTableView.delegate = self;
        _MainTableView.dataSource = self;
        [_MainTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
        //        _MainTableView.scrollEnabled = NO;
    }
    return _MainTableView;
}



@end
