//
//  NetConfig.h
//  云渠道
//
//  Created by xiaoq on 2018/4/4.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#ifndef NetConfig_h
#define NetConfig_h
#endif /* NetConfig_h */

typedef NS_OPTIONS(NSUInteger, ConfigState){
    BANK_TYPE=1, //银行类型
    CARD_TYPE=2, //证件类型
    COMMISSION_TYPE=3, //提成方式
    COMPLAINT_TYPE=4, //投诉方式
    COMPLAINT_RESOLVE_TYPE=5, //投诉解决方式
    CONTRACT_END_REASON=6, //合同终止原因
    ENABLED_TYPE=7, //禁用类型
    HOUSE_OLD=8,//房龄
    HOUSE_TYPE=9,//住房类型
    MONEY_TYPE=10,//货币类型
    OPEN_TYPE=11,//开盘方式
    BUY_TYPE=12,//置业目的
    PAY_WAY=13,//支付方式
    PROJECT_IMG_TYPE=14,//项目图片类型
    PROJECT_TAGS_DEFAULT=15,//项目标签默认
    PROPERTY_TYPE=16,//物业类型
    BUILD_TYPE=17,//建筑类型
    USER_DISABLED_TYPE=18,//用户失效类型
    FACE=19,//朝向
    LADDER_RATIO=20,//梯户比
    DECORATE=21, //装修标准、
    AVERAGE=22, //均价
    FOLLOW_TYPE=23,//跟进方式
    APPEAL_TYPE=24   //申述类型
};

#pragma mark ---  基础接口  ---
//基础接口
static NSString *const Base_Net = @"http://120.27.21.136:2798/";

#pragma mark ---  配置文件  ---
//配置文件
static NSString *const Config_URL = @"config";

#pragma mark ---  登录注册  ---
//1登录
static NSString *const Login_URL = @"agent/user/login";

//2验证码
static NSString *const Captcha_URL = @"agent/user/captcha";

//3注册
static NSString *const Register_URL = @"agent/user/register";



#pragma mark ---  我的  ---
//上传文件
static NSString *const UploadFile_URL = @"agent/file/upload";
//获取关注列表
static NSString *const GetFocusProjectList_URL = @"agent/personal/getFocusProjectList";



#pragma mark ---  客源  ---


//1客户列表
static NSString *const ListClient_URL = @"agent/client/list";

//新增客户和需求
static NSString *const AddCustomer_URL = @"agent/client/addClientAndNeed";

//6修改客户信息
static NSString *const UpdateClient_URL = @"agent/client/update";


//新增客户需求
static NSString *const AddCliendAddNeed_URL = @"agent/client/addNeed";

//修改客户需求

static NSString *const UpdateNeed_URL = @"agent/client/updateNeed";

//删除客户需求
static NSString *const DeleteNeed_URL = @"agent/client/deleteNeed";

//获取客户信息
static NSString *const GetCliendInfo_URL = @"agent/client/getInfo";

//新增跟进记录
static NSString *const AddRecord_URL = @"agent/client/addFollow";

//获取客户跟进
static NSString *const GetRecord_URL = @"agent/client/getFollowList";






#pragma mark ---  房源  ---
//获取项目列表
static NSString *const ProjectList_URL = @"user/project/list";


