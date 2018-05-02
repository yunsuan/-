//
//  CustomerTableCell.m
//  云渠道
//
//  Created by 谷治墙 on 2018/3/20.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "CustomerTableCell.h"

@implementation CustomerTableCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self initUI];
    }
    return self;
}

- (void)setModel:(CustomerTableModel *)model{
    
    if (model.name) {
        
        _nameL.text = model.name;
    }else{
        
        _nameL.text = @"";
    }
    
    [_nameL mas_remakeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView.mas_left).offset(10 *SIZE);
        make.top.equalTo(self.contentView.mas_top).offset(14 *SIZE);
        make.width.equalTo(@(_nameL.mj_textWith + 10 *SIZE));
        make.height.equalTo(@(14 *SIZE));
    }];
    
    if (model.total_price) {
        
        NSDictionary *configdic = [UserModelArchiver unarchive].Configdic;
        NSDictionary *dic =  [configdic valueForKey:[NSString stringWithFormat:@"%d",25]];
        NSArray *typeArr = dic[@"param"];
        for (int i = 0; i < typeArr.count; i++) {
            
            if ([typeArr[i][@"id"] integerValue] == [model.total_price integerValue]) {
                
                _priceL.text = [NSString stringWithFormat:@"意向总价：%@",typeArr[i][@"param"]];
                break;
            }
        }
    }else{
        
        _priceL.text = @"意向总价：";
    }
    
    if (model.property_type) {
        
        NSDictionary *configdic = [UserModelArchiver unarchive].Configdic;
        NSDictionary *dic =  [configdic valueForKey:[NSString stringWithFormat:@"%d",16]];
        NSArray *typeArr = dic[@"param"];
        for (int i = 0; i < typeArr.count; i++) {
            
            if ([typeArr[i][@"id"] integerValue] == [model.property_type integerValue]) {
                
                _typeL.text = [NSString stringWithFormat:@"意向物业：%@",typeArr[i][@"param"]];
                break;
            }
        }
    }else{
        
        _typeL.text = @"意向物业：";
    }
    
    _areaL.text = @"意向区域：";
    
    if (model.region.count) {
        
        for (int i = 0; i < model.region.count; i++) {
            
            if (i == 0) {
                
                if ([model.region[i][@"province_name"] length]) {
                    
                    _areaL.text = [NSString stringWithFormat:@"区域：%@",model.region[i][@"province_name"]];
                    
                    if ([model.region[i][@"city_name"] length]) {
                        
                        _areaL.text = [NSString stringWithFormat:@"%@-%@",_areaL.text,model.region[i][@"city_name"]];
                        if ([model.region[i][@"district_name"] length]) {
                            
                            _areaL.text = [NSString stringWithFormat:@"%@-%@",_areaL.text,model.region[i][@"district_name"]];
                        }
                    }
                }else{
                    
                    _areaL.text = @"区域：";
                }
                
            }else{
                
                if ([model.region[i][@"province_name"] length]) {
                    
                    _areaL.text = [NSString stringWithFormat:@"%@ %@",_areaL.text,model.region[i][@"province_name"]];
                    
                    if ([model.region[i][@"city_name"] length]) {
                        
                        _areaL.text = [NSString stringWithFormat:@"%@-%@",_areaL.text,model.region[i][@"city_name"]];
                        if ([model.region[i][@"district_name"] length]) {
                            
                            _areaL.text = [NSString stringWithFormat:@"%@-%@",_areaL.text,model.region[i][@"district_name"]];
                        }
                    }
                }
            }
        }
    }else{
        
        _areaL.text = @"区域：";
    }

    
    if (model.tel) {
        
        NSArray *arr = [model.tel componentsSeparatedByString:@","];
        _phoneL.text = [NSString stringWithFormat:@"%@",arr[0]];
    }else{
        
        _phoneL.text = [NSString stringWithFormat:@"%@",model.tel];
    }
    
    
    
    NSMutableAttributedString *intentionStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"购买意向度：%@%%",model.intent]];
    [intentionStr addAttribute:NSForegroundColorAttributeName value:COLOR(255, 165, 29, 1) range:NSMakeRange(6, intentionStr.length - 6)];
    _intentionRateL.attributedText = intentionStr;
    
    NSMutableAttributedString *urgentStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"购买紧迫度：%@%%",model.urgency]];
    [urgentStr addAttribute:NSForegroundColorAttributeName value:COLOR(255, 165, 29, 1) range:NSMakeRange(6, urgentStr.length - 6)];
    _urgentRateL.attributedText = urgentStr;
    
    if ([model.sex integerValue] == 0) {
        
        _gender.image = [UIImage imageNamed:@""];
    }else if ([model.sex integerValue] == 1){
        
        _gender.image = [UIImage imageNamed:@"man"];
    }else{
        
        _gender.image = [UIImage imageNamed:@"girl"];
    }
}

- (void)initUI{
    
    _gender = [[UIImageView alloc] init];
//    _gender.layer.cornerRadius = 33.5 *SIZE;
//    _gender.clipsToBounds = YES;
    _gender.backgroundColor = CH_COLOR_white;
    [self.contentView addSubview:_gender];
    
    _nameL = [[UILabel alloc] init];
    _nameL.textColor = YJTitleLabColor;
    _nameL.font = [UIFont systemFontOfSize:15 *SIZE];
    [self.contentView addSubview:_nameL];
    
    _priceL = [[UILabel alloc] init];
    _priceL.textColor = YJContentLabColor;
    _priceL.font = [UIFont systemFontOfSize:11 *SIZE];
    [self.contentView addSubview:_priceL];
    
    _typeL = [[UILabel alloc] init];
    _typeL.textColor = YJContentLabColor;
    _typeL.font = [UIFont systemFontOfSize:11 *SIZE];
    [self.contentView addSubview:_typeL];
    
    _areaL = [[UILabel alloc] init];
    _areaL.textColor = YJContentLabColor;
    _areaL.numberOfLines = 0;
    _areaL.font = [UIFont systemFontOfSize:11 *SIZE];
    [self.contentView addSubview:_areaL];
    
    _matchRateL = [[UILabel alloc] init];
    _matchRateL.textColor = YJContentLabColor;
    _matchRateL.textAlignment = NSTextAlignmentRight;
    _matchRateL.font = [UIFont systemFontOfSize:11 *SIZE];
    [self.contentView addSubview:_matchRateL];
    
    _phoneL = [[UILabel alloc] init];
    _phoneL.textColor = YJContentLabColor;
    _phoneL.font = [UIFont systemFontOfSize:11 *SIZE];
    _phoneL.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:_phoneL];
    
    _intentionRateL = [[UILabel alloc] init];
    _intentionRateL.textColor = YJContentLabColor;
    _intentionRateL.font = [UIFont systemFontOfSize:11 *SIZE];
    _intentionRateL.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:_intentionRateL];
    
    _urgentRateL = [[UILabel alloc] init];
    _urgentRateL.textColor = YJContentLabColor;
    _urgentRateL.font = [UIFont systemFontOfSize:11 *SIZE];
    _urgentRateL.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:_urgentRateL];
    
    _line = [[UIView alloc] init];//WithFrame:CGRectMake(0, 110 *SIZE - 2 *SIZE, SCREEN_Width, 2 *SIZE)];
    _line.backgroundColor = YJBackColor;
    [self.contentView addSubview:_line];
    
    [self MasonryUI];
}

- (void)MasonryUI{
    
    
    [_nameL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView.mas_left).offset(10 *SIZE);
        make.top.equalTo(self.contentView.mas_top).offset(14 *SIZE);
        make.width.equalTo(@(_nameL.mj_textWith + 10 *SIZE));
        make.height.equalTo(@(14 *SIZE));
    }];
    
    [_gender mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_nameL.mas_right).offset(10 *SIZE);
        make.top.equalTo(self.contentView.mas_top).offset(16 *SIZE);
        make.width.equalTo(@(12 *SIZE));
        make.height.equalTo(@(12 *SIZE));
    }];
    
    [_priceL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView.mas_left).offset(10 *SIZE);
        make.top.equalTo(self.contentView.mas_top).offset(36 *SIZE);
        make.width.equalTo(@(140 *SIZE));
        make.height.equalTo(@(10 *SIZE));
    }];
    
    [_typeL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView.mas_left).offset(10 *SIZE);
        make.top.equalTo(self.contentView.mas_top).offset(56 *SIZE);
        make.width.equalTo(@(140 *SIZE));
        make.height.equalTo(@(10 *SIZE));
    }];
    
    [_areaL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView.mas_left).offset(10 *SIZE);
        make.top.equalTo(self.contentView.mas_top).offset(75 *SIZE);
        make.width.equalTo(@(230 *SIZE));
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-15 *SIZE);
    }];
    
    [_matchRateL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(self.contentView.mas_right).offset(-10 *SIZE);
        make.top.equalTo(self.contentView.mas_top).offset(18 *SIZE);
        make.width.equalTo(@(100 *SIZE));
        make.height.equalTo(@(10 *SIZE));
    }];
    
    [_phoneL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(self.contentView.mas_right).offset(-10 *SIZE);
        make.top.equalTo(self.contentView.mas_top).offset(41 *SIZE);
        make.width.equalTo(@(100 *SIZE));
        make.height.equalTo(@(10 *SIZE));
    }];
    
    [_intentionRateL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(self.contentView.mas_right).offset(-10 *SIZE);
        make.top.equalTo(self.contentView.mas_top).offset(59 *SIZE);
        make.width.equalTo(@(100 *SIZE));
        make.height.equalTo(@(10 *SIZE));
    }];
    
    [_urgentRateL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(self.contentView.mas_right).offset(-10 *SIZE);
        make.top.equalTo(self.contentView.mas_top).offset(80 *SIZE);
        make.width.equalTo(@(100 *SIZE));
        make.height.equalTo(@(10 *SIZE));
    }];
    
    [_line mas_makeConstraints:^(MASConstraintMaker *make) {
        
//        CGRectMake(0, 110 *SIZE - 2 *SIZE, SCREEN_Width, 2 *SIZE)
        
        make.left.equalTo(self.contentView.mas_left).offset(0 *SIZE);
        make.top.equalTo(_areaL.mas_bottom).offset(13 *SIZE);
        make.width.equalTo(@(SCREEN_Width));
        make.height.equalTo(@(2 *SIZE));
//        make.bottom.equalTo(self.contentView.mas_bottom).offset(-15 *SIZE);
    }];
}



@end
