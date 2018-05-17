//
//  HouseTypeDetailVC.m
//  云渠道
//
//  Created by 谷治墙 on 2018/4/4.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "HouseTypeDetailVC.h"
#import "RoomDetailTableCell5.h"
#import "HouseTypeTableCell.h"
#import "HouseTypeTableCell2.h"
#import "HouseTypeDetailVC.h"
#import "HouseTypeTableHeader.h"
#import "HouseTypeTableHeader2.h"
#import "BuildingAlbumVC.h"

@interface HouseTypeDetailVC ()<UITableViewDelegate,UITableViewDataSource>
{
    
    NSString *_houseTypeId;
    NSMutableDictionary *_baseInfoDic;
    NSMutableArray *_imgArr;
    NSMutableArray *_houseArr;
    NSString *_projectId;
    NSMutableArray *_matchList;
}
@property (nonatomic, strong) UIButton *recommendBtn;

@property (nonatomic, strong) UITableView *houseTable;

@property (nonatomic, strong) TransmitView *transmitView;

@end

@implementation HouseTypeDetailVC

- (instancetype)initWithHouseTypeId:(NSString *)houseTypeId index:(NSInteger)index dataArr:(NSArray *)dataArr projectId:(NSString *)projectId
{
    self = [super init];
    if (self) {
        
        _projectId = projectId;
        _houseTypeId = houseTypeId;
        _imgArr = [@[] mutableCopy];
        _matchList = [@[] mutableCopy];
        self.dataArr = [NSMutableArray arrayWithArray:dataArr];
        _houseArr = [NSMutableArray arrayWithArray:self.dataArr];
        [_houseArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            if ([[NSString stringWithFormat:@"%@",obj[@"id"]] isEqualToString:houseTypeId]) {
                
                [_houseArr removeObjectAtIndex:idx];
                *stop = YES;
            }
        }];
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self initUI];
    
    dispatch_queue_t queue1 = dispatch_queue_create("com.houseType.gcg.group", DISPATCH_QUEUE_CONCURRENT);
    
    dispatch_group_t group = dispatch_group_create();
    
    dispatch_group_async(group, queue1, ^{
        
        [self RequestMethod];
        
    });
    dispatch_group_async(group, queue1, ^{
        
        [self MatchListRequest];
        
    });
}

- (void)RequestMethod{
    
    [BaseRequest GET:HouseTypeDetail_URL parameters:@{@"id":_houseTypeId} success:^(id resposeObject) {
        
        NSLog(@"%@",resposeObject);
        if ([resposeObject[@"code"] integerValue] == 200) {
            
            if (![resposeObject[@"data"] isKindOfClass:[NSNull class]]) {
                
                [self SetData:resposeObject[@"data"]];
            }else{
                
                [self showContent:@"暂无信息"];
            }
        }
    } failure:^(NSError *error) {
        
        NSLog(@"%@",error);
        [self showContent:@"网络错误"];
    }];
}

- (void)SetData:(NSDictionary *)data{
    
    if ([data[@"baseInfo"] isKindOfClass:[NSDictionary class]]) {
        
        _baseInfoDic = [NSMutableDictionary dictionaryWithDictionary:data[@"baseInfo"]];
        [_baseInfoDic enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
           
            if ([obj isKindOfClass:[NSNull class]]) {
                
                [_baseInfoDic setObject:@"" forKey:key];
            }
        }];
    }
    
    if ([data[@"imgInfo"] isKindOfClass:[NSArray class]]) {
        
        NSArray *arr = data[@"imgInfo"];
        for ( int i = 0; i < arr.count; i++) {
            
            if ([arr[i] isKindOfClass:[NSDictionary class]]) {
                
                NSMutableDictionary *tempDic = [[NSMutableDictionary alloc] initWithDictionary:arr[i]];
                
                [_imgArr addObject:tempDic];
            }
        }
    }
    
    [_houseTable reloadData];
}

- (void)MatchListRequest{
    
    [BaseRequest GET:HouseTypeMatching_URL parameters:@{@"project_id":_projectId,@"house_type_id":_houseTypeId} success:^(id resposeObject) {
        
        NSLog(@"%@",resposeObject);
        if ([resposeObject[@"code"] integerValue] == 200) {
            
            [self SetMatchPeople:resposeObject[@"data"]];
        }else{
            
            [self showContent:resposeObject[@"msg"]];
        }
    } failure:^(NSError *error) {
       
        NSLog(@"%@",error);
        [self showContent:@"网络错误"];
    }];
}

- (void)SetMatchPeople:(NSArray *)data{
    
    for (int i = 0 ; i < data.count; i++) {
        
        NSMutableDictionary *tempDic = [[NSMutableDictionary alloc] initWithDictionary:data[i]];
        
        [tempDic enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
            
            if ([obj isKindOfClass:[NSNull class]]) {
                
                [tempDic setObject:@"" forKey:key];
            }
        }];
        
        CustomMatchModel *model = [[CustomMatchModel alloc] initWithDictionary:tempDic];
        [_matchList addObject:model];
    }
    [_houseTable reloadData];
}



- (void)ActionRecommendBtn:(UIButton *)btn{
    
    [[UIApplication sharedApplication].keyWindow addSubview:self.transmitView];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section == 2) {
        
        return _matchList.count;
    }
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 8 *SIZE;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    if (section == 0) {
        
        return 366 *SIZE;
    }
    return 33 *SIZE;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    if (section == 0) {
        
        HouseTypeTableHeader *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"HouseTypeTableHeader"];
        if (!header) {
            
            header = [[HouseTypeTableHeader alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width, 366 *SIZE)];
        }
        header.imgArr = [NSMutableArray arrayWithArray:_imgArr];
        
        return header;
    }else{
        
        HouseTypeTableHeader2 *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"HouseTypeTableHeader2"];
        if (!header) {
            
            header = [[HouseTypeTableHeader2 alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width, 33 *SIZE)];
        }
        if (section == 1) {
            
            header.titleL.font = [UIFont systemFontOfSize:15 *SIZE];
            header.titleL.text = @"本楼盘其他户型";
        }else{
            
            header.titleL.font = [UIFont systemFontOfSize:13 *SIZE];
            header.titleL.text = [NSString stringWithFormat:@"匹配的客户(%ld)",_matchList.count];
        }
        return header;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        
        HouseTypeTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HouseTypeTableCell"];
        if (!cell) {
            
            cell = [[HouseTypeTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"HouseTypeTableCell"];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.typeL.text = _baseInfoDic[@"house_type_name"];
        cell.areaL.text = [NSString stringWithFormat:@"建筑面积：%@㎡-%@㎡",_baseInfoDic[@"property_area_min"],_baseInfoDic[@"property_area_max"]];
//        cell.houseDisL.text = @"户型分布：1栋、3栋";
        cell.titleL.text = @"户型卖点";
        cell.contentL.text = _baseInfoDic[@"sell_point"];
        
        return cell;
    }else{
        if (indexPath.section == 1) {
            
            HouseTypeTableCell2 *cell = [tableView dequeueReusableCellWithIdentifier:@"HouseTypeTableCell2"];
            if (!cell) {
                
                cell = [[HouseTypeTableCell2 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"HouseTypeTableCell2"];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.num = _houseArr.count;
            if (_houseArr.count) {
                
                cell.dataArr = [NSMutableArray arrayWithArray:_houseArr];
                [cell.cellColl reloadData];
            }
            cell.collCellBlock = ^(NSInteger index) {
              
                HouseTypeDetailVC *nextVC = [[HouseTypeDetailVC alloc] initWithHouseTypeId:[NSString stringWithFormat:@"%@",_houseArr[index][@"id"]] index:index dataArr:self.dataArr projectId:_projectId];
//                nextVC.dataArr = _houseArr;
                [self.navigationController pushViewController:nextVC animated:YES];
            };
            
            return cell;
        }else{
            
            RoomDetailTableCell5 *cell = [tableView dequeueReusableCellWithIdentifier:@"RoomDetailTableCell5"];
            if (!cell) {
                
                cell = [[RoomDetailTableCell5 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"RoomDetailTableCell5"];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.model = _matchList[indexPath.row];
            cell.recommendBtn.tag = indexPath.row;
            cell.recommendBtnBlock5 = ^(NSInteger index) {
                
                CustomMatchModel *model = _matchList[index];
                [BaseRequest POST:RecommendClient_URL parameters:@{@"project_id":_projectId,@"client_need_id":model.need_id,@"client_id":model.client_id} success:^(id resposeObject) {
                    
                    NSLog(@"%@",resposeObject);
                  
                    if ([resposeObject[@"code"] integerValue] == 200) {
                        
                        
                    }else if ([resposeObject[@"code"] integerValue] == 400){
                        
                        
                    }
                    else{
                        [self showContent:resposeObject[@"msg"]];
                    }
                } failure:^(NSError *error) {
                    
                    NSLog(@"%@",error);
                    [self showContent:@"网络错误"];
                }];
            };
            return cell;
            return cell;
        }
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    return [[UIView alloc] init];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
}



- (void)initUI{
    
    self.navBackgroundView.hidden = NO;
    self.titleLabel.text = @"户型详情";
    self.line.hidden = YES;

    _recommendBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _recommendBtn.frame = CGRectMake(SCREEN_Width - 35, STATUS_BAR_HEIGHT + 8, 24, 24);
//    [_recommendBtn setBackgroundColor:YJBlueBtnColor];
    [_recommendBtn addTarget:self action:@selector(ActionRecommendBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_recommendBtn setBackgroundImage:[UIImage imageNamed:@"share"] forState:UIControlStateNormal];
    [self.view addSubview:self.recommendBtn];
    [self.recommendBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.leftButton);
        make.right.equalTo(self.navBackgroundView).offset(- 8 *SIZE);
        make.size.mas_offset(CGSizeMake(22, 22));
    }];
    
    _houseTable = [[UITableView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, SCREEN_Width, SCREEN_Height - NAVIGATION_BAR_HEIGHT) style:UITableViewStyleGrouped];
    _houseTable.backgroundColor = self.view.backgroundColor;
    _houseTable.delegate = self;
    _houseTable.dataSource = self;
    _houseTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_houseTable];
    
}

- (TransmitView *)transmitView{
    
    if (!_transmitView) {
        
        _transmitView = [[TransmitView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width, SCREEN_Height)];
        WS(weakSelf);
        _transmitView.transmitTagBtnBlock = ^(NSInteger index) {
            
            if (index == 0) {
                
                [weakSelf shareWebPageToPlatformType:UMSocialPlatformType_QQ];
            }
        };
    }
    return _transmitView;
}

//
- (void)shareWebPageToPlatformType:(UMSocialPlatformType)platformType
{
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    
    //创建网页内容对象
    UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:@"分享标题" descr:@"分享内容描述" thumImage:[UIImage imageNamed:@"icon"]];
    //设置网页地址
    shareObject.webpageUrl = @"http://mobile.umeng.com/social";
    
    //分享消息对象设置分享内容对象
    messageObject.shareObject = shareObject;
    
    //调用分享接口
    [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
        if (error) {
            NSLog(@"************Share fail with error %@*********",error);
        }else{
            NSLog(@"response data is %@",data);
            [self showContent:@"分享成功"];
            [self.transmitView removeFromSuperview];
        }
    }];
}
@end
