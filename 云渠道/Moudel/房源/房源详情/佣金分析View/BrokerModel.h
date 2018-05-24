//
//  BrokerModel.h
//  云渠道
//
//  Created by xiaoq on 2018/4/27.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BrokerModel : NSObject
@property (nonatomic , strong) NSMutableArray *dataarr;
@property (nonatomic , strong) NSMutableArray *bsicarr;
@property (nonatomic , strong) NSMutableArray *companyarr;

-(instancetype)initWithdata:(NSArray *)data;
-(NSMutableArray *)getbreakinfo;
@end
