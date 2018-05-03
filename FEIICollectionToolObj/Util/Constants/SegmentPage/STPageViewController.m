//
//  STPageViewController.m
//  officecamp
//
//  Created by shine-team1 on 16/6/13.
//  Copyright © 2016年 st. All rights reserved.
//

#import "STPageViewController.h"
#import "STPageView.h"
#import "STPageCollectionCell.h"

@interface STPageViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,STPageContentViewDelegate>
@property (nonatomic, assign) CGFloat pageBarHeight;
@property (nonatomic, weak) STPageView *contentViews;
@property (nonatomic, weak) UICollectionView *collectionMain;
@property (nonatomic, weak) UIView *line;
@property (nonatomic, assign) CGFloat lineWidth;
@property (nonatomic,assign) int lastPositionX;
@property (nonatomic,assign) BOOL scrollToRight;

@property (nonatomic ,strong) NSArray *itemsArray;
@property (nonatomic, strong) NSArray *controllersClass;
@property (nonatomic, strong) NSMutableArray *controllers;
@end

#define CollectionWidth (SCREEN_Width - 120)
#define SCREEN_Width ([[UIScreen mainScreen] bounds].size.width)
#define SCREEN_Height ([[UIScreen mainScreen] bounds].size.height)
#define line_X 40
#define line_padingW 75

static NSString *mainCell = @"mainCellmainCell";

@implementation STPageViewController
- (NSMutableArray *)controllers{
    if (!_controllers) {
        NSMutableArray *controllers = [NSMutableArray array];
        for (int i = 0; i < _controllersClass.count; i ++) {
            Class className = _controllersClass[i];
            UIViewController *vc = [[className alloc] init];
            vc.title = _itemsArray[i];
            [self addChildViewController:vc];
            [controllers addObject:vc];
        }
        _controllers = controllers;
    }
    return _controllers;
}

- (instancetype)initWithTitles:(NSArray *)titlesArray controllersClass:(NSArray *)controllersClass
{
    if (self = [super init]) {
        
        self.itemsArray = titlesArray;
        self.controllersClass = controllersClass;
        self.pageBarHeight = 44;
        [self addCollectionPage];
        [self addCollectionMain];
    }
    return self;
}

-(void)setPageBarHeight:(CGFloat)pageBarHeight{
    _pageBarHeight = pageBarHeight;
}

-(void)viewDidLoad{
    [super viewDidLoad];
    
    self.title = @"场地预订";
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    [MobClick beginLogPageView:@"我的场地预订"];
    
    _scrollToRight = YES;
    _lastPositionX = 0;
}

- (void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
    [MobClick endLogPageView:@"我的场地预订"];
}

- (void)addCollectionPage{
    
    STPageView *contentViews = [[STPageView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.pageBarHeight) itemsArray:self.itemsArray];
    contentViews.delegate = self;
    [self.view addSubview:contentViews];
    self.contentViews = contentViews;
    
    UIView *line = [[UIView alloc] init];
    line.backgroundColor = [UIColor colorWithHex:MAIN_CONLOR_HEX];
    
    CGFloat lineWidth = [self getWidth:_itemsArray[0]];
    CGFloat cellWidth = SCREEN_WIDTH / _itemsArray.count;
    CGFloat lineX = (cellWidth - lineWidth) / 2 + 0 * cellWidth;
    CGFloat padding = 5.0f;
    
    self.lineWidth = self.view.frame.size.width / self.itemsArray.count;
    line.frame = CGRectMake(lineX - padding, self.pageBarHeight - 1, lineWidth + 2 * padding, 1);
    [self.contentViews addSubview:line];
    [self.contentViews bringSubviewToFront:line];
    self.line = line;
}

- (void)addCollectionMain{
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.minimumLineSpacing = 0;
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    CGRect frame = CGRectMake(0, CGRectGetMaxY(self.contentViews.frame), self.view.frame.size.width, self.view.frame.size.height - self.pageBarHeight - 64);
    
    UICollectionView *collectionMain = [[UICollectionView alloc] initWithFrame:frame collectionViewLayout:layout];
    collectionMain.dataSource = self;
    collectionMain.delegate = self;
    collectionMain.pagingEnabled = YES;
    collectionMain.scrollEnabled = YES;
    collectionMain.bounces = NO;
    collectionMain.showsHorizontalScrollIndicator = NO;
    [collectionMain registerClass:[STPageCollectionCell class] forCellWithReuseIdentifier:mainCell];
    [self.view addSubview:collectionMain];
    [self.view bringSubviewToFront:collectionMain];
    self.collectionMain = collectionMain;
}

#pragma mark - UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return collectionView.frame.size;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

#pragma mark - UICollectionViewDataSource && UICollectionViewDelegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.itemsArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    STPageCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:mainCell forIndexPath:indexPath];
    [cell setIndexController:self.controllers[indexPath.row]];
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [self.collectionMain scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:indexPath.row inSection:0] atScrollPosition:UICollectionViewScrollPositionLeft animated:YES];
    
    CGFloat lineWidth = [self getWidth:_itemsArray[indexPath.row]];
    
    CGFloat cellWidth = SCREEN_WIDTH / _itemsArray.count;
    CGFloat lineX = (cellWidth - lineWidth) / 2 + indexPath.row * cellWidth;
    CGFloat padding = 5.0f;
    
    [UIView animateWithDuration:0.25 animations:^{
        self.line.frame = CGRectMake(lineX - padding, self.pageBarHeight - 1, lineWidth + 2 * padding, 1);
    }];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    CGFloat x = scrollView.contentOffset.x ;
    int index = (x + SCREEN_Width * 0.5) / SCREEN_Width;
    
    CGFloat lineWidth = [self getWidth:_itemsArray[index]];
    
    CGFloat cellWidth = SCREEN_WIDTH / _itemsArray.count;
    CGFloat lineX = (cellWidth - lineWidth) / 2 + index * cellWidth;
    CGFloat padding = 5.0f;
    
    [UIView animateWithDuration:0.25 animations:^{
        self.line.frame = CGRectMake(lineX - padding, self.pageBarHeight - 1, lineWidth + 2 * padding, 1);
    }];
    self.contentViews.index = index;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    int currentPostion = scrollView.contentOffset.x;
    if (currentPostion - _lastPositionX > 5) {
        _scrollToRight = YES;
    }else if(currentPostion - _lastPositionX < -5){
        _scrollToRight = NO;
    }
    _lastPositionX = currentPostion;
}

#pragma mark - LZPageContentViewDelegate
- (void)pageContentView:(STPageView *)pageContentView didClickBtnIndex:(NSInteger)index
{
    [self.collectionMain scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0] atScrollPosition:UICollectionViewScrollPositionLeft animated:YES];
    
    CGFloat cellWidth = SCREEN_WIDTH / _itemsArray.count;
    CGFloat lineWidth = [self getWidth:_itemsArray[index]];
    CGFloat lineX = (cellWidth - lineWidth) / 2 + index * cellWidth;
    CGFloat padding = 5.0f;
    
    [UIView animateWithDuration:0.25 animations:^{
        self.line.frame = CGRectMake(lineX - padding, self.pageBarHeight - 1, lineWidth + 2 * padding, 1);
    }];
}

- (CGFloat)getWidth:(NSString *)title {
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 1000, 0)];
    label.text = title;
    label.font = [UIFont systemFontOfSize:14.0f];
    [label sizeToFit];
    
    return label.frame.size.width;
}
@end

