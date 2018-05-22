//
//  FEIIExpressionInputView.m
//  jdyk
//
//  Created by Lieniu03 on 2018/5/21.
//  Copyright © 2018年 Lieniu03. All rights reserved.
//

#import "FEIIExpressionInputView.h"
#import "EmotionModel.h"
#import "FEIIExpressionHelper.h"

#define kViewHeight 216
#define kToolbarHeight 37
#define kOneEmoticonHeight 50
#define kOnePageCount 20

@interface FEIIEmoticonCell : UICollectionViewCell

@property (nonatomic, strong) FEIIEmotcion *emoticon;
@property (nonatomic, assign) BOOL deleted;
@property (nonatomic, strong) UIImageView *imageView;

@end

@implementation FEIIEmoticonCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    _imageView = [UIImageView new];
    _imageView.frame = CGRectMake(0, 0, 32, 32);
    _imageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.contentView addSubview:_imageView];
    return self;
}

- (void)setEmoticon:(FEIIEmotcion *)emoticon {
    if (_emoticon == emoticon) return;
    _emoticon = emoticon;
    [self updateContent];
}

- (void)setDeleted:(BOOL)deleted{
    if (_deleted == deleted) return;
    _deleted = deleted;
    [self updateContent];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self updateLayout];
}

- (void)updateContent {
    _imageView.image = nil;
    
    if (_deleted) {
        _imageView.image = [UIImage imageNamed:@"compose_emotion_delete"];
    } else if (_emoticon) {
        if (_emoticon.type == FEIIEmotionTypeEmoji) {
            
        } else if (_emoticon.group.groupId && _emoticon.png){
            
            NSString *emoticonBundlePath = [[NSBundle mainBundle] pathForResource:@"KeyBoardInput" ofType:@"bundle"];
            NSString *pngPath = [emoticonBundlePath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@",_emoticon.group.groupId]];
            pngPath = [pngPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@",_emoticon.png]];
            
            if (pngPath) {
                [_imageView sd_setImageWithURL:[NSURL fileURLWithPath:pngPath]];
            }
        }
    }
}

- (void)updateLayout {
    _imageView.center = CGPointMake(self.frame.size.width / 2, self.frame.size.height / 2);
}

@end

@protocol FEIIEmoticonScrollViewDelegate <UICollectionViewDelegate>
- (void)emoticonScrollViewDidTapCell:(FEIIEmoticonCell *)cell;
@end

@interface FEIIEmoticonScrollView : UICollectionView
@end

@implementation FEIIEmoticonScrollView {
    NSTimeInterval *_touchBeganTime;
    BOOL _touchMoved;
    UIImageView *_magnifier;
    UIImageView *_magnifierContent;
    __weak FEIIEmoticonCell *_currentMagnifierCell;
    NSTimer *_backspaceTimer;
}

- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout {
    self = [super initWithFrame:frame collectionViewLayout:layout];
    self.backgroundColor = [UIColor clearColor];
    self.backgroundView = [UIView new];
    self.pagingEnabled = YES;
    self.showsHorizontalScrollIndicator = NO;
    self.clipsToBounds = NO;
    self.canCancelContentTouches = NO;
    self.multipleTouchEnabled = NO;
    _magnifier = [[UIImageView alloc] initWithImage:[FEIIExpressionHelper imageNamed:@"emoticon_keyboard_magnifier"]];
    _magnifierContent = [UIImageView new];
    
//    _magnifierContent.size = CGSizeMake(40, 40);
//    _magnifierContent.centerX = _magnifier.width / 2;
    [_magnifier addSubview:_magnifierContent];
    [_magnifierContent mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.size.mas_equalTo(CGSizeMake(40, 40));
        make.centerX.mas_equalTo(_magnifier.mas_centerX);
        
    }];
    _magnifier.hidden = YES;
    [self addSubview:_magnifier];
    return self;
}

- (void)dealloc {
    [self endBackspaceTimer];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    _touchMoved = NO;
    FEIIEmoticonCell *cell = [self cellForTouches:touches];
    _currentMagnifierCell = cell;
    [self showMagnifierForCell:_currentMagnifierCell];
    
    if (cell.imageView.image && !cell.deleted) {
        [[UIDevice currentDevice] playInputClick];
    }
    
    if (cell.deleted) {
        [self endBackspaceTimer];
        [self performSelector:@selector(startBackspaceTimer) withObject:nil afterDelay:0.5];
    }
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    _touchMoved = YES;
    if (_currentMagnifierCell && _currentMagnifierCell.deleted) return;
    
    FEIIEmoticonCell *cell = [self cellForTouches:touches];
    if (cell != _currentMagnifierCell) {
        if (!_currentMagnifierCell.deleted && !cell.deleted) {
            _currentMagnifierCell = cell;
        }
        [self showMagnifierForCell:cell];
    }
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    FEIIEmoticonCell *cell = [self cellForTouches:touches];
    if ((!_currentMagnifierCell.deleted && cell.emoticon) || (!_touchMoved && cell.deleted)) {
        if ([self.delegate respondsToSelector:@selector(emoticonScrollViewDidTapCell:)]) {
            [((id<FEIIEmoticonScrollViewDelegate>) self.delegate) emoticonScrollViewDidTapCell:cell];
        }
    }
    [self hideMagnifier];
    [self endBackspaceTimer];
}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self hideMagnifier];
    [self endBackspaceTimer];
}

- (FEIIEmoticonCell *)cellForTouches:(NSSet<UITouch *> *)touches {
    UITouch *touch = touches.anyObject;
    CGPoint point = [touch locationInView:self];
    NSIndexPath *indexPath = [self indexPathForItemAtPoint:point];
    if (indexPath) {
        FEIIEmoticonCell *cell = (id)[self cellForItemAtIndexPath:indexPath];
        return cell;
    }
    return nil;
}

- (void)showMagnifierForCell:(FEIIEmoticonCell *)cell {
    if (cell.deleted || !cell.imageView.image) {
        [self hideMagnifier];
        return;
    }
    CGRect rect = [cell convertRect:cell.bounds toView:self];
    [_magnifier mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.mas_equalTo(cell.mas_centerX);
        make.bottom.mas_equalTo(cell.mas_bottom).offset(-9);
        
    }];
//    _magnifier.centerX = CGRectGetMidX(rect);
//    _magnifier.bottom = CGRectGetMaxY(rect) - 9;
    _magnifier.hidden = NO;
    
    _magnifierContent.image = cell.imageView.image;
    [_magnifierContent mas_updateConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(9);
        
    }];
//    _magnifierContent.top = 20;
    
    [_magnifierContent.layer removeAllAnimations];
    NSTimeInterval dur = 0.1;
    [UIView animateWithDuration:dur delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
//        _magnifierContent.top = 3;
        [_magnifierContent mas_updateConstraints:^(MASConstraintMaker *make) {
            
            make.top.mas_equalTo(3);
            
        }];
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:dur delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
//            _magnifierContent.top = 6;
            [_magnifierContent mas_updateConstraints:^(MASConstraintMaker *make) {
                
                make.top.mas_equalTo(6);
                
            }];
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:dur delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
//                _magnifierContent.top = 5;
                [_magnifierContent mas_updateConstraints:^(MASConstraintMaker *make) {
                    
                    make.top.mas_equalTo(5);
                    
                }];
            } completion:^(BOOL finished) {
            }];
        }];
    }];
}

- (void)hideMagnifier {
    _magnifier.hidden = YES;
}

- (void)startBackspaceTimer {
    [self endBackspaceTimer];
    @WeakObj(self);
    if (@available(iOS 10.0, *)) {
        _backspaceTimer = [NSTimer timerWithTimeInterval:0.1 repeats:YES block:^(NSTimer * _Nonnull timer) {
            @StrongObj(self);
            //        @strongify(self);
            if (!self) return;
            FEIIEmoticonCell *cell = self->_currentMagnifierCell;
            if (cell.deleted) {
                if ([self.delegate respondsToSelector:@selector(emoticonScrollViewDidTapCell:)]) {
                    [[UIDevice currentDevice] playInputClick];
                    [((id<FEIIEmoticonScrollViewDelegate>) self.delegate) emoticonScrollViewDidTapCell:cell];
                }
            }
        }];
    } else {
        _backspaceTimer = [NSTimer timerWithTimeInterval:0.1 target:selfWeak selector:@selector(dosomething) userInfo:nil repeats:YES];
    }
    
    [[NSRunLoop mainRunLoop] addTimer:_backspaceTimer forMode:NSRunLoopCommonModes];
}

- (void)dosomething{
    
    if (!self) return;
    FEIIEmoticonCell *cell = self->_currentMagnifierCell;
    if (cell.deleted) {
        if ([self.delegate respondsToSelector:@selector(emoticonScrollViewDidTapCell:)]) {
            [[UIDevice currentDevice] playInputClick];
            [((id<FEIIEmoticonScrollViewDelegate>) self.delegate) emoticonScrollViewDidTapCell:cell];
        }
    }
    
}

- (void)endBackspaceTimer {
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(startBackspaceTimer) object:nil];
    [_backspaceTimer invalidate];
    _backspaceTimer = nil;
}

@end

@interface FEIIExpressionInputView ()<UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UIView *pageControl;
@property (nonatomic, strong) NSArray<FEIIEmotcionGroup *> *emoticonGroups;
@property (nonatomic, strong) NSArray<NSNumber *> *emoticonGroupPageIndexs;
@property (nonatomic, strong) NSArray<NSNumber *> *emoticonGroupPageCounts;
@property (nonatomic, assign) NSInteger emoticonGroupTotalPageCount;
@property (nonatomic, assign) NSInteger currentPageIndex;

@end

@implementation FEIIExpressionInputView

+ (instancetype)sharedView {
    static FEIIExpressionInputView *v;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        v = [self new];
    });
    return v;
}

- (instancetype)init {
    self = [super init];
    
    self.frame = CGRectMake(0, 0, SCREEN_WIDTH, kViewHeight);
    self.backgroundColor = [UIColor colorWithHex:0XF9F9F9];
    [self _initGroups];
    
    [self _initTopLine];
    [self _initCollectionView];
    
    _currentPageIndex = NSNotFound;
    
    return self;
}



- (void)_initGroups {
    _emoticonGroups = [FEIIExpressionHelper emoticonGroups];
    
    //获取各表情组起始页下标数组
    NSMutableArray *indexs = [NSMutableArray new];
    NSUInteger index = 0;
    for (FEIIEmotcionGroup *group in _emoticonGroups) {
        [indexs addObject:@(index)];
        NSUInteger count = ceil(group.emoticons.count / (float)kOnePageCount);
        if (count == 0) count = 1;
        index += count;
    }
    _emoticonGroupPageIndexs = indexs;
    
    //表情组总页数
    NSMutableArray *pageCounts = [NSMutableArray new];
    _emoticonGroupTotalPageCount = 0;
    for (FEIIEmotcionGroup *group in _emoticonGroups) {
        NSUInteger pageCount = ceil(group.emoticons.count / (float)kOnePageCount);
        if (pageCount == 0) pageCount = 1;
        [pageCounts addObject:@(pageCount)];
        _emoticonGroupTotalPageCount += pageCount;
    }
    _emoticonGroupPageCounts = pageCounts;
}

- (void)_initTopLine {
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, 1)];
    line.backgroundColor = [UIColor colorWithHex:0Xbfbfbf];
    line.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    [self addSubview:line];
}

- (void)_initCollectionView {
    CGFloat itemWidth = (SCREEN_WIDTH - 10 * 2) / 7.0;
    CGFloat padding = (SCREEN_WIDTH - 7 * itemWidth) / 2.0;
    CGFloat paddingLeft = padding;
    CGFloat paddingRight = SCREEN_WIDTH - paddingLeft - itemWidth * 7;
    
    UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.itemSize = CGSizeMake(itemWidth, kOneEmoticonHeight);
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 0;
    layout.sectionInset = UIEdgeInsetsMake(0, paddingLeft, 0, paddingRight);
    
    _collectionView = [[FEIIEmoticonScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, kOneEmoticonHeight * 3) collectionViewLayout:layout];
    
    [_collectionView registerClass:[FEIIEmoticonCell class] forCellWithReuseIdentifier:@"cell"];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.backgroundColor = [UIColor whiteColor];
    [self addSubview:_collectionView];
    
    _pageControl = [[UIView alloc]initWithFrame:CGRectMake(0, _collectionView.frame.size.height-25, SCREEN_WIDTH, 20)];
    _pageControl.userInteractionEnabled = NO;
    [self addSubview:_pageControl];
}

#pragma mark YHEmoticonScrollViewDelegate

- (void)emoticonScrollViewDidTapCell:(FEIIEmoticonCell *)cell {
    if (!cell) return;
    if (cell.deleted) {
        if ([self.delegate respondsToSelector:@selector(emoticonInputDidTapBackspace)]) {
            [[UIDevice currentDevice] playInputClick];
            [self.delegate emoticonInputDidTapBackspace];
        }
    } else if (cell.emoticon) {
        NSString *text = nil;
        switch (cell.emoticon.type) {
            case FEIIEmotionTypeImage: {
                text = cell.emoticon.chs;
            } break;
            case FEIIEmotionTypeEmoji: {
//                NSNumber *num = [NSNumber numberWithString:cell.emoticon.code];
//                text = [NSString stringWithUTF32Char:num.unsignedIntValue];
            } break;
            default:break;
        }
        if (text && [self.delegate respondsToSelector:@selector(emoticonInputDidTapText:)]) {
            [self.delegate emoticonInputDidTapText:text];
        }
    }
}

#pragma mark UICollectionViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    NSInteger page = round(scrollView.contentOffset.x / scrollView.frame.size.width);
    if (page < 0) page = 0;
    else if (page >= _emoticonGroupTotalPageCount) page = _emoticonGroupTotalPageCount - 1;
    if (page == _currentPageIndex) return;
    _currentPageIndex = page;
    NSInteger curGroupIndex = 0, curGroupPageIndex = 0, curGroupPageCount = 0;
    for (NSInteger i = _emoticonGroupPageIndexs.count - 1; i >= 0; i--) {
        NSNumber *pageIndex = _emoticonGroupPageIndexs[i];
        if (page >= pageIndex.unsignedIntegerValue) {
            curGroupIndex = i;
            curGroupPageIndex = ((NSNumber *)_emoticonGroupPageIndexs[i]).integerValue;
            curGroupPageCount = ((NSNumber *)_emoticonGroupPageCounts[i]).integerValue;
            break;
        }
    }
    
}

- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
    return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return NO;
}

#pragma mark UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return _emoticonGroupTotalPageCount;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return kOnePageCount + 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    FEIIEmoticonCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    if (indexPath.row == kOnePageCount) {
        cell.deleted = YES;
        cell.emoticon = nil;
    } else {
        cell.deleted = NO;
        cell.emoticon = [self _emoticonForIndexPath:indexPath];
    }
    cell.backgroundColor = [UIColor grayColor];
    return cell;
}

- (FEIIEmotcion *)_emoticonForIndexPath:(NSIndexPath *)indexPath {
    NSUInteger section = indexPath.section;
    for (NSInteger i = _emoticonGroupPageIndexs.count - 1; i >= 0; i--) {
        NSNumber *pageIndex = _emoticonGroupPageIndexs[i];
        if (section >= pageIndex.unsignedIntegerValue) {
            FEIIEmotcionGroup *group = _emoticonGroups[i];
            NSUInteger page = section - pageIndex.unsignedIntegerValue;
            NSUInteger index = page * kOnePageCount + indexPath.row;
            
            // transpose line/row
            NSUInteger ip = index / kOnePageCount;
            NSUInteger ii = index % kOnePageCount;
            NSUInteger reIndex = (ii % 3) * 7 + (ii / 3);
            index = reIndex + ip * kOnePageCount;
            
            if (index < group.emoticons.count) {
                return group.emoticons[index];
            } else {
                return nil;
            }
        }
    }
    return nil;
}

#pragma mark @protocol UITextViewDelegate

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [_textView resignFirstResponder];
}

#pragma mark - UIInputViewAudioFeedback

- (BOOL)enableInputClicksWhenVisible {
    return YES;
}

@end
