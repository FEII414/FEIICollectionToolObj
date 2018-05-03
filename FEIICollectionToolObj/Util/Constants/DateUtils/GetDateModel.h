//
//  GetDateModel.h
//  officecamp
//
//  Created by shine-team1 on 16/4/17.
//  Copyright © 2016年 st. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GetDateModel : NSObject

- (void) clearDate;

-(void)saveDateToSandBoxStr:(NSString *)str;

- (NSString *)backDateStr;

@end
