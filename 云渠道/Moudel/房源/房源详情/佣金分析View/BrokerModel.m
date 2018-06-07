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
                                          @"basic" :[NSString stringWithFormat:@"1.推荐后，%@分钟内等信息被确认有效，收到推荐有效信息后%@日内结佣;\n\n2.开发商确认客户有效后%@日内结佣;\n\n3.客户%@日内签订合同，收到成交信息后%@日内结佣",data[i][@"visit_confirm_time"],data[i][@"confirm_settle_commission_time"],data[i][@"visit_settle_commission_time"],data[i][@"make_bargain_time"],data[i][@"region_settle_commission_time"]],
                                          @"begin_time":data[i][@"begin_time"],
                                          @"end_time":data[i][@"end_time"]
                                            };
            [_companyarr addObject:companydic];
            
            
            NSArray *arr = data[i][@"person"];
            [_dataarr addObjectsFromArray:arr];
            for (int j = 0 ; j<arr.count; j++) {
                NSDictionary *dic = @{
                                      @"basic" :[NSString stringWithFormat:@"1.推荐后，%@分钟内等信息被确认有效，收到推荐有效信息后%@日内结佣;\n\n2.开发商确认客户有效后%@日内结佣;\n\n3.客户%@日内签订合同，收到成交信息后%@日内结佣",data[i][@"visit_confirm_time"],data[i][@"confirm_settle_commission_time"],data[i][@"visit_settle_commission_time"],data[i][@"make_bargain_time"],data[i][@"region_settle_commission_time"]]
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
        NSArray *broker = _dataarr[i][@"broker"];
        NSString *str1 =@"";
        NSString *str2 =@"";
        NSString *str3 =@"";
        for (int j =0; j<broker.count; j++) {
      
            if ([broker[j][@"broker_name"] isEqualToString:@"推荐佣金"]) {
                str1 = [NSString stringWithFormat:@"推荐佣金：%@元\n",broker[j][@"list"][0][@"param"]];
            }
            else if ([broker[j][@"broker_name"] isEqualToString:@"到访佣金"])
            {
                str2 = [NSString stringWithFormat:@"到访佣金：%@元\n",broker[j][@"list"][0][@"param"]];
            }
            else{
                NSArray *list = broker[j][@"list"];
                for (int k = 0 ; k<list.count; k++) {
                    if ([list[k][@"commission_way"] isEqualToString:@"定额"]) {
                        NSString *property = list[k][@"property_type"];
                        NSArray *propertyarr = [property componentsSeparatedByString:@","];
                        for (int t= 0; t<propertyarr.count; t++) {
                            
                            if ([propertyarr[t] length]) {
                                
                                str3 = [NSString stringWithFormat:@"%@-%@元;%@",propertyarr[t],list[k][@"param"],str3];
                            }else{
                                
                                str3 = [NSString stringWithFormat:@"%@元;",list[k][@"param"]];
                            }
                        }
                    }
                    else if ([list[k][@"commission_way"] isEqualToString:@"比率"])
                    {
                        NSString *property = list[k][@"property_type"];
                        NSArray *propertyarr = [property componentsSeparatedByString:@","];
                        for (int t= 0; t<propertyarr.count; t++) {
                            str3 = [NSString stringWithFormat:@"%@-总价*%@%%;%@",propertyarr[t],list[k][@"param"],str3];
                        }
                    
                    }else{
                        
                        NSString *property = list[k][@"property_type"];
                        NSArray *propertyarr = [property componentsSeparatedByString:@","];
                        for (int t= 0; t<propertyarr.count; t++) {
                            str3 = [NSString stringWithFormat:@"%@-面积*%@%%;%@",propertyarr[t],list[k][@"param"],str3];
                        }
                        
                    }
                    
                     str3 =[NSString stringWithFormat:@"成交佣金：%@",str3];
                }
            }
        }
        [arr addObject:[NSString stringWithFormat:@"%@%@%@",str1,str2,str3]];
    }
    
    self.breakerinfo = arr;
}


@end
