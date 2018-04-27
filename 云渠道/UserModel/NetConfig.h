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
//配置文件
static NSString *const Config_URL = @"config";

#pragma mark ---  登录注册  ---
//1登录
static NSString *const Login_URL = @"agent/user/login";

//2验证码
static NSString *const Captcha_URL = @"agent/user/captcha";

//3注册
static NSString *const Register_URL = @"agent/user/register";

//修改密码
static NSString *const ChangePassword_URL = @"agent/user/changePassword";



#pragma mark ---  我的  ---
//上传文件
static NSString *const UploadFile_URL = @"agent/file/upload";

//获取关注列表
static NSString *const GetFocusProjectList_URL = @"agent/personal/getFocusProjectList";

//获取个人信息
static NSString *const GetPersonalBaseInfo_URL = @"agent/personal/getBaseInfo";

//修改个人信息
static NSString *const UpdatePersonal_URL = @"agent/personal/update";

//获取公司列表
static NSString *const GetCompanyList_URL = @"agent/personal/getCompanyList";

//获取经纪人工作历史
static NSString *const WorkHis_URL = @"agent/personal/WorkHis";

//获取经纪人申请历史
static NSString *const ApplyHis_URL = @"agent/personal/ApplyHis";

//取消关注项目
static NSString *const CancelFocusProject_URL = @"agent/personal/cancelFocusProject";

//绑定银行卡
static NSString *const BindingBankCard_URL = @"agent/personal/bindingBankCard";

//发送验证码
static NSString *const SendCaptcha_URL = @"agent/personal/sendCaptcha";

//获取银行卡信息
static NSString *const BankCardInfo_URL = @"agent/personal/bankCardInfo";

//意见反馈
static NSString *const Advice_URL = @"agent/personal/advice";
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
//获取客户以推荐项目
static NSString *const GetStateList_URL = @"agent/client/getStateList";



#pragma mark ---  房源  ---
//获取项目列表
static NSString *const ProjectList_URL = @"user/project/list";

//获取项目信息，动态，户型等信息
static NSString *const ProjectDetail_URL = @"user/project/detail";

//关注项目
static NSString *const FocusProject_URL = @"agent/personal/focusProject";

//获取动态列表
static NSString *const DynamicList_URL = @"user/dynamic/list";

//获取项目图片
static NSString *const GetImg_URL = @"user/img/get";

//获取项目分析
static NSString *const HouseTypeAnalyse_URL = @"user/houseType/analyse";

//获取佣金规则
static NSString *const GetRule_URL = @"user/project/getRule";

//获取户型信息
static NSString *const HouseTypeDetail_URL = @"user/houseType/detail";



#pragma mark ---  消息  ---

//获取消息未读数量
static NSString *const InfoList_URL = @"agent/message/getUnread";

static NSString *const SystemInfoList_URL = @"agent/message/system";

static NSString *const SystemRead_URL = @"agent/message/agentMessageRead";

#pragma mark ---  工作  ---
static NSString *const RecommendList_URL = @"user/work/getRecommendList";

static NSString *const AgentInfoCount_URL = @"user/work/broker/count";

static NSString *const Butterinfocount_URL = @"user/work/butter/count";

