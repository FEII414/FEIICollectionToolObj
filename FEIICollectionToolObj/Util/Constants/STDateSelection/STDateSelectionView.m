//
//  STDateSelectionView.m
//  dploffice
//
//  Created by shine-team1 on 16/12/21.
//  Copyright © 2016年 com. All rights reserved.
//

#import "STDateSelectionView.h"
#import "GetSystemDate.h"
#import "STDatePicker.h"

typedef enum{
    
    STdateselectionToday,
    STdateselectionTomorrw,
    STdateselectionDate,
    
}STdateselection;


@interface STDateSelectionView()

@property (nonatomic, weak)UIButton *buttonToday;       ///今天
@property (nonatomic, weak)UIButton *buttonTomorrow;    ///明天
@property (nonatomic, weak)UIButton *buttonDate;        ///选择日期
@property (nonatomic, weak)UIView *bottomLine;          ///线条
@property (nonatomic, copy)NSString *todayDate;         ///今天
@property (nonatomic, copy)NSString *tomorrwDate;       ///明天
@property (nonatomic, copy)NSString *clickDate;       ///选择日期
@property (nonatomic, strong)STDatePicker *datePicker;  ///选择时间控件

@end

@implementation STDateSelectionView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.todayDate = [GetSystemDate getDateSlash];
        self.tomorrwDate = [GetSystemDate getDateSlashTomorrow];
        self.clickDate = self.todayDate;
        [self setButton];
        [self setLayout];
    }
    return self;
}

- (void)setButton
{
    UIButton *buttonToday = [UIButton buttonWithType:UIButtonTypeCustom];
    [buttonToday setTitle:@"今天" forState:UIControlStateNormal];
    buttonToday.titleLabel.font = [UIFont systemFontOfSize:15];
    [buttonToday setTitleColor:[UIColor colorWithHex:MAIN_CONLOR_HEX] forState:UIControlStateNormal];
    [buttonToday addTarget:self action:@selector(clickedButtonDate:) forControlEvents:UIControlEventTouchUpInside];
    buttonToday.tag = STdateselectionToday;
    self.buttonToday = buttonToday;
    [self addSubview:buttonToday];
    
    UIButton *buttonTmorrow = [UIButton buttonWithType:UIButtonTypeCustom];
    [buttonTmorrow setTitle:@"明天" forState:UIControlStateNormal];
    buttonTmorrow.titleLabel.font = [UIFont systemFontOfSize:15];
    [buttonTmorrow setTitleColor:[UIColor colorWithHex:0x999999]  forState:UIControlStateNormal];
    buttonTmorrow.tag = STdateselectionTomorrw;
    [buttonTmorrow addTarget:self action:@selector(clickedButtonDate:) forControlEvents:UIControlEventTouchUpInside];
    self.buttonTomorrow = buttonTmorrow;
    [self addSubview:buttonTmorrow];
    
    UIButton *buttonDate = [UIButton buttonWithType:UIButtonTypeCustom];
    [buttonDate setTitle:@"选择日期" forState:UIControlStateNormal];
    buttonDate.titleLabel.font = [UIFont systemFontOfSize:15];
    [buttonDate setTitleColor:[UIColor colorWithHex:0x999999] forState:UIControlStateNormal];
    buttonDate.tag = STdateselectionDate;
    [buttonDate addTarget:self action:@selector(clickedButtonDate:) forControlEvents:UIControlEventTouchUpInside];
    self.buttonDate = buttonDate;
    [self addSubview:buttonDate];
    
    UIView *bottomLine = [[UIView alloc]init];
    bottomLine.backgroundColor = [UIColor colorWithHex: MAIN_CONLOR_HEX];
    [self addSubview:bottomLine];
    self.bottomLine = bottomLine;

}

- (void)setLayout
{
    [self.buttonTomorrow mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.centerX.mas_equalTo(self.mas_centerX);
        make.centerY.mas_equalTo(self.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(40, 44));
        
    }];
    
    [self.buttonToday mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.centerY.mas_equalTo(self.mas_centerY);
        make.left.mas_equalTo(30);
        make.size.mas_equalTo(CGSizeMake(40, 44));
        
    }];
    
    [self.buttonDate mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.centerY.mas_equalTo(self.mas_centerY);
        make.right.mas_equalTo(-30);
        make.size.mas_equalTo(CGSizeMake(80, 44));
        
    }];
    
    [self.bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.bottom.mas_equalTo(-0);
        make.width.mas_equalTo(self.buttonToday.mas_width);
        make.left.mas_equalTo(self.buttonToday.mas_left);
        make.height.mas_equalTo(2);
        
    }];
}

#pragma mark /************************* 点击事件 ***************************/

- (void)clickedButtonDate:(UIButton *)btn
{
    
    switch (btn.tag) {
        case STdateselectionToday:
        {
            [_datePicker dismiss];
            if (self.dateSelectionBlock) {
                self.dateSelectionBlock(self.todayDate);
            }
            self.clickDate = self.todayDate;
            [self selectdButton:self.buttonToday];
        }
            break;
            
        case STdateselectionTomorrw:
        {
            [_datePicker dismiss];
            if (self.dateSelectionBlock) {
                self.dateSelectionBlock(self.tomorrwDate);
            }
            self.clickDate = self.tomorrwDate;
            [self selectdButton:self.buttonTomorrow];
        }
            break;
            
        case STdateselectionDate:
        {
            [self showpickerBackView];
            [self selectdButton:self.buttonDate];
        }
            break;
            
        default:
            break;
    }
}

- (void)RemakeConstraintsWithView:(UIButton *)view
{

    [self.bottomLine mas_remakeConstraints:^(MASConstraintMaker *make) {
        
        make.bottom.mas_equalTo(-0);
        make.width.mas_equalTo(view.mas_width);
        make.left.mas_equalTo(view.mas_left);
        make.height.mas_equalTo(2);
        
    }];

}

#pragma mark /************************* 显示时间控件 ***************************/

- (void)showpickerBackView
{
    _datePicker = [STDatePicker datePicker];
    if (!_datePicker.isShow) {
        [_datePicker.dateP setDatePickerMode:UIDatePickerModeDate];
        _datePicker.dateP.minimumDate = [NSDate date];
        _datePicker.dateP.maximumDate = [[GetSystemDate shareSystemtool]dateAfterMonths:[NSDate date] gapMonth:3];
        _datePicker.isCover = NO; //不显示遮盖按钮
        [_datePicker show];
    }
    
    __weak typeof(self) weakSelf = self;
    _datePicker.datePickerBtnBlock = ^(NSString *date){
        
        ///取消
        if ([date isEqualToString:@"cancel"]) {
            if ([weakSelf.clickDate isEqualToString:weakSelf.tomorrwDate]) {
                 [weakSelf selectdButton:weakSelf.buttonTomorrow];
            }
            if ([weakSelf.clickDate isEqualToString:weakSelf.todayDate]) {
                 [weakSelf selectdButton:weakSelf.buttonToday];
            }
        }else
        {
            ///确定
            if ([date isEqualToString:weakSelf.todayDate] ) {
                [weakSelf selectdButton:weakSelf.buttonToday];
            }
            
            if ([date isEqualToString:weakSelf.tomorrwDate]) {
                [weakSelf selectdButton:weakSelf.buttonTomorrow];
            }
            
            if (![date isEqualToString:weakSelf.todayDate] && ![date isEqualToString:weakSelf.tomorrwDate]) {
                
                NSDate *formatDate = [GetSystemDate converDateFromString:date];
                NSString *fmtDate = [GetSystemDate stringYearMonthDayFromDate:formatDate forMat:@"M月d日"];
                [weakSelf.buttonDate setTitle:fmtDate forState:UIControlStateNormal];
                weakSelf.clickDate = date;
                
            }
            
            ///回调出去
            if (weakSelf.dateSelectionBlock) {
                weakSelf.dateSelectionBlock(date);
            }
        }
        
    };
}

#pragma mark /************************* 选中状态 ***************************/
- (void)selectdButton:(UIButton *)btn
{
    if ([btn isEqual:self.buttonToday]) {
        [self.buttonToday setTitleColor:[UIColor colorWithHex:MAIN_CONLOR_HEX] forState:UIControlStateNormal];
        [self.buttonTomorrow setTitleColor:[UIColor colorWithHex:0x999999] forState:UIControlStateNormal];
        [self.buttonDate setTitleColor:[UIColor colorWithHex:0x999999] forState:UIControlStateNormal];
        [self RemakeConstraintsWithView:self.buttonToday];
        [self.buttonDate setTitle:@"选择日期" forState:UIControlStateNormal];
    }
    
    if ([btn isEqual:self.buttonTomorrow]) {
        [self.buttonToday setTitleColor:[UIColor colorWithHex:0x999999] forState:UIControlStateNormal];
        [self.buttonTomorrow setTitleColor:[UIColor colorWithHex:MAIN_CONLOR_HEX] forState:UIControlStateNormal];
        [self.buttonDate setTitleColor:[UIColor colorWithHex:0x999999] forState:UIControlStateNormal];
        [self RemakeConstraintsWithView:self.buttonTomorrow];
        [self.buttonDate setTitle:@"选择日期" forState:UIControlStateNormal];
    }
    
    if ([btn isEqual:self.buttonDate]) {
        [self.buttonToday setTitleColor:[UIColor colorWithHex:0x999999] forState:UIControlStateNormal];
        [self.buttonTomorrow setTitleColor:[UIColor colorWithHex:0x999999] forState:UIControlStateNormal];
        [self.buttonDate setTitleColor:[UIColor colorWithHex:MAIN_CONLOR_HEX] forState:UIControlStateNormal];
        [self RemakeConstraintsWithView:self.buttonDate];
    }
}


@end
