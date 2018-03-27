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
#import "RoomDetailTableCell5.h"

@interface RoomDetailVC ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UITableViewDelegate,UITableViewDataSource>
{
    
    NSArray *_titleArr;
}
@property (nonatomic, strong) UICollectionView *segmentColl;

@property (nonatomic, strong) UICollectionViewFlowLayout *flowLayout;

@property (nonatomic, strong) UITableView *roomTable;

@property (nonatomic, strong) UIButton *recommendBtn;

@property (nonatomic, strong) UIButton *counselBtn;


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

    return 6;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section == 5) {

        return 2;
    }else{

        return 1;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    if (!section) {
        
        return 363 *SIZE;
    }else{
        
        if (section == 5) {
            
            return 33 *SIZE;
        }else{
            
            return 6 *SIZE;
        }
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return CGFLOAT_MIN;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    if (!section) {
    
        return [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width, 363 *SIZE)];
    }else{
        
        if (section == 5) {
            
            return [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width, 33 *SIZE)];
        }else{
            
            return [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width, 6 *SIZE)];
        }
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    return [[UIView alloc] init];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    switch (indexPath.section) {
        case 0:
        {
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
            break;
        }
        case 1:
        {
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
            break;
        }
        case 2:
        {
            RoomDetailTableCell2 *cell = [tableView dequeueReusableCellWithIdentifier:@"RoomDetailTableCell2"];
            if (!cell) {
                
                cell = [[RoomDetailTableCell2 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"RoomDetailTableCell2"];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            return cell;
            break;
        }
        case 3:
        {
            RoomDetailTableCell3 *cell = [tableView dequeueReusableCellWithIdentifier:@"RoomDetailTableCell3"];
            if (!cell) {
                
                cell = [[RoomDetailTableCell3 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"RoomDetailTableCell3"];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.num = 10;
            //                cell.cellColl
            return cell;
            break;
        }
        case 4:
        {
            RoomDetailTableCell5 *cell = [tableView dequeueReusableCellWithIdentifier:@"RoomDetailTableCell5"];
            if (!cell) {
                
                cell = [[RoomDetailTableCell5 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"RoomDetailTableCell5"];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.nameL.text = @"张三";
            cell.priceL.text = @"80 - 100";
            cell.typeL.text = @"三室一厅";
            cell.areaL.text = @"郫都区-德源大道";
            cell.intentionRateL.text = @"23";
            cell.urgentRateL.text = @"43";
            cell.matchRateL.text = @"83";
            cell.phoneL.text = @"13438339177";
            return cell;
            break;
        }
        case 5:
        {
            RoomDetailTableCell5 *cell = [tableView dequeueReusableCellWithIdentifier:@"RoomDetailTableCell5"];
            if (!cell) {
                
                cell = [[RoomDetailTableCell5 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"RoomDetailTableCell5"];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.nameL.text = @"张三";
            cell.priceL.text = @"80 - 100";
            cell.typeL.text = @"三室一厅";
            cell.areaL.text = @"郫都区-德源大道";
            cell.intentionRateL.text = @"23";
            cell.urgentRateL.text = @"43";
            cell.matchRateL.text = @"83";
            cell.phoneL.text = @"13438339177";
            return cell;
            break;
        }
        default:{
            RoomDetailTableCell5 *cell = [tableView dequeueReusableCellWithIdentifier:@"RoomDetailTableCell5"];
            if (!cell) {
                
                cell = [[RoomDetailTableCell5 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"RoomDetailTableCell5"];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.nameL.text = @"张三";
            cell.priceL.text = @"80 - 100";
            cell.typeL.text = @"三室一厅";
            cell.areaL.text = @"郫都区-德源大道";
            cell.intentionRateL.text = @"23";
            cell.urgentRateL.text = @"43";
            cell.matchRateL.text = @"83";
            cell.phoneL.text = @"13438339177";
            return cell;
            break;
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
    _roomTable = [[UITableView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, SCREEN_Width, SCREEN_Height - NAVIGATION_BAR_HEIGHT - 47 *SIZE) style:UITableViewStyleGrouped];
    _roomTable.backgroundColor = self.view.backgroundColor;
    _roomTable.delegate = self;
    _roomTable.dataSource = self;
    _roomTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_roomTable];
    
    _counselBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _counselBtn.frame = CGRectMake(0, SCREEN_Height - 47 *SIZE, 120 *SIZE, 47 *SIZE);
    _counselBtn.titleLabel.font = [UIFont systemFontOfSize:14 *sIZE];
//    [_counselBtn addTarget:self action:@selector(<#selector#>) forControlEvents:UIControlEventTouchUpInside];
    [_counselBtn setTitle:@"电话咨询" forState:UIControlStateNormal];
    [_counselBtn setBackgroundColor:COLOR(255, 188, 88, 1)];
    [_counselBtn setTitleColor:CH_COLOR_white forState:UIControlStateNormal];
    [self.view addSubview:_counselBtn];
    
    _recommendBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _recommendBtn.frame = CGRectMake(120 *SIZE, SCREEN_Height - 47 *SIZE, 240 *SIZE, 47 *SIZE);
    _recommendBtn.titleLabel.font = [UIFont systemFontOfSize:14 *sIZE];
    //    [_counselBtn addTarget:self action:@selector(<#selector#>) forControlEvents:UIControlEventTouchUpInside];
    [_recommendBtn setTitle:@"推荐" forState:UIControlStateNormal];
    [_recommendBtn setBackgroundColor:COLOR(27, 152, 255, 1)];
    [_recommendBtn setTitleColor:CH_COLOR_white forState:UIControlStateNormal];
    [self.view addSubview:_recommendBtn];

}



@end
