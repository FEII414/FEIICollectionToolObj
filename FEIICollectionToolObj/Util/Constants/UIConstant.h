//
//  UIConstant.h
//  deLiPei
//
//  Created by shine-team1 on 15/12/8.
//  Copyright © 2015年 dlp. All rights reserved.
//










#warning 所有的请求接口已经迁移到 ApiConstant.h文件中。









//主颜色
#define MAIN_CONLOR_HEX 0Xffd500

//16进制颜色
#define UIColorHex(_hex_) [UIColor colorWithHexString:((__bridge NSString *)CFSTR(#_hex_))]

// Main Screen
#define SCREEN_HEIGHT [[UIScreen mainScreen]bounds].size.height
#define SCREEN_WIDTH [[UIScreen mainScreen]bounds].size.width

//NSUserDefault
#define DEFAULTS [NSUserDefaults standardUserDefaults]



//导航栏固定高度
#define navHeight 64
//评论款的高度
#define textViewHeight 50
//tabbar的高度
#define tabbarHeight 44

//判断当前设备
#define IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)  
#define SCREEN_MAX_LENGTH (MAX(SCREEN_WIDTH, SCREEN_HEIGHT))
#define SCREEN_MIN_LENGTH (MIN(SCREEN_WIDTH, SCREEN_HEIGHT))
#define IS_IPHONE_5 (IS_IPHONE && SCREEN_MAX_LENGTH == 568.0)
#define IS_IPHONE_6 (IS_IPHONE && SCREEN_MAX_LENGTH == 667.0)
#define IS_IPHONE_6P (IS_IPHONE && SCREEN_MAX_LENGTH == 736.0)

//微信持久化数据
#define WXDPL_APP_ID @"wxb657971c86a42799"
#define WXDPL_APP_Secret @"440ae289397c3dd36c8719cac044ab87"
#define WX_OPEN_ID @"openid"
#define WX_ACCESS_TOKEN @"access_token"
#define WX_REFRESH_TOKEN @"refresh_token"
#define WX_UNION_ID @"unionid"
#define WX_CTIY @"city"
#define WX_COUNTRY @"country"
#define WX_HEADIMAGE_URL @"headimgurl"
#define WX_PROVINCE @"province"
#define WX_NICKNAME @"nickname"
#define WX_LANGUAGE @"language"
#define WX_SEX @"sex"

//服务器持久化数据
#define DPL_ID @"id"
#define DPL_RONGTOKEN @"rongToken"
#define DPL_TOKEN @"token"
#define DPL_USERTYPE @"userType"
#define READ_COUNT @"readCount"
#define DPL_DISCOUNT @"disCount"

//push标识
#define DPL_PRESHVC @"preshVc"

//手机注册标识
#define DPL_PHONE @"phone"
#define DPL_PASSWORD @"password"
#define DPL_VEFICATIONCODE @"vefication"

//RCB Color
#define CQColor(r,g,b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
#define CQolorAlpha(r,g,b,alp) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(alp)]
#define RGBA(r,g,b,a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]
#define RGB(r,g,b) RGBA(r,g,b,1.0f)

#define COMMODITYCOLOR RGB(194, 194, 194) //商品字体颜色
#define TABLEVIEWCOLOR CQColor(229, 229, 229) //table背景颜色
//Button Color
#define BUTTON_COLOR_HEX 0x000000
//标题字体
#define TITTLE_FONT [UIFont boldSystemFontOfSize: 16]
//title Color hex
#define TITTLE_COLOR 0x333333

#define NETWORK_ERROR_MESSAGE @"当前网络不可用，请检查网络连接"

//消息的界面的高度

//通知标识
#define POSTER_COMMENT_TYPE @"poster"
#define INFO_COMMENT_TYPE @"info"
#define IMAGE_OVER @"over"
#define DEFAULT_CONTROLLER @"wechatSusse"

//微信支付成功/失败的通知
#define WECHAT_PAY_SUCCESS @"wechatPaySuccess"
#define WECHAT_PAY_FAILURE @"wechatPayFailure"

#define PUSH_fansClick @"fansClick"

//全局CELL标识
#define EDIT_FIELD_CELL_INDENTIFIER @"editFieldCellIndentifier"
#define FEED_BACK_EMAIL_ACCOUT @"rivers_liu@shine-team.com"

//找工作发简历ID
#define WORK_ID @"10000"
#define DIS_VC @"DISMISS"

#define TRIBE_POSTER_LIST @"tribePosterList"
#define TRIBE_DELETE_NOTIFATION @"tribeDelete"
#define ME_RESOURCE_LIST @"meResourceList"
#define ME_TRIBE_QUIT_JOIN_NOTIFATION @"tribeQuitJoin"

//小图后缀
#define SMALL_IMG_SUFFIX @"_small"

//跳转到支付页面
#define DIMISS_PAYCONTROLLER @"dimiss_paycontrller"

//二维码内容前缀
#define QRCODE_CONTENT_PREFIX @"com.dploffice.communt"

//办公室二维码类型
#define OFFICE_QRCODE_TYPE @"office"

//工位二维码类型
#define WORKSPACE_QRCODE_TYPE @"workspace"

//无效的二维码--状态码
#define INVALID_QRCODEIMAGE 920001

//二维码已过期--状态码
#define QRCODEIMAGE_EXPIRED 920002

//消息新的通知
#define DEFAULT_MESSAGE_NEW @"DEFAULT_MESSAGE_NEW"
