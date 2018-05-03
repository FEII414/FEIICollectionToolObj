//
//  FEIISegementView.m
//  FEIICollectionToolObj
//
//  Created by fei li on 2018/5/3.
//  Copyright © 2018年 feii. All rights reserved.
//

#import "FEIISegementView.h"

@implementation FEIISegementView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
 
 self.navigationItem.titleView = self.topNavigationView;
 
 -(UIView *)topNavigationView{
 
 if (_topNavigationView == nil) {
 _topNavigationView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 100, 44)];
 _topNavigationView.backgroundColor = [UIColor clearColor];
 
 _buttonDemand = [UIButton buttonWithType:UIButtonTypeCustom];
 [_buttonDemand setTitle:@"需求" forState:UIControlStateNormal];
 [_buttonDemand setTitleColor:[UIColor colorWithHex:0x999999] forState:UIControlStateNormal];
 [_buttonDemand addTarget:self action:@selector(clickedDemand) forControlEvents:UIControlEventTouchUpInside];
 _buttonDemand.titleLabel.font = [UIFont systemFontOfSize:16];
 
 _buttonShare = [UIButton buttonWithType:UIButtonTypeCustom];
 [_buttonShare setTitle:@"分享" forState:UIControlStateNormal];
 [_buttonShare setTitleColor:[UIColor colorWithHex:0x000000] forState:UIControlStateNormal];
 [_buttonShare addTarget:self action:@selector(clickedShare) forControlEvents:UIControlEventTouchUpInside];
 _buttonShare.titleLabel.font = [UIFont systemFontOfSize:16];
 
 _viewLine = [[UIView alloc]initWithFrame:CGRectMake(2, 43, 33, 1)];
 _viewLine.backgroundColor = [UIColor colorWithHex:MAIN_CONLOR_HEX];
 
 [_topNavigationView addSubview:_buttonShare];
 [_topNavigationView addSubview:_buttonDemand];
 [_topNavigationView addSubview:_viewLine];
 
 [_buttonShare mas_makeConstraints:^(MASConstraintMaker *make) {
 make.top.mas_equalTo(12);
 make.left.mas_equalTo(2);
 make.size.mas_equalTo(CGSizeMake(33, 18));
 }];
 [_buttonDemand mas_makeConstraints:^(MASConstraintMaker *make) {
 make.top.mas_equalTo(12);
 make.right.mas_equalTo(-2);
 make.size.mas_equalTo(CGSizeMake(33, 18));
 }];
 }
 return _topNavigationView;
 }
 
 -(void)clickedShare{
 
 [self setLineHeaderViewAnimationX:_buttonShare.frame.origin.x andWidth:_buttonShare.frame.size.width];
 [_buttonShare setTitleColor:[UIColor colorWithHex:0x000000] forState:UIControlStateNormal];
 [_buttonDemand setTitleColor:[UIColor colorWithHex:0x999999] forState:UIControlStateNormal];
 self.shareVc.view.hidden = NO;
 self.demandVc.view.hidden = YES;
 
 }
 
 -(void)clickedDemand{
 
 [self setLineHeaderViewAnimationX:_buttonDemand.frame.origin.x andWidth:_buttonDemand.frame.size.width];
 [_buttonShare setTitleColor:[UIColor colorWithHex:0x999999] forState:UIControlStateNormal];
 [_buttonDemand setTitleColor:[UIColor colorWithHex:0x000000] forState:UIControlStateNormal];
 if (!_isDemand) {
 
 [self.view addSubview:self.demandVc.view];
 _isDemand = YES;
 }
 self.shareVc.view.hidden = YES;
 self.demandVc.view.hidden = NO;
 
 }
 
 -(void)setLineHeaderViewAnimationX:(float)x andWidth:(float)width{
 
 [UIView beginAnimations:nil context:nil];
 [UIView setAnimationDuration:0.5];
 [UIView setAnimationDelegate:self];
 _viewLine.frame = CGRectMake(x, 43, width, 1);
 [UIView commitAnimations];
 
 }
 
*/

@end
