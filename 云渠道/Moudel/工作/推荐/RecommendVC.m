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
#import "InvalidVC.h"
#import "ValidVC.h"
#import "ComplaintVC.h"
#import "ComplaintUnCompleteVC.h"
#import "ComplaintCompleteVC.h"
#import "confirmDetailVC.h"
#import "CompleteCustomVC1.h"
#import "InvalidView.h"



@interface RecommendVC ()<UITableViewDelegate,UITableViewDataSource,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
{
    
    NSInteger _index;
    NSArray *_titleArr;
    NSMutableArray *_unComfirmArr;
    NSMutableArray *_validArr;
    NSMutableArray *_inValidArr;
    NSMutableArray *_appealArr;
}
@property (nonatomic , strong) UITableView *MainTableView;

@property (nonatomic, strong) UICollectionView *recommendColl;

@property (nonatomic, strong) UICollectionViewFlowLayout *flowLayout;

@property (nonatomic, strong) InvalidView *invalidView;

-(void)initUI;
-(void)initDateSouce;

@end

@implementation RecommendVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = YJBackColor;
    self.navBackgroundView.hidden = NO;
    self.titleLabel.text = @"新房推荐";
    [self initDateSouce];
    [self initUI];
    [self UnComfirmRequest];
    
}

-(void)initDateSouce
{
    _titleArr = @[@"确认中",@"有效",@"无效",@"申诉"];
    _unComfirmArr = [@[] mutableCopy];
    _validArr = [@[] mutableCopy];
    _inValidArr = [@[] mutableCopy];
    _appealArr = [@[] mutableCopy];
}

-(void)UnComfirmRequest{
    
    [BaseRequest GET:BrokerWaitConfirm_URL parameters:nil success:^(id resposeObject) {
        NSLog(@"%@",resposeObject);
        [self showContent:resposeObject[@"msg"]];
        if ([resposeObject[@"code"] integerValue] == 200) {
            
            [_unComfirmArr removeAllObjects];
            [self SetUnComfirmArr:resposeObject[@"data"][@"data"]];
        }
    } failure:^(NSError *error) {
        
        [self showContent:@"网络错误"];
        NSLog(@"%@",error);
    }];
}

- (void)SetUnComfirmArr:(NSArray *)data{
    
    for (int i = 0; i < data.count; i++) {
        
        NSMutableDictionary *tempDic = [[NSMutableDictionary alloc] initWithDictionary:data[i]];
        [tempDic enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
            
            if ([obj isKindOfClass:[NSNull class]]) {
                
                [tempDic setObject:@"" forKey:key];
            }
        }];
        
        [_unComfirmArr addObject:tempDic];
    }
    
    [_MainTableView reloadData];
}

- (void)ValidRequest{
    
    [BaseRequest GET:BrokerValue_URL parameters:nil success:^(id resposeObject) {
        NSLog(@"%@",resposeObject);
        [self showContent:resposeObject[@"msg"]];
        if ([resposeObject[@"code"] integerValue] == 200) {
            
            [_validArr removeAllObjects];
            [self SetValidArr:resposeObject[@"data"][@"data"]];
        }
    } failure:^(NSError *error) {
        
        [self showContent:@"网络错误"];
        NSLog(@"%@",error);
    }];
}

- (void)SetValidArr:(NSArray *)data{
    
//    [_validArr removeAllObjects];
    for (int i = 0; i < data.count; i++) {
        
        NSMutableDictionary *tempDic = [[NSMutableDictionary alloc] initWithDictionary:data[i]];
        [tempDic enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
           
            if ([obj isKindOfClass:[NSNull class]]) {
                
                [tempDic setObject:@"" forKey:key];
            }
        }];
        
        [_validArr addObject:tempDic];
    }
    
    [_MainTableView reloadData];
}

- (void)InValidRequest{
    
    [BaseRequest GET:BrokerDisabled_URL parameters:nil success:^(id resposeObject) {
        NSLog(@"%@",resposeObject);
        [self showContent:resposeObject[@"msg"]];
        if ([resposeObject[@"code"] integerValue] == 200) {
            
            [_inValidArr removeAllObjects];
            [self SetInValidArr:resposeObject[@"data"][@"data"]];
        }
    } failure:^(NSError *error) {
        
        [self showContent:@"网络错误"];
        NSLog(@"%@",error);
    }];
}

- (void)SetInValidArr:(NSArray *)data{
    
    for (int i = 0; i < data.count; i++) {
        
        NSMutableDictionary *tempDic = [[NSMutableDictionary alloc] initWithDictionary:data[i]];
        [tempDic enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
            
            if ([obj isKindOfClass:[NSNull class]]) {
                
                [tempDic setObject:@"" forKey:key];
            }
        }];
        
        [_inValidArr addObject:tempDic];
    }
    
    [_MainTableView reloadData];
}

- (void)ApealRequest{
    
    [BaseRequest GET:BrokerAppeal_URL parameters:nil success:^(id resposeObject) {
        NSLog(@"%@",resposeObject);
        [self showContent:resposeObject[@"msg"]];
        if ([resposeObject[@"code"] integerValue] == 200) {
            
            [_appealArr removeAllObjects];
            [self SetApealArr:resposeObject[@"data"][@"data"]];
        }
    } failure:^(NSError *error) {
        
        [self showContent:@"网络错误"];
        NSLog(@"%@",error);
    }];
}

- (void)SetApealArr:(NSArray *)data{
    
    for (int i = 0; i < data.count; i++) {
        
        NSMutableDictionary *tempDic = [[NSMutableDictionary alloc] initWithDictionary:data[i]];
        [tempDic enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
            
            if ([obj isKindOfClass:[NSNull class]]) {
                
                [tempDic setObject:@"" forKey:key];
            }
        }];
        
        [_appealArr addObject:tempDic];
    }
    
    [_MainTableView reloadData];
}

-(void)initUI
{
    _flowLayout = [[UICollectionViewFlowLayout alloc] init];
    _flowLayout.minimumLineSpacing = 0;
    _flowLayout.minimumInteritemSpacing = 0;
    _flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    _flowLayout.itemSize = CGSizeMake(SCREEN_Width / 4, 40 *SIZE);
    
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
    
    return 4;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    RecommendCollCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"RecommendCollCell" forIndexPath:indexPath];
    if (!cell) {

        cell = [[RecommendCollCell alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width /4, 40 *SIZE)];
    }
    cell.titleL.text = _titleArr[indexPath.item];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    _index = indexPath.item;
    [self.MainTableView reloadData];
    if (_index == 0) {
        
        if (_unComfirmArr.count) {
            
            [_MainTableView reloadData];
        }else{
            
            [self UnComfirmRequest];
        }
        
    }else if (_index == 1){
        
        if (_validArr.count) {
            
            [_MainTableView reloadData];
        }else{
            
            [self ValidRequest];
        }
    }else if (_index == 2){
        
        if (_inValidArr.count) {
            
            [_MainTableView reloadData];
        }else{
            
            [self InValidRequest];
        }
    }else{
        
        if (_appealArr.count) {
            
            [_MainTableView reloadData];
        }else{
            
           [self ApealRequest];
        }
    }
}


#pragma mark  ---  delegate   ---

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (_index == 0) {
        
        return _unComfirmArr.count;
    }else if (_index == 1){
        
        return _validArr.count;
    }else if (_index == 2){
        
        return _inValidArr.count;
    }else{
        
        return _appealArr.count;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (_index == 0) {
        
        return 132 *SIZE;
        
    }else if (_index < 3){
        
        return 107 *SIZE;
    }else{
        
        return 126 *SIZE;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_index == 0) {
        
        static NSString *CellIdentifier = @"RecommendCell";
        
        RecommendCell *cell  = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (!cell) {
            cell = [[RecommendCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.dataDic = _unComfirmArr[indexPath.row];
        
        cell.tag = indexPath.row;
        
        cell.confirmBtnBlock = ^(NSInteger index) {
            
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"确认到访" message:@"" preferredStyle:UIAlertControllerStyleActionSheet];
            
            UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                
            }];
            
            UIAlertAction *valid = [UIAlertAction actionWithTitle:@"有效到访" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {

                NSDictionary *dic = _unComfirmArr[index];
                CompleteCustomVC1 *nextVC = [[CompleteCustomVC1 alloc] initWithClientID:dic[@"client_id"] name:dic[@"name"]];
                [self.navigationController pushViewController:nextVC animated:YES];
            }];
            
            UIAlertAction *invalid = [UIAlertAction actionWithTitle:@"无效到访" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                self.invalidView.client_id = _unComfirmArr[indexPath.row][@"client_id"];
                [[UIApplication sharedApplication].keyWindow addSubview:self.invalidView];
            }];
            
            [alert addAction:valid];
            [alert addAction:invalid];
            [alert addAction:cancel];
            [self.navigationController presentViewController:alert animated:YES completion:^{
                
            }];
        };
        
        return cell;
    }else if (_index < 3){
        
        static NSString *CellIdentifier = @"RecommendCell3";
        
        RecommendCell3 *cell  = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (!cell) {
            cell = [[RecommendCell3 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        if (_index == 1) {
            
            cell.dataDic = _validArr[indexPath.row];
        }else{
            
            cell.inValidDic = _inValidArr[indexPath.row];
        }
        
        
        return cell;
    }else{
        
        static NSString *CellIdentifier = @"RecommendCell5";
        
        RecommendCell5 *cell  = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (!cell) {
            cell = [[RecommendCell5 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.dataDic = _appealArr[indexPath.row];
//        cell.nameL.text = @"张三";
//        cell.codeL.text = @"推荐编号：456522312";
//        cell.confirmL.text = @"到访确认人：李四";
//        cell.projectL.text = @"推荐项目：云算公馆";
////        cell.phoneL.text = @"联系电话：18789455612";
//        cell.statusL.text = @"处理完成";
//        cell.recomTimeL.text = @"推荐日期：2017-12-15";
//        cell.timeL.text = @"申诉日期：2017-12-15  13:00:00";
        
        return cell;
    }
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
   
    if (_index == 0) {
        
        UnconfirmDetailVC *nextVC = [[UnconfirmDetailVC alloc] initWithString:_unComfirmArr[indexPath.row][@"client_id"]];
    
        [self.navigationController pushViewController:nextVC animated:YES];
    }
    
//    if (_index == 1) {
//
//        confirmDetailVC *nextVC = [[confirmDetailVC alloc] init];
//        [self.navigationController pushViewController:nextVC animated:YES];
//    }
    if (_index == 1) {
        
        ValidVC *nextVC = [[ValidVC alloc] init];
        [self.navigationController pushViewController:nextVC animated:YES];
    }
    if (_index == 2) {
        
        
        InvalidVC *nextVC = [[InvalidVC alloc] initWithClientId:_inValidArr[indexPath.row][@"client_id"]];
        [self.navigationController pushViewController:nextVC animated:YES];
    }
    if (_index == 3) {
        
        if (indexPath.row == 0) {
            
            ComplaintCompleteVC *nextVC = [[ComplaintCompleteVC alloc] init];
            [self.navigationController pushViewController:nextVC animated:YES];
        }else{
            
            ComplaintUnCompleteVC *nextVC = [[ComplaintUnCompleteVC alloc] init];
            [self.navigationController pushViewController:nextVC animated:YES];
        }
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


- (InvalidView *)invalidView{
    
    if (!_invalidView) {
        
        _invalidView = [[InvalidView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width, SCREEN_Height)];
    }
    return _invalidView;
}


@end
