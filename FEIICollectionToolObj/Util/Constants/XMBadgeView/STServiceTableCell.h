//
//  STServiceTableCell.h
//  dploffice
//
//  Created by shine-team1 on 16/12/1.
//  Copyright © 2016年 com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface STServiceTableCell : UITableViewCell

@property (nonatomic,copy) void (^serviceBtnBlock)(NSString *type);

-(void)setServiceList:(NSArray *)serviceList;

@end
