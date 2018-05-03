//
//  GetSystemDate.h
//  officecamp
//
//  Created by shine-team1 on 16/4/5.
//  Copyright © 2016年 st. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GetSystemDate : NSObject

@property (nonatomic, copy)NSString *currentDate;
@property (nonatomic, strong)NSDateComponents *addComps;

/**
 单例

 @return <#return value description#>
 */
+(instancetype)shareSystemtool;

/**
 *  获取当前星期
 */
- (NSString *)getWeek;

/**
 *  返回当前的年-月-日
 */
- (NSString *)getDate;

/**
 *  返回当前的年/月/日
 */
+ (NSString *)getDateSlash;

/**
 *  获取当前时间 HH:mm
 */
- (NSString *)getTimerFunc;
/**
 *  获取秒 ss
 */
- (NSString *)getTimerSS;

/**
 *  日期加一
 */
- (NSString *)getDateAdd;
- (NSString *)getWeekAdd;

/**
 *  日期减一
 */
- (NSString *)getDateReduce;

/**
 *  传入日期算出星期
 */
- (NSString *)getWeekSetNSString:(NSString *)string;

- (NSString *)checkGetDate;

// 获取当前年份
- (NSInteger) getYear;
- (NSInteger) getYear:(NSDate *)date;

// 获取当前月份
- (NSInteger) getMonth;
- (NSInteger) getMonth:(NSDate *)date;

// 根据年、月获取此月的最大天数
- (NSInteger) getMaxDayNum:(NSInteger) year month:(NSInteger)month;


/**
 计算某个日期n个月之后的日期

 @param currentDate   当前日期
 @param gapMonthCount n个月后的日期

 @return 
 */
- (NSDate *)dateAfterMonths:(NSDate *)currentDate gapMonth:(NSInteger)gapMonthCount;

/**
 *  判断是是过去还是未来
 *
 *  @param oneDay     要比较的天数
 *  @param anotherDay
 *
 *  @return 返回一个判断码
 */
+(int)compareOneDay:(NSDate *)oneDay withAnotherDay:(NSDate *)anotherDay;

/**
 *  传入字符串返回nsdate
 */
+(NSDate *)converDateFromString:(NSString *)string;

/**
 *  传入date返回年份string
 */
+(NSString *)stringFromDate:(NSDate *)date;

/**
 *  传入date返回月份string
 */
+(NSString *)monthStringFromDate:(NSDate *)date;

/**
 *  根据日期得到天数string
 */
+(NSString *)dayStringFromDate:(NSDate *)date;

/**
 *  返回格式 yyyy-MM-DD HH:mm
 */
- (NSString *)getDateHouse;

/**
 *  返回date mater格式 yyyy-MM-DD HH:mm
 */
+(NSDate *)converDateFromStringHouse:(NSString *)string;

/**
 *  返回date mater格式 HH:mm
 */
+(NSDate *)converDateFromStringHouseBrach:(NSString *)string;

/**
 *  比较date打下  格式 yyy-mm-dd HH:mm
 */
+(int)compareOneDayHours:(NSDate *)oneDay withAnotherDayHOuser:(NSDate *)anotherDay;

/**
 *  比较date打下  格式 HH:mm
 */
+(int)compareOneDayStar:(NSDate *)strDay withAnotherEnd:(NSDate *)endDay;

/**
 *  传入date，返回yyyy-mm格式字符串
 */
+(NSString *)stringYearMonthFromDate:(NSDate *)date;

/**
 *  传入date，返回YYYY-MM-DD 字符串
 */
+(NSString *)stringYearMonthDayFromDate:(NSDate *)date;

/**
 *  当前时间在加上一个小时
 */
- (NSString *)getTimerFuncAddHoush;

/**
 *   返回yyyy.mm.dd
 */
+(NSString *)stringMonthDate:(NSDate *)date;

/**
 *   传入famatter，比较大小
 */
+(int)compareOneDay:(NSDate *)oneDay withAnotherDay:(NSDate *)anotherDay WithFormatter:(NSString *)matter;

/**
 *  根据日期获取为周几
 */
+(NSString *)weekDayStringFromDate:(NSDate *)date;

/**
 *  服务器时间格式暂定为yyyy-MM-dd HH:mm
 *  将服务器传过来的字符串时间转换为显示在界面的时间
 *  同年、同月、同日只显示时间
 *  同年、同月、不同日则显示日期和时间
 *  同年、不同月则显示月份、日期和时间
 *  剩余则显示完全
 */
+(NSString *)showTimeFromServerDate:(NSString *)serverDateStr compareDateStr:(NSString *)otherDateStr;

/**
 *   传入date，和自定义formatter格式
 */
+(NSString *)stringYearMonthDate:(NSDate *)date withFormatter:(NSString *)matter;


/**
 获取明天的日期
 */
+ (NSString *)getDateSlashTomorrow;


/**
 自定义foramt

 @param date   传入date
 @param format 需要展现的mat

 @return
 */
+(NSString *)stringYearMonthDayFromDate:(NSDate *)date forMat:(NSString *)format;

/**
 自定义foramt
 
 @param date   传入date
 @param format 需要返回的中文年月日或时间
 
 @return
 */
+ (NSString*)getDateOrTime:(NSString*)dateStr;

/**
 返回 X年X月X日 XX时：XX分

 @param dateStr 传入（xx-xx-xx xx:xx）

 @return X年X月X日 XX时：XX分
 */
+ (NSString*)getDateAndTime:(NSString*)dateStr;

@end
