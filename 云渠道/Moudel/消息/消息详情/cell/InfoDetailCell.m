//
//  InfoDetailCell.m
//  云渠道
//
//  Created by xiaoq on 2018/3/26.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "InfoDetailCell.h"

@implementation InfoDetailCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self initUI];
    }
    return self;
}

-(void)initUI
{
    UIView * header = [[UIView alloc]initWithFrame:CGRectMake(10*SIZE , 19*SIZE, 6.7*SIZE, 13.3*SIZE)];
    header.backgroundColor = YJBlueBtnColor;
    [self.contentView addSubview:header];
    _title = [[UILabel alloc]initWithFrame:CGRectMake(27.3*SIZE, 19*SIZE, 300*SIZE, 16*SIZE)];
    _title.font = [UIFont systemFontOfSize:15.3*SIZE];
    _title.textColor = YJTitleLabColor;
//    _contentview = [[UIView alloc]init];
//    __weak __typeof(&*self)weakSelf = self;
//    [_contentview mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(weakSelf.title.mas_left).offset(1 *SIZE);
//        make.top.equalTo(weakSelf.title.mas_bottom).offset(1 *SIZE);
//        make.width.equalTo(@(300 *SIZE));
//        make.height.equalTo(weakSelf.mas_height);
//    }];
    [self.contentView addSubview:_contentview];
     
}

-(void)SetCellContentbyarr:(NSArray *)arr
{
//    for(int i = 0; i<arr.count; i++){
//        UILabel *contentlab = [[UILabel alloc]init];
//        contentlab.textColor = YJContentLabColor;
//        contentlab.text = arr[i];
//        contentlab.font = [UIFont systemFontOfSize:13.3*SIZE];
//        contentlab.frame = CGRectMake(0, 20*SIZE+29*SIZE*i, 300*SIZE, 16*SIZE);
//        [_contentview addSubview:contentlab];
//    }
}

@end
