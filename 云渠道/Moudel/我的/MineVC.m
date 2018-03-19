//
//  MineVC.m
//  云渠道
//
//  Created by xiaoq on 2018/3/13.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "MineVC.h"
#import "MineCell.h"

@interface MineVC ()<UITableViewDelegate,UITableViewDataSource>
{
    NSArray *_namelist;
}
@property (nonatomic , strong) UITableView *Mytableview;
@end

@implementation MineVC


- (void)viewDidLoad {
    [super viewDidLoad];
    [self InitDataSouce];
    [self InitUI];
    
    // Do any additional setup after loading the view.
}

-(void)InitUI{
    [self.view addSubview:self.Mytableview];
}

-(void)InitDataSouce
{
    _namelist = @[@[@"公司认证",@"工作经历"],@[@"我的佣金",@"我的订阅",@"我的关注"],@[@"意见反馈",@"关于易家",@"退出登录"]];
}



#pragma mark  ---  delegate  ---
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 2;
    }
    else
        return 3;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
   
    return 3;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 45*SIZE;
}

//-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
//{
//    return 20*SIZE;
//}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 360*SIZE, 10*SIZE)];
    view.backgroundColor = [UIColor clearColor];
    return view;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"MineCell";
    
    MineCell *cell  = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[MineCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    [cell SetTitle:_namelist[indexPath.section][indexPath.row] icon:@"" contentlab:@""];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if(indexPath.section == 0)
    {
        
    }
    else if (indexPath.section ==1)
    {
        
    }else
    {
        if (indexPath.row == 0) {
            
        }
        else if(indexPath.row ==1)
        {
            
        }else{
            
            
            [self alertControllerWithNsstring:@"温馨提示" And:@"你确定要退出当前账号吗？" WithCancelBlack:^{
                
            } WithDefaultBlack:^{
                [[NSUserDefaults standardUserDefaults] removeObjectForKey:LOGINENTIFIER];
                [[NSNotificationCenter defaultCenter]postNotificationName:@"goLoginVC" object:nil];
                
            }];
        }
        
    }
//    switch (indexPath.row) {
//        case 0:
//        {
//            MyCommissionVC *next_vc = [[MyCommissionVC alloc]init];
//            [self.navigationController pushViewController:next_vc animated:YES];
//        }
//            break;
//        case 1:
//        {
//            MyAttentionVC *next_vc = [[MyAttentionVC alloc]init];
//            [self.navigationController pushViewController:next_vc animated:YES];
//        }
//            break;
//        case 2:
//        {
//            FixPassWrodVC *next_vc = [[FixPassWrodVC alloc]init];
//            [self.navigationController pushViewController:next_vc animated:YES];
//
//        }
//            break;
//        case 3:
//        {
//            AbortVC *next_vc = [[AbortVC alloc]init];
//            [self.navigationController pushViewController:next_vc animated:YES];
//        }
//            break;
//        case 4:
//        {
    
//            [self alertControllerWithNsstring:@"温馨提示" And:@"你确定要退出当前账号吗？" WithCancelBlack:^{
//
//            } WithDefaultBlack:^{
//                [[NSUserDefaults standardUserDefaults] removeObjectForKey:LOGINENTIFIER];
//                [[NSNotificationCenter defaultCenter]postNotificationName:@"goLoginVC" object:nil];
//
//            }];
//
//        }
//            break;
//
//        default:
//            break;
//    }
}

#pragma mark  ---  懒加载   ---

-(UITableView *)Mytableview
{
    if(!_Mytableview)
    {
        _Mytableview =   [[UITableView alloc]initWithFrame:CGRectMake(0, STATUS_BAR_HEIGHT+115*SIZE, 360*SIZE, SCREEN_Height-STATUS_BAR_HEIGHT-115*SIZE) style:UITableViewStylePlain];
        _Mytableview.backgroundColor = YJBackColor;
        _Mytableview.delegate = self;
        _Mytableview.dataSource = self;
        [_Mytableview setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    }
    return _Mytableview;
}


@end
