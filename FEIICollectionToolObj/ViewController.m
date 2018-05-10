//
//  ViewController.m
//  FEIICollectionToolObj
//
//  Created by Lieniu03 on 2018/5/3.
//  Copyright © 2018年 feii. All rights reserved.
//

#import "ViewController.h"

#pragma mark - Class define variable
#define K_MAIN_VIEW_SCROLL_HEIGHT 80.0f
#define K_MAIN_VIEW_SCROLL_TEXT_TAG 300
#define K_MAIN_VIEW_TEME_INTERVAL 0.35         //计时器间隔时间(单位秒)
#define K_MAIN_VIEW_SCROLLER_SPACE 20          //每次移动的距离
#define K_MAIN_VIEW_SCROLLER_LABLE_WIDTH  280  //字体宽度
#define K_MAIN_VIEW_SCROLLER_LABLE_MARGIN 20   //前后间隔距离

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    NSLog(@"test");
    [self initView];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//初始化数据
-(void) initView{
    
    if (!self.arrData) {
        self.arrData = @[
  @{
      @"newsId"   :@"201507070942261935",
      @"newsImg"  :@"http://bg.fx678.com/HTMgr/upload/UpFiles/20150707/sy_2015070709395519.jpg",
      @"newsTitle" : @"一三大理由欧元任性抗跌，欧元区峰会将为希腊定调"
      },
  @{
      @"newsId"   :@201507070929021220,
      @"newsImg"   :@"http://bg.fx678.com/HTMgr/upload/UpFiles/20150707/sy_2015070709273545.jpg",
      @"newsTitle" :@"二欧盟峰会或现希腊转机，黄金打响1162保卫战"
      },
  @{
      @"newsId"    :@201507070656471857,
      @"newsImg"   :@"http://bg.fx678.com/HTMgr/upload/UpFiles/20150707/2015070706533134.jpg",
      @"newsTitle" :@"三希腊困局欧元不怕，油价服软暴跌8%"
      },
  @{
      @"newsId"    :@201507070656471857,
      @"newsImg"   :@"http://bg.fx678.com/HTMgr/upload/UpFiles/20150707/2015070706533134.jpg",
      @"newsTitle" :@"四希腊困局欧元不怕，油价服软暴跌8%"
      },
  @{
      @"newsId"    :@201507070656471857,
      @"newsImg"   :@"http://bg.fx678.com/HTMgr/upload/UpFiles/20150707/2015070706533134.jpg",
      @"newsTitle" :@"五希腊困局欧元不怕，油价服软暴跌8%"
      }
  ];
    }
    
    //文字滚动
    [self initScrollText];
    
    //开启滚动
    [self startScroll];
}


//文字滚动初始化
-(void) initScrollText{
    
    //获取滚动条
    scrollViewText = (UIScrollView *)[self.view viewWithTag:K_MAIN_VIEW_SCROLL_TEXT_TAG];
    if(!scrollViewText){
        scrollViewText = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, K_MAIN_VIEW_SCROLL_HEIGHT)];
        scrollViewText.showsHorizontalScrollIndicator = NO;   //隐藏水平滚动条
        scrollViewText.showsVerticalScrollIndicator = NO;     //隐藏垂直滚动条
        scrollViewText.scrollEnabled = NO;
        scrollViewText.tag = K_MAIN_VIEW_SCROLL_TEXT_TAG;
        [scrollViewText setBackgroundColor:[UIColor grayColor]];
        
        //清除子控件
        for (UIView *view in [scrollViewText subviews]) {
            [view removeFromSuperview];
        }
        
        //添加到当前视图
        [self.view addSubview:scrollViewText];
    }
    
    
    if (self.arrData) {
        
        CGFloat offsetX = 0 ,i = 0, h = 30;
        
        //设置滚动文字
        UILabel *labText = nil;
        for (NSDictionary *dicTemp in self.arrData) {
            labText = [[UILabel alloc] initWithFrame:CGRectMake(
                                                                i * (K_MAIN_VIEW_SCROLLER_LABLE_WIDTH + K_MAIN_VIEW_SCROLLER_LABLE_MARGIN),
                                                                (K_MAIN_VIEW_SCROLL_HEIGHT - h) / 2,
                                                                K_MAIN_VIEW_SCROLLER_LABLE_WIDTH,
                                                                h)];
            [labText setFont:[UIFont systemFontOfSize:18]];
            [labText setTextColor:[UIColor whiteColor]];
            labText.text = dicTemp[@"newsTitle"];
//            offsetX += labText.frame.origin.x;
            
            //添加到滚动视图
            [scrollViewText addSubview:labText];
            
            i++;
        }
        offsetX += labText.frame.origin.x + K_MAIN_VIEW_SCROLLER_LABLE_WIDTH + K_MAIN_VIEW_SCROLLER_LABLE_MARGIN;
        //设置滚动区域大小
        [scrollViewText setContentSize:CGSizeMake(offsetX, 0)];
    }
}


//开始滚动
-(void) startScroll{
    
    if (!timer)
        timer = [NSTimer scheduledTimerWithTimeInterval:K_MAIN_VIEW_TEME_INTERVAL target:self selector:@selector(setScrollText) userInfo:nil repeats:YES];
    
    [timer fire];
}


//滚动处理
-(void) setScrollText{
    
    CGFloat startX = scrollViewText.contentSize.width - K_MAIN_VIEW_SCROLLER_LABLE_WIDTH - K_MAIN_VIEW_SCROLLER_LABLE_MARGIN;
    
    [UIView animateWithDuration:K_MAIN_VIEW_TEME_INTERVAL * 2 animations:^{
        CGRect rect;
        CGFloat offsetX = 0.0;
        
        for (UILabel *lab in scrollViewText.subviews) {
            
            rect = lab.frame;
            offsetX = rect.origin.x - K_MAIN_VIEW_SCROLLER_SPACE;
            if (offsetX < -K_MAIN_VIEW_SCROLLER_LABLE_WIDTH){
                offsetX = startX;
                lab.hidden = true;
            }
            
            lab.frame = CGRectMake(offsetX, rect.origin.y, rect.size.width, rect.size.height);
        }
        
        NSLog(@"offsetX:%f",offsetX);
        
    }completion:^(BOOL finished) {
        CGRect rect;
        CGFloat offsetX = 0.0;
            for (UILabel *lab in scrollViewText.subviews) {

                rect = lab.frame;
                offsetX = rect.origin.x;
                if (offsetX < startX && offsetX > startX-22){
                    lab.hidden = false;
                }

            }
    }];
    
}

@end
