//
//  PersonalVC.m
//  云渠道
//
//  Created by 谷治墙 on 2018/3/28.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "PersonalVC.h"
#import "PersonalTableCell.h"
#import "ChangePassWordVC.h"
#import "BirthVC.h"
#import "ChangeNameVC.h"
#import "ChangeAddessVC.h"
#import "MyCodeVC.h"

@interface PersonalVC ()<UITableViewDelegate,UITableViewDataSource>
{
//    UIImagePickerController *_imagePickerController; /**< 相册拾取器 */
    NSArray *_titleArr;
    NSMutableArray *_contentArr;
}
@property (nonatomic, strong) UITableView *personTable;

@property (nonatomic, strong) UIButton *exitBtn;

@end

@implementation PersonalVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initDataSource];
    [self initUI];
}

- (void)initDataSource{
    
    _titleArr = @[@"运算编号",@"我的二维码",@"姓名",@"电话号码",@"性别",@"出生年月",@"住址",@"修改密码"];
    _contentArr = [[NSMutableArray alloc] initWithArray:_titleArr];
//    _imagePickerController = [[UIImagePickerController alloc] init];
//    _imagePickerController.delegate = self;
}


#pragma mark -- action

- (void)ActionExitBtn:(UIButton *)btn{
    
    [self alertControllerWithNsstring:@"温馨提示" And:@"你确定要退出当前账号吗？" WithCancelBlack:^{
        
    } WithDefaultBlack:^{
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:LOGINENTIFIER];
        [UserModel defaultModel].Token = @"";
        [UserModelArchiver archive];
        [[NSNotificationCenter defaultCenter]postNotificationName:@"goLoginVC" object:nil];
        
    }];
}



#pragma mark -- tableview
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 8;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 51 *SIZE;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    PersonalTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PersonalTableCell"];
    if (!cell) {
        
        cell = [[PersonalTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"PersonalTableCell"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.titleL.text = _titleArr[indexPath.row];
    cell.contentL.text = _contentArr[indexPath.row];

    cell.contentL.hidden = NO;
    cell.headImg.hidden = YES;
    
    if (indexPath.row == 0 || indexPath.row == 4) {
        
        cell.rightView.hidden = YES;
    }else{
        
        cell.rightView.hidden = NO;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    switch (indexPath.row) {
        case 0:
        {
            break;
        }
        case 1:
        {
            MyCodeVC *nextVC = [[MyCodeVC alloc] init];
            [self.navigationController pushViewController:nextVC animated:YES];
            break;
        }
        case 2:
        {
            ChangeNameVC *nextVC = [[ChangeNameVC alloc] init];
            [self.navigationController pushViewController:nextVC animated:YES];
            break;
        }
        case 3:
        {
            
            break;
        }
        case 4:
        {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"性别" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
            
            UIAlertAction *male = [UIAlertAction actionWithTitle:@"男" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                
            }];
            
            UIAlertAction *female = [UIAlertAction actionWithTitle:@"女" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                
            }];
            
            UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                
            }];
            
            [alert addAction:male];
            [alert addAction:female];
            [alert addAction:cancel];
            [self.navigationController presentViewController:alert animated:YES completion:^{
                
            }];
            break;
        }
        case 5:
        {
            BirthVC *nextVC = [[BirthVC alloc] init];
            [self.navigationController pushViewController:nextVC animated:YES];
            break;
        }
        case 6:
        {
            ChangeAddessVC *nextVC = [[ChangeAddessVC alloc] init];
            [self.navigationController pushViewController:nextVC animated:YES];
            break;
        }
        case 7:
        {
            ChangePassWordVC *nextVC = [[ChangePassWordVC alloc] init];
            [self.navigationController pushViewController:nextVC animated:YES];
            break;
        }
        default:
            break;
    }
}

- (void)initUI{
    
    self.navBackgroundView.hidden = NO;
    self.titleLabel.text = @"账户信息";
    
    
    _personTable = [[UITableView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, SCREEN_Width, SCREEN_Height - NAVIGATION_BAR_HEIGHT - 50 *SIZE - TAB_BAR_MORE) style:UITableViewStylePlain];
    _personTable.backgroundColor = self.view.backgroundColor;
    _personTable.delegate = self;
    _personTable.dataSource = self;
    _personTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_personTable];
    
    _exitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _exitBtn.frame = CGRectMake(0, SCREEN_Height - 50 *SIZE - TAB_BAR_MORE, SCREEN_Width, 50 *SIZE + TAB_BAR_MORE);
    _exitBtn.titleLabel.font = [UIFont systemFontOfSize:14 *sIZE];
    [_exitBtn addTarget:self action:@selector(ActionExitBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_exitBtn setTitle:@"退出登录" forState:UIControlStateNormal];
    [_exitBtn setBackgroundColor:YJContentLabColor];
    [_exitBtn setTitleColor:YJTitleLabColor forState:UIControlStateNormal];
    [self.view addSubview:_exitBtn];
}


@end
