//
//  MyAttentionVC.m
//  云渠道
//
//  Created by 谷治墙 on 2018/3/29.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "MyAttentionVC.h"
//#import "AttentionTableCell.h"
#import "RoomListModel.h"
#import "MyAttentionModel.h"
#import "PeopleCell.h"
#import "CompanyCell.h"
#import "RoomDetailVC1.h"

@interface MyAttentionVC ()<UITableViewDelegate,UITableViewDataSource>
{
    NSMutableArray *_dataArr;
    NSArray *_arr;
}
@property (nonatomic, strong) UITableView *attentionTable;

@end

@implementation MyAttentionVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initDataShource];
    [self initUI];

}

- (void)initDataShource{
    
    _arr = @[@[@[@"住宅",@"写字楼",@"商铺",@"别墅",@"公寓"],@[@"学区房",@"投资房"]],@[@[@"住宅",@"写字楼",@"商铺",@"别墅",@"公寓"],@[@"学区dd房",@"投资房"]],@[@[@"住宅",@"写字楼",@"商铺",@"别墅",@"公寓"],@[@"学区房",@"投资房的"]]];
    _dataArr = [@[] mutableCopy];
    [self RequestMethod];
}

- (void)RequestMethod{
    
    [BaseRequest GET:GetFocusProjectList_URL parameters:nil success:^(id resposeObject) {
        
//        NSLog(@"%@",resposeObject);

        if ([resposeObject[@"code"] integerValue] == 200) {
            
            [self SetData:resposeObject[@"data"]];
        }else{
            
            [self showContent:resposeObject[@"msg"]];
        }
    } failure:^(NSError *error) {
        
     
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
        
        MyAttentionModel *model = [[MyAttentionModel alloc] initWithDictionary:tempDic];
        
        [_dataArr addObject:model];
    }
    [_attentionTable reloadData];
}

#pragma table
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _dataArr.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 120*SIZE;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    MyAttentionModel *model = _dataArr[indexPath.row];
    if ([model.guarantee_brokerage integerValue] == 2) {
        
        static NSString *CellIdentifier = @"CompanyCell";
        
        CompanyCell *cell  = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (!cell) {
            cell = [[CompanyCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        [cell SetTitle:model.project_name image:model.img_url contentlab:model.absolute_address statu:model.sale_state];
       
        NSArray *tempArr3 = @[model.property_tags,model.project_tags_name.count? model.project_tags_name:@[]];
        [cell settagviewWithdata:tempArr3];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
        
    }else{
        
        static NSString *CellIdentifier = @"PeopleCell";
        
        PeopleCell *cell  = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (!cell) {
            cell = [[PeopleCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        [cell SetTitle:model.project_name image:model.img_url contentlab:model.absolute_address statu:model.sale_state];
        
        if ([model.guarantee_brokerage integerValue] == 1) {
            
            cell.surelab.hidden = NO;
        }else{
            
            cell.surelab.hidden = YES;
        }
        NSArray *tempArr3 = @[model.property_tags,model.project_tags_name.count? model.project_tags_name:@[]];
        [cell settagviewWithdata:tempArr3];
        
        cell.getLevel.hidden = YES;
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return YES;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return UITableViewCellEditingStyleDelete;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MyAttentionModel *model = _dataArr[indexPath.row];
    NSDictionary *dic = @{@"project_id":model.project_id};
    [BaseRequest GET:CancelFocusProject_URL parameters:dic success:^(id resposeObject) {
        
 
        if ([resposeObject[@"code"] integerValue] == 200) {
            
            [_dataArr removeObjectAtIndex:indexPath.row];
            [tableView reloadData];
        }        else{
            [self showContent:resposeObject[@"msg"]];
        }
    } failure:^(NSError *error) {
       
//        NSLog(@"%@",error);
        [self showContent:@"网络错误"];
    }];
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return @"取消关注";
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MyAttentionModel *model = _dataArr[indexPath.row];
    RoomDetailVC1 *nextVC = [[RoomDetailVC1 alloc] initWithModel:model];
    if ([model.guarantee_brokerage integerValue] == 2) {
        
        nextVC.brokerage = @"no";
    }else{
        
        nextVC.brokerage = @"yes";
    }
    nextVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:nextVC animated:YES];
}

- (void)initUI{
    
    self.navBackgroundView.hidden = NO;
    self.titleLabel.text = @"我的关注";
    
    _attentionTable = [[UITableView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, SCREEN_Width, SCREEN_Height - NAVIGATION_BAR_HEIGHT) style:UITableViewStylePlain];
    _attentionTable.backgroundColor = self.view.backgroundColor;
    _attentionTable.delegate = self;
    _attentionTable.dataSource = self;
    _attentionTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_attentionTable];
}
@end
