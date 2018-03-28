//
//  MessageVC.m
//  云渠道
//
//  Created by xiaoq on 2018/3/13.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "MessageVC.h"
#import "MessageTableCell.h"
#import "SystemMessageVC.h"
#import "WorkMessageVC.h"

@interface MessageVC ()<UITableViewDelegate,UITableViewDataSource>
{
    NSArray *_data;
}

@property (nonatomic, strong) UITableView *messageTable;

@end

@implementation MessageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    _data = @[@[@"systemmessage",@"系统消息",@"未读消息1条"],@[@"worknews",@"工作消息",@"未读消息两条"]];
    [self initUI];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 83 *SIZE;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString *Identifier = @"MessageTableCell";
    MessageTableCell *cell = [tableView dequeueReusableCellWithIdentifier:Identifier];
    if (!cell) {
        
        cell = [[MessageTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Identifier];
        [cell SetCellContentbyimg:_data[indexPath.row][0] title:_data[indexPath.row][1] content:_data[indexPath.row][2]];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        SystemMessageVC *next_vc = [[SystemMessageVC alloc]init];
        [self.navigationController pushViewController:next_vc  animated:YES];
    }
    else{
        WorkMessageVC *next_vc = [[WorkMessageVC alloc]init];
        [self.navigationController pushViewController:next_vc animated:YES];
    }
}

- (void)initUI{
    
    self.navBackgroundView.hidden = NO;
    self.leftButton.hidden = YES;
    self.titleLabel.text = @"消息";
    self.leftButton.hidden = YES;
    
    _messageTable = [[UITableView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, SCREEN_Width, SCREEN_Height - NAVIGATION_BAR_HEIGHT - TAB_BAR_HEIGHT) style:UITableViewStylePlain];
    _messageTable.backgroundColor = YJBackColor;
    _messageTable.delegate = self;
    _messageTable.dataSource = self;
    _messageTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.view addSubview:_messageTable];
}

@end

