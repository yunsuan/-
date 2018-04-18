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
    
    
//    self.cellView.addressL.text = @"区域：成都 - 郫都区   成都 -高新区";
    
    NSData *JSONData = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"region" ofType:@"json"]];
    
    NSError *err;
    NSArray *provice = [NSJSONSerialization JSONObjectWithData:JSONData
                                                       options:NSJSONReadingMutableContainers
                                                         error:&err];
    NSArray *arr = [_model.region componentsSeparatedByString:@","];
    
    for (int i = 0; i < provice.count; i++) {
        
        if([provice[i][@"region"] integerValue] == [arr[0] integerValue]){
            
            NSArray *city = provice[i][@"item"];
            for (int j = 0; j < city.count; j++) {
                
                if([city[j][@"region"] integerValue] == [arr[1] integerValue]){
                    
                    NSArray *area = city[j][@"item"];
                    
                    for (int k = 0; k < area.count; k++) {
                        
                        if([area[k][@"region"] integerValue] == [arr[2] integerValue]){
                            
                            self.cellView.addressL.text = [NSString stringWithFormat:@"区域：%@-%@-%@",provice[i][@"name"],city[0][@"name"],area[k][@"name"]];
                        }
                    }
                }
            }
        }
    }
    
    if ([model.total_price integerValue]) {
        
        NSDictionary *configdic = [UserModelArchiver unarchive].Configdic;
        NSDictionary *dic =  [configdic valueForKey:[NSString stringWithFormat:@"%d",25]];
        NSArray *typeArr = dic[@"param"];
        for (int i = 0; i < typeArr.count; i++) {
            
            if ([typeArr[i][@"id"] integerValue] == [model.total_price integerValue]) {
                
                self.cellView.priceL.text = [NSString stringWithFormat:@"总价：%@",typeArr[i][@"param"]];
                break;
            }
        }
        
    }else{
        
        self.cellView.priceL.text = @"总价：";
    }
    
    if ([model.area integerValue]) {
        
        NSDictionary *configdic = [UserModelArchiver unarchive].Configdic;
        NSDictionary *dic =  [configdic valueForKey:[NSString stringWithFormat:@"%d",26]];
        NSArray *typeArr = dic[@"param"];
        for (int i = 0; i < typeArr.count; i++) {
            
            if ([typeArr[i][@"id"] integerValue] == [model.area integerValue]) {
                
                self.cellView.areaL.text = [NSString stringWithFormat:@"面积：%@",typeArr[i][@"param"]];
                break;
            }
        }
        
    }else{
        
        self.cellView.areaL.text = @"面积：";
    }
    
    if ([model.house_type integerValue]) {
        
        NSDictionary *configdic = [UserModelArchiver unarchive].Configdic;
        NSDictionary *dic =  [configdic valueForKey:[NSString stringWithFormat:@"%d",9]];
        NSArray *typeArr = dic[@"param"];
        for (int i = 0; i < typeArr.count; i++) {
            
            if ([typeArr[i][@"id"] integerValue] == [model.house_type integerValue]) {
                
                self.cellView.houseTypeL.text = [NSString stringWithFormat:@"房型：%@",typeArr[i][@"param"]];
                break;
            }
        }
        
    }else{
        
        self.cellView.houseTypeL.text = @"房型：";
    }
    
//    if ([model.orientation integerValue]) {
//        
//        NSDictionary *configdic = [UserModelArchiver unarchive].Configdic;
//        NSDictionary *dic =  [configdic valueForKey:[NSString stringWithFormat:@"%d",19]];
//        NSArray *typeArr = dic[@"param"];
//        for (int i = 0; i < typeArr.count; i++) {
//            
//            if ([typeArr[i][@"id"] integerValue] == [model.orientation integerValue]) {
//                
//                self.cellView.faceL.text = [NSString stringWithFormat:@"朝向：%@",typeArr[i][@"param"]];
//                break;
//            }
//        }
//        
//    }else{
//        
//        self.cellView.faceL.text = @"朝向：";
//    }
    
    if ([model.floor_max integerValue] && [model.floor_min integerValue]) {
        
        self.cellView.floorL.text = [NSString stringWithFormat:@"楼层：%@层-%@层",model.floor_min,model.floor_max];
    }else if (model.floor_min && !model.floor_max){
        
        self.cellView.floorL.text = [NSString stringWithFormat:@"楼层：%@层以上",model.floor_min];
    }else if (model.floor_max && !model.floor_min){
        
        self.cellView.floorL.text = [NSString stringWithFormat:@"楼层：%@层以上",model.floor_max];
    }else{
        
        self.cellView.floorL.text = @"楼层：";
    }
    
    if ([model.decorate integerValue]) {
        
        NSDictionary *configdic = [UserModelArchiver unarchive].Configdic;
        NSDictionary *dic =  [configdic valueForKey:[NSString stringWithFormat:@"%d",21]];
        NSArray *typeArr = dic[@"param"];
        for (int i = 0; i < typeArr.count; i++) {
            
            if ([typeArr[i][@"id"] integerValue] == [model.decorate integerValue]) {
                
                self.cellView.standardL.text = [NSString stringWithFormat:@"装修标准：%@",typeArr[i][@"param"]];
                break;
            }
        }
        
    }else{
        
        self.cellView.standardL.text = @"装修标准：";
    }
    
    if ([model.buy_purpose integerValue]) {
        
        NSDictionary *configdic = [UserModelArchiver unarchive].Configdic;
        NSDictionary *dic =  [configdic valueForKey:[NSString stringWithFormat:@"%d",12]];
        NSArray *typeArr = dic[@"param"];
        for (int i = 0; i < typeArr.count; i++) {
            
            if ([typeArr[i][@"id"] integerValue] == [model.buy_purpose integerValue]) {
                
                self.cellView.purposeL.text = [NSString stringWithFormat:@"置业目的：%@",typeArr[i][@"param"]];
                break;
            }
        }
        
    }else{
        
        self.cellView.purposeL.text = @"置业目的：";
    }
    
    if ([model.buy_purpose integerValue]) {
        
        NSDictionary *configdic = [UserModelArchiver unarchive].Configdic;
        NSDictionary *dic =  [configdic valueForKey:[NSString stringWithFormat:@"%d",13]];
        NSArray *typeArr = dic[@"param"];
        for (int i = 0; i < typeArr.count; i++) {
            
            if ([typeArr[i][@"id"] integerValue] == [model.pay_type integerValue]) {
                
                self.cellView.payWayL.text = [NSString stringWithFormat:@"付款方式：%@",typeArr[i][@"param"]];
                break;
            }
        }
        
    }else{
        
        self.cellView.payWayL.text = @"付款方式：";
    }
    
    if ([model.intent integerValue]) {
        
        self.cellView.intentionL.text = [NSString stringWithFormat:@"购房意向度：%@",model.urgency];
    }else{
        
        self.cellView.intentionL.text = @"购房意向度：";
    }
    
    if ([model.urgency integerValue]) {
        
        self.cellView.urgentL.text = [NSString stringWithFormat:@"购房紧迫度：%@",model.urgency];
    }else{
        
        self.cellView.urgentL.text = @"购房紧迫度：";
    }
    self.requireL.text = model.comment;
}

- (void)initUI{
    
    _cellView = [[CustomTableCellView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width, 348 *SIZE)];
    [self.contentView addSubview:_cellView];
    
    UILabel *tagL = [[UILabel alloc] initWithFrame:CGRectMake(10 *SIZE, 367 *SIZE, 80 *SIZE, 14 *SIZE)];
    tagL.textColor = YJTitleLabColor;
    tagL.font = [UIFont systemFontOfSize:15 *SIZE];
    tagL.text = @"需求标签";
    [self.contentView addSubview:tagL];
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 466 *SIZE, SCREEN_Width, 36 *SIZE)];
    view.backgroundColor = YJBackColor;
    [self.contentView addSubview:view];
    
    UILabel *requestL = [[UILabel alloc] initWithFrame:CGRectMake(10 *SIZE, 12 *SIZE, 100 *SIZE, 12 *SIZE)];
    requestL.textColor = YJContentLabColor;
    requestL.font = [UIFont systemFontOfSize:13 *SIZE];
    requestL.text = @"其他要求";
    [view addSubview:requestL];
    
    _requireL = [[UILabel alloc] init];
    _requireL.textColor = YJContentLabColor;
    _requireL.numberOfLines = 0;
    _requireL.font = [UIFont systemFontOfSize:12 *SIZE];
    [self.contentView addSubview:_requireL];
    
    [self masonryUI];
}

- (void)masonryUI{
    
    [_requireL mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.contentView).offset(28 *SIZE);
        make.top.equalTo(self.contentView).offset(518 *SIZE);
        make.right.equalTo(self.contentView).offset(-28 *SIZE);
        make.bottom.equalTo(self.contentView).offset(-72 *SIZE);
    }];
}

@end
