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

#pragma mark ---  基础接口  ---
//基础接口
static NSString *const Base_Net = @"http://120.27.21.136:2798/";

#pragma mark ---  配置文件  ---
//1获取省份
static NSString *const ProvinceList_URL = @"getProvinceList";

//2获取市
static NSString *const CityList_URL = @"getCityList";

//3获取区县
static NSString *const AreaList_URL = @"getDistrictList";



#pragma mark ---  新增客户  ---
//1登录
static NSString *const Login_URL = @"agent/user/login";

//2验证码
static NSString *const Captcha_URL = @"agent/user/captcha";

//3注册
static NSString *const Register_URL = @"agent/user/register";

//4新增客户
static NSString *const AddCustomer_URL = @"agent/client/add";

