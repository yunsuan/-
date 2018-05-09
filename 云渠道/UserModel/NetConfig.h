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

static NSString *const Advicer_URL = @"user/yunsuan/advicer";

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

//推荐客户
static NSString *const RecommendClient_URL = @"agent/client/recommend";

//客户匹配项目
static NSString *const ClientMatching_URL = @"agent/matching/client";

#pragma mark ---  房源  ---
//获取开放区域
static NSString *const OpenCity_URL = @"user/project/openCity";

//获取项目列表
static NSString *const ProjectList_URL = @"user/project/list";

//获取项目信息，动态，户型等信息
static NSString *const ProjectDetail_URL = @"user/project/detail";

//获取项目的具体信息
static NSString *const ProjectBuildInfo_URL = @"user/project/buildInfo";

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

//项目户型匹配
static NSString *const HouseTypeMatching_URL = @"agent/matching/houseType";

//项目匹配客户
static NSString *const ProjectMatching_URL = @"agent/matching/project";

//获取楼栋
static NSString *const GetBuilding_URL = @"user/yunsuan/build";

//获取单元
static NSString *const GetUnit_URL = @"user/yunsuan/unit";

//添加客户并且推荐到项目上
static NSString *const AddAndRecommend_URL = @"project/client/addAndRecommend";

//获取客源列表用于推荐
static NSString *const FastRecommendList_URL = @"agent/matching/fastRecommendList";
#pragma mark ---  消息  ---

//获取消息未读数量
static NSString *const InfoList_URL = @"agent/message/getUnread";

//系统消息列表
static NSString *const SystemInfoList_URL = @"agent/message/system";

//标记系统消息已读
static NSString *const SystemRead_URL = @"agent/message/agentMessageRead";

//工作消息列表
static NSString *const WorkingInfoList_URL = @"agent/message/work/list";

//经纪人待确认客户消息
static NSString *const WaitConfirminfo_URL = @"agent/message/work/waitConfirmDetail";

//经纪人有效到访客户消息
static NSString *const Valueinfo_URL = @"agent/message/work/confirmDetail";

//经纪人无效客户消息
static NSString *const Disabledinfo_URL = @"agent/message/work/disabledDetail";
#pragma mark ---  工作  ---
static NSString *const RecommendList_URL = @"agent/work/getRecommendList";

static NSString *const AgentInfoCount_URL = @"agent/work/broker/count";

static NSString *const Butterinfocount_URL = @"agent/work/butter/count";

//更新数据
static NSString *const FlushDate_URL = @"agent/work/flushDate";

//经纪人信息统计
static NSString *const BrokerCount_URL = @"agent/work/broker/count";

//对接人信息统计
static NSString *const ButterCount_URL = @"agent/work/butter/count";

//经纪人待确认客户列表
static NSString *const BrokerWaitConfirm_URL = @"agent/work/broker/waitConfirm";

//经纪人有效到访客户列表
static NSString *const BrokerValue_URL = @"agent/work/broker/value";

//经纪人无效列表
static NSString *const BrokerDisabled_URL = @"agent/work/broker/disabled";

//申诉
static NSString *const ClientAppeal_URL = @"agent/client/appeal";

//经纪人申诉列表
static NSString *const BrokerAppeal_URL = @"agent/work/broker/appeal";

//经纪人申诉详情
static NSString *const BrokerAppealDetail_URL = @"agent/work/broker/appealDetail";

//对接经纪人判断为有效到访
static NSString *const ConfirmValue_URL = @"agent/client/confirmValue";


//对接经纪人判断为无效
static NSString *const ConfirmDisabled_URL = @"agent/client/confirmDisabled";

//经纪人待确认客户详细
static NSString *const WaitConfirmDetail_URL = @"agent/work/broker/waitConfirmDetail";

//经纪人无效客户详细
static NSString *const DisabledDetail_URL = @"agent/work/broker/disabledDetail";

//获取申诉信息
static NSString *const AppealGetOne_URL = @"agent/appeal/getOne";

//取消申诉
static NSString *const AppealCancel_URL = @"agent/client/appealCancel";

//经纪人有效到访客户详细
static NSString *const ValueDetail_URL = @"agent/work/broker/valueDetail";

//项目待确认列表
static NSString *const ProjectWaitConfirm_URL = @"agent/work/project/waitConfirm";

//项目待确认详情
static NSString *const ProjectWaitConfirmDetail_URL = @"agent/work/project/waitConfirmDetail";

//项目有效列表
static NSString *const ProjectValue_URL = @"agent/work/project/value";

//项目有效详情
static NSString *const ProjectValueDetail_URL = @"agent/work/project/valueDetail";

//项目失效列表
static NSString *const ProjectDisabled_URL = @"agent/work/project/disabled";

//项目失效详情
static NSString *const ProjectDisabledDetail_URL = @"agent/work/project/disabledDetail";

//项目申诉列表
static NSString *const ProjectAppealList_URL = @"agent/work/project/appealList";

//经纪人待成交列表
static NSString *const ProjectWaitDeal_URL = @"agent/work/project/waitDeal";
