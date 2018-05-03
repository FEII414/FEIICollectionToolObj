//
//  PinyinIndexUtil.m
//  dploffice
//
//  Created by Alex Wu on 16/3/21.
//  Copyright © 2016年 com. All rights reserved.
//

#import "PinyinIndexUtil.h"
#import "ChineseString.h"

@implementation PinyinIndexUtil


+(NSMutableArray*) indexToChineseArrayFor:(NSArray*)oriArray {
    
    NSMutableArray *tempArray = [self sortChineseArrar:oriArray];
    NSMutableArray *result=[NSMutableArray array];
    NSMutableArray *item = [NSMutableArray array];
    
    NSString *tempString ;
    //拼音分组
    for (NSObject* object in tempArray) {
        
        
        NSString *pinyin = [((ChineseString*)object).pinYin substringToIndex:1];
        //不同
        if(![tempString isEqualToString:pinyin])
        {
            //分组
            item = [NSMutableArray array];
            [item  addObject:object];
            [result addObject:item];
            //遍历
            tempString = pinyin;
        }else//相同
        {
            [item  addObject:object];
        }
    }
    return result;
    
}



+(NSMutableArray*)indexArray:(NSArray*)oriArr{
    
    NSMutableArray *tempArray = [self sortChineseArrar:oriArr];
    NSMutableArray *result=[NSMutableArray array];
    NSString *tempString ;
    
    for (NSString* object in tempArray)
    {
        NSString *pinyin = [((ChineseString*)object).pinYin substringToIndex:1];
        //不同
        if(![tempString isEqualToString:pinyin])
        {
            // NSLog(@"IndexArray----->%@",pinyin);
            [result addObject:pinyin];
            tempString = pinyin;
        }
    }
    return result;
}





+(NSMutableArray*)sortChineseArrar:(NSArray*)oriArr
{
    //获取字符串中文字的拼音首字母并与字符串共同存放
    NSMutableArray *chineseStringsArray=[NSMutableArray array];
    for(int i=0;i<[oriArr count];i++)
    {
        
        ChineseString *chineseString =(ChineseString *)[oriArr objectAtIndex:i];

        if(chineseString.string==nil){
            chineseString.string=@"";
        }
        //去除两端空格和回车
        chineseString.string  = [chineseString.string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        
        //此方法存在一些问题 有些字符过滤不了
        //NSCharacterSet *set = [NSCharacterSet characterSetWithCharactersInString:@"@／：；（）¥「」＂、[]{}#%-*+=_\\|~＜＞$€^•'@#$%^&*()_+'\""];
        //chineseString.string = [chineseString.string stringByTrimmingCharactersInSet:set];
        
        
        //这里我自己写了一个递归过滤指定字符串   RemoveSpecialCharacter
        chineseString.string =[PinyinIndexUtil removeSpecialCharacter:chineseString.string];
        // NSLog(@"string====%@",chineseString.string);
        
        
        //判断首字符是否为字母
        NSString *regex = @"[A-Za-z]+";
        NSPredicate*predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
        
        if ([predicate evaluateWithObject:chineseString.string])
        {
            //首字母大写
            chineseString.pinYin = [chineseString.string capitalizedString] ;
        }else{
            if(![chineseString.string isEqualToString:@""]){
                NSString *pinYinResult=[NSString string];
                for(int j=0;j<chineseString.string.length;j++){
                    NSString *singlePinyinLetter=[[NSString stringWithFormat:@"%c",pinyinFirstLetter([chineseString.string characterAtIndex:j])]uppercaseString];
                    
                    pinYinResult=[pinYinResult stringByAppendingString:singlePinyinLetter];
                }
                chineseString.pinYin=pinYinResult;
            }else{
                chineseString.pinYin=@"";
            }
        }
        [chineseStringsArray addObject:chineseString];
    }
    //按照拼音首字母对这些Strings进行排序
    NSArray *sortDescriptors = [NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"pinYin" ascending:YES]];
    [chineseStringsArray sortUsingDescriptors:sortDescriptors];
    
    return chineseStringsArray;
}

+(NSString*)removeSpecialCharacter: (NSString *)str {
    NSRange urgentRange = [str rangeOfCharacterFromSet: [NSCharacterSet characterSetWithCharactersInString: @",.？、 ~￥#&<>《》()[]{}【】^@/￡¤|§¨「」『』￠￢￣~@#&*（）——+|《》$_€"]];
    if (urgentRange.location != NSNotFound)
    {
        return [self removeSpecialCharacter:[str stringByReplacingCharactersInRange:urgentRange withString:@""]];
    }
    return str;
}



@end
