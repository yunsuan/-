//
//  FollowRecordVC.m
//  云渠道
//
//  Created by 谷治墙 on 2018/4/3.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "FollowRecordVC.h"
#import "BorderTF.h"
#import "DropDownBtn.h"

@interface FollowRecordVC ()
{
    
    NSArray *_titleArr;
    NSArray *_wayArr;
}

@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) UITextField *nameTF;

@property (nonatomic, strong) UITextField *followTF;

@property (nonatomic, strong) UILabel *timeL;

@property (nonatomic, strong) BorderTF *intentionTF;

@property (nonatomic, strong) BorderTF *urgentTF;



@end

@implementation FollowRecordVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initDataSource];
    [self initUI];
}

- (void)initDataSource{
    
    _titleArr = @[@"客户名称",@"跟进时间",@"跟进人"];
    _wayArr = @[@"电话",@"QQ",@"微信",@"面谈",@"其他"];

}

- (void)ActionSelectBtn:(UIButton *)btn{
    
//    UIButton *btn1 = [btn viewWithTag:btn.tag];
//    [btn1 setImage:[UIImage imageNamed:@"selected"] forState:UIControlStateNormal];
//    
//    for (int i = 0; i < 5; i++) {
//        
//        UIButton *btn2 = [btn viewWithTag:i];
//        if (i != btn.tag) {
//            
//            [btn2 setImage:[UIImage imageNamed:@"default"] forState:UIControlStateNormal];
//        }
//    }
}

- (void)initUI{
    
    self.navBackgroundView.hidden = NO;
    self.titleLabel.text = @"跟进记录";
    
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, SCREEN_Width, SCREEN_Height - NAVIGATION_BAR_HEIGHT)];
//    _scrollView.delegate = self;
    [_scrollView setContentSize:CGSizeMake(SCREEN_Width, 878 *SIZE)];
    [self.view addSubview:_scrollView];
    
    UIView *view1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width, 128 *SIZE)];
    view1.backgroundColor = CH_COLOR_white;
    [_scrollView addSubview:view1];
    
    UIView *view2 = [[UIView alloc] initWithFrame:CGRectMake(0, 136 *SIZE, SCREEN_Width, 591 *SIZE)];
    view2.backgroundColor = CH_COLOR_white;
    [_scrollView addSubview:view2];

    for (int i = 0; i < 3; i++) {
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10 *SIZE, 14 *SIZE + i *43 *SIZE, 60 *SIZE, 13 *SIZE)];
        label.textColor = YJContentLabColor;
        label.font = [UIFont systemFontOfSize:13 *SIZE];
        label.text = _titleArr[i];
        [view1 addSubview:label];
        
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(10 *SIZE, 43 *SIZE * (i + 1), 340 *SIZE, 1)];
        line.backgroundColor = YJBackColor;
        [view1 addSubview:line];
        
        if (i == 1) {
            
            _timeL = [[UILabel alloc] initWithFrame:CGRectMake(78 *SIZE, 60 *SIZE, 200 *SIZE, 13 *SIZE)];
            _timeL.textColor = YJTitleLabColor;
            _timeL.font = [UIFont systemFontOfSize:13 *SIZE];
            [view1 addSubview:_timeL];
        }else{
            
            UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(78 *SIZE , i * 43 *SIZE, 270 *SIZE, 42 *SIZE)];
            textField.font = [UIFont systemFontOfSize:13 *SIZE];
            [view1 addSubview:textField];
        }
    }
    
    UILabel *wayL = [[UILabel alloc] initWithFrame:CGRectMake(9 *SIZE, 20 *SIZE, 60 *SIZE, 11 *SIZE)];
    wayL.textColor = YJTitleLabColor;
    wayL.font = [UIFont systemFontOfSize:12 *SIZE];
    wayL.text = @"跟进方式";
    [view2 addSubview:wayL];
    
    for (int i = 0; i < 5; i++) {
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(71 *SIZE + (i % 2) * 146 *SIZE, 15 *SIZE + (i / 2) * 40 *SIZE, 60 *SIZE, 25 *SIZE);
        btn.tag = i;
        btn.titleLabel.font = [UIFont systemFontOfSize:14 *sIZE];
        [btn addTarget:self action:@selector(ActionSelectBtn:) forControlEvents:UIControlEventTouchUpInside];
        [btn setTitle:_wayArr[i] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"default"] forState:UIControlStateNormal];
        [btn setTitleColor:YJContentLabColor forState:UIControlStateNormal];
        [view2 addSubview:btn];
    }
}

@end
