//
//  RoomListModel.h
//  云渠道
//
//  Created by 谷治墙 on 2018/4/11.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RoomListModel : NSObject

@property (nonatomic , strong) NSString *city;
@property (nonatomic , strong) NSString *project_name;
@property (nonatomic , strong) NSString *district;
@property (nonatomic , strong) NSString *average_price;
@property (nonatomic , strong) NSString *property_id;
@property (nonatomic , strong) NSString *province;

- (NSMutableDictionary *)modeltodic;

@end
