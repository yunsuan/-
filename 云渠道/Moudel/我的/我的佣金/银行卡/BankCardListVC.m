//
//  BankCardListVC.m
//  云渠道
//
//  Created by 谷治墙 on 2018/3/21.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "BankCardListVC.h"
#import "BankCardListTableCell.h"
#import "BankCardListTableCell2.h"
#import "AddBankCardVC.h"

@interface BankCardListVC ()<UITableViewDelegate,UITableViewDataSource>
{
    
    NSMutableArray *_dataArr;
}
@property (nonatomic, strong) UITableView *bankTable;

@end

@implementation BankCardListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initDataSource];
    [self initUI];
    
}

- (void)initDataSource{
    
    _dataArr = [@[] mutableCopy];
    [self RequestMethod];
}

- (void)RequestMethod{
    
    [BaseRequest POST:BankCardInfo_URL parameters:nil success:^(id resposeObject) {
        
        NSLog(@"%@",resposeObject);
        if ([resposeObject[@"code"] integerValue] == 200) {
            
            if ([resposeObject[@"data"] isKindOfClass:[NSDictionary class]]) {
                
                [self SetData:resposeObject[@"data"]];
            }
        }else{
            
            [self showContent:resposeObject[@"msg"]];
        }
    } failure:^(NSError *error) {
       
        NSLog(@"%@",error);
        [self showContent:@"网络错误"];
    }];
}

- (void)SetData:(NSDictionary *)data{
    
    NSMutableDictionary *tempDic = [[NSMutableDictionary alloc] initWithDictionary:data];
    [tempDic enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        
        if ([obj isKindOfClass:[NSNull class]]) {
            
            [tempDic setObject:@"" forKey:key];
        }
    }];
    
    [_dataArr addObject:tempDic];
    [_bankTable reloadData];
}

- (void)ActionRightBtn:(UIButton *)btn{
    
    if (_dataArr.count) {
        
        NSString *str = [NSString stringWithFormat:@"%@，您好！有且仅能绑定一张银行卡，如欲绑定其他银行卡请先将当前银行卡解除绑定。",@"温先生"];
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"温馨提示" message:str preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *confirm = [UIAlertAction actionWithTitle:@"解除绑定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        [alert addAction:confirm];
        [alert addAction:cancel];
        [self.navigationController presentViewController:alert animated:YES completion:^{
            
        }];
    }
}
    
    

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 147 *SIZE;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 3 *SIZE;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (_dataArr.count) {
        
        NSString *Identifier = @"BankCardListTableCell";
        BankCardListTableCell *cell = [tableView dequeueReusableCellWithIdentifier:Identifier];
        if (!cell) {
            
            cell = [[BankCardListTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Identifier];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backImg.image = [UIImage imageNamed:@"bg_china"];
//        cell.bankL.text = _dataArr[indexPath.section][@"bank"];
        NSMutableAttributedString *atti = [[NSMutableAttributedString alloc] initWithString:_dataArr[indexPath.section][@"bank_card"]];
//        atti addAttribute:<#(nonnull NSAttributedStringKey)#> value:<#(nonnull id)#> range:<#(NSRange)#>
        cell.accL.attributedText = atti;
        
        return cell;
    }else{
        
        NSString *Identifier = @"BankCardListTableCell2";
        BankCardListTableCell2 *cell = [tableView dequeueReusableCellWithIdentifier:Identifier];
        if (!cell) {
            
            cell = [[BankCardListTableCell2 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Identifier];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        
        return cell;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width, 3 *SIZE)];
    view.backgroundColor = tableView.backgroundColor;
    return view;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (!_dataArr.count) {
        
        AddBankCardVC *nextVC = [[AddBankCardVC alloc] init];
        [self.navigationController pushViewController:nextVC animated:YES];
    }else{
        
        
    }
}

- (void)initUI{
    
    self.navBackgroundView.hidden = NO;
    self.titleLabel.text = @"银行卡";
    
    self.rightBtn.hidden = NO;
    [self.rightBtn setTitle:@"解绑" forState:UIControlStateNormal];
    self.rightBtn.titleLabel.font = [UIFont systemFontOfSize:15 *SIZE];
    [self.rightBtn setTitleColor:YJTitleLabColor forState:UIControlStateNormal];
    [self.rightBtn addTarget:self action:@selector(ActionRightBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    _bankTable = [[UITableView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, SCREEN_Width, SCREEN_Height - NAVIGATION_BAR_HEIGHT) style:UITableViewStylePlain];
    _bankTable.backgroundColor = YJBackColor;
    _bankTable.delegate = self;
    _bankTable.dataSource = self;
    _bankTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_bankTable];
}

@end
