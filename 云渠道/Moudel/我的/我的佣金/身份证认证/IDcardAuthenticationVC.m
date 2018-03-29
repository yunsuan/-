//
//  IDcardAuthenticationVC.m
//  云渠道
//
//  Created by 谷治墙 on 2018/3/29.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "IDcardAuthenticationVC.h"

@interface IDcardAuthenticationVC ()

@property (nonatomic, strong) UITextField *nameTF;

@property (nonatomic, strong) UITextField *idCardTF;

@end

@implementation IDcardAuthenticationVC

- (void)viewDidLoad {
    [super viewDidLoad];
    

    [self initUI];
}

- (void)initUI{
    
    self.titleLabel.text = @"身份证认证";
    self.navBackgroundView.hidden = NO;
    
    for (int i = 0; i < 2; i++) {
        
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT + i *52 *SIZE, SCREEN_Width, 50 *SIZE)];
        view.backgroundColor = CH_COLOR_white;
        [self.view addSubview:view];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10 *SIZE, 18 *SIZE, 60 *SIZE, 13 *SIZE)];
        label.textColor = YJTitleLabColor;
        label.font = [UIFont systemFontOfSize:13 *SIZE];
        if (i == 0) {
            
            label.text = @"姓名";
        }else{
            
            label.text = @"身份证号";
        }
        [view addSubview:label];
        
        UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(85 *SIZE, 0, 260 *SIZE, 50 *SIZE)];
        textField.font = [UIFont systemFontOfSize:13 *SIZE];
        textField.clearButtonMode = UITextFieldViewModeWhileEditing;
        if (i == 0) {
            
            textField.placeholder = @"请填写身份证上姓名";
            _nameTF = textField;
            [view addSubview:_nameTF];
        }else{
            
            textField.placeholder = @"请填写身份证号码";
            _idCardTF = textField;
            [view addSubview:_idCardTF];
        }
    }
    
}

@end
