//
//  GetSystemDate.m
//  officecamp
//
//  Created by shine-team1 on 16/4/5.
//  Copyright © 2016年 st. All rights reserved.
//

#import "GetSystemDate.h"
#import "GetDateModel.h"

@interface GetSystemDate()

@property (nonatomic, strong)GetDateModel *model;
@property (nonatomic, strong)NSDateFormatter *dateFformatter;

@end

@implementation GetSystemDate

+(instancetype)shareSystemtool{
    
    static GetSystemDate *shareClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareClient = [[GetSystemDate alloc]init];
    });
    return shareClient;
    
}

- (NSDateComponents *)systemDate
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDate *dataNow;
    NSDateComponents *comps = [[NSDateComponents alloc]init];
    NSInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitWeekday;
    dataNow = [NSDate date];
    comps = [calendar components:unitFlags fromDate:dataNow];
    return comps;
    
}

- (NSString *)getWeek
{
    NSArray * arrWeek=[NSArray arrayWithObjects:@"星期日",@"星期一",@"星期二",@"星期三",@"星期四",@"星期五",@"星期六", nil];
    NSDateComponents *comps = [self systemDate];
    NSString *weekStr = [arrWeek objectAtIndex:[comps weekday] - 1];
    return weekStr;
}

- (NSString *)getDate
{
    NSDate *  senddate=[NSDate date];
    [self.dateFformatter setDateFormat:@"YYYY-MM-dd"];
    NSString *locationString=[self.dateFformatter stringFromDate:senddate];
    return locationString;
}

+ (NSString *)getDateSlash
{
    NSDate *  senddate=[NSDate date];
    NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
    [dateformatter setDateFormat:@"YYYY-MM-dd"];
    NSString *locationString=[dateformatter stringFromDate:senddate];
    return locationString;
}

+ (NSString *)getDateSlashTomorrow
{
    NSDate *  senddate=[NSDate date];
    NSDate *tomorrow = [[NSDate alloc]initWithTimeInterval:60*60*24 sinceDate:senddate];
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSString *strTomorrow = [formatter stringFromDate:tomorrow];
    return strTomorrow;
}

- (NSString *)getDateHouse
{
    NSDate *  senddate=[NSDate date];
    [self.dateFformatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSString *locationString=[self.dateFformatter stringFromDate:senddate];
    return locationString;
}

- (NSString *)checkGetDate
{
    NSDateComponents *comps = [self systemDate];
    NSInteger year = [comps year];
    NSInteger month = [comps month];
    NSString *dateStr = [NSString stringWithFormat:@"%ld年%ld月",year,month];
    return dateStr;
}

- (NSString *)getTimerFunc
{
    [self.dateFformatter setDateFormat:@"HH:mm"];
    NSString *timestamp = [self.dateFformatter stringFromDate:[NSDate date]];
    return timestamp;
}

- (NSString *)getTimerFuncAddHoush
{
    [self.dateFformatter setDateFormat:@"HH:mm"];
    NSDate *myDate = [self.dateFformatter dateFromString:[self getTimerFunc]];
    NSDate *newDate = [myDate dateByAddingTimeInterval:60*60];
    NSString *timestamp = [self.dateFformatter stringFromDate:newDate];
    return timestamp;
}

- (NSString *)getTimerSS
{
    [self.dateFformatter setDateFormat:@"ss"];
    NSString *timestamp = [self.dateFformatter stringFromDate:[NSDate date]];
    return timestamp;
}

- (NSString *)getDateAdd
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateFormatter *inputFormatter = [[NSDateFormatter alloc] init];
    [inputFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"]];
    [inputFormatter setDateFormat:@"yyyy-MM"];
    NSDate *inputDate = [inputFormatter dateFromString:[self.model backDateStr]];
    NSTimeInterval secondsPerDay = 3600 * 24 * 30;
    NSDate *nextDate = [NSDate dateWithTimeInterval:secondsPerDay sinceDate:inputDate];
    NSDateComponents *comps = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth | NSCalendarUnitMonth fromDate:nextDate];
    NSInteger year = [comps year];
    NSInteger month = [comps month];
    NSString *dateStr = [NSString stringWithFormat:@"%ld-%ld",year,month];
    self.addComps = comps;
    [self.model saveDateToSandBoxStr:dateStr];
    return dateStr;
    
}

- (NSString *)getDateReduce
{
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    [self.dateFformatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"]];
    [self.dateFformatter setDateFormat:@"yyyy-MM"];
    NSDate *inputDate = [self.dateFformatter dateFromString:[self.model backDateStr]];
    NSTimeInterval secondsPerDay = 3600 * 24 * 30;
    NSDate *nextDate = [NSDate dateWithTimeInterval:-secondsPerDay sinceDate:inputDate];
        NSDateComponents *comps = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth | NSCalendarUnitMonth fromDate:nextDate];
    NSInteger year = [comps year];
    NSInteger month = [comps month];
    NSString *dateStr = [NSString stringWithFormat:@"%ld-%ld",year,month];
    self.addComps = comps;
    [self.model saveDateToSandBoxStr:dateStr];
    return dateStr;
}

- (NSString *)getWeekAdd
{
    NSArray * arrWeek=[NSArray arrayWithObjects:@"星期日",@"星期一",@"星期二",@"星期三",@"星期四",@"星期五",@"星期六", nil];
    NSDateComponents *comps = [self addComps];
    NSString *weekStr = [arrWeek objectAtIndex:[comps weekday] - 1];
    return weekStr;
}

- (NSString *)getWeekSetNSString:(NSString *)string
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    [self.dateFformatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"]];
    [self.dateFformatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *inputDate = [self.dateFformatter dateFromString:string];
    NSDateComponents *comps = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitWeekday|NSCalendarUnitDay fromDate:inputDate];
    NSArray * arrWeek=[NSArray arrayWithObjects:@"星期日",@"星期一",@"星期二",@"星期三",@"星期四",@"星期五",@"星期六", nil];
    NSString *weekStr = [arrWeek objectAtIndex:[comps weekday] - 1];
    return weekStr;
}

- (NSDate *)dateAfterMonths:(NSDate *)currentDate gapMonth:(NSInteger)gapMonthCount {
    //获取当年的月份，当月的总天数
    NSCalendar *calendar = [NSCalendar calendarWithIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *components = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitHour|NSCalendarUnitMinute|NSCalendarUnitCalendar fromDate:currentDate];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateStyle:NSDateFormatterFullStyle];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    
    NSString *dateStr = @"";
    NSInteger endDay = 0;//天
    NSDate *newDate = [NSDate date];//新的年&月
    //判断是否是下一年
    if (components.month+gapMonthCount > 12) {
        //是下一年
        dateStr = [NSString stringWithFormat:@"%zd-%zd-01",components.year+(components.month+gapMonthCount)/12,(components.month+gapMonthCount)%12];
        newDate = [formatter dateFromString:dateStr];
        //新月份的天数
        NSInteger newDays = [calendar rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:newDate].length;
        if ([self isEndOfTheMonth:currentDate]) {//当前日期处于月末
            endDay = newDays;
        } else {
            endDay = newDays < components.day?newDays:components.day;
        }
        dateStr = [NSString stringWithFormat:@"%zd-%zd-%zd",components.year+(components.month+gapMonthCount)/12,(components.month+gapMonthCount)%12,endDay];
    } else {
        //依然是当前年份
        dateStr = [NSString stringWithFormat:@"%zd-%zd-01",components.year,components.month+gapMonthCount];
        newDate = [formatter dateFromString:dateStr];
        //新月份的天数
        NSInteger newDays = [calendar rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:newDate].length;
        if ([self isEndOfTheMonth:currentDate]) {//当前日期处于月末
            endDay = newDays;
        } else {
            endDay = newDays < components.day?newDays:components.day;
        }
        
        dateStr = [NSString stringWithFormat:@"%zd-%zd-%zd",components.year,components.month+gapMonthCount,endDay];
    }
    
    newDate = [formatter dateFromString:dateStr];
    return newDate;
}

//判断是否是月末
- (BOOL)isEndOfTheMonth:(NSDate *)date {
    NSCalendar *calendar = [NSCalendar calendarWithIdentifier:NSCalendarIdentifierGregorian];
    NSInteger daysInMonth = [calendar rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:date].length;
    NSDateComponents *componets = [calendar components:NSCalendarUnitDay fromDate:date];
    if (componets.day >= daysInMonth) {
        return YES;
    }
    return NO;
}

+(int)compareOneDay:(NSDate *)oneDay withAnotherDay:(NSDate *)anotherDay
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd-MM-yyyy"];
    NSString *oneDayStr = [dateFormatter stringFromDate:oneDay];
    NSString *anotherDayStr = [dateFormatter stringFromDate:anotherDay];
    NSDate *dateA = [dateFormatter dateFromString:oneDayStr];
    NSDate *dateB = [dateFormatter dateFromString:anotherDayStr];
    NSComparisonResult result = [dateA compare:dateB];
    NSLog(@"date1 : %@, date2 : %@", oneDay, anotherDay);
    if (result == NSOrderedDescending) {
        //NSLog(@"date1 是未来");
        return 1;
    }
    else if (result == NSOrderedAscending){
        //NSLog(@"Date1 是过去");
        return -1;
    }
    //NSLog(@"相同");
    return 0;
    
}
+(int)compareOneDay:(NSDate *)oneDay withAnotherDay:(NSDate *)anotherDay WithFormatter:(NSString *)matter
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:matter];
    NSString *oneDayStr = [dateFormatter stringFromDate:oneDay];
    NSString *anotherDayStr = [dateFormatter stringFromDate:anotherDay];
    NSDate *dateA = [dateFormatter dateFromString:oneDayStr];
    NSDate *dateB = [dateFormatter dateFromString:anotherDayStr];
    NSComparisonResult result = [dateA compare:dateB];
    NSLog(@"date1 : %@, date2 : %@", oneDay, anotherDay);
    if (result == NSOrderedDescending) {
        //NSLog(@"date1 是未来");
        return 1;
    }
    else if (result == NSOrderedAscending){
        //NSLog(@"Date1 是过去");
        return -1;
    }
    //NSLog(@"相同");
    return 0;
}

+(int)compareOneDayHours:(NSDate *)oneDay withAnotherDayHOuser:(NSDate *)anotherDay
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSString *oneDayStr = [dateFormatter stringFromDate:oneDay];
    NSString *anotherDayStr = [dateFormatter stringFromDate:anotherDay];
    NSDate *dateA = [dateFormatter dateFromString:oneDayStr];
    NSDate *dateB = [dateFormatter dateFromString:anotherDayStr];
    NSComparisonResult result = [dateA compare:dateB];
    NSLog(@"date1 : %@, date2 : %@", oneDay, anotherDay);
    if (result == NSOrderedDescending) {
        //NSLog(@"date1 是未来");
        return 1;
    }
    else if (result == NSOrderedAscending){
        //NSLog(@"Date1 是过去");
        return -1;
    }
    //NSLog(@"相同");
    return 0;
    
}

+(int)compareOneDayStar:(NSDate *)strDay withAnotherEnd:(NSDate *)endDay
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"HH:mm"];
    NSString *oneDayStr = [dateFormatter stringFromDate:strDay];
    NSString *anotherDayStr = [dateFormatter stringFromDate:endDay];
    NSDate *dateA = [dateFormatter dateFromString:oneDayStr];
    NSDate *dateB = [dateFormatter dateFromString:anotherDayStr];
    NSComparisonResult result = [dateA compare:dateB];
    if (result == NSOrderedDescending) {
        //NSLog(@"date1 是未来");
        return 1;
    }
    else if (result == NSOrderedAscending){
        //NSLog(@"Date1 是过去");
        return -1;
    }
    //NSLog(@"相同");
    return 0;
    
}

- (NSInteger) getYear
{
    NSDateComponents *comps = [self systemDate];
    NSInteger year = [comps year];
    return year;
}

- (NSInteger) getMonth
{
    NSDateComponents *comps = [self systemDate];
    NSInteger month = [comps month];
    
    return month;
}

- (NSInteger) getYear:(NSDate *)date
{
    NSDateComponents *comps = [self systemDate:date];
    NSInteger year = [comps year];
    return year;
}

- (NSInteger) getMonth:(NSDate *)date
{
    NSDateComponents *comps = [self systemDate:date];
    NSInteger year = [comps month];
    return year;
}

- (NSDateComponents *)systemDate:(NSDate *)dateNow
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *comps = [[NSDateComponents alloc]init];
    NSInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitWeekday;
    comps = [calendar components:unitFlags fromDate:dateNow];
    return comps;
    
}

- (NSInteger) getMaxDayNum:(NSInteger)year month:(NSInteger)month
{
    if((month == 1)||(month == 3)||(month == 5)||(month == 7)||(month == 8)||(month == 10)||(month == 12)) {
        return 31;
    }
    
    if((month == 4)||(month == 6)||(month == 9)||(month == 11)) {
        return 30;
    }
        
    if((year%4 == 1)||(year%4 == 2)||(year%4 == 3)) {
        return 28;
    }
    
    if(year%400 == 0) {
        return 29;
    }
    
    if(year%100 == 0) {
        return 28;
    }
    
    return 29;
    
}

+(NSDate *)converDateFromString:(NSString *)string
{
    NSDateFormatter *inputFormatter = [[NSDateFormatter alloc] init];
    [inputFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"]];
    [inputFormatter setDateFormat:@"yyyy-MM-dd"];
    NSDate* inputDate = [inputFormatter dateFromString:string];
    return inputDate;
}

+(NSDate *)converDateFromStringHouse:(NSString *)string
{
    NSDateFormatter *inputFormatter = [[NSDateFormatter alloc] init];
    [inputFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"]];
    [inputFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSDate* inputDate = [inputFormatter dateFromString:string];
    return inputDate;
}

+(NSDate *)converDateFromStringHouseBrach:(NSString *)string
{
    NSDateFormatter *inputFormatter = [[NSDateFormatter alloc] init];
    [inputFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"]];
    [inputFormatter setDateFormat:@"HH:mm"];
    NSDate* inputDate = [inputFormatter dateFromString:string];
    return inputDate;
}

+(NSString *)stringFromDate:(NSDate *)date
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy"];
    NSString *destDateString = [dateFormatter stringFromDate:date];
    return destDateString;
}

+(NSString *)monthStringFromDate:(NSDate *)date
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"MM"];
    NSString *destDateString = [dateFormatter stringFromDate:date];
    return destDateString;
}

+(NSString *)dayStringFromDate:(NSDate *)date {
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd"];
    NSString *destDateString = [dateFormatter stringFromDate:date];
    return destDateString;
}

+(NSString *)stringYearMonthFromDate:(NSDate *)date
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM"];
    NSString *destDateString = [dateFormatter stringFromDate:date];
    return destDateString;
}

+(NSString *)stringYearMonthDayFromDate:(NSDate *)date
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *destDateString = [dateFormatter stringFromDate:date];
    return destDateString;
}

+(NSString *)stringYearMonthDayFromDate:(NSDate *)date forMat:(NSString *)format
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:format];
    NSString *destDateString = [dateFormatter stringFromDate:date];
    return destDateString;
}


+(NSString *)stringMonthDate:(NSDate *)date
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy.MM.dd"];
    NSString *destDateString = [dateFormatter stringFromDate:date];
    return destDateString;
}

+(NSString *)stringYearMonthDate:(NSDate *)date withFormatter:(NSString *)matter
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:matter];
    NSString *destDateString = [dateFormatter stringFromDate:date];
    return destDateString;
}

+(NSString *)weekDayStringFromDate:(NSDate *)date {
    
    NSArray *weekdays = [NSArray arrayWithObjects: @"周日", @"周一", @"周二", @"周三", @"周四", @"周五", @"周六", nil];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *comps = [[NSDateComponents alloc]init];
    NSInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitWeekday;
    comps = [calendar components:unitFlags fromDate:date];
    return [weekdays objectAtIndex:(comps.weekday - 1)];
}

+(NSString *)showTimeFromServerDate:(NSString *)serverDateStr compareDateStr:(NSString *)otherDateStr {
    
    NSDateFormatter *format = [[NSDateFormatter alloc]init];
    [format setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSDate *serverDate = [format dateFromString:serverDateStr];
    NSDate *compareDate = [format dateFromString:otherDateStr];
    
    NSDateFormatter *yearFormat = [[NSDateFormatter alloc]init];
    [yearFormat setDateFormat:@"yyyy"];
    NSString *serverYear = [yearFormat stringFromDate:serverDate];
    NSString *compareYear = [yearFormat stringFromDate:compareDate];
    
    NSDateFormatter *monthFormat = [[NSDateFormatter alloc]init];
    [monthFormat setDateFormat:@"MM"];
    NSString *serverMonth = [monthFormat stringFromDate:serverDate];
    NSString *compareMonth = [monthFormat stringFromDate:compareDate];
    
    NSDateFormatter *dayFormat = [[NSDateFormatter alloc]init];
    [dayFormat setDateFormat:@"dd"];
    NSString *serverDay = [dayFormat stringFromDate:serverDate];
    NSString *compareDay = [dayFormat stringFromDate:compareDate];
    
    NSDateFormatter *timeFormat = [[NSDateFormatter alloc]init];
    [timeFormat setDateFormat:@"HH:mm"];
    NSString *serverTime = [timeFormat stringFromDate:serverDate];
    
    if ([compareYear isEqualToString:serverYear] && [compareMonth isEqualToString:serverMonth] && [compareDay isEqualToString:serverDay]) {
        
        if ([@"0" isEqualToString:[serverTime substringWithRange:NSMakeRange(0, 1)]]) {
            return [NSString stringWithFormat:@"上午%@", serverTime];
        } else {
            return [NSString stringWithFormat:@"下午%@", serverTime];
        }
        
    } else if ([compareYear isEqualToString:serverYear] && [compareMonth isEqualToString:serverMonth]) {
        [format setDateFormat:@"MM-dd HH:mm"];
        return [format stringFromDate:serverDate];
    } else {
        return serverDateStr;
    }
}

+ (NSString*)getDateOrTime:(NSString*)dateStr{
    
    NSString *returnStr;
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSDate *useDate = [formatter dateFromString:dateStr];
    NSLog(@"---useDate--%@",useDate);
    NSString *useYear = [GetSystemDate stringFromDate:useDate];
    NSString *useMonth = [GetSystemDate monthStringFromDate:useDate];
    NSString *useDay = [GetSystemDate dayStringFromDate:useDate];
    NSString *weekdays = [GetSystemDate weekDayStringFromDate:useDate];
    NSString *useHours = [GetSystemDate converDateFromStringHouseBrach:dateStr];
    
    NSDate *toDate = [NSDate date];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    if ([[formatter stringFromDate:toDate]isEqualToString:[formatter stringFromDate:useDate]]) {
        
        [formatter setDateFormat:@"HH:mm"];
        returnStr = [formatter stringFromDate:useDate];
        return returnStr;
        
    }
    NSString *toYear = [GetSystemDate stringFromDate:toDate];
    if ([useYear isEqualToString:toYear]) {
        
        returnStr = [NSString stringWithFormat:@"%@月%@日",useMonth,useDay];
        return returnStr;
        
    }
    
    returnStr = [NSString stringWithFormat:@"%@年%@月%@日",useYear,useMonth,useDay];
    return returnStr;
    
}

+ (NSString*)getDateAndTime:(NSString*)dateStr{
    
    NSString *returnStr;
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSDate *useDate = [formatter dateFromString:dateStr];
    NSLog(@"---useDate--%@",useDate);
    NSString *useYear = [GetSystemDate stringFromDate:useDate];
    NSString *useMonth = [GetSystemDate monthStringFromDate:useDate];
    NSString *useDay = [GetSystemDate dayStringFromDate:useDate];
//    NSString *weekdays = [GetSystemDate weekDayStringFromDate:useDate];
    NSString *useHours;
    
    NSDate *toDate = [NSDate date];
    [formatter setDateFormat:@"yyyy-MM-dd"];
//    if ([[formatter stringFromDate:toDate]isEqualToString:[formatter stringFromDate:useDate]]) {
    
        [formatter setDateFormat:@"HH:mm"];
        useHours = [formatter stringFromDate:useDate];
        
//    }
    NSString *toYear = [GetSystemDate stringFromDate:toDate];
    if ([useYear isEqualToString:toYear]) {
        
        returnStr = [NSString stringWithFormat:@"%@月%@日 %@",useMonth,useDay,useHours];
        return returnStr;
        
    }
    
    returnStr = [NSString stringWithFormat:@"%@年%@月%@日 %@",useYear,useMonth,useDay,useHours];
    return returnStr;
    
}

//时间戳转时间
+ (NSString *)timestampSwitchTime:(long)timestamp andFormatter:(NSString *)format{
    
    timestamp = timestamp/1000;
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    
    [formatter setDateFormat:format]; // （@"YYYY-MM-dd hh:mm:ss"）----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    
    NSTimeZone *timeZone = [NSTimeZone timeZoneWithName:@"Asia/Beijing"];
    
    [formatter setTimeZone:timeZone];
    
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:timestamp];
    
    NSString *confromTimespStr = [formatter stringFromDate:confromTimesp];
    
    return confromTimespStr;
    
}

#pragma mark /************************* 懒加载 ***************************/
-(NSDateFormatter *)dateFformatter
{
    if (!_dateFformatter) {
        _dateFformatter = [[NSDateFormatter alloc]init];
    }
    return _dateFformatter;
}


-(GetDateModel *)model
{
    if (!_model)
    {
        _model = [[GetDateModel alloc]init];
    }
    return _model;
}



@end
