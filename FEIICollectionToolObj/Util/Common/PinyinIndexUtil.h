//
//  PinyinIndexUtil.h
//  dploffice
//
//  Created by Alex Wu on 16/3/21.
//  Copyright © 2016年 com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PinyinIndexUtil : NSObject

+(NSMutableArray*) indexToChineseArrayFor:(NSArray*)oriArray;

+(NSMutableArray*)indexArray:(NSArray*)oriArr;

@end
