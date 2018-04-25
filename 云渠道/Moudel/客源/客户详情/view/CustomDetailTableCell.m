//
//  CustomDetailTableCell.m
//  云渠道
//
//  Created by 谷治墙 on 2018/3/22.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "CustomDetailTableCell.h"

@implementation CustomDetailTableCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self initUI];
    }
    return self;
}

- (void)setModel:(CustomRequireModel *)model{
    
    if ([model.house_type integerValue]) {
        
        NSDictionary *configdic = [UserModelArchiver unarchive].Configdic;
        NSDictionary *dic =  [configdic valueForKey:[NSString stringWithFormat:@"%d",16]];
        NSArray *typeArr = dic[@"param"];
        for (int i = 0; i < typeArr.count; i++) {
            
            if ([typeArr[i][@"id"] integerValue] == [model.house_type integerValue]) {
                
                _typeL.text = [NSString stringWithFormat:@"物业类型：%@",typeArr[i][@"param"]];
                break;
            }
        }
        
    }else{
        
        _typeL.text = @"物业类型：";
    }
    
    if (model.region.count) {
        
        for (int i = 0; i < model.region.count; i++) {
            
            if (i == 0) {
                
                if ([model.region[i][@"province_name"] length]) {
                    
                    _addressL.text = [NSString stringWithFormat:@"区域：%@",model.region[i][@"province_name"]];
                    
                    if ([model.region[i][@"city_name"] length]) {
                        
                        _addressL.text = [NSString stringWithFormat:@"%@-%@",_addressL.text,model.region[i][@"city_name"]];
                        if ([model.region[i][@"district_name"] length]) {
                            
                            _addressL.text = [NSString stringWithFormat:@"%@-%@",_addressL.text,model.region[i][@"district_name"]];
                        }
                    }
                }else{
                    
                    _addressL.text = @"区域：";
                }
                
            }else{
                
                if ([model.region[i][@"province_name"] length]) {
                    
                    _addressL.text = [NSString stringWithFormat:@"%@ %@",_addressL.text,model.region[i][@"province_name"]];
                    
                    if ([model.region[i][@"city_name"] length]) {
                        
                        _addressL.text = [NSString stringWithFormat:@"%@-%@",_addressL.text,model.region[i][@"city_name"]];
                        if ([model.region[i][@"district_name"] length]) {
                            
                            _addressL.text = [NSString stringWithFormat:@"%@-%@",_addressL.text,model.region[i][@"district_name"]];
                        }
                    }
                }
            }
        }
    }else{
        
        _addressL.text = @"区域：";
    }
    
    if ([model.total_price integerValue]) {
        
        NSDictionary *configdic = [UserModelArchiver unarchive].Configdic;
        NSDictionary *dic =  [configdic valueForKey:[NSString stringWithFormat:@"%d",25]];
        NSArray *typeArr = dic[@"param"];
        for (int i = 0; i < typeArr.count; i++) {
            
            if ([typeArr[i][@"id"] integerValue] == [model.total_price integerValue]) {
                
                _priceL.text = [NSString stringWithFormat:@"总价：%@",typeArr[i][@"param"]];
                break;
            }
        }
        
    }else{
        
        _priceL.text = @"总价：";
    }
    
    if ([model.area integerValue]) {
        
        NSDictionary *configdic = [UserModelArchiver unarchive].Configdic;
        NSDictionary *dic =  [configdic valueForKey:[NSString stringWithFormat:@"%d",26]];
        NSArray *typeArr = dic[@"param"];
        for (int i = 0; i < typeArr.count; i++) {
            
            if ([typeArr[i][@"id"] integerValue] == [model.area integerValue]) {
                
                _areaL.text = [NSString stringWithFormat:@"面积：%@",typeArr[i][@"param"]];
                break;
            }
        }
        
    }else{
        
        _areaL.text = @"面积：";
    }
    
    if ([model.property_type integerValue]) {
        
        NSDictionary *configdic = [UserModelArchiver unarchive].Configdic;
        NSDictionary *dic =  [configdic valueForKey:[NSString stringWithFormat:@"%d",9]];
        NSArray *typeArr = dic[@"param"];
        for (int i = 0; i < typeArr.count; i++) {
            
            if ([typeArr[i][@"id"] integerValue] == [model.property_type integerValue]) {
                
                _houseTypeL.text = [NSString stringWithFormat:@"户型：%@",typeArr[i][@"param"]];
                break;
            }
        }
        
    }else{
        
        _houseTypeL.text = @"户型：";
    }
    
    if ([model.floor_max integerValue] && [model.floor_min integerValue]) {
        
        _floorL.text = [NSString stringWithFormat:@"楼层：%@层-%@层",model.floor_min,model.floor_max];
    }else if (model.floor_min && !model.floor_max){
        
        _floorL.text = [NSString stringWithFormat:@"楼层：%@层以上",model.floor_min];
    }else if (model.floor_max && !model.floor_min){
        
        _floorL.text = [NSString stringWithFormat:@"楼层：%@层以上",model.floor_max];
    }else{
        
        _floorL.text = @"楼层：";
    }
    
    if ([model.decorate integerValue]) {
        
        NSDictionary *configdic = [UserModelArchiver unarchive].Configdic;
        NSDictionary *dic =  [configdic valueForKey:[NSString stringWithFormat:@"%d",21]];
        NSArray *typeArr = dic[@"param"];
        for (int i = 0; i < typeArr.count; i++) {
            
            if ([typeArr[i][@"id"] integerValue] == [model.decorate integerValue]) {
                
                _standardL.text = [NSString stringWithFormat:@"装修标准：%@",typeArr[i][@"param"]];
                break;
            }
        }
        
    }else{
        
        _standardL.text = @"装修标准：";
    }
    
    if ([model.buy_purpose integerValue]) {
        
        NSDictionary *configdic = [UserModelArchiver unarchive].Configdic;
        NSDictionary *dic =  [configdic valueForKey:[NSString stringWithFormat:@"%d",12]];
        NSArray *typeArr = dic[@"param"];
        for (int i = 0; i < typeArr.count; i++) {
            
            if ([typeArr[i][@"id"] integerValue] == [model.buy_purpose integerValue]) {
                
                _purposeL.text = [NSString stringWithFormat:@"置业目的：%@",typeArr[i][@"param"]];
                break;
            }
        }
        
    }else{
        
        _purposeL.text = @"置业目的：";
    }
    
    if ([model.pay_type integerValue]) {
        
        NSDictionary *configdic = [UserModelArchiver unarchive].Configdic;
        NSDictionary *dic =  [configdic valueForKey:[NSString stringWithFormat:@"%d",13]];
        NSArray *typeArr = dic[@"param"];
        for (int i = 0; i < typeArr.count; i++) {
            
            if ([typeArr[i][@"id"] integerValue] == [model.pay_type integerValue]) {
                
                _payWayL.text = [NSString stringWithFormat:@"付款方式：%@",typeArr[i][@"param"]];
                break;
            }
        }
        
    }else{
        
        _payWayL.text = @"付款方式：";
    }
    
    if ([model.intent integerValue]) {
        
        _intentionL.text = [NSString stringWithFormat:@"购房意向度：%@",model.urgency];
    }else{
        
        _intentionL.text = @"购房意向度：";
    }
    
    if ([model.urgency integerValue]) {
        
        _urgentL.text = [NSString stringWithFormat:@"购房紧迫度：%@",model.urgency];
    }else{
        
        _urgentL.text = @"购房紧迫度：";
    }
}

- (void)ActionEditBtn:(UIButton *)btn{
    
    if (self.editBlock) {
        
        self.editBlock(self.tag);
    }
}

- (void)initUI{
    
    for (int i = 0 ; i < 11; i++) {
        
        if (i < 2) {
            
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.frame = CGRectMake(280 *SIZE + i * 47 *SIZE, 5 *SIZE, 29 *SIZE, 29 *SIZE);
            if (i == 0) {
                
                
            }else{
                
                [btn addTarget:self action:@selector(ActionEditBtn:) forControlEvents:UIControlEventTouchUpInside];
                [btn setImage:[UIImage imageNamed:@"eidt"] forState:UIControlStateNormal];
                _editBtn = btn;
                [self addSubview:_editBtn];
            }
        }
        
        UILabel *label = [[UILabel alloc] init];
        label.textColor = YJTitleLabColor;
        label.font = [UIFont systemFontOfSize:13 *SIZE];
        switch (i) {
            case 0:
            {
                _typeL = label;
                [self.contentView addSubview:_typeL];
                break;
            }
            case 1:
            {
                _addressL = label;
                _addressL.numberOfLines = 0;
                [self.contentView addSubview:_addressL];
                break;
            }
            case 2:
            {
                _priceL = label;
                [self.contentView addSubview:_priceL];
                break;
            }
            case 3:
            {
                _areaL = label;
                [self.contentView addSubview:_areaL];
                break;
            }
            case 4:
            {
                _houseTypeL = label;
                [self.contentView addSubview:_houseTypeL];
                break;
            }
            case 5:
            {
                _floorL = label;
                [self.contentView addSubview:_floorL];
                break;
            }
            case 6:
            {
                _standardL = label;
                [self.contentView addSubview:_standardL];
                break;
            }
            case 7:
            {
                _purposeL = label;
                [self.contentView addSubview:_purposeL];
                break;
            }
            case 8:
            {
                _payWayL = label;
                [self.contentView addSubview:_payWayL];
                break;
            }
            case 9:
            {
                _intentionL = label;
                [self.contentView addSubview:_intentionL];
                break;
            }
            case 10:
            {
                _urgentL = label;
                [self.contentView addSubview:_urgentL];
                break;
            }
            default:
                break;
        }
    }
    
    [self MasonryUI];
}

- (void)MasonryUI{
    
    [_typeL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(28 *SIZE);
        make.top.equalTo(self.contentView).offset(32 *SIZE);
        make.width.equalTo(@(300 *SIZE));
    }];
    
    [_addressL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(28 *SIZE);
        make.top.equalTo(_typeL.mas_bottom).offset(18 *SIZE);
        make.width.equalTo(@(300 *SIZE));
    }];
    
    [_priceL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(28 *SIZE);
        make.top.equalTo(_addressL.mas_bottom).offset(18 *SIZE);
        make.width.equalTo(@(300 *SIZE));
    }];
    
    [_areaL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(28 *SIZE);
        make.top.equalTo(_priceL.mas_bottom).offset(18 *SIZE);
        make.width.equalTo(@(300 *SIZE));
    }];
    
    [_houseTypeL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(28 *SIZE);
        make.top.equalTo(_areaL.mas_bottom).offset(18 *SIZE);
        make.width.equalTo(@(300 *SIZE));
    }];
    
    [_floorL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(28 *SIZE);
        make.top.equalTo(_houseTypeL.mas_bottom).offset(18 *SIZE);
        make.width.equalTo(@(300 *SIZE));
    }];
    
    [_standardL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(28 *SIZE);
        make.top.equalTo(_floorL.mas_bottom).offset(18 *SIZE);
        make.width.equalTo(@(300 *SIZE));
    }];
    
    [_purposeL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(28 *SIZE);
        make.top.equalTo(_standardL.mas_bottom).offset(18 *SIZE);
        make.width.equalTo(@(300 *SIZE));
    }];
    
    [_payWayL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(28 *SIZE);
        make.top.equalTo(_purposeL.mas_bottom).offset(18 *SIZE);
        make.width.equalTo(@(300 *SIZE));
    }];
    
    [_intentionL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(28 *SIZE);
        make.top.equalTo(_payWayL.mas_bottom).offset(18 *SIZE);
        make.width.equalTo(@(300 *SIZE));
    }];
    
    [_urgentL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(28 *SIZE);
        make.top.equalTo(_intentionL.mas_bottom).offset(18 *SIZE);
        make.width.equalTo(@(300 *SIZE));
        make.bottom.equalTo(self.contentView).offset(-17 *SIZE);
    }];
    
    
}

@end
