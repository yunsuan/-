//
//  RoomAnalyzeVC.m
//  云渠道
//
//  Created by 谷治墙 on 2018/4/17.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "RoomAnalyzeVC.h"
#import "AnalyzeTableCell.h"

@interface RoomAnalyzeVC ()<UITableViewDelegate,UITableViewDataSource>
{
    
    NSMutableArray *_dataArr;

}
@property (nonatomic, strong) UITableView *analyzeTable;

@end

@implementation RoomAnalyzeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initDataSource];
    [self initUI];
}

- (void)initDataSource{
    
    _dataArr = [@[] mutableCopy];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 4;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    if (section == 0) {
        
        return 40 *SIZE;
    }else{
        
        return 0;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    return [[UIView alloc] init];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 7 *SIZE;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    return [[UIView alloc] init];
}

//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
//
//    if (section == 0) {
//
//        return nil;
//    }
//    RoomBrokerageTableHeader *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"RoomBrokerageTableHeader"];
//    if (!header) {
//
//        header = [[RoomBrokerageTableHeader alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width, 51 *SIZE)];
//    }
//    header.titleL.text = @"2017-07-11至2017-08-10";
//    header.dropBtn.tag = section;
//    if ([_selectArr[section] integerValue]) {
//
//        [header.dropBtn setImage:[UIImage imageNamed:@"uparrow"] forState:UIControlStateNormal];
//    }else{
//
//        [header.dropBtn setImage:[UIImage imageNamed:@"downarrow"] forState:UIControlStateNormal];
//    }
//    header.dropBtnBlock = ^(NSInteger index) {
//
//        if ([_selectArr[index] integerValue]) {
//
//            [_selectArr replaceObjectAtIndex:index withObject:@0];
//        }else{
//
//            [_selectArr replaceObjectAtIndex:index withObject:@1];
//        }
//        [tableView reloadData];
//    };
//
//    return header;
//}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    AnalyzeTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AnalyzeTableCell"];
    if (!cell) {
        
        cell = [[AnalyzeTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"AnalyzeTableCell"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.titleL.text = @"项目优势";
    cell.contentL.text = @"房子二梯三户边套，南北通透户型，产证面积89平实用95平，可谈朝南带阳台，厨房朝北带很大生活阳台，一个卧室朝南，二个朝南。非常方正，没有一点浪费空间。";
    
    return cell;
}

- (void)initUI{
    
    _analyzeTable.rowHeight = UITableViewAutomaticDimension;
    _analyzeTable.estimatedRowHeight = 214 *SIZE;
    
    _analyzeTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width, self.view.frame.size.height - NAVIGATION_BAR_HEIGHT - TAB_BAR_MORE) style:UITableViewStyleGrouped];
    _analyzeTable.backgroundColor = YJBackColor;;
    _analyzeTable.delegate = self;
    _analyzeTable.dataSource = self;
    _analyzeTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_analyzeTable];
}

@end
