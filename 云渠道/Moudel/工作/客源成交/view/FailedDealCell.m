//
//  FailedDealCell.m
//  云渠道
//
//  Created by 谷治墙 on 2018/5/8.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "FailedDealCell.h"

@implementation FailedDealCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self initUI];
    }
    return self;
}

- (void)setDataDic:(NSMutableDictionary *)dataDic{
    
    _nameL.text = dataDic[@"name"];
    _codeL.text = [NSString stringWithFormat:@"推荐编号：%@",dataDic[@"client_id"]];
    _projectL.text = [NSString stringWithFormat:@"推荐项目：%@",dataDic[@"project_name"]];
    _recommendTimeL.text = [NSString stringWithFormat:@"推荐时间：%@",dataDic[@"create_time"]];
    _invalidTimeL.text = [NSString stringWithFormat:@"无效时间：%@",dataDic[@"state_change_time"]];
}

- (void)ActionPhoneBtn:(UIButton *)btn{
    
    if (self.failedDealCellPhoneBtnBlock) {
        
        self.failedDealCellPhoneBtnBlock(self.tag);
    }
}

- (void)initUI{
    
    _nameL = [[UILabel alloc] init];//WithFrame:CGRectMake(9 *SIZE, 16 *SIZE, 100 *SIZE, 14 *SIZE)];
    _nameL.textColor = YJTitleLabColor;
    _nameL.font = [UIFont systemFontOfSize:15 *SIZE];
    [self.contentView addSubview:_nameL];
    
    _codeL = [[UILabel alloc] init];//WithFrame:CGRectMake(9 *SIZE, 45 *SIZE, 300 *SIZE, 11 *SIZE)];
    _codeL.textColor = YJ86Color;
    _codeL.font = [UIFont systemFontOfSize:12 *SIZE];
    [self.contentView addSubview:_codeL];
    
    _projectL = [[UILabel alloc] init];//WithFrame:CGRectMake(9 *SIZE, 65 *SIZE, 300 *SIZE, 11 *SIZE)];
    _projectL.textColor = YJ86Color;
    _projectL.font = [UIFont systemFontOfSize:12 *SIZE];
    [self.contentView addSubview:_projectL];
    
    _recommendTimeL = [[UILabel alloc] init];//WithFrame:CGRectMake(9 *SIZE, 84 *SIZE, 300 *SIZE, 11 *SIZE)];
    _recommendTimeL.textColor = YJ86Color;
    _recommendTimeL.font = [UIFont systemFontOfSize:12 *SIZE];
    [self.contentView addSubview:_recommendTimeL];
    
    _phoneBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    _phoneBtn.frame = CGRectMake(335 *SIZE, 16 *SIZE, 19 *SIZE, 19 *SIZE);
    [_phoneBtn addTarget:self action:@selector(ActionPhoneBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_phoneBtn setBackgroundImage:[UIImage imageNamed:@"phone"] forState:UIControlStateNormal];
    [self.contentView addSubview:_phoneBtn];
    
    _invalidTimeL = [[UILabel alloc] init];//WithFrame:CGRectMake(9 *SIZE, 105 *SIZE, 300 *SIZE, 11 *SIZE)];
    _invalidTimeL.textColor = YJBlueBtnColor;
    _invalidTimeL.font = [UIFont systemFontOfSize:12 *SIZE];
    [self.contentView addSubview:_invalidTimeL];
    
    _lineView = [[UIView alloc] init];//WithFrame:CGRectMake(0, 106 *SIZE, SCREEN_Width, SIZE)];
    _lineView.backgroundColor = YJBackColor;
    [self.contentView addSubview:_lineView];
    
    [self MasonryUI];
}

- (void)MasonryUI{
    
    [_nameL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(9 *SIZE);
        make.top.equalTo(self.contentView).offset(15 *SIZE);
        make.right.equalTo(self.contentView).offset(-9 *SIZE);
    }];
    
    [_codeL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(9 *SIZE);
        make.top.equalTo(_nameL.mas_bottom).offset(14 *SIZE);
        make.right.equalTo(self.contentView).offset(-150 *SIZE);
    }];
    
    [_projectL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(9 *SIZE);
        make.top.equalTo(_codeL.mas_bottom).offset(10 *SIZE);
        make.right.equalTo(self.contentView).offset(-150 *SIZE);
    }];
    
    
    [_phoneBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(335 *SIZE);
        make.top.equalTo(self.contentView).offset(16 *SIZE);
        make.width.height.mas_equalTo(19 *SIZE);
    }];
    
    [_recommendTimeL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(10 *SIZE);
        make.top.equalTo(_projectL.mas_bottom).offset(10 *SIZE);
        make.right.equalTo(self.contentView).offset(-10 *SIZE);
    }];
    
    [_invalidTimeL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(10 *SIZE);
        make.top.equalTo(_recommendTimeL.mas_bottom).offset(10 *SIZE);
        make.right.equalTo(self.contentView).offset(-10 *SIZE);
    }];
    
    [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(0 *SIZE);
        make.top.equalTo(_invalidTimeL.mas_bottom).offset(15 *SIZE);
        make.width.mas_equalTo(SCREEN_Width);
        make.height.mas_equalTo(SIZE);
        make.bottom.equalTo(self.contentView).offset(0 *SIZE);
    }];
}

@end
