//
//  NomineeVC.m
//  云渠道
//
//  Created by xiaoq on 2018/3/28.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "NomineeVC.h"
#import "NomineeCollCell.h"
#import "NomineeCell.h"
#import "NomineeCell2.h"
#import "NomineeCell3.h"
#import "UnconfirmDetailVC.h"
#import "CompleteCustomVC1.h"
#import "InvalidView.h"
#import "NoInvalidVC.h"
#import "ValidVC.h"

@interface NomineeVC ()<UITableViewDelegate,UITableViewDataSource,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
{
    
    NSInteger _index;
    NSArray *_titleArr;
}
@property (nonatomic , strong) UITableView *MainTableView;

@property (nonatomic, strong) UICollectionView *nomineeColl;

@property (nonatomic, strong) UICollectionViewFlowLayout *flowLayout;

@property (nonatomic, strong) InvalidView *invalidView;

-(void)initUI;
-(void)initDateSouce;
@end

@implementation NomineeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initDateSouce];
    [self initUI];
    
}

-(void)initDateSouce
{
    
    _titleArr = @[@"待确认",@"有效",@"无效"];
}

-(void)initUI
{
    
    self.navBackgroundView.hidden = NO;
    self.titleLabel.text = @"报备的客户";
    self.line.hidden = YES;
    
    _flowLayout = [[UICollectionViewFlowLayout alloc] init];
    _flowLayout.minimumLineSpacing = 0;
    _flowLayout.minimumInteritemSpacing = 0;
    _flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    _flowLayout.itemSize = CGSizeMake(SCREEN_Width / 3, 40 *SIZE);
    
    _nomineeColl = [[UICollectionView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, SCREEN_Width, 40 *SIZE) collectionViewLayout:_flowLayout];
    _nomineeColl.backgroundColor = CH_COLOR_white;
    _nomineeColl.delegate = self;
    _nomineeColl.dataSource = self;
    _nomineeColl.bounces = NO;
    [_nomineeColl registerClass:[NomineeCollCell class] forCellWithReuseIdentifier:@"NomineeCollCell"];
    [self.view addSubview:_nomineeColl];
    [_nomineeColl selectItemAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:0] animated:YES scrollPosition:0];
    
    _MainTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT + 41 *SIZE, 360*SIZE, SCREEN_Height-NAVIGATION_BAR_HEIGHT - 41 *SIZE) style:UITableViewStylePlain];
    _MainTableView.backgroundColor = YJBackColor;
    _MainTableView.delegate = self;
    _MainTableView.dataSource = self;
    [_MainTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.view addSubview:_MainTableView];
}




#pragma mark  ---  delegate   ---

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return 3;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    NomineeCollCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"NomineeCollCell" forIndexPath:indexPath];
    if (!cell) {
        
        cell = [[NomineeCollCell alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width /3, 40 *SIZE)];
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
    
    if (_index == 2) {
        
        return 120 *SIZE;
    }
    return 108 *SIZE;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
        
    if (_index == 0) {
        
        static NSString *CellIdentifier = @"NomineeCell";
        
        NomineeCell *cell  = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (!cell) {
            cell = [[NomineeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.nameL.text = @"张三";
        cell.codeL.text = @"推荐编号：456522312";
        cell.reportTimeL.text = @"报备日期：2017-12-12";
        cell.timeL.text = @"失效时间：2017-12-15";
        cell.tag = indexPath.row;
        cell.phoneBtnBlock = ^(NSInteger index) {
            
            
        };
        cell.confirmBtnBlock = ^(NSInteger index) {
            
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"确认到访" message:@"" preferredStyle:UIAlertControllerStyleActionSheet];
            
            UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                
            }];
            
            UIAlertAction *valid = [UIAlertAction actionWithTitle:@"有效到访" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                
                CompleteCustomVC1 *nextVC = [[CompleteCustomVC1 alloc] init];
                [self.navigationController pushViewController:nextVC animated:YES];
            }];
            
            UIAlertAction *invalid = [UIAlertAction actionWithTitle:@"无效到访" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                
                [[UIApplication sharedApplication].keyWindow addSubview:self.invalidView];
            }];
            
            [alert addAction:valid];
            [alert addAction:invalid];
            [alert addAction:cancel];
            [self.navigationController presentViewController:alert animated:YES completion:^{
                
            }];
        };
        return cell;
    }else if (_index == 1){
        
        static NSString *CellIdentifier = @"NomineeCell2";
        
        NomineeCell2 *cell  = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (!cell) {
            cell = [[NomineeCell2 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.nameL.text = @"张三";
        cell.codeL.text = @"推荐编号：456522312";
        cell.contactL.text = @"置业顾问：丽萨";
        cell.reportTimeL.text = @"报备日期：2017-12-12";
        cell.tag = indexPath.row;
        cell.phoneBtnBlock = ^(NSInteger index) {
            
            
        };
        
        return cell;
    }else{
        
        static NSString *CellIdentifier = @"NomineeCell3";
        
        NomineeCell3 *cell  = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (!cell) {
            cell = [[NomineeCell3 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.nameL.text = @"张三";
        cell.codeL.text = @"推荐编号：456522312";
        cell.projectL.text = @"项目名称：云算公馆";
        cell.reportTimeL.text = @"报备日期：2017-12-12  12:00:00";
        cell.timeL.text = @"失效时间：2017-12-15  13:00:00";
        cell.statusL.text = @"未到访失效";
        cell.tag = indexPath.row;
        cell.messBtnBlock = ^(NSInteger index) {
            
            
        };
        cell.phoneBtnBlock = ^(NSInteger index) {
            
            
        };
        return cell;
    }
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (_index == 0) {
        
        UnconfirmDetailVC *nextVC = [[UnconfirmDetailVC alloc] initWithString:@"recommended"];
        [self.navigationController pushViewController:nextVC animated:YES];
    }else if(_index == 1) {
        
        ValidVC *nextVC = [[ValidVC alloc] init];
        [self.navigationController pushViewController:nextVC animated:YES];
    }else{
        
        NoInvalidVC *nextVC = [[NoInvalidVC alloc] init];
        [self.navigationController pushViewController:nextVC animated:YES];
    }
}

- (InvalidView *)invalidView{
    
    if (!_invalidView) {
        
        _invalidView = [[InvalidView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width, SCREEN_Height)];
    }
    return _invalidView;
}




@end
