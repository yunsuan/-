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
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(post) name:@"reloadMessList" object:nil];
    
    _data = @[@[@"systemmessage",@"系统消息",@"未读消息0条"],@[@"worknews",@"工作消息",@"未读消息0条"]];
    
    [self initUI];
   

}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    [self post];
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

    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell SetCellContentbyimg:_data[indexPath.row][0] title:_data[indexPath.row][1] content:_data[indexPath.row][2]];
    
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
    _messageTable.mj_header = [GZQGifHeader headerWithRefreshingBlock:^{
        [self post];
    }];
    [self.view addSubview:_messageTable];
}

-(void)post{
    [BaseRequest GET:InfoListCount_URL parameters:nil success:^(id resposeObject) {
        if ([resposeObject[@"code"] integerValue]==200) {
           NSInteger system = 0; //= [resposeObject[@"data"][@"system"][@"total"] integerValue]-[resposeObject[@"data"][@"system"][@"read"] integerValue];
//            if (system <0) {
//                system = 0;
//            }
            NSInteger working = [resposeObject[@"data"][@"work"][@"unread"] integerValue];
            if (working<0) {
                working = 0;
            }
            _data = @[@[@"systemmessage",@"系统消息",[NSString stringWithFormat:@"未读消息%ld条",system]],@[@"worknews",@"工作消息",[NSString stringWithFormat:@"未读消息%ld条",working]]];
    
            [_messageTable reloadData];
            [_messageTable.mj_header endRefreshing];

            if (working+system < 1) {
                
                [[[self.navigationController.tabBarController.viewControllers objectAtIndex:0] tabBarItem] setBadgeValue:nil];
            }else{
                
                [[[self.navigationController.tabBarController.viewControllers objectAtIndex:0] tabBarItem] setBadgeValue:[NSString stringWithFormat:@"%ld",working+system]];
            }
            
            [UIApplication sharedApplication].applicationIconBadgeNumber = working+system;
        }
        
    } failure:^(NSError *error) {
        [self showContent:@"网络错误"];
        [_messageTable.mj_header endRefreshing];
    }];
}

@end

