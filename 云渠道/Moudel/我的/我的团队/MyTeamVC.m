//
//  MyTeamVC.m
//  云渠道
//
//  Created by 谷治墙 on 2018/8/14.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "MyTeamVC.h"

#import "MyTeamTableHeader.h"
#import "MyTeamTableHeader2.h"
#import "MyTeamTableCell.h"
#import "MyTeamTableCell2.h"

@interface MyTeamVC ()<UITableViewDelegate,UITableViewDataSource>
{
    
    NSMutableArray *_dataArr;
    NSMutableDictionary *_person;
    NSMutableDictionary *_parent;
    NSMutableDictionary *_recommend;
}

@property (nonatomic, strong) UITableView *mainTable;
@end

@implementation MyTeamVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initDataSource];
    [self initUI];
    [self RequestMethod];
}

- (void)initDataSource{
    
    _parent = [@{} mutableCopy];
    _person = [@{} mutableCopy];
    _recommend = [@{} mutableCopy];
    _dataArr = [@[] mutableCopy];
}

- (void)RequestMethod{
    
    [BaseRequest GET:PersonalMyTeamList_URL parameters:nil success:^(id resposeObject) {
        
        NSLog(@"%@",resposeObject);
        if ([resposeObject[@"code"] integerValue] == 200) {
            
            [self SetData:resposeObject[@"data"]];
        }else{
            
            [self showContent:resposeObject[@"msg"]];
        }
    } failure:^(NSError *error) {
        
        NSLog(@"%@",error);
    }];
}

- (void)SetData:(NSDictionary *)data{
    
    if ([data[@"person"] isKindOfClass:[NSDictionary class]]) {
        
        _person = [NSMutableDictionary dictionaryWithDictionary:data[@"person"]];
        [_person enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
           
            if ([obj isKindOfClass:[NSNull class]]) {
                
                [_person setObject:@"" forKey:key];
            }
        }];
    }
    
    if ([data[@"parent"] isKindOfClass:[NSDictionary class]]) {
        
        _parent = [NSMutableDictionary dictionaryWithDictionary:data[@"parent"]];
        [_parent enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
            
            if ([obj isKindOfClass:[NSNull class]]) {
                
                [_parent setObject:@"" forKey:key];
            }
        }];
    }
    
    if ([data[@"recommend"] isKindOfClass:[NSDictionary class]]) {
        
        _recommend = [NSMutableDictionary dictionaryWithDictionary:data[@"recommend"]];
        [_recommend enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
            
            if ([obj isKindOfClass:[NSNull class]]) {
                
                [_recommend setObject:@"" forKey:key];
            }
        }];
    }
    
    if ([data[@"child"] isKindOfClass:[NSArray class]]) {
        
        _dataArr = [NSMutableArray arrayWithArray:data[@"child"]];
        for (int i = 0; i < _dataArr.count; i++) {
            
            NSMutableDictionary *tempDic = [NSMutableDictionary dictionaryWithDictionary:_dataArr[i]];
            [tempDic enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
                
                if ([obj isKindOfClass:[NSNull class]]) {
                    
                    [tempDic setObject:@"" forKey:key];
                }
            }];
            [_dataArr replaceObjectAtIndex:i withObject:tempDic];
        }
    }
    
    [_mainTable reloadData];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    if (_dataArr.count && _parent.count) {
        
        return 3;
    }else if(!_dataArr.count && !_parent.count){
        
        return 1;
    }else{
        
        return 2;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section == 0) {
        
        return 0;
    }else if (section == 1){
        
        if (_parent.count) {
            
            return 1;
        }else{
            
            return _dataArr.count;
        }
    }else{
        
        return _dataArr.count;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    if (section == 0) {
        
        MyTeamTableHeader *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"MyTeamTableHeader"];
        if (!header) {
            
            header = [[MyTeamTableHeader alloc] initWithReuseIdentifier:@"MyTeamTableHeader"];
        }
        
        header.headImg.image = [UIImage imageNamed:@"def_head"];
        
        header.nameL.text = _person[@"name"];
        header.levelL.text = [NSString stringWithFormat:@"等级：%@",_person[@"grade"]];
        [header.headImg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",TestBase_Net,_person[@"head_img"]]] placeholderImage:[UIImage imageNamed:@"def_head"] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
           
            header.headImg.image = [UIImage imageNamed:@"def_head"];
        }];
        header.recommendL.text = [NSString stringWithFormat:@"今日推荐：%@人",_recommend[@"today"]];
        header.allL.text = [NSString stringWithFormat:@"所有成员：%@人",_recommend[@"total"]];
        
        return header;
    }else{
        
        MyTeamTableHeader2 *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"MyTeamTableHeader2"];
        if (!header) {
            
            header = [[MyTeamTableHeader2 alloc] initWithReuseIdentifier:@"MyTeamTableHeader2"];
        }
        if (section == 1) {
            
            if (_parent.count) {
                
                header.titleL.text = @"我的推荐人";
            }else{
                
                header.titleL.text = @"我的团队";
            }
        }else{
            
            header.titleL.text = @"我的团队";
        }
        
        return header;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    return [[UIView alloc] init];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return CGFLOAT_MIN;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 1) {
        
        if (_parent.count) {
            
            MyTeamTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyTeamTableCell"];
            if (!cell) {
                
                cell = [[MyTeamTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MyTeamTableCell"];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            [cell.headImg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",TestBase_Net,_parent[@"head_img"]]] placeholderImage:[UIImage imageNamed:@"def_head"] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
                
                cell.headImg.image = [UIImage imageNamed:@"def_head"];
            }];
            
            cell.nameL.text = _parent[@"name"];
            cell.levelL.text = [NSString stringWithFormat:@"等级：%@",_parent[@"grade"]];
            cell.timeL.text = _parent[@"create_time"];
            if ([_parent[@"sex"] integerValue] == 1) {
                
                cell.genderImg.image = [UIImage imageNamed:@"man"];
            }else if ([_parent[@"sex"] integerValue] == 2){
                
                cell.genderImg.image = [UIImage imageNamed:@"girl"];
            }else{
                
                cell.genderImg.image = [UIImage imageNamed:@""];
            }
            
            return cell;
        }else{
            
            MyTeamTableCell2 *cell = [tableView dequeueReusableCellWithIdentifier:@"MyTeamTableCell2"];
            if (!cell) {
                
                cell = [[MyTeamTableCell2 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MyTeamTableCell2"];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            [cell.headImg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",TestBase_Net,_dataArr[indexPath.row][@"head_img"]]] placeholderImage:[UIImage imageNamed:@"def_head"] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
                
                cell.headImg.image = [UIImage imageNamed:@"def_head"];
            }];
            
            cell.nameL.text = _dataArr[indexPath.row][@"name"];
            cell.levelL.text = [NSString stringWithFormat:@"等级：%@",_dataArr[indexPath.row][@"grade"]];
            cell.timeL.text = _dataArr[indexPath.row][@"create_time"];
            if ([_dataArr[indexPath.row][@"sex"] integerValue] == 1) {
                
                cell.genderImg.image = [UIImage imageNamed:@"man"];
            }else if ([_dataArr[indexPath.row][@"sex"] integerValue] == 2){
                
                cell.genderImg.image = [UIImage imageNamed:@"girl"];
            }else{
                
                cell.genderImg.image = [UIImage imageNamed:@""];
            }
            cell.commissionL.text = [NSString stringWithFormat:@"奖励金：%@",_dataArr[indexPath.row][@"produce_grade"]];
            return cell;

        }
    }else{
        
        MyTeamTableCell2 *cell = [tableView dequeueReusableCellWithIdentifier:@"MyTeamTableCell2"];
        if (!cell) {
            
            cell = [[MyTeamTableCell2 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MyTeamTableCell2"];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [cell.headImg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",TestBase_Net,_dataArr[indexPath.row][@"head_img"]]] placeholderImage:[UIImage imageNamed:@"def_head"] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
            
            cell.headImg.image = [UIImage imageNamed:@"def_head"];
        }];
        
        cell.nameL.text = _dataArr[indexPath.row][@"name"];
        cell.levelL.text = [NSString stringWithFormat:@"等级：%@",_dataArr[indexPath.row][@"grade"]];
        cell.timeL.text = _dataArr[indexPath.row][@"create_time"];
        if ([_dataArr[indexPath.row][@"sex"] integerValue] == 1) {
            
            cell.genderImg.image = [UIImage imageNamed:@"man"];
        }else if ([_dataArr[indexPath.row][@"sex"] integerValue] == 2){
            
            cell.genderImg.image = [UIImage imageNamed:@"girl"];
        }else{
            
            cell.genderImg.image = [UIImage imageNamed:@""];
        }
        cell.commissionL.text = [NSString stringWithFormat:@"奖励金：%@",_dataArr[indexPath.row][@"produce_grade"]];
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
}

- (void)initUI{
    
    self.navBackgroundView.hidden = NO;
    self.titleLabel.text = @"我的团队";
    
    _mainTable = [[UITableView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, SCREEN_Width, SCREEN_Height - NAVIGATION_BAR_HEIGHT) style:UITableViewStyleGrouped];
    _mainTable.rowHeight = UITableViewAutomaticDimension;
    _mainTable.estimatedRowHeight = 67 *SIZE;
    _mainTable.backgroundColor = self.view.backgroundColor;
    _mainTable.delegate = self;
    _mainTable.dataSource = self;
    _mainTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_mainTable];
}

@end
