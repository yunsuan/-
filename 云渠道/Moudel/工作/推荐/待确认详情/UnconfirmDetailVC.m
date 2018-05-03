//
//  UnconfirmDetailVC.m
//  云渠道
//
//  Created by 谷治墙 on 2018/4/9.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "UnconfirmDetailVC.h"
#import "CountDownCell.h"
#import "InfoDetailCell.h"
#import "CompleteCustomVC1.h"
#import "InvalidView.h"

@interface UnconfirmDetailVC ()<UITableViewDelegate,UITableViewDataSource>
{
    NSArray *_data;
    NSArray *_titleArr;
    NSString *_str;
}
@property (nonatomic , strong) UITableView *Maintableview;
@property (nonatomic , strong) UIButton *confirmBtn;
@property (nonatomic, strong) InvalidView *invalidView;

@end

@implementation UnconfirmDetailVC

- (instancetype)initWithString:(NSString *)str
{
    self = [super init];
    if (self) {
        
        _str = str;
        
    }
    return self;
}

-(void)post{
    [BaseRequest POST:WaitConfirmDetail_URL parameters:@{
                                                         @"client_id":_str
                                                         }
              success:^(id resposeObject) {
                  NSLog(@"%@",resposeObject);
                                                         }
              failure:^(NSError *error) {
                                                             
                                                         }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self post];
    [self initDataSouce];
    [self initUI];
}


-(void)initDataSouce
{
    
    _titleArr = @[@"推荐编号",@"客户信息",@"项目信息",@"委托人信息"];
    _data = @[@"项目名称：凤凰国际",@"项目地址：dafdsfasdfasdfsadfasfasfasdf高新区-天府三街-000号",@"推荐时间：2017-10-23  19:00:00"];
}

- (void)ActionConfirmBtn:(UIButton *)btn{
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"确认到访" message:@"" preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    UIAlertAction *valid = [UIAlertAction actionWithTitle:@"有效到访" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        CompleteCustomVC1 *nextVC = [[CompleteCustomVC1 alloc] init];
        [self.navigationController pushViewController:nextVC animated:YES];
    }];
    
    UIAlertAction *invalid = [UIAlertAction actionWithTitle:@"无效到访" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        [[UIApplication sharedApplication].keyWindow addSubview:self.invalidView];
    }];
    
    [alert addAction:valid];
    [alert addAction:invalid];
    [alert addAction:cancel];
    [self.navigationController presentViewController:alert animated:YES completion:^{
        
    }];
}

#pragma mark    -----  delegate   ------

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *backview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 360*SIZE, 53*SIZE)];
    backview.backgroundColor = [UIColor whiteColor];
    UIView * header = [[UIView alloc]initWithFrame:CGRectMake(10*SIZE , 19*SIZE, 6.7*SIZE, 13.3*SIZE)];
    header.backgroundColor = YJBlueBtnColor;
    [backview addSubview:header];
    UILabel * title = [[UILabel alloc]initWithFrame:CGRectMake(27.3*SIZE, 19*SIZE, 300*SIZE, 16*SIZE)];
    title.font = [UIFont systemFontOfSize:15.3*SIZE];
    title.textColor = YJTitleLabColor;
    title.text = _titleArr[section];
    [backview addSubview:title];
    return backview;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 53*SIZE;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
    
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section ==0 && indexPath.row ==2) {
        static NSString *CellIdentifier = @"CountDownCell";
        CountDownCell *cell  = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (!cell) {
            cell = [[CountDownCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        [cell setcountdownbyday:0 hours:0 min:0 sec:30];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else{
        static NSString *CellIdentifier = @"InfoDetailCell";
        InfoDetailCell *cell  = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (!cell) {
            cell = [[InfoDetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        [cell SetCellContentbystring:_data[indexPath.row]];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    
    
}

- (void)initUI{
    
    self.navBackgroundView.hidden = NO;
    self.titleLabel.text = @"待确认详情";
    _Maintableview.rowHeight = 150 *SIZE;
    _Maintableview.estimatedRowHeight = UITableViewAutomaticDimension;
    
    _Maintableview = [[UITableView alloc]initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, 360*SIZE, SCREEN_Height - NAVIGATION_BAR_HEIGHT- 40 *SIZE - TAB_BAR_MORE) style:UITableViewStyleGrouped];
    _Maintableview.backgroundColor = YJBackColor;
    _Maintableview.delegate = self;
    _Maintableview.dataSource = self;
    [_Maintableview setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.view addSubview:_Maintableview];
    
    _confirmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _confirmBtn.frame = CGRectMake(0, SCREEN_Height - 40 *SIZE - TAB_BAR_MORE, SCREEN_Width, 40 *SIZE + TAB_BAR_MORE);
    _confirmBtn.titleLabel.font = [UIFont systemFontOfSize:14 *sIZE];
    [_confirmBtn addTarget:self action:@selector(ActionConfirmBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_confirmBtn setTitle:@"确认" forState:UIControlStateNormal];
    [_confirmBtn setBackgroundColor:YJBlueBtnColor];
    [_confirmBtn setTitleColor:CH_COLOR_white forState:UIControlStateNormal];
    [self.view addSubview:_confirmBtn];
        

}

- (InvalidView *)invalidView{
    
    if (!_invalidView) {
        
        _invalidView = [[InvalidView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width, SCREEN_Height)];
    }
    return _invalidView;
}
@end
