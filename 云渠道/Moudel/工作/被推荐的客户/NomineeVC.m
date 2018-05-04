//
//  NomineeVC.m
//  云渠道
//
//  Created by xiaoq on 2018/3/28.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "NomineeVC.h"
//#import "NomineeCollCell.h"
#import "RecommendCollCell.h"
#import "NomineeCell.h"
#import "NomineeCell2.h"
#import "NomineeCell3.h"
#import "RecommendCell5.h"
//#import "UnconfirmDetailVC.h"
#import "confirmDetailVC.h"
#import "CompleteCustomVC1.h"
#import "InvalidView.h"
#import "NoInvalidVC.h"
#import "ValidVC.h"
#import "ComplaintCompleteVC.h"
#import "ComplaintUnCompleteVC.h"

@interface NomineeVC ()<UITableViewDelegate,UITableViewDataSource,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
{
    
    NSInteger _index;
    NSArray *_titleArr;
    NSMutableArray *_unComfirmArr;
    NSMutableArray *_validArr;
    NSMutableArray *_inValidArr;
    NSMutableArray *_appealArr;
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
    [self UnComfirmRequest];
}

-(void)initDateSouce
{
    
    _titleArr = @[@"待确认",@"有效",@"无效",@"申诉"];
    _unComfirmArr = [@[] mutableCopy];
    _validArr = [@[] mutableCopy];
    _inValidArr = [@[] mutableCopy];
    _appealArr = [@[] mutableCopy];
}

-(void)UnComfirmRequest{
    
    [BaseRequest GET:ProjectWaitConfirm_URL parameters:nil success:^(id resposeObject) {
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
    
    [BaseRequest GET:ProjectValue_URL parameters:nil success:^(id resposeObject) {
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
    
    self.navBackgroundView.hidden = NO;
    self.titleLabel.text = @"报备的客户";
    self.line.hidden = YES;
    
    _flowLayout = [[UICollectionViewFlowLayout alloc] init];
    _flowLayout.minimumLineSpacing = 0;
    _flowLayout.minimumInteritemSpacing = 0;
    _flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    _flowLayout.itemSize = CGSizeMake(SCREEN_Width / 4, 40 *SIZE);
    
    _nomineeColl = [[UICollectionView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, SCREEN_Width, 40 *SIZE) collectionViewLayout:_flowLayout];
    _nomineeColl.backgroundColor = CH_COLOR_white;
    _nomineeColl.delegate = self;
    _nomineeColl.dataSource = self;
    _nomineeColl.bounces = NO;
    [_nomineeColl registerClass:[RecommendCollCell class] forCellWithReuseIdentifier:@"RecommendCollCell"];
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
    
    return 4;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    RecommendCollCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"RecommendCollCell" forIndexPath:indexPath];
    if (!cell) {
        
        cell = [[RecommendCollCell alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width / 4, 40 *SIZE)];
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
    
    if (_index == 2) {
        
        return 133 *SIZE;
    }else if (_index == 3){
        
        return 103 *SIZE;
    }
    return 128 *SIZE;
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
        
        cell.dataDic = _unComfirmArr[indexPath.row];
        cell.tag = indexPath.row;
        cell.phoneBtnBlock = ^(NSInteger index) {
            
            NSString *phone = [_unComfirmArr[index][@"tel"] componentsSeparatedByString:@","][0];
            if (phone.length) {
                
                //获取目标号码字符串,转换成URL
                NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",phone]];
                //调用系统方法拨号
                [[UIApplication sharedApplication] openURL:url];
            }else{
                
                [self alertControllerWithNsstring:@"温馨提示" And:@"暂时未获取到联系电话"];
            }
        };
        
       
        return cell;
    }else if (_index == 1){
        
        static NSString *CellIdentifier = @"NomineeCell2";
        
        NomineeCell2 *cell  = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (!cell) {
            cell = [[NomineeCell2 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.dataDic = _validArr[indexPath.row];
        cell.tag = indexPath.row;
        cell.phoneBtnBlock = ^(NSInteger index) {
            
            NSString *phone = [_validArr[index][@"tel"] componentsSeparatedByString:@","][0];
            if (phone.length) {
                
                //获取目标号码字符串,转换成URL
                NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",phone]];
                //调用系统方法拨号
                [[UIApplication sharedApplication] openURL:url];
            }else{
                
                [self alertControllerWithNsstring:@"温馨提示" And:@"暂时未获取到联系电话"];
            }
        };
        
        return cell;
    }else if(_index == 2){
        
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
        //        cell.phoneL.text = @"联系电话：18789455612";
        cell.statusL.text = @"处理完成";
        cell.recomTimeL.text = @"推荐日期：2017-12-15";
        cell.timeL.text = @"申诉日期：2017-12-15  13:00:00";
        
        return cell;
    }
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (_index == 0) {
        
        confirmDetailVC *nextVC = [[confirmDetailVC alloc] init];
        [self.navigationController pushViewController:nextVC animated:YES];
    }else if(_index == 1) {
        
        ValidVC *nextVC = [[ValidVC alloc] init];
        [self.navigationController pushViewController:nextVC animated:YES];
    }else if(_index == 2){
        
        NoInvalidVC *nextVC = [[NoInvalidVC alloc] init];
        [self.navigationController pushViewController:nextVC animated:YES];
    }else{
        
        if (indexPath.row == 0) {
            
            ComplaintCompleteVC *nextVC = [[ComplaintCompleteVC alloc] init];
            [self.navigationController pushViewController:nextVC animated:YES];
        }else{
            
            ComplaintUnCompleteVC *nextVC = [[ComplaintUnCompleteVC alloc] init];
            [self.navigationController pushViewController:nextVC animated:YES];
        }
    }
}

- (InvalidView *)invalidView{
    
    if (!_invalidView) {
        
        _invalidView = [[InvalidView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width, SCREEN_Height)];
    }
    return _invalidView;
}




@end
