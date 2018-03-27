//
//  RoomDetailVC.m
//  云渠道
//
//  Created by xiaoq on 2018/3/21.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "RoomDetailVC.h"
#import "RoomDetailCollCell.h"
#import "RoomDetailTableCell.h"
#import "RoomDetailTableCell1.h"
#import "RoomDetailTableCell2.h"
#import "RoomDetailTableCell3.h"
#import "RoomDetailTableCell4.h"

@interface RoomDetailVC ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UITableViewDelegate,UITableViewDataSource>
{
    
    NSArray *_titleArr;
}
@property (nonatomic, strong) UICollectionView *segmentColl;

@property (nonatomic, strong) UICollectionViewFlowLayout *flowLayout;

@property (nonatomic, strong) UITableView *roomTable;


@end

@implementation RoomDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initDataSource];
    [self initUI];
    
    [_segmentColl selectItemAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:0] animated:YES scrollPosition:0];
}

- (void)initDataSource{
    
    _titleArr = @[@"详情",@"佣金",@"分析"];
}

- (void)ActionMoreBtn:(UIButton *)btn{
    
    NSLog(@"%ld",btn.tag);
}

#pragma mark -- collectionview
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return 3;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    RoomDetailCollCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"RoomDetailCollCell" forIndexPath:indexPath];
    if (!cell) {
        
        cell = [[RoomDetailCollCell alloc] initWithFrame:CGRectMake(0, 0, 64 *SIZE, 40 *SIZE)];
    }
    cell.titleL.text = _titleArr[indexPath.item];

    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    
}



#pragma mark -- tableview

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return 7;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section == 6) {

        return 2;
    }else{

        return 1;
    }
//    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (!indexPath.section) {
        
        RoomDetailTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RoomDetailTableCell"];
        if (!cell) {
            
            cell = [[RoomDetailTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"RoomDetailTableCell"];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.developL.text = @"阳光物业公司";
        cell.openL.text = @"2017年02月20日";
        cell.payL.text = @"2019年02月";
        cell.timeL.text = @"70年";
        cell.moreBtn.tag = indexPath.section;
        [cell.moreBtn addTarget:self action:@selector(ActionMoreBtn:) forControlEvents:UIControlEventTouchUpInside];
        return cell;
    }else{
        
        if (indexPath.section == 1) {
            
            RoomDetailTableCell1 *cell = [tableView dequeueReusableCellWithIdentifier:@"RoomDetailTableCell1"];
            if (!cell) {
                
                cell = [[RoomDetailTableCell1 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"RoomDetailTableCell1"];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            cell.numL.text = @"（共13条）";
            cell.titleL.text = @"云算公馆参考价格5000元/㎡";
            cell.timeL.text = @"2017年12月19日   12:43:00";
            cell.contentL.text = @"2017年11月28日讯：云算公馆现房在售，在售房源建筑面积188㎡只余底层且只余一套，三室..";
            cell.moreBtn.tag = indexPath.section;
            [cell.moreBtn addTarget:self action:@selector(ActionMoreBtn:) forControlEvents:UIControlEventTouchUpInside];
            return cell;
        }else{
            
            if (indexPath.section == 2) {
                
                RoomDetailTableCell2 *cell = [tableView dequeueReusableCellWithIdentifier:@"RoomDetailTableCell2"];
                if (!cell) {
                    
                    cell = [[RoomDetailTableCell2 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"RoomDetailTableCell2"];
                }
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                
                return cell;
            }else{
                
                RoomDetailTableCell3 *cell = [tableView dequeueReusableCellWithIdentifier:@"RoomDetailTableCell3"];
                if (!cell) {
                    
                    cell = [[RoomDetailTableCell3 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"RoomDetailTableCell3"];
                }
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.num = 10;
//                cell.cellColl
                return cell;
            }
        }
    }
}

- (void)initUI{
    
    self.navBackgroundView.hidden = NO;
    self.titleLabel.hidden = NO;
    
    _flowLayout = [[UICollectionViewFlowLayout alloc] init];
    _flowLayout.itemSize = CGSizeMake(64 *SIZE, 44 *SIZE);
    _flowLayout.minimumLineSpacing = 0;
    _flowLayout.minimumInteritemSpacing = 0;
    
    _segmentColl = [[UICollectionView alloc] initWithFrame:CGRectMake(84 *SIZE, STATUS_BAR_HEIGHT, 192 *SIZE, 40 *SIZE) collectionViewLayout:_flowLayout];
    _segmentColl.backgroundColor = CH_COLOR_white;
    _segmentColl.delegate = self;
    _segmentColl.dataSource = self;
    [_segmentColl registerClass:[RoomDetailCollCell class] forCellWithReuseIdentifier:@"RoomDetailCollCell"];
    [self.navBackgroundView addSubview:_segmentColl];
    
    
    _roomTable.rowHeight = 360 *SIZE;
    _roomTable.estimatedRowHeight = UITableViewAutomaticDimension;
    _roomTable = [[UITableView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, SCREEN_Width, SCREEN_Height - NAVIGATION_BAR_HEIGHT) style:UITableViewStyleGrouped];
    _roomTable.backgroundColor = self.view.backgroundColor;
    _roomTable.delegate = self;
    _roomTable.dataSource = self;
    [self.view addSubview:_roomTable];

}



@end
