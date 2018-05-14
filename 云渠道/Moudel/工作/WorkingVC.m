//
//  WorkingVC.m
//  云渠道
//
//  Created by xiaoq on 2018/3/13.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "WorkingVC.h"
#import "WorkingCell.h"
#import "RecommendVC.h"
#import "NomineeVC.h"
#import "BarginVC.h"

@interface WorkingVC ()<UITableViewDelegate,UITableViewDataSource>
{
    NSArray *_namelist;
    NSArray *_imglist;
    NSArray *_countdata;
}

@property (nonatomic , strong) UITableView *MainTableView;

-(void)initUI;
-(void)initDateSouce;
@end

@implementation WorkingVC

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self postWithidentify:[UserModelArchiver unarchive].agent_identity];

    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = YJBackColor;
    self.navBackgroundView.hidden = NO;
    self.leftButton.hidden = YES;
    self.titleLabel.text = @"工作";
     self.leftButton.hidden = YES;
    [self initDateSouce];
    [self initUI];

}

-(void)refresh{
    

}

-(void)postWithidentify:(NSString *)identify
{
    switch ([identify integerValue]) {
        case 1:
        {
            _namelist = @[@"新房推荐",@"客户报备",@"成交客户"];
            _imglist = @[@"recommended",@"client",@"Clinchadeal"];
            [BaseRequest GET:AgentInfoCount_URL parameters:nil success:^(id resposeObject) {
            _countdata = @[[NSString stringWithFormat:@"累计推荐%@，有效%@，无效%@",resposeObject[@"data"][@"recommend"][@"recommend_count"],resposeObject[@"data"][@"recommend"][@"value"],resposeObject[@"data"][@"recommend"][@"disabled"]],[NSString stringWithFormat:@"累计报备%@，有效%@，无效%@",resposeObject[@"data"][@"preparation"][@"count"],resposeObject[@"data"][@"preparation"][@"value"],resposeObject[@"data"][@"preparation"][@"disabled"]],[NSString stringWithFormat:@"累计报备%@，有效%@，无效%@",resposeObject[@"data"][@"preparation"][@"count"],resposeObject[@"data"][@"preparation"][@"value"],resposeObject[@"data"][@"preparation"][@"disabled"]],[NSString stringWithFormat:@"累计人数%@，成交%@，为成交%@",resposeObject[@"data"][@"preparation"][@"count"],resposeObject[@"data"][@"preparation"][@"value"],resposeObject[@"data"][@"preparation"][@"disabled"]]];
                [_MainTableView reloadData];
            } failure:^(NSError *error) {
                
            }];
        }
            break;
        case 2:{
            _namelist = @[@"客户报备"];
            _imglist = @[@"client"];
            _countdata  = @[@""];
            [BaseRequest GET:Butterinfocount_URL parameters:nil success:^(id resposeObject) {
                _countdata = @[[NSString stringWithFormat:@"累计报备%@，有效%@，无效%@",resposeObject[@"data"][@"recommend_count"],resposeObject[@"data"][@"value"],resposeObject[@"data"][@"valueDisabled"]]];
                [_MainTableView reloadData];
            } failure:^(NSError *error) {

            }];
        }
            break;
        
        default:{
            break;
        }
            
    }

    
}

-(void)initDateSouce
{
    _countdata  = @[@""];
}

-(void)initUI
{
    [self.view addSubview:self.MainTableView];
}



#pragma mark  ---  delegate   ---

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _countdata.count;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 84*SIZE;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"WorkingCell";
    
    WorkingCell *cell  = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[WorkingCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    [cell setTitle:_namelist[indexPath.row] content:_countdata[indexPath.row] img:_imglist[indexPath.row]];
    return cell;
    
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (_countdata.count ==3) {
        if (indexPath.row == 0) {
            
            RecommendVC *nextVC = [[RecommendVC alloc] init];
            [self.navigationController pushViewController:nextVC animated:YES];
        }else{
            
            NomineeVC *nextVC = [[NomineeVC alloc] init];
            [self.navigationController pushViewController:nextVC animated:YES];
        }
    }
    else{
        if (indexPath.row == 0) {
            
            RecommendVC *nextVC = [[RecommendVC alloc] init];
            [self.navigationController pushViewController:nextVC animated:YES];
        }else if(indexPath.row == 1){
            
            NomineeVC *nextVC = [[NomineeVC alloc] init];
            [self.navigationController pushViewController:nextVC animated:YES];
        }else{
            
            BarginVC *nextVC = [[BarginVC alloc] init];
            [self.navigationController pushViewController:nextVC animated:YES];
        }
    }
 
}



#pragma mark  ---  懒加载   ---
-(UITableView *)MainTableView
{
    if(!_MainTableView)
    {
        _MainTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT+1*SIZE, 360*SIZE, SCREEN_Height-NAVIGATION_BAR_HEIGHT-1*SIZE) style:UITableViewStylePlain];
        _MainTableView.backgroundColor = YJBackColor;
        _MainTableView.delegate = self;
        _MainTableView.dataSource = self;
        [_MainTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    }
    return _MainTableView;
}



@end
