//
//  CustomDetailVC.m
//  云渠道
//
//  Created by 谷治墙 on 2018/3/22.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "CustomDetailVC.h"
#import "CustomDetailTableCell.h"
#import "CustomTableHeader.h"
#import "CustomTableHeader2.h"
#import "CustomTableHeader3.h"

@interface CustomDetailVC ()<UITableViewDelegate,UITableViewDataSource,CustomTableHeaderDelegate,CustomTableHeader2Delegate,CustomTableHeader3Delegate>
{
    
    NSInteger _item;
}
@property (nonatomic, strong) UITableView *customDetailTable;

@end

@implementation CustomDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initUI];
}

- (void)head1collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    _item = indexPath.item;
    [_customDetailTable reloadData];
    NSLog(@"%@",indexPath);
}

- (void)head2collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    _item = indexPath.item;
    [_customDetailTable reloadData];
    NSLog(@"%@",indexPath);
}

- (void)DGActionAddBtn:(UIButton *)btn{
    
    
}

- (void)DGActionEditBtn:(UIButton *)btn{
    
    NSLog(@"%ld",_item);
}


- (void)head3collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    _item = indexPath.item;
    [_customDetailTable reloadData];
    NSLog(@"%@",indexPath);
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    if (!_item) {
        
        return 367 *SIZE;
    }else{
        
        if (_item == 1) {
            
            return 417 *SIZE;
        }else{
            
            return 484 *SIZE;
        }
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    if (!_item) {
        
        CustomTableHeader *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"CustomTableHeader"];
        if (!header) {
            
            header = [[CustomTableHeader alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width, 368 *SIZE)];
            header.delegate = self;
            [header.headerColl selectItemAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:0] animated:YES scrollPosition:UICollectionViewScrollPositionNone];
        }
        
        return header;
    }else{
        
        if (_item == 1) {
            
            CustomTableHeader2 *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"CustomTableHeader2"];
            if (!header) {
                
                header = [[CustomTableHeader2 alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width, 418 *SIZE)];
                header.delegate = self;
                [header.headerColl selectItemAtIndexPath:[NSIndexPath indexPathForItem:1 inSection:0] animated:YES scrollPosition:UICollectionViewScrollPositionNone];
            }
            
            return header;
        }else{
            
            CustomTableHeader3 *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"CustomTableHeader3"];
            if (!header) {
                
                header = [[CustomTableHeader3 alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width, 485 *SIZE)];
                header.delegate = self;
                [header.headerColl selectItemAtIndexPath:[NSIndexPath indexPathForItem:2 inSection:0] animated:YES scrollPosition:UICollectionViewScrollPositionNone];
            }
            
            return header;
        }
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString * Identifier = @"CustomDetailTableCell";
    CustomDetailTableCell *cell = [tableView dequeueReusableCellWithIdentifier:Identifier];
    if (!cell) {
        
        cell = [[CustomDetailTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Identifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}


- (void)initUI{
    
    self.navBackgroundView.hidden = NO;
    self.titleLabel.text = @"客户详情";

    _customDetailTable.estimatedRowHeight = 174 *SIZE;
    _customDetailTable.rowHeight = UITableViewAutomaticDimension;
    
    _customDetailTable = [[UITableView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, SCREEN_Width, SCREEN_Height - NAVIGATION_BAR_HEIGHT) style:UITableViewStyleGrouped];
    _customDetailTable.backgroundColor = YJBackColor;
    _customDetailTable.delegate = self;
    _customDetailTable.dataSource = self;
    _customDetailTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_customDetailTable];
}


@end
