//
//  MyAttentionVC.m
//  云渠道
//
//  Created by 谷治墙 on 2018/3/29.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "MyAttentionVC.h"
#import "AttentionTableCell.h"

@interface MyAttentionVC ()<UITableViewDelegate,UITableViewDataSource>
{
    
    NSArray *_arr;
}
@property (nonatomic, strong) UITableView *attentionTable;

@end

@implementation MyAttentionVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initDataShource];
    [self initUI];

}

- (void)initDataShource{
    
    _arr = @[@[@[@"住宅",@"写字楼",@"商铺",@"别墅",@"公寓"],@[@"学区房",@"投资房"]],@[@[@"住宅",@"写字楼",@"商铺",@"别墅",@"公寓"],@[@"学区dd房",@"投资房"]],@[@[@"住宅",@"写字楼",@"商铺",@"别墅",@"公寓"],@[@"学区房",@"投资房的"]]];
    
    [self RequestMethod];
}

- (void)RequestMethod{
    
    [BaseRequest POST:GetFocusProjectList_URL parameters:nil success:^(id resposeObject) {
        
        NSLog(@"%@",resposeObject);
        if ([resposeObject[@"status"] integerValue] == 200) {
            
            
        }else{
            
            
        }
    } failure:^(NSError *error) {
        
        NSLog(@"%@",error.localizedDescription);
    }];
}

#pragma table
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 141 *SIZE;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    AttentionTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AttentionTableCell"];
    if (!cell) {
        
        cell = [[AttentionTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"AttentionTableCell"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.nameL.text = @"新希望国际大厦 套三 清水房";
    cell.areaL.text = @"10342元/㎡";
    cell.addressL.text = @"高新区-天府三街";
    cell.typeL.text = @"物业类型：住宅";
    cell.attributeL.text = @"所属门店：NO23";
    cell.timeL.text = @"添加房源日期：2017-10-23";
    cell.priceL.text = @"120万";
    [cell settagviewWithdata:_arr[indexPath.row]];
    
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return YES;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return UITableViewCellEditingStyleDelete;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return @"取消关注";
}

- (void)initUI{
    
    self.navBackgroundView.hidden = NO;
    self.titleLabel.text = @"我的关注";
    
    _attentionTable = [[UITableView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, SCREEN_Width, SCREEN_Height - NAVIGATION_BAR_HEIGHT) style:UITableViewStylePlain];
    _attentionTable.backgroundColor = self.view.backgroundColor;
    _attentionTable.delegate = self;
    _attentionTable.dataSource = self;
    _attentionTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_attentionTable];
}
@end
