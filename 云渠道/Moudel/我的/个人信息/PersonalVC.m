//
//  PersonalVC.m
//  云渠道
//
//  Created by 谷治墙 on 2018/3/28.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "PersonalVC.h"
#import "PersonalTableCell.h"

@interface PersonalVC ()<UITableViewDelegate,UITableViewDataSource>
{
    
    NSArray *_titleArr;
    NSMutableArray *_contentArr;
}
@property (nonatomic, strong) UITableView *personTable;

@end

@implementation PersonalVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initDataSource];
    [self initUI];
}

- (void)initDataSource{
    
    _titleArr = @[@"头像",@"运算编号",@"我的二维码",@"姓名",@"电话号码",@"性别",@"出生年月",@"住址",@"修改密码"];
    _contentArr = [[NSMutableArray alloc] initWithArray:_titleArr];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 9;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    PersonalTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PersonalTableCell"];
    if (!cell) {
        
        cell = [[PersonalTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"PersonalTableCell"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.titleL.text = _titleArr[indexPath.row];
    cell.contentL.text = _contentArr[indexPath.row];
    if (indexPath.row == 0) {
        
        cell.contentL.hidden = YES;
        cell.headImg.hidden = NO;
    }else{
        
        cell.contentL.hidden = NO;
        cell.headImg.hidden = YES;
    }
    
    if (indexPath.row == 1) {
        
        cell.rightView.hidden = YES;
    }else{
        
        cell.rightView.hidden = NO;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
}

- (void)initUI{
    
    _personTable = [[UITableView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, SCREEN_Width, SCREEN_Height - NAVIGATION_BAR_HEIGHT - 50 *SIZE) style:UITableViewStylePlain];
    _personTable.backgroundColor = self.view.backgroundColor;
    _personTable.delegate = self;
    _personTable.dataSource = self;
    _personTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_personTable];
}


@end
