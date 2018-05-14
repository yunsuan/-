//
//  CityVC.m
//  云渠道
//
//  Created by 谷治墙 on 2018/5/14.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "CityVC.h"

@interface CityVC ()///<UITableViewDelegate,UITableViewDataSource>
{
    
    NSMutableArray *_cityArr;
}
@property (nonatomic, strong) UITableView *cityTable;

@end

@implementation CityVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initDataSource];
    [self initUI];
    [self CityListRequest];
}

- (void)initDataSource{
    
    _cityArr = [@[] mutableCopy];
}

- (void)CityListRequest{
    
    [BaseRequest GET:@"getCityList" parameters:nil success:^(id resposeObject) {
        
        NSLog(@"%@",resposeObject);
        if ([resposeObject[@"code"] integerValue] == 200) {
            
            _cityArr = [NSMutableArray arrayWithArray:resposeObject[@"data"]];
            
        }else{
            
            [self showContent:resposeObject[@"msg"]];
        }
    } failure:^(NSError *error) {
        
        NSLog(@"%@",error);
        [self showContent:@"网络错误"];
    }];
}

- (void)SetData:(NSArray *)data{
    
    for (NSDictionary *dic in data) {
        
        
    }
}

- (void)initUI{
    
    
    self.navBackgroundView.hidden = NO;
//    [self.leftviewBtn setImage:[UIImage imageNamed:@"delete"] forState:UIControlStateNormal];
    
//    _cityTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 40 *SIZE + NAVIGATION_BAR_HEIGHT, SCREEN_Width, SCREEN_Height - 40 *SIZE - NAVIGATION_BAR_HEIGHT) style:UITableViewStylePlain];
//    _cityTable.backgroundColor = self.view.backgroundColor;
//    _cityTable.delegate = self;
//    _cityTable.dataSource = self;
//    [self.view addSubview:_cityTable];
}

@end
