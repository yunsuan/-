//
//  MyTeamVC.m
//  云渠道
//
//  Created by 谷治墙 on 2018/8/14.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "MyTeamVC.h"

#import "MyTeamTableHeader.h"
#import "MyTeamTableHeader2.h"
#import "MyTeamTableCell.h"
#import "MyTeamTableCell2.h"

@interface MyTeamVC ()<UITableViewDelegate,UITableViewDataSource>
{
    
    NSMutableArray *_dataArr;
}

@property (nonatomic, strong) UITableView *mainTable;
@end

@implementation MyTeamVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initUI];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section == 0) {
        
        return 0;
    }else if (section == 1){
        
        return 1;
    }else{
        
        return 3;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    if (section == 0) {
        
        MyTeamTableHeader *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"MyTeamTableHeader"];
        if (!header) {
            
            header = [[MyTeamTableHeader alloc] initWithReuseIdentifier:@"MyTeamTableHeader"];
        }
        
        header.headImg.image = [UIImage imageNamed:@"def_head"];
        header.nameL.text = @"张三";
        header.levelL.text = @"等级：新秀";
        header.recommendL.text = @"今日推荐：2人";
        header.allL.text = @"所有成员：189人";
        
        return header;
    }else{
        
        MyTeamTableHeader2 *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"MyTeamTableHeader2"];
        if (!header) {
            
            header = [[MyTeamTableHeader2 alloc] initWithReuseIdentifier:@"MyTeamTableHeader2"];
        }
        header.titleL.text = @"我的推荐人";
        
        return header;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    return [[UIView alloc] init];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return CGFLOAT_MIN;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 1) {
        
        MyTeamTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyTeamTableCell"];
        if (!cell) {
            
            cell = [[MyTeamTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MyTeamTableCell"];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.headImg.image = [UIImage imageNamed:@"def_head"];
        cell.nameL.text = @"张三";
        cell.levelL.text = @"等级：新秀";
        cell.timeL.text = @"2018.6.10";
        
        return cell;
    }else{
        
        MyTeamTableCell2 *cell = [tableView dequeueReusableCellWithIdentifier:@"MyTeamTableCell2"];
        if (!cell) {
            
            cell = [[MyTeamTableCell2 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MyTeamTableCell2"];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.headImg.image = [UIImage imageNamed:@"def_head"];
        
        cell.nameL.text = @"张三";
        cell.levelL.text = @"等级：新秀";
        cell.timeL.text = @"2018.6.10";
        cell.commissionL.text = @"奖励金：20";
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
}

- (void)initUI{
    
    self.navBackgroundView.hidden = NO;
    self.titleLabel.text = @"我的团队";
    
    _mainTable = [[UITableView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, SCREEN_Width, SCREEN_Height - NAVIGATION_BAR_HEIGHT) style:UITableViewStyleGrouped];
    _mainTable.rowHeight = UITableViewAutomaticDimension;
    _mainTable.estimatedRowHeight = 67 *SIZE;
    _mainTable.backgroundColor = self.view.backgroundColor;
    _mainTable.delegate = self;
    _mainTable.dataSource = self;
    _mainTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_mainTable];
}

@end
