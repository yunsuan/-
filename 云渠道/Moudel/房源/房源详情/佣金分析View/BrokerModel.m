//
//  BrokerModel.m
//  云渠道
//
//  Created by xiaoq on 2018/4/27.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "BrokerModel.h"

@implementation BrokerModel

-(instancetype)initWithdata:(NSArray *)data
{
    self = [super init];
    if (self) {
        _bsicarr = [NSMutableArray array];
        _dataarr = [NSMutableArray array];
        _breakerinfo = [NSMutableArray array];
        _companyarr = [NSMutableArray array];
   
        
        
        for (int i = 0; i<data.count; i++) {
            NSDictionary *companydic = @{
                                         @"basic":data[i][@"describe"],
                                         @"begin_time":data[i][@"begin_time"],
                                         @"end_time":data[i][@"end_time"]
//                                         @"basic" :[NSString stringWithFormat:@"1.推荐后，%@分钟内等信息被确认有效，收到推荐有效信息后%@日内结佣;\n\n2.开发商确认客户有效后%@日内结佣;\n\n3.客户%@日内签订合同，收到成交信息后%@日内结佣",data[i][@"visit_confirm_time"],data[i][@"confirm_settle_commission_time"],data[i][@"visit_settle_commission_time"],data[i][@"make_bargain_time"],data[i][@"region_settle_commission_time"]],
//                                          @"begin_time":data[i][@"begin_time"],
//                                          @"end_time":data[i][@"end_time"]
                                         
                                            };
            [_companyarr addObject:companydic];
            
            
            NSArray *arr = data[i][@"person"];
            [_dataarr addObjectsFromArray:arr];
            for (int j = 0 ; j<arr.count; j++) {
                NSDictionary *dic = @{
//                                      @"basic" :[NSString stringWithFormat:@"1.推荐后，%@分钟内等信息被确认有效，收到推荐有效信息后%@日内结佣;\n\n2.开发商确认客户有效后%@日内结佣;\n\n3.客户%@日内签订合同，收到成交信息后%@日内结佣",data[i][@"visit_confirm_time"],data[i][@"confirm_settle_commission_time"],data[i][@"visit_settle_commission_time"],data[i][@"make_bargain_time"],data[i][@"region_settle_commission_time"]]
                                      @"basic":data[i][@"describe"]
                                      };
                [_bsicarr addObject:dic];
            }
        }
        [self getbreakinfo];
    }
    return self;
}

-(void)getbreakinfo
{
    NSMutableArray *arr = [NSMutableArray array];
    for (int i = 0; i<_dataarr.count; i++) {
        [arr addObject:_dataarr[i][@"commission_describe"]];
    }
    self.breakerinfo = arr;
}


@end
