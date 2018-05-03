//
//  PriceTypeTableViewCell.m
//  zrrkf
//
//  Created by shine-team1 on 16/7/5.
//  Copyright © 2016年 dpl. All rights reserved.
//

#import "PriceTypeTableViewCell.h"
#import "PriceTypeView.h"
#import "OrderDatels.h"
#import "TeackeOrderDatelsModel.h"
#import "GetSystemDate.h"

@interface PriceTypeTableViewCell()

@property (nonatomic, strong)PriceTypeView *typeView;

@end

@implementation PriceTypeTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setPriceTypeView];
    }
    return self;
}

- (void)setPriceTypeView
{
    _typeView = [[PriceTypeView alloc]init];
    _typeView.backgroundColor = TABLEVIEWCOLOR;
    [self.contentView addSubview:_typeView];
    [_typeView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(-0);
        make.height.mas_equalTo(_typeView.frame.size.height);
        
    }];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    
}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated
{
    
}

-(void)setDatelmodel:(TeackeOrderDatelsModel *)datelmodel
{
    _datelmodel = datelmodel;
    _typeView.priceTypeLabel.text = [self payType:datelmodel.teacakeOrder.payType];
    _typeView.orderPrice.text = [NSString stringWithFormat:@"订单金额：%.2f元",datelmodel.teacakeOrder.amount];
//    _typeView.orderDate.text = [NSString stringWithFormat:@"下单时间：%@",datelmodel.teacakeOrder.createDateStr];
    if (datelmodel.teacakeOrder.createDateStr && ![datelmodel.teacakeOrder.createDateStr isEqualToString:@""]) {
        _typeView.orderDate.text = [NSString stringWithFormat:@"下单时间：%@",[GetSystemDate getDateOrTime:datelmodel.teacakeOrder.createDateStr]];
    }
}

- (NSString *)payType:(NSString *)type
{
    if ([type isEqualToString:@"weixin"])
    {
        return @"微信支付";
    }else
    {
        return @"微信支付";
    }
}

@end
