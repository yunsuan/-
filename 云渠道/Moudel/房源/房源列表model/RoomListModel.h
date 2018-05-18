//
//  RoomListModel.h
//  云渠道
//
//  Created by 谷治墙 on 2018/4/11.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RoomListModel : NSObject

@property (nonatomic, strong) NSString *absolute_address;
@property (nonatomic, strong) NSString *brokerSortCompare;
@property (nonatomic, strong) NSString *city;
@property (nonatomic, strong) NSString *city_name;
@property (nonatomic, strong) NSString *cycle;
@property (nonatomic, strong) NSString *deposit;
@property (nonatomic, strong) NSString *district;
@property (nonatomic, strong) NSString *district_name;
@property (nonatomic, strong) NSString *img_url;
@property (nonatomic, strong) NSString *guarantee_brokerage;
@property (nonatomic, strong) NSString *project_id;
@property (nonatomic, strong) NSString *project_name;
@property (nonatomic, strong) NSString *project_tags;
@property (nonatomic, strong) NSMutableArray *property_tags;
@property (nonatomic, strong) NSString *province;
@property (nonatomic, strong) NSString *province_name;
@property (nonatomic, strong) NSString *sale_state;
@property (nonatomic, strong) NSString *sort;



- (NSMutableDictionary *)modeltodic;
- (instancetype)initWithDictionary:(NSDictionary *)dict;

@end
