//
//  RoomMatchListVC.m
//  云渠道
//
//  Created by 谷治墙 on 2018/4/18.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "RoomMatchListVC.h"
#import "BoxView.h"
#import "MoreView.h"
#import "RoomCollCell.h"
#import "CustomDetailTableCell3.h"
//#import "CustomRequireModel.h"

@interface RoomMatchListVC ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
{
    NSArray *_arr;
    NSMutableArray *_dataArr;
    NSString *_clientId;
    CustomRequireModel *_model;
    NSArray *_tagsArr;
}

@property (nonatomic , strong) UITableView *matchListTable;

@property (nonatomic, strong) UITextField *searchBar;

@end

@implementation RoomMatchListVC

- (instancetype)initWithClientId:(NSString *)clientId dataArr:(NSArray *)dataArr model:(id)model
{
    self = [super init];
    if (self) {
        
        _clientId = clientId;
        _arr = dataArr;
        _dataArr = [NSMutableArray arrayWithArray:dataArr];
        _model = model;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = YJBackColor;
    self.navBackgroundView.hidden = NO;
    [self initDateSouce];
    [self initUI];
    
}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
}

-(void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
}

-(void)initDateSouce
{
    
    _tagsArr = [self getDetailConfigArrByConfigState:PROJECT_TAGS_DEFAULT];
}


#pragma mark -- tableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString * Identifier = @"CustomDetailTableCell3";
    CustomDetailTableCell3 *cell = [tableView dequeueReusableCellWithIdentifier:Identifier];
    if (!cell) {
        
        cell = [[CustomDetailTableCell3 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Identifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.tag = indexPath.row;
    [cell setDataDic:_dataArr[indexPath.row]];
    
    NSMutableArray *tempArr = [@[] mutableCopy];
    for (int i = 0; i < [_dataArr[indexPath.row][@"property_tags"] count]; i++) {
        
        [[self getDetailConfigArrByConfigState:PROPERTY_TYPE] enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            if ([obj[@"id"] integerValue] == [_dataArr[indexPath.row][@"property_tags"][i] integerValue]) {
                
                [tempArr addObject:obj[@"param"]];
                *stop = YES;
            }
        }];
    }
    
    NSArray *tempArr1 = [_dataArr[indexPath.row][@"project_tags"]  componentsSeparatedByString:@","];
    NSMutableArray *tempArr2 = [@[] mutableCopy];
    for (int i = 0; i < tempArr1.count; i++) {
        
        [_tagsArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            if ([obj[@"id"] integerValue] == [tempArr1[i] integerValue]) {
                
                [tempArr2 addObject:obj[@"param"]];
                *stop = YES;
            }
        }];
    }
    NSArray *tempArr3 = @[tempArr,tempArr2.count == 0 ? @[]:tempArr2];
    [cell settagviewWithdata:tempArr3];
    
    cell.recommendBtnBlock3 = ^(NSInteger index) {
        
        if (_dataArr.count) {

            [BaseRequest POST:RecommendClient_URL parameters:@{@"project_id":_dataArr[index][@"project_id"],@"client_need_id":_model.need_id,@"client_id":_model.client_id} success:^(id resposeObject) {

//                NSLog(@"%@",resposeObject);
                [self showContent:resposeObject[@"msg"]];
                if ([resposeObject[@"code"] integerValue] == 200) {

                    
                }
            } failure:^(NSError *error) {

//                NSLog(@"%@",error);
                [self showContent:@"网络错误"];
            }];
        }
    };
    
    return cell;
}


- (void)textFieldDidChange:(NSNotification *)notification{
    
    [_dataArr removeAllObjects];
    UITextField *sender = (UITextField *)[notification object];
    if (sender.text.length) {
        
//        for (CustomMatchModel *model in _dataArr) {
//
//            if ([model.name containsString:sender.text] ||[model.tel containsString:sender.text]) {
//
//                [_dataArr addObject:model];
//            }
//        }
    }else{
        
        _dataArr = [NSMutableArray arrayWithArray:_arr];
    }
    
    [_matchListTable reloadData];
}

-(void)initUI
{

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldDidChange:) name:UITextFieldTextDidChangeNotification object:_searchBar];
    
    UIView *whiteView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width, 62 *SIZE + STATUS_BAR_HEIGHT)];
    whiteView.backgroundColor = CH_COLOR_white;
    [self.view addSubview:whiteView];
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, STATUS_BAR_HEIGHT + 61 *SIZE, SCREEN_Width, SIZE)];
    line.backgroundColor = YJBackColor;
    [whiteView addSubview:line];
    
    self.leftButton.center = CGPointMake(25 * sIZE, STATUS_BAR_HEIGHT + 30 *SIZE);
    self.leftButton.bounds = CGRectMake(0, 0, 80 * sIZE, 33 * sIZE);
    self.maskButton.frame = CGRectMake(0, STATUS_BAR_HEIGHT, 60 * sIZE, 44 *SIZE);
    
    [whiteView addSubview:self.leftButton];
    [whiteView addSubview:self.maskButton];
    
    _searchBar = [[UITextField alloc] initWithFrame:CGRectMake(38 *SIZE, STATUS_BAR_HEIGHT + 14  *SIZE, 283 *SIZE, 33 *SIZE)];
    _searchBar.backgroundColor = YJBackColor;
    _searchBar.leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 11 *SIZE, 0)];
    //设置显示模式为永远显示(默认不显示)
    _searchBar.leftViewMode = UITextFieldViewModeAlways;
    _searchBar.placeholder = @"小区/楼盘/商铺";
    _searchBar.font = [UIFont systemFontOfSize:11 *SIZE];
    _searchBar.returnKeyType = UIReturnKeySearch;
    UIImageView *rightImg = [[UIImageView alloc] initWithFrame:CGRectMake(0 *SIZE, 8 *SIZE, 17 *SIZE, 17 *SIZE)];
    //    rightImg.backgroundColor = YJGreenColor;
    rightImg.image = [UIImage imageNamed:@"search_2"];
    _searchBar.rightView = rightImg;
    _searchBar.rightViewMode = UITextFieldViewModeUnlessEditing;
    _searchBar.clearButtonMode = UITextFieldViewModeWhileEditing;
    _searchBar.delegate = self;
    [whiteView addSubview:_searchBar];
    
    
    
    [self.view addSubview:self.matchListTable];
}

#pragma mark  ---  懒加载   ---
-(UITableView *)matchListTable
{
    if(!_matchListTable)
    {
        _matchListTable = [[UITableView alloc]initWithFrame:CGRectMake(0, STATUS_BAR_HEIGHT + 62 *SIZE , 360*SIZE, SCREEN_Height-STATUS_BAR_HEIGHT - 62 *SIZE - TAB_BAR_MORE) style:UITableViewStylePlain];
        _matchListTable.backgroundColor = YJBackColor;
        _matchListTable.delegate = self;
        _matchListTable.dataSource = self;
        [_matchListTable setSeparatorStyle:UITableViewCellSeparatorStyleNone];

    }
    return _matchListTable;
}

@end
