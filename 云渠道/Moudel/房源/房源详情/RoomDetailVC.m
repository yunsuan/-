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
#import "RoomDetailTableHeader.h"
#import "RoomDetailTableHeader5.h"

@interface RoomDetailVC ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UITableViewDelegate,UITableViewDataSource,BMKMapViewDelegate,RoomDetailTableCell4Delegate,UIScrollViewDelegate>
{

    NSArray *_titleArr;
}
@property (nonatomic, strong) UICollectionView *segmentColl;

@property (nonatomic, strong) UICollectionViewFlowLayout *flowLayout;

@property (nonatomic, strong) UITableView *roomTable;

@property (nonatomic, strong) UIButton *recommendBtn;

@property (nonatomic, strong) UIView *parting;

@property (nonatomic, strong) UIButton *counselBtn;

@property (nonatomic, strong) BMKMapView *mapView;

@property (nonatomic, assign) CGFloat alpha;

@property (nonatomic, assign) BOOL animatFinsh;

@end

@implementation RoomDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initDataSource];
    [self initUI];
    
    [_segmentColl selectItemAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:0] animated:YES scrollPosition:0];
}

- (void)MapViewPopMethod{
    
    self.mapView.delegate = nil;
    [self.mapView removeFromSuperview];
}

- (void)initDataSource{
    
    _titleArr = @[@"楼盘",@"动态",@"楼栋",@"户型",@"分析",@"佣金"];
}

- (void)ActionMoreBtn:(UIButton *)btn{
    
    NSLog(@"%ld",btn.tag);
}


#pragma mark -- BMKMap

- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation{
    
    
}

#pragma mark -- animation Method

- (void)navigationAnimation{
    
    WS(ws);
    
    if (_animatFinsh == NO) {
    
        for (int i = 0; i < 3; i++) {
            switch (i) {
                case 0:{
                    [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionTransitionNone animations:^{
                       
                        ws.recommendBtn.frame = CGRectMake(85 *SIZE, STATUS_BAR_HEIGHT + 8, 24, 24);
                        [ws.navBackgroundView layoutIfNeeded];
                    } completion:^(BOOL finished) {

                    }];
                    break;
                }
                case 1:{
                    
                    [UIView animateWithDuration:0.5 delay:0.1 options:UIViewAnimationOptionTransitionNone animations:^{
                        
                        ws.parting.frame = CGRectMake(CGRectGetMaxX(ws.recommendBtn.frame) + 5 *SIZE, STATUS_BAR_HEIGHT + 10, SIZE, 20);
                        [ws.navBackgroundView layoutIfNeeded];
                    } completion:^(BOOL finished) {
                        
                    }];
                    break;
                }
                case 2:{
                    [UIView animateWithDuration:0.5 delay:0.2 options:UIViewAnimationOptionTransitionNone animations:^{
                        
                        ws.segmentColl.frame = CGRectMake(CGRectGetMaxX(ws.parting.frame) + 5 *SIZE, STATUS_BAR_HEIGHT, SCREEN_Width - CGRectGetMaxX(ws.parting.frame) - 5 *SIZE, 40);
//                        [ws.segmentColl mas_remakeConstraints:^(MASConstraintMaker *make) {
//                            make.left.equalTo(ws.parting.mas_right);
//                            make.bottom.equalTo(ws.navBackgroundView);
//                            make.right.equalTo(ws.navBackgroundView);
//                            make.height.mas_equalTo(40);
//                        }];
                        [ws.navBackgroundView layoutIfNeeded];
                    } completion:^(BOOL finished) {
                        _animatFinsh = YES;
                    }];
                    break;
                }
                default:
                    break;
            }
        }
    }
}

- (void)resetFrame{
    
    WS(ws);
    if (_animatFinsh == YES) {
        for (int i = 0; i < 3; i++) {
            switch (i) {
                case 0:{
                    [UIView animateWithDuration:0.5 delay:0.0 options:UIViewAnimationOptionTransitionNone animations:^{
                        
                        ws.segmentColl.frame = CGRectMake(SCREEN_Width, STATUS_BAR_HEIGHT, 280 *SIZE, 40);
                        [ws.navBackgroundView layoutIfNeeded];
                    } completion:nil];
                    
                    break;
                }
                case 1:{
                    
                    [UIView animateWithDuration:0.3 delay:0.1 options:UIViewAnimationOptionTransitionNone animations:^{
                        
                        ws.parting.frame = CGRectMake(SCREEN_Width, STATUS_BAR_HEIGHT + 10, SIZE, 20);
                        [ws.navBackgroundView layoutIfNeeded];
                    } completion:^(BOOL finished) {
                        
                    }];
                    
                    break;
                }
                case 2:{
                    [UIView animateWithDuration:0.3 delay:0.2 options:UIViewAnimationOptionTransitionNone animations:^{
                        
                        ws.recommendBtn.frame = CGRectMake(SCREEN_Width - 35, STATUS_BAR_HEIGHT + 8, 24, 24);
                        [ws.navBackgroundView layoutIfNeeded];
                    } completion:^(BOOL finished) {
                        _animatFinsh = NO;
                    }];
                    break;
                }
                default:
                    break;
            }
        }
    }
}

#pragma mark -- delegate

- (void)Cell4collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    
}

#pragma mark -- scrollView

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    if (scrollView == _roomTable) {
        
        // 计算当前偏移位置
        CGFloat threholdHeight = 183 *SIZE - NAVIGATION_BAR_HEIGHT;
        if (scrollView.contentOffset.y >= 0 &&
            scrollView.contentOffset.y <= threholdHeight) {
            self.alpha = scrollView.contentOffset.y / threholdHeight;
            self.navBackgroundView.alpha = self.alpha;
        }
        else if (scrollView.contentOffset.y < 0){
            scrollView.contentOffset = CGPointMake(0, 0);
        }
        else{
            self.navBackgroundView.alpha = 1.0;
            _recommendBtn.alpha = 1.0f;
        }
        
        if (self.alpha == 0) {
            _recommendBtn.alpha = 1.0;
        }
        
        if (scrollView.contentOffset.y > threholdHeight &&
            self.navBackgroundView.alpha == 1.0) {
            [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
            
            [self navigationAnimation];

        }else{
            [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
            
            [self resetFrame];
        }
    }
}

#pragma mark -- collectionview
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return 6;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    RoomDetailCollCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"RoomDetailCollCell" forIndexPath:indexPath];
    if (!cell) {
        
        cell = [[RoomDetailCollCell alloc] initWithFrame:CGRectMake(0, 0, 50 *SIZE, 40 *SIZE)];
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
        
        return 368 *SIZE;
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
    
        RoomDetailTableHeader *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"RoomDetailTableHeader"];
        if (!header) {
            
            header = [[RoomDetailTableHeader alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width, 383 *SIZE)];
        }
        header.titleL.text = @"FUNX自由青年公寓 城北店火爆来袭";
        header.statusL.text = @"在售";
        header.attentL.text = @"关注人数：23";
        header.payL.text = @"交房时间：暂无数据";
//        header.priceL.text = @""
        header.addressL.text = @"高新区-天府五街230号";
        return header;
//        return [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width, 363 *SIZE)];
    }else{
        
        if (section == 5) {
            
            RoomDetailTableHeader5 *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"RoomDetailTableHeader5"];
            if (!header) {
                
                header = [[RoomDetailTableHeader5 alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width, 383 *SIZE)];
            }
            header.numL.text = @"匹配的客户(23)";
            
            return header;
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
            
            return cell;
            break;
        }
        case 4:
        {
            RoomDetailTableCell4 *cell = [tableView dequeueReusableCellWithIdentifier:@"RoomDetailTableCell4"];
            if (!cell) {
                
                cell = [[RoomDetailTableCell4 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"RoomDetailTableCell4"];
                [cell.contentView addSubview:self.mapView];
                [_mapView mas_makeConstraints:^(MASConstraintMaker *make) {
                    
                    make.left.equalTo(cell.contentView).offset(0);
                    make.top.equalTo(cell.contentView).offset(33 *SIZE);
                    make.right.equalTo(cell.contentView).offset(0);
                    make.width.equalTo(@(360 *SIZE));
                    make.height.equalTo(@(187 *SIZE));
                    make.bottom.equalTo(cell.contentView).offset(-59 *SIZE);
                }];
            }
            cell.delegate = self;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;

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
    
    [self.maskButton addTarget:self action:@selector(MapViewPopMethod) forControlEvents:UIControlEventTouchUpInside];
    
    _flowLayout = [[UICollectionViewFlowLayout alloc] init];
    _flowLayout.itemSize = CGSizeMake(50 *SIZE, 44 *SIZE);
    _flowLayout.minimumLineSpacing = 0;
    _flowLayout.minimumInteritemSpacing = 0;
    _flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    _segmentColl = [[UICollectionView alloc] initWithFrame:CGRectMake(SCREEN_Width, STATUS_BAR_HEIGHT, 280 *SIZE, 40) collectionViewLayout:_flowLayout];
    _segmentColl.backgroundColor = CH_COLOR_white;
    _segmentColl.delegate = self;
    _segmentColl.dataSource = self;
    _segmentColl.showsHorizontalScrollIndicator = NO;
    _segmentColl.bounces = NO;
    [_segmentColl registerClass:[RoomDetailCollCell class] forCellWithReuseIdentifier:@"RoomDetailCollCell"];
    [self.navBackgroundView addSubview:_segmentColl];
    
    
    _roomTable.rowHeight = 360 *SIZE;
    _roomTable.estimatedRowHeight = UITableViewAutomaticDimension;
    _roomTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width, SCREEN_Height - 47 *SIZE - TAB_BAR_MORE) style:UITableViewStyleGrouped];
    _roomTable.backgroundColor = self.view.backgroundColor;
    _roomTable.delegate = self;
    _roomTable.dataSource = self;
    _roomTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_roomTable];
    
    _counselBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _counselBtn.frame = CGRectMake(0, SCREEN_Height - 47 *SIZE - TAB_BAR_MORE, SCREEN_Width, 47 *SIZE + TAB_BAR_MORE);
    _counselBtn.titleLabel.font = [UIFont systemFontOfSize:14 *sIZE];
//    [_counselBtn addTarget:self action:@selector(<#selector#>) forControlEvents:UIControlEventTouchUpInside];
    [_counselBtn setTitle:@"电话咨询" forState:UIControlStateNormal];
    [_counselBtn setBackgroundColor:COLOR(255, 188, 88, 1)];
    [_counselBtn setTitleColor:CH_COLOR_white forState:UIControlStateNormal];
    [self.view addSubview:_counselBtn];
    
    [self.view addSubview:self.navBackgroundView];

    _recommendBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _recommendBtn.frame = CGRectMake(SCREEN_Width - 35, STATUS_BAR_HEIGHT + 8, 24, 24);
//    [_recommendBtn setBackgroundColor:YJBlueBtnColor];
//    [_recommendBtn addTarget:self action:@selector(<#selector#>) forControlEvents:UIControlEventTouchUpInside];
    [_recommendBtn setBackgroundImage:[UIImage imageNamed:@"share"] forState:UIControlStateNormal];
    [self.view addSubview:self.recommendBtn];
    [self.recommendBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.leftButton);
        make.right.equalTo(self.navBackgroundView).offset(- 8 *SIZE);
        make.size.mas_offset(CGSizeMake(22, 22));
    }];
    [self.view addSubview:self.leftButton];
    [self.view addSubview:self.maskButton];
    
    self.parting = [[UIView alloc]initWithFrame:CGRectMake(SCREEN_Width, STATUS_BAR_HEIGHT + 10, SIZE, 20)];
    self.parting.backgroundColor = YJBackColor;
    [self.view addSubview:self.parting];
    
}

- (BMKMapView *)mapView{
    
    if (!_mapView) {
        
        _mapView = [[BMKMapView alloc] init];
        _mapView.delegate = self;
        _mapView.userInteractionEnabled = NO;
    }
    return _mapView;
}


@end
