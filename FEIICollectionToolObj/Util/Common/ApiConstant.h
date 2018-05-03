//
//  ApiConstant.h
//  dploffice
//
//  Created by shine-team1 on 16/8/4.
//  Copyright © 2016年 com. All rights reserved.
//

#ifndef ApiConstant_h
#define ApiConstant_h



#pragma mark /************************* GET请求 ***************************/

/**
 *  获取首页的地址
 */
//#define URL_GET_HOME @"/component/sequ/list"
#define URL_GET_HOME @"/home"
/**
 *  获取分类资源
 */
#define URL_GET_GATEGORYMATION @"/informationCategory/parent/list?parentId"
/**
 *  根据ID进行获取资源
 */
#define URL_GET_IDGATEGORYMATION @"/information/category/list?categoryId="
/**
 *  根据分类资源ID进入详情页面
 */
#define URL_GET_IDDETAILGATEGORYMATION @"/information/detail?id="
/**
 *  搜索资源
 */
#define URL_GET_SEATCHALLSOURESS @"/information/list?title.27="
/**
 *  增加资源浏览量
 */
#define URL_GET_ADDEXPLORORCOUNT @"/information/addPv?id="
/**
 *  获取资源评论列表
 */
#define URL_GET_COMMENTLIST @"/review/information/list?informationId="
/**
 *  帖子回复列表
 */
#define URL_GET_INVITITONDAETALIST @"/posterreview/"
/**
 *  获取用户最新动态
 */
#define URL_GET_INFORMATIONNEW @"/information/enterprise/news"

/**
 *  获取关注列表
 */
#define URL_GET_INFOMATIONFRIENDLIST @"/information/friends/list"
/**
 *  获取省份
 */
#define URL_GET_ALLPROVINCELIST @"/area/allProvince"
/**
 *  获取城市
 */
#define URL_GET_ALLPROVINCELISTID @"/area/parent/list?parentId="
/**
 *  获取所有职业
 */
#define URL_GET_ALLPOSITIONLIST @"/position/parent/list?parentId="

/**
 *  获取粉丝列表
 */
#define URL_GET_RELATIONSHIPFRIENDLIST @"/relationship/friendlist"

/**
 *  获取关注列表
 */
#define URL_GET_RELATIONSHIPIDOLLIST @"/relationship/idollist"

/**
 *  获取图片验证码
 */
///jcaptcha?codeid=
#define URL_GET_CAPTCHAPHONE @"/captcha?phone="

/**
 *  验证码验证
 */
#define URL_GET_CHECKPHONEANDCODE @"/member/imgCode/check?phone={phone}&code={code}"

/**
 *  验证手机号有限性
 */
#define URL_GET_PHONEVALIDCHECK @"/member/phone/valid/check?phone="

/**
 *  手机验证码用途，注册和忘记密码
 */
#define PHONE_REGISTER @"add"
#define PHONE_FORGET @"forget"

/**
 *  获取企业列表
 */
#define URL_ENTERPRISE @"/business/list"

// 我的发布资源列表
#define URL_INFORMATION_PUBLIST @"/information/user/list"

// 我的收藏资源列表
#define URL_INFORMATION_COLLECTIONLIST @"/information/user/collentlist"

// 我发布的帖子列表
#define URL_POSTER_PUBLIST @"/poster/myposter"

// 我评论的帖子列表
#define URL_POSTER_COMLIST @"/poster/myreviewposter"


#define USER_MEMBER_TYPE @"0"
#define USER_ENTERPRISE_TYPE @"1"

#define URL_ME_HOME @"/member/me/home"

#define URL_ME_ENTERPRISE_HOME @"/enterprise/me/home"

#define URL_MEMBER_HOME @"/member/{id}/home"

#define URL_ENTERPRISE_HOME @"/enterprise/{id}/home"

// 用户加入的部落列表
#define URL_USER_JOINED_TRIBE @"/tribe/{fansId}/{fansType}/membertribelist"

// 用户粉丝列表
#define URL_USER_FOCUS @"/relationship/{idolId}/{idolType}/memberfriendlist"

// 用户关注列表
#define URL_USER_FOCUS_LIST @"/relationship/{idolId}/{idolType}/memberidollist"

// 用户发布的资源
#define URL_USER_INFORMATION @"/information/{userId}/{userType}/list"

//获取用户级别信息
#define URL_GET_MEMBER_LEVEL @"/member/me/level"

/******************* 茶点预订模块 *********************/

//获取茶点列表
#define URL_GET_TEACAKE_LIST @"/teacake/list?spaceId="

//获取网点信息
#define URL_GET_SPACE_LIST @"/space/list"

//支持茶点配送的网点列表
#define URL_SPACE_SUPPORT_SEND_LIST @"/space/supportsend/list"

//获取楼层网点信息
#define URL_GET_SPACE_FLOORS @"/space/{sid}/floors"

//获取房间列表
#define URL_GET_SPACE_FLOORSOFFCIS @"/space/floor/{fid}/offices"

//订单详情
#define URL_GET_TEACAKEORDER @"/teacake/order/{id}/detail"
#define URL_GET_MEETINGROOMORDER @"/meetingroom/booking/{id}/detail"

//前提获取订单评价
#define URL_GET_TEACKEEVALUATE @"/teacake/order/{orderid}/teacake/evaluate"

//获取用户收货人信息
#define URL_GET_TEACKERMENBER @"/teacake/consignee/member"

#pragma mark /************************* POST请求 ***************************/
/**
 *  微信登录
 */
#define URL_POST_WXLOGIN @"/member/signin"

//退出登录
#define URL_SING_OUT     @"/member/signout"

/**
 *  上传图片
 */
#define URL_POST_PUSHIMAGE @"/file/upload"
/**
 *  创建保存部落
 */
#define URL_POST_ALLTRIBEVC @"/tribe/save"

// 删除部落
#define URL_TRIBE_DELETE @"/tribe/{tid}/delete"

/**
 *  保持资源评论
 */
#define URL_POST_SAVATCOMENT @"/review/save"
/**
 *  发布接口
 */
#define URL_POST_INFORMATION @"/information/save"
/**
 *  帖子评论接口
 */
#define URL_POST_ERREVIEWINFOMATION @"/poster/review/save"

/**
 *  关注接口
 */
#define URL_POST_ERELATIONSHIPBEFRIEND @"/relationship/befriend"
/**
 *  取消关注接口
 */
#define URL_POST_ERELATIONSHIPCANCELBEFRIEND @"/relationship/cancelbefriend"
/**
 *  发布帖子接口
 */
#define URL_POST_POSTERSAVER @"/poster/save"

#define URL_POST_DELETE @"/poster/{pid}/delete"

#define URL_POST_UPDATE @"/poster/update"

/**
 *  更新用户信息
 */
#define URL_POST_MEMBER_INFO_UPDATE @"/member/me/info/update"

/**
 *  手机注册
 */
#define URL_POST_MEMBERREGISTER @"/member/register"

/**
 *  更新用户信息
 */
#define URL_POST_MEMBER_SIGNOUT @"/member/signout"

/**
 *  手机验证码校验
 */
#define URL_POST_PHONECHECK @"/member/check/phone/code"

/**
 *  找回密码
 */
#define URL_POST_GETCAKPASSWORD @"/member/getcackpassword"

//修改密码
#define URL_CHANGE_PASSWORD @"/member/me/updatepassword"

/**
 *  收藏资源
 */
#define URL_POST_COLLENT @"/information/collent"


#define URL_POST_SIGNIN_PHONE @"/member/signin/phone"



// 消息提醒类型
#define CHAT_MESSAGE_TYPE @"CHAT"

#define REPLY_MESSAGE_TYPE @"REPLY"

#define URL_MESSAGE_REMIND_STATUS @"/member/me/message/status"

// 修改消息提醒设置
#define URL_MESSAGE_REMIND_CHANGE @"/member/me/message/remind/change"


/**
 *  推送校验码
 */
#define URL_POST_ENTERPRISE_PHONE_VCODE @"/member/phone/vcode"

//我的企业列表
#define URL_ME_ENTERPRISE @"/member/me/enterprise/list"
/**
 *  更新绑定手机
 */
#define URL_POST_MEMBER_PHONE_UPDATE @"/member/me/phone/update"

/**
 *  绑定微信
 */
#define URL_POST_ME_WECHAT @"/member/me/bindwechat"

//解除绑定企业
#define URL_UNBIND_ENTERPRISE @"/member/me/bindrecord/unbind"

// 取消绑定
#define URL_CANCEL_ENTERPRISE_BIND @"/member/me/bindrecord/cancel"

// 搜索企业
#define URL_SEARCH_ENTERPRISE @"/member/enterprise/search"

// 绑定企业
#define URL_BIND_ENTERPRISE @"/member/me/enterprise/bind"

#define URL_INFOMATION_DELETE @"/information/delete"

#define URL_FOCUS_FRIEND_LIST @"/poster/friends/list"

// 顶级行业URL
#define URL_INDUSTRY_TOP_LIST @"/industry/toplist"
// 子级行业URL
#define URL_INDUSTRY_CHILDREN_LIST @"/industry/parent/list?parentId="

// 新增企业服务URL
#define URL_ENTERPRISE_BUSINESS_SAVE @"/business/save"
// 企业服务详情URL
#define URL_ENTERPRISE_DETAIL @"/business/{bid}/detail"
// 删除企业服务
#define URL_ENTERPRISE_DELETE @"/business/{bid}/delete"

// 删除帖子评论URL
#define URL_COMMENT_DELETE @"/posterreview/{cid}/delete"

#define URL_INFO_COMMENT_DELETE @"/review/delete"

//已报名参加的活动
#define URL_JOINED_ACTIVITY_LIST @"/activity/join/list"

/******************* 茶点预订模块 *********************/

//订单列表
#define URL_ORDER_LIST @"/teacake/order/list"
#define URL_MEETINGROOMORDER @"/meetingroom/booking/list"

//生成订单
#define URL_ORDER_SAVE @"/teacake/order/save"

//更新订单交易状态
#define URL_UPDATEDEALSTATUS @"/teacake/order/dealstatus/update"

//微信支付
#define URL_WECHATPACKAGES @"/teacake/order/wechat/packages"
#define URL_WECHATMEETING @"/meetingroom/booking/wechat/packages"

//评价订单
#define URL_EVALUATE_ORDER @"/teacake/order/evaluate/save"

//保存收货人信息
#define URL_TEACKECONIGNESAVE @"/teacake/consignee/save"

//更新收货人信息
#define URL_URL_TEACKECONIGNEUPDATE @"/teacake/consignee/update"

/***************** 会议室预订模块 ***********************/

//会议室列表
#define URL_MEETINGROOM_LIST @"/meetingroom/list"

//获取某天的会议室列表
#define URL_MEETINGROOM_DATE_LIST @"/meetingroom/date/list?date="

//会议室详情
#define URL_MEETINGROOM_DETAIL @"/meetingroom/{id}"

//获取会议室某天的预订时段信息
#define URL_MEETINGROOM_BOOKING_TIMES @"/meetingroom/{id}/bookingtimes?checkedDate="

//获取茶水费用
#define URL_ROOM_TEAFEE @"/meetingroom/booking/getteafee"

//提交会议室预订
#define URL_SAVE_ROOM_ORDER @"/meetingroom/booking/save"

//订单详情
#define URL_ROOM_ORDER_DETAIL @"/meetingroom/booking/{id}/detail"

//获取会议室订单评价
#define URL_ROOM_EVALUATE @"/teacake/order/{orderid}/meetingroom/evaluate"

//获取微信预支付信息
#define URL_ROOM_ORDER_WECHAT_PACKAGES @"/meetingroom/booking/wechat/packages"

/***************** 活动模块 ***********************/

//活动列表
#define ACTIVITY_LIST @"/activity/list"

//活动详情
#define ACTIVITY_DETAIL @"/activity/{id}/detail"

//加入活动
#define ACTIVITY_JOIN @"/activity/join"

//退出活动
#define ACTIVITY_QUIT @"/activity/quit"

/***************** 网点模块 ***********************/

//网点详情
#define SPACE_DETAIL @"/space/{id}"

//新增预约参观
#define SPACE_VISIT_SAVE @"/visit/save"

//预约参观详情
#define VISIT_DETAIL @"/visit/{id}"

//取消预约参观
#define VISIT_CANCEL @"/visit/cancel"

//我的预约参观列表
#define VISIT_LIST @"/visit/list"

//获取预约评价
#define VISIT_EVALUATE_GET @"/teacake/order/{orderid}/visit/evaluate"

/***************** 二维码扫描 ***********************/

//将二维码ID带到服务端，服务端返回该二维码对应的信息
#define QRCORE_SCAN @"/qrcode/{id}/scan"

//工位订单-确认到位
#define CONFIRM_WORKSPACE_ORDER @"/workspace/order/confirm"

#endif /* ApiConstant_h */
/***************** 工位预订模块 ***********************/

//工位列表
#define URL_WORKPLACE_LIST @"/workspace/list"

//工位详情
#define URL_WORKPLACE_SUPPORT_LIST @"/workspace/{id}/support/list"

//工位座位状态
#define URL_WORKPLACE_SEATSTATUS @"/workspace/seat/status?usingDate={date}&wid={workplaceid}"

//提交工位订单
#define URL_WORKPLACE_ORDER_SAVE @"/workspace/order/save"

//订单详情
#define URL_WORKPLACE_ORDER_DETAIL @"/workspace/order/{id}/detail"
//订单列表
#define URL_WORKPLACEORDER_LIST @"/workspace/order/list"

//取消订单
#define URL_WORKPLACECANCEL @"/workspace/order/cancel"

//获取工位订单评价
#define URL_WORKPLACE_EVALUATE @"/teacake/order/{orderid}/workspace/evaluate"

/***************** 分享模块 ***********************/
//分享列表
#define URL_SHARE_LIST @"/poster/list"
//分享类别
#define URL_SHARETYPE_LIST @"/poster/tag/list"
//分享保存
#define URL_SHAREISSUE @"/poster/save"
//帖子详情
#define URL_POSTER_DETAIL @"/poster/{Id}/detail"
//帖子点赞
#define URL_POSTER_LIKE @"/poster/like"
//帖子收藏
#define URL_POSTER_COLLECT @"/poster/collect"
//帖子评论删除
#define URL_POSTER_REVIEW_DELETE @"/poster/review/delete"
//帖子列表
#define URL_POSTER_LIST @"/poster/{pid}/review/list"
//帖子删除
#define URL_POSTER_DELETE @"/poster/delete"

/***************** 需求模块 ***********************/
//需求列表
#define URL_DEMAND_LIST @"/demand/list"
//需求类别
#define URL_DEMANDTYPE_LIST @"/demand/tag/list"
//需求保存
#define URL_DEMANDISSUE @"/demand/save"
//需求详情
#define URL_DEMAND_DETAIL @"/demand/{id}/detail"
//需求点赞
#define URL_DEMAND_LIKE @"/demand/like"
//需求收藏
#define URL_DEMAND_COLLECT @"/demand/collect"
//需求评论删除
#define URL_DEMAND_REVIEW_DELETE @"/demand/review/delete"
//需求评论列表
#define URL_DEMAND_REVIEW_LIST @"/demand/{id}/review/list"
//需求评论发表
#define URL_DEMAND_REVIEW_SAVE @"/demand/review/save"
//需求删除
#define URL_DEMAND_DELETE @"/demand/delete"
//需求 新增浏览量
#define URL_DEMAND_VISIT @"/demand/visit"

/***************** 企业模块 ***********************/
#define URL_ENTERPRISE_LIST @"/enterprise/list"
#define URL_ENTERPRISE_DETAILS @"/enterprise/{id}"

/***************** 企业模块 ***********************/
#define URL_ENTERPRISE_LIST @"/enterprise/list"
#define URL_ENTERPRISE_DETAILS @"/enterprise/{id}"

/***************** 独立会员 ***********************/
//获取会员套餐列表
#define URL_MEMBERMEAL_LIST @"/memberMeal/list"
//保存套餐订单
#define URL_MEMBERMEALORDER_SAVE @"/memberMeal/order/save"
//获取微信订单参数信息
#define URL_MEMBERMEALORDER_WECHATPACKAGES @"/memberMeal/order/wechat/packages"
//查询用户是否在套餐有效期内 (已废弃)
#define URL_MEMBER_ME_VALID @"/member/me/valid"
//校验套餐订单是否已支付
#define URL_MEMBERMEAL_ORDER_ISPAY @"/memberMeal/order/ispay?bid={bid}"
//返回用户企业的网点
#define URL_MEMBER_ME_SPACE @"/member/me/space"

/***************** 邀请员工***********************/
#define URL_ENTERPRISE_INVITESAVE @"/enterprise/invitesave"
//获取会员入驻企业下的所有会员
#define URL_MEMBER_MYENTERPRISE_MEMBERLIST @"/member/myenterprise/memberlist"

/***************** 工单服务 ***********************/
#define URL_WORKORDER_SAVE @"/workorder/save"

/***************** 办公管理 ***********************/
#define URL_MEMBER_ADMIN_LIST @"/member/me/space/admin"

//服务列表
#define URL_MEMBER_ME_SERVICELIST @"/member/me/servicelist"

/***************** 投诉服务 ***********************/
#define URL_COMPLAINTS_PEOPLE_LIST @"/service/admin/list"
#define URL_COMPLAINTS_SUBMIT @"/complaint/save"
#define URL_COMPLAINTS_PEOPLE_SEARCH @"/service/admin/search?keyword="
