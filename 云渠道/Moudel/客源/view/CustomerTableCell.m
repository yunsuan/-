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
    }
    
    [_nameL mas_remakeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView.mas_left).offset(10 *SIZE);
        make.top.equalTo(self.contentView.mas_top).offset(14 *SIZE);
        make.width.equalTo(@(_nameL.mj_textWith + 10 *SIZE));
        make.height.equalTo(@(14 *SIZE));
    }];
    
    if (model.total_price) {
        
        _priceL.text = [NSString stringWithFormat:@"意向总价：%@",model.total_price];
    }else{
        
        _priceL.text = @"意向总价：";
    }
    
    if (model.house_type) {
        
        _typeL.text = [NSString stringWithFormat:@"意向户型：%@",model.house_type];
    }else{
        
        _typeL.text = @"意向户型：";
    }
    
    if ([_model.region count]) {
        
        _areaL.text = [NSString stringWithFormat:@"意向区域：%@",model.region[0][@"city"]];
    }else{
        
        _areaL.text = @"意向区域：";
    }
   
    
//    NSMutableAttributedString *matchStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"匹配度：%@%@",model.matchRate,@"%"]];
//    [matchStr addAttribute:NSForegroundColorAttributeName value:COLOR(27, 152, 255, 1) range:NSMakeRange(4, matchStr.length - 4)];
//    _matchRateL.attributedText = matchStr;
    
    _phoneL.text = [NSString stringWithFormat:@"%@",model.tel];
    
    NSMutableAttributedString *intentionStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"购买意向度：%@%@",model.intent,@"%"]];
    [intentionStr addAttribute:NSForegroundColorAttributeName value:COLOR(255, 165, 29, 1) range:NSMakeRange(6, intentionStr.length - 6)];
    _intentionRateL.attributedText = intentionStr;
    
    NSMutableAttributedString *urgentStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"购买紧迫度：%@%@",model.urgency,@"%"]];
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
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 110 *SIZE - 2 *SIZE, SCREEN_Width, 2 *SIZE)];
    line.backgroundColor = YJBackColor;
    [self.contentView addSubview:line];
    
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
        make.width.equalTo(@(140 *SIZE));
        make.height.equalTo(@(10 *SIZE));
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
}



@end
