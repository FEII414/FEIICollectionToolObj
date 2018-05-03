//
//  STServiceTableCell.m
//  dploffice
//
//  Created by shine-team1 on 16/12/1.
//  Copyright © 2016年 com. All rights reserved.
//

#import "STServiceTableCell.h"

#pragma mark /************************* 自定义button ***************************/

@interface STServiceBtn : UIButton

@property (nonatomic, weak) UILabel *nameLabel;
@property (nonatomic, weak) UIImageView *icon;
@property (nonatomic, weak) UIImageView *backgroup;


@end

@implementation STServiceBtn

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self setServiBtn];
    }
    return self;
}

- (void)setServiBtn
{
    CGFloat left;
    if (IS_IPHONE_6P) {
        left = 14;
    }else
    {
        left = 7;
    }
    
    UIImageView *backgroup  = [[UIImageView alloc]init];
    backgroup.contentMode = UIViewContentModeScaleAspectFill;
    backgroup.clipsToBounds = YES;
    [self addSubview:backgroup];
    self.backgroup = backgroup;
    [backgroup mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
        
    }];
    
    UIImageView *icon = [[UIImageView alloc]init];
    [self addSubview:icon];
    self.icon = icon;
    [icon mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.bottom.mas_equalTo(-13);
        make.left.mas_equalTo(left);
        make.size.mas_equalTo(CGSizeMake(17, 17));
        
    }];
    
    UILabel *name = [[UILabel alloc]init];
    name.textColor = [UIColor colorWithHex:MAIN_CONLOR_HEX];
    name.font = [UIFont systemFontOfSize:14];
    name.textAlignment = NSTextAlignmentCenter;
    [self addSubview:name];
    self.nameLabel = name;
    [name mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.bottom.mas_equalTo(-13);
        make.left.mas_equalTo(icon.mas_right);
        make.right.mas_equalTo(-left);
        make.height.mas_equalTo(15);
        
    }];
    
}

@end

@interface STServiceTableCell()

@property (nonatomic, strong)NSArray *sectionDatas;


@end

@implementation STServiceTableCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        
        
    }
    return self;
}


-(void)setServiceList:(NSArray *)serviceList
{
    _sectionDatas = serviceList;
    CGFloat pading = 12;
    CGFloat witdh = (SCREEN_WIDTH - (4 * pading)) / 3;
    for (int i = 0; i < serviceList.count; i++) {
        
        CGFloat x = ((i * pading) + (i * witdh)) + pading;
        STServiceBtn *btn = [[STServiceBtn alloc]init];
        btn.backgroundColor = [UIColor redColor];
        btn.tag = i;
        [self setBtnAttribute:btn andType:serviceList[i]];
        [btn addTarget:self action:@selector(serviceClcik:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:btn];
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.mas_equalTo(20);
            make.left.mas_equalTo(x);
            make.width.mas_equalTo(witdh);
            make.bottom.mas_equalTo(0);
            
        }];
        
        
    }
}

- (void)setBtnAttribute:(STServiceBtn *)btn andType:(NSString *)type
{
    if ([type isEqualToString:@"ENTERPRISE_SPACEADMIN_SERVICE"]) {
        btn.nameLabel.text = @"办公管家";
        btn.icon.image = [UIImage imageNamed:@"office_keeper"];
        btn.backgroup.image = [UIImage imageNamed:@"office_backgroup"];
    }
    
    if ([type isEqualToString:@"ENTERPRISE_WORKORDER_SERVICE"]) {
        btn.nameLabel.text = @"工单服务";
        btn.icon.image = [UIImage imageNamed:@"werkplace_icon"];
        btn.backgroup.image = [UIImage imageNamed:@"worick_backgroup"];
    }
    
    if ([type isEqualToString:@"ENTERPRISE_INVITEMEMBER_SERVICE"]) {
        btn.nameLabel.text = @"员工邀请";
        btn.icon.image = [UIImage imageNamed:@"employees_icon"];
        btn.backgroup.image = [UIImage imageNamed:@"emplace_backgroup"];
    }
    
}

- (void)serviceClcik:(UIButton *)btn
{
    NSLog(@"%ld",(long)btn.tag);
    if (self.serviceBtnBlock) {
        self.serviceBtnBlock(_sectionDatas[btn.tag]);
    }
}

@end
