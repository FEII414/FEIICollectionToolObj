//
//  STDateSelectionView.h
//  dploffice
//
//  Created by shine-team1 on 16/12/21.
//  Copyright © 2016年 com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface STDateSelectionView : UIView

-(instancetype)initWithFrame:(CGRect)frame;

@property (nonatomic, copy)  void   (^dateSelectionBlock)(NSString *date);  //选择的日期

@end
