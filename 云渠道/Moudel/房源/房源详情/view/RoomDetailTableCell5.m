//
//  RoomDetailTableCell5.m
//  云渠道
//
//  Created by 谷治墙 on 2018/3/27.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "RoomDetailTableCell5.h"

@implementation RoomDetailTableCell5

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self initUI];
    }
    return self;
}

//- (void)setModel:(CustomerTableModel *)model{
//    
//    [_headImg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",HTTPHEAD,model.headStr]] placeholderImage:[UIImage imageNamed:@""] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
//        
//    }];
//    _nameL.text = model.name;
//    _priceL.text = [NSString stringWithFormat:@"意向总价：%@",model.price];
//    _typeL.text = [NSString stringWithFormat:@"意向户型：%@",model.type];
//    _areaL.text = [NSString stringWithFormat:@"意向区域：%@",model.area];
//    
//    NSMutableAttributedString *matchStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"匹配度：%@%@",model.matchRate,@"%"]];
//    [matchStr addAttribute:NSForegroundColorAttributeName value:COLOR(27, 152, 255, 1) range:NSMakeRange(4, matchStr.length - 4)];
//    _matchRateL.attributedText = matchStr;
//    
//    _phoneL.text = [NSString stringWithFormat:@"%@",model.phone];
//    
//    NSMutableAttributedString *intentionStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"购买意向度：%@%@",model.intention,@"%"]];
//    [intentionStr addAttribute:NSForegroundColorAttributeName value:COLOR(255, 165, 29, 1) range:NSMakeRange(6, intentionStr.length - 6)];
//    _intentionRateL.attributedText = intentionStr;
//    
//    NSMutableAttributedString *urgentStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"购买紧迫度：%@%@",model.urgent,@"%"]];
//    [urgentStr addAttribute:NSForegroundColorAttributeName value:COLOR(255, 165, 29, 1) range:NSMakeRange(6, urgentStr.length - 6)];
//    _urgentRateL.attributedText = urgentStr;
//    
//}

- (void)initUI{
    
    _headImg = [[UIImageView alloc] init];
    _headImg.layer.cornerRadius = 33.5 *SIZE;
    _headImg.clipsToBounds = YES;
    _headImg.backgroundColor = CH_COLOR_white;
    [self.contentView addSubview:_headImg];
    
    _nameL = [[UILabel alloc] init];
    _nameL.textColor = YJTitleLabColor;
    _nameL.font = [UIFont systemFontOfSize:13 *SIZE];
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
//    _intentionRateL.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:_intentionRateL];
    
    _urgentRateL = [[UILabel alloc] init];
    _urgentRateL.textColor = YJContentLabColor;
    _urgentRateL.font = [UIFont systemFontOfSize:11 *SIZE];
//    _urgentRateL.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:_urgentRateL];
    
    _recommendBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _recommendBtn.titleLabel.font = [UIFont systemFontOfSize:13 *sIZE];
    [_recommendBtn setBackgroundColor:COLOR(27, 152, 255, 1)];
    [_recommendBtn setTitle:@"推荐" forState:UIControlStateNormal];
    [_recommendBtn setTitleColor:CH_COLOR_white forState:UIControlStateNormal];
    [self.contentView addSubview:_recommendBtn];
    
    _line = [[UIView alloc] init];
    _line.backgroundColor = YJBackColor;
    [self.contentView addSubview:_line];
    
    [self MasonryUI];
}

- (void)MasonryUI{
    
    [_headImg mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView.mas_left).offset(10 *SIZE);
        make.top.equalTo(self.contentView.mas_top).offset(30 *SIZE);
        make.width.equalTo(@(67 *SIZE));
        make.height.equalTo(@(67 *SIZE));
    }];
    
    [_nameL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView.mas_left).offset(89 *SIZE);
        make.top.equalTo(self.contentView.mas_top).offset(16 *SIZE);
        make.width.equalTo(@(140 *SIZE));
        make.height.equalTo(@(12 *SIZE));
    }];
    
    [_priceL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView.mas_left).offset(89 *SIZE);
        make.top.equalTo(self.contentView.mas_top).offset(41 *SIZE);
        make.width.equalTo(@(140 *SIZE));
        make.height.equalTo(@(10 *SIZE));
    }];
    
    [_typeL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView.mas_left).offset(89 *SIZE);
        make.top.equalTo(self.contentView.mas_top).offset(59 *SIZE);
        make.width.equalTo(@(140 *SIZE));
        make.height.equalTo(@(10 *SIZE));
    }];
    
    [_areaL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView.mas_left).offset(89 *SIZE);
        make.top.equalTo(self.contentView.mas_top).offset(80 *SIZE);
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
        
        make.right.equalTo(self.contentView).offset(-10 *SIZE);
        make.top.equalTo(self.contentView.mas_top).offset(41 *SIZE);
        make.width.equalTo(@(100 *SIZE));
        make.height.equalTo(@(10 *SIZE));
    }];
    
    [_intentionRateL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(89 *SIZE);
        make.top.equalTo(self.contentView.mas_top).offset(101 *SIZE);
        make.width.equalTo(@(95 *SIZE));
        make.height.equalTo(@(10 *SIZE));
        make.bottom.equalTo(_line.mas_top).offset(-15 *SIZE);
    }];
    
    [_urgentRateL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(186 *SIZE);
        make.top.equalTo(self.contentView.mas_top).offset(101 *SIZE);
        make.width.equalTo(@(95 *SIZE));
        make.height.equalTo(@(10 *SIZE));
    }];
    
    [_recommendBtn mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.right.equalTo(self.contentView).offset(- 10 *SIZE);
        make.top.equalTo(self.contentView).offset(58 *SIZE);
        make.width.equalTo(@(77 *SIZE));
        make.height.equalTo(@(30 *SIZE));
    }];
    
    [_line mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.contentView).offset(0);
        make.top.equalTo(_intentionRateL.mas_bottom).offset(15 *SIZE);
        make.width.equalTo(@(SCREEN_Width));
        make.height.equalTo(@(2 *SIZE));
        make.bottom.equalTo(self.contentView).offset(0);
    }];
}

@end
