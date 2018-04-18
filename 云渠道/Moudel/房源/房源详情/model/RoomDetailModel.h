//
//  RoomDetailModel.h
//  云渠道
//
//  Created by 谷治墙 on 2018/4/18.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "BaseModel.h"

@interface RoomDetailModel : BaseModel

@property (nonatomic, strong) NSString *absolute_address;

@property (nonatomic, strong) NSString *average_price;

@property (nonatomic, strong) NSString *developer_name;

@property (nonatomic, strong) NSString *latitude;

@property (nonatomic, strong) NSString *longitude;

@property (nonatomic, strong) NSString *project_name;

@property (nonatomic, strong) NSString *project_tags;

@property (nonatomic, strong) NSString *sale_state;

@property (nonatomic, strong) NSString *total_float_url;

@end
