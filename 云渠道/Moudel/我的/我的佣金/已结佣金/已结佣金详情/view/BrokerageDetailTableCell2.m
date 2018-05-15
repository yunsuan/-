//
//  BrokerageDetailTableCell2.m
//  云渠道
//
//  Created by 谷治墙 on 2018/3/29.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "BrokerageDetailTableCell2.h"

@implementation BrokerageDetailTableCell2

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self initUI];
    }
    return self;
}

- (void)initUI{
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(10 *SIZE, 19 *SIZE, 7 *SIZE, 13 *SIZE)];
    view.backgroundColor = YJBlueBtnColor;
    [self.contentView addSubview:view];
    
    _titleL = [[UILabel alloc] initWithFrame:CGRectMake(27 *SIZE, 19 *SIZE, 200 *SIZE, 14 *SIZE)];
    _titleL.textColor = YJTitleLabColor;
    _titleL.font = [UIFont systemFontOfSize:15 *SIZE];
    [self.contentView addSubview:_titleL];
    
    _codeL = [[UILabel alloc] init];
    _codeL.textColor = YJContentLabColor;
    _codeL.numberOfLines = 0;
    _codeL.font = [UIFont systemFontOfSize:13 *SIZE];
    [self.contentView addSubview:_codeL];
    
    _nameL = [[UILabel alloc] init];
    _nameL.textColor = YJContentLabColor;
    _nameL.numberOfLines = 0;
    _nameL.font = [UIFont systemFontOfSize:13 *SIZE];
    [self.contentView addSubview:_nameL];
    
    _houseTypeL = [[UILabel alloc] init];
    _houseTypeL.textColor = YJContentLabColor;
    _houseTypeL.numberOfLines = 0;
    _houseTypeL.font = [UIFont systemFontOfSize:13 *SIZE];
    [self.contentView addSubview:_houseTypeL];
    
    _addressL = [[UILabel alloc] init];
    _addressL.textColor = YJContentLabColor;
    _addressL.numberOfLines = 0;
    _addressL.font = [UIFont systemFontOfSize:13 *SIZE];
    [self.contentView addSubview:_addressL];
    
    _unitL = [[UILabel alloc] init];
    _unitL.textColor = YJContentLabColor;
    _unitL.numberOfLines = 0;
    _unitL.font = [UIFont systemFontOfSize:13 *SIZE];
    [self.contentView addSubview:_unitL];
    
    _contactL = [[UILabel alloc] init];
    _contactL.textColor = YJContentLabColor;
    _contactL.font = [UIFont systemFontOfSize:13 *SIZE];
    [self.contentView addSubview:_contactL];
    
    _brokerTypeL = [[UILabel alloc] init];
    _brokerTypeL.textColor = YJContentLabColor;
    _brokerTypeL.font = [UIFont systemFontOfSize:13 *SIZE];
    [self.contentView addSubview:_brokerTypeL];
    
    _priceL = [[UILabel alloc] init];
    _priceL.textColor = YJContentLabColor;
    _priceL.font = [UIFont systemFontOfSize:13 *SIZE];
    [self.contentView addSubview:_priceL];
    
    _timeL = [[UILabel alloc] init];
    _timeL.textColor = YJContentLabColor;
    _timeL.font = [UIFont systemFontOfSize:13 *SIZE];
    [self.contentView addSubview:_timeL];
    
    _companyL = [[UILabel alloc] init];
    _companyL.textColor = YJContentLabColor;
    _companyL.font = [UIFont systemFontOfSize:13 *SIZE];
    [self.contentView addSubview:_companyL];
    
    _endTimeL = [[UILabel alloc] init];
    _endTimeL.textColor = YJContentLabColor;
    _endTimeL.font = [UIFont systemFontOfSize:13 *SIZE];
    [self.contentView addSubview:_endTimeL];
    
    _ruleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    _ruleBtn.frame = CGRectMake(259 *SIZE, 262 *SIZE, 94 *SIZE, 23 *SIZE);
    _ruleBtn.titleLabel.font = [UIFont systemFontOfSize:13 *sIZE];
//    [_ruleBtn addTarget:self action:@selector(<#selector#>) forControlEvents:UIControlEventTouchUpInside];
    [_ruleBtn setTitle:@"查看佣金规则!" forState:UIControlStateNormal];
    [_ruleBtn setTitleColor:YJBlueBtnColor forState:UIControlStateNormal];
    [self.contentView addSubview:_ruleBtn];
    
    _statusImg = [[UIImageView alloc] init];
    [self.contentView addSubview:_statusImg];
    
    [self masonryUI];
}

- (void)masonryUI{
    
    [_codeL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(28 *SIZE);
        make.top.equalTo(self.contentView).offset(55 *SIZE);
        make.right.equalTo(self.contentView).offset(-28 *SIZE);
        make.bottom.equalTo(_nameL.mas_top).offset(-17 *SIZE);
    }];
    
    [_nameL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(28 *SIZE);
        make.top.equalTo(_codeL.mas_bottom).offset(17 *SIZE);
        make.right.equalTo(self.contentView).offset(-28 *SIZE);
        make.bottom.equalTo(_houseTypeL.mas_top).offset(-17 *SIZE);
    }];
    
    [_houseTypeL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(28 *SIZE);
        make.top.equalTo(_nameL.mas_bottom).offset(17 *SIZE);
        make.right.equalTo(self.contentView).offset(-28 *SIZE);
        make.bottom.equalTo(_addressL.mas_top).offset(-17 *SIZE);
    }];
    
    [_addressL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(28 *SIZE);
        make.top.equalTo(_houseTypeL.mas_bottom).offset(17 *SIZE);
        make.right.equalTo(self.contentView).offset(-28 *SIZE);
        make.bottom.equalTo(_brokerTypeL.mas_top).offset(-17 *SIZE);
    }];
    
//    [_unitL mas_makeConstraints:^(MASConstraintMaker *make) {
//
//        make.left.equalTo(self.contentView).offset(28 *SIZE);
//        make.top.equalTo(_addressL.mas_bottom).offset(17 *SIZE);
//        make.right.equalTo(self.contentView).offset(-28 *SIZE);
//        make.bottom.equalTo(_contactL.mas_top).offset(-17 *SIZE);
//    }];
//
//    [_contactL mas_makeConstraints:^(MASConstraintMaker *make) {
//
//        make.left.equalTo(self.contentView).offset(28 *SIZE);
//        make.top.equalTo(_addressL.mas_bottom).offset(17 *SIZE);
//        make.right.equalTo(self.contentView).offset(-28 *SIZE);
//        make.bottom.equalTo(_brokerTypeL.mas_top).offset(-17 *SIZE);
//    }];
    
    [_brokerTypeL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(28 *SIZE);
        make.top.equalTo(_addressL.mas_bottom).offset(17 *SIZE);
        make.right.equalTo(self.contentView).offset(-28 *SIZE);
        make.bottom.equalTo(_priceL.mas_top).offset(-17 *SIZE);
    }];
    
    [_priceL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(28 *SIZE);
        make.top.equalTo(_brokerTypeL.mas_bottom).offset(17 *SIZE);
        make.right.equalTo(self.contentView).offset(-28 *SIZE);
        make.bottom.equalTo(_timeL.mas_top).offset(-17 *SIZE);
    }];
    
    [_timeL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(28 *SIZE);
        make.top.equalTo(_priceL.mas_bottom).offset(17 *SIZE);
        make.right.equalTo(self.contentView).offset(-28 *SIZE);
        make.bottom.equalTo(_endTimeL.mas_top).offset(-17 *SIZE);
    }];
    
//    [_companyL mas_makeConstraints:^(MASConstraintMaker *make) {
//
//        make.left.equalTo(self.contentView).offset(28 *SIZE);
//        make.top.equalTo(_timeL.mas_bottom).offset(17 *SIZE);
//        make.right.equalTo(self.contentView).offset(-28 *SIZE);
//        make.bottom.equalTo(_endTimeL.mas_top).offset(-17 *SIZE);
//    }];
//
    [_endTimeL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(28 *SIZE);
        make.top.equalTo(_timeL.mas_bottom).offset(17 *SIZE);
        make.right.equalTo(self.contentView).offset(-28 *SIZE);
        make.bottom.equalTo(self.contentView).offset(-32 *SIZE);
    }];
    
    [_ruleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(259 *SIZE);
        make.top.equalTo(_nameL.mas_bottom).offset(101 *SIZE);
        make.width.equalTo(@(94 *SIZE));
        make.height.equalTo(@(23 *SIZE));
    }];
    
    [_statusImg mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(271 *SIZE);
        make.top.equalTo(_nameL.mas_bottom).offset(132 *SIZE);
        make.width.height.equalTo(@(75 *SIZE));
//        make.height.equalTo(@(23 *SIZE));
    }];
}

@end
