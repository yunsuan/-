//
//  SystemMessageVC.m
//  云渠道
//
//  Created by xiaoq on 2018/3/23.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "SystemMessageVC.h"
#import "SystemMessageCell.h"
#import "InfoDetailVC.h"

@interface SystemMessageVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic , strong) UITableView *systemmsgtable;


-(void)initUI;
-(void)initDateSouce;

@end

@implementation SystemMessageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = YJBackColor;
    self.navBackgroundView.hidden = NO;
    self.titleLabel.text = @"系统消息";
    [self initDateSouce];
    [self initUI];
    
}

-(void)initDateSouce
{

}

-(void)initUI
{
    [self.view addSubview:self.systemmsgtable];
    
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
    return 110*SIZE;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    

        static NSString *CellIdentifier = @"SystemMessageCell";
        
        SystemMessageCell *cell  = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (!cell) {
            cell = [[SystemMessageCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
 
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
   
    
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    InfoDetailVC * next_vc =[[InfoDetailVC alloc]init];
    [self.navigationController pushViewController:next_vc animated:YES];
}



#pragma mark  ---  懒加载   ---
-(UITableView *)systemmsgtable
{
    if(!_systemmsgtable)
    {
        _systemmsgtable =   [[UITableView alloc]initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, 360*SIZE, SCREEN_Height-NAVIGATION_BAR_HEIGHT) style:UITableViewStylePlain];
        _systemmsgtable.backgroundColor = YJBackColor;
        _systemmsgtable.delegate = self;
        _systemmsgtable.dataSource = self;
        [_systemmsgtable setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    }
    return _systemmsgtable;
}



@end
