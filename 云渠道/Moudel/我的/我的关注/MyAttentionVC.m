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
#import "RoomDetailVC1.h"
#import "RoomListModel.h"


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
        
        NSLog(@"%@",resposeObject);

        if ([resposeObject[@"code"] integerValue] == 200) {
            
            if (![resposeObject[@"data"] isKindOfClass:[NSNull class]]) {
                
                if ([resposeObject[@"data"][@"data"] isKindOfClass:[NSArray class]]) {
                    
                    [self SetData:resposeObject[@"data"][@"data"]];
                }else{
                    
//                    [self showContent:@"暂无关注"];
                }
            }else{
                
//                [self showContent:@"暂无关注"];
            }
        }        else{
            [self showContent:resposeObject[@"msg"]];
        }
    } failure:^(NSError *error) {
        
        NSLog(@"%@",error);
        NSLog(@"%@",error.localizedDescription);
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
    
    static NSString *CellIdentifier = @"PeopleCell";
    
    PeopleCell *cell  = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[PeopleCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    MyAttentionModel *model = _dataArr[indexPath.row];
    [cell SetTitle:model.project_name image:model.img_url contentlab:model.absolute_address statu:model.sale_state];
    
    NSArray *tempArr1 = @[model.property_tags,model.project_tags_name];
    [cell settagviewWithdata:tempArr1];
    cell.getLevel.hidden = YES;
    
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
       
        NSLog(@"%@",error);
        [self showContent:@"网络错误"];
    }];
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return @"取消关注";
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    RoomListModel *model = [[RoomListModel alloc]init];
    MyAttentionModel *attention = _dataArr[indexPath.row];
//    NSDictionary *dic = @{@"project_id":attention.project_id};
    model.project_id =attention.project_id;
    RoomDetailVC1 *nextVC = [[RoomDetailVC1 alloc] initWithModel:model];
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
