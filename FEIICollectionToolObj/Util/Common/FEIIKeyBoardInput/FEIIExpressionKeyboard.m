//
//  FEIIExpressionKeyboard.m
//  jdyk
//
//  Created by Lieniu03 on 2018/5/21.
//  Copyright © 2018年 Lieniu03. All rights reserved.
//

#import "FEIIExpressionKeyboard.h"
#import "FEIIExpressionInputView.h"
#import "FEIIExpressionHelper.h"

#define kTopToolbarH    46   //顶部工具栏高度
#define kToolbarBtnH    35   //顶部工具栏的按钮高度
#define kBotContainerH  216  //底部表情高度
#define DURTAION  0.25f      //键盘显示/收起动画时间
#define kTextVTopMargin 8

@interface FEIIExpressionTextView : UITextView

@property (nonatomic,copy)  NSString *emoticon;
@property (nonatomic,strong) NSMutableArray <NSString *>*emoticonArray;
//删除表情
- (void)deleteEmoticon;

@end

@implementation FEIIExpressionTextView

- (NSMutableArray<NSString *> *)emoticonArray{
    if (!_emoticonArray) {
        _emoticonArray = [NSMutableArray new];
    }
    return _emoticonArray;
}


- (void)setEmoticon:(NSString *)emoticon{
    _emoticon = emoticon;
    
    NSMutableString *maStr = [[NSMutableString alloc] initWithString:self.text];
    if (_emoticon) {
        [maStr insertString:_emoticon atIndex:self.selectedRange.location];
        [self.emoticonArray addObject:_emoticon];
    }
    self.text = maStr;
}

- (void)deleteEmoticon{
    
    NSRange range = self.selectedRange;
    NSInteger location = (NSInteger)range.location;
    if (location == 0) {
        if (range.length) {
            self.text = @"";
        }
        return ;
    }
    //判断是否表情
    NSString *subString = [self.text substringToIndex:location];
    if ([subString hasSuffix:@"]"]) {
        
        //查询是否存在表情
        __block NSString *emoticon = nil;
        __block NSRange  emoticonRange;
        [[FEIIExpressionHelper regexEmoticon] enumerateMatchesInString:subString options:kNilOptions range:NSMakeRange(0, subString.length) usingBlock:^(NSTextCheckingResult * _Nullable result, NSMatchingFlags flags, BOOL * _Nonnull stop) {
            emoticonRange = result.range;
            emoticon = [subString substringWithRange:result.range];
        }];
        NSLog(@"要删除表情是：\n%@",emoticon);
        if (emoticon) {
            //是表情符号,移除
            if ([self.emoticonArray containsObject:emoticon]) {
                
                self.text = [self.text stringByReplacingCharactersInRange:emoticonRange withString:@" "];
                NSLog(@"删除后字符串为:\n%@",self.text);
                
                range.location -= emoticonRange.length;
                range.length = 1;
                self.selectedRange = range;
                
            }
        }else{
            self.text = [self.text stringByReplacingCharactersInRange:range withString:@""];
            range.location -= 1;
            range.length = 1;
            self.selectedRange = range;
        }
        
    }else{
        self.text = [self.text stringByReplacingCharactersInRange:range withString:@""];
        range.location -= 1;
        range.length = 1;
        self.selectedRange = range;
    }
    
}
@end

@interface FEIIExpressionKeyboard()<FEIIExpressionInputViewDelegate,UITextViewDelegate>{
    BOOL    _toolbarButtonTap; //toolbarBtn被点击
    CGFloat _height_oneRowText;//输入框每一行文字高度
    CGFloat _height_Toolbar;   //当前Toolbar高度
    NSMutableArray *_toolbarButtonArr;
    UIButton       *_toolbarButtonSelected;
}

//表情键盘被添加到的VC 和 父视图
@property (nonatomic, weak) UIViewController *viewController;
@property (nonatomic, weak) UIView  *superView;

//TopToolBar
@property (nonatomic, strong) UIView *topToolBar;
@property (nonatomic, strong) FEIIExpressionTextView *textView;
@property (nonatomic, strong) UIButton *toolbarEmoticonButton;//表情
@property (nonatomic, strong) UIButton *toolbarSendButton;//“发送”
@property (nonatomic, strong) UIView   *toolbarBackground;

//BottomContainer
@property (nonatomic, strong) UIView *botContainer;
@property (nonatomic, strong) FEIIExpressionInputView *inputV;

@property (nonatomic, weak)id <FEIIExpressionKeyboardDelegate>delegate;
@end

@implementation FEIIExpressionKeyboard

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        _toolbarButtonArr = [NSMutableArray new];
        [self _addNotifations];
        [self _initUI];
    }
    return self;
}

#pragma mark - Public
- (instancetype)initWithViewController:(UIViewController <FEIIExpressionKeyboardDelegate>*)viewController{
    if (self = [super init]) {
        //保存VC和父视图
        self.viewController = viewController;
        _delegate = viewController;
        self.superView = self.viewController.view;
        [self.superView addSubview:self];
        self.backgroundColor = [UIColor redColor];
        
        //表情键盘在父视图的位置
        __weak typeof(self) weakSelf = self;
        [self mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.bottom.equalTo(weakSelf.superView).offset(kBotContainerH);
            make.height.mas_equalTo(kBotContainerH+kTopToolbarH);
            make.left.right.equalTo(weakSelf.superView);
            
        }];
    }
    return self;
}

- (void)endEditing{
    
    _toolbarButtonTap = NO;
    if (![_textView isFirstResponder]) {
        [self _onlyShowToolbar];
    }else{
        [self.textView resignFirstResponder];
    }
    
}

#pragma mark - filePrivate
- (void)_addNotifations{
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyBoardHidden:) name:UIKeyboardWillHideNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyBoardShow:) name:UIKeyboardWillShowNotification object:nil];
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)_layoutUI{
    __weak typeof(self) weakSelf = self;
    [_topToolBar setContentHuggingPriority:249 forAxis:UILayoutConstraintAxisVertical];
    [_topToolBar setContentCompressionResistancePriority:749 forAxis:UILayoutConstraintAxisVertical];
    
    [_topToolBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(weakSelf);
        make.bottom.equalTo(weakSelf.botContainer.mas_top);
        make.height.mas_equalTo(kTopToolbarH);
    }];
    
    [_toolbarBackground mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(weakSelf.topToolBar);
        make.height.mas_equalTo(kBotContainerH);
    }];
    
    [_toolbarEmoticonButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(kToolbarBtnH);
        make.right.equalTo(weakSelf.toolbarSendButton.mas_left);
        make.bottom.equalTo(weakSelf.topToolBar).offset(-5);
    }];
    
    
    [_toolbarSendButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(kToolbarBtnH);
        make.right.equalTo(weakSelf.topToolBar.mas_right);
        make.bottom.equalTo(weakSelf.topToolBar).offset(-5);
    }];
    
    [_textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(5);
        make.top.equalTo(weakSelf.topToolBar).offset(kTextVTopMargin);
        make.bottom.equalTo(weakSelf.topToolBar).offset(-kTextVTopMargin);
        make.right.equalTo(weakSelf.toolbarEmoticonButton.mas_left).offset(-5);
    }];
    
    [_botContainer mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(kBotContainerH);
        make.left.right.equalTo(weakSelf);
        make.bottom.equalTo(weakSelf);
    }];
    
    [_inputV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(weakSelf.botContainer);
        make.left.right.bottom.equalTo(weakSelf.botContainer);
    }];
    
}

- (void)_initUI{
    
    //顶部工具栏
    UIView *topToolBar = [UIView new];
    topToolBar.backgroundColor = [UIColor whiteColor];
    [self addSubview:topToolBar];
    _topToolBar = topToolBar;
    
    
    //顶部线
    UIView *line = [UIView new];
    line.backgroundColor = [UIColor colorWithHex:0xBFBFBF];
    [topToolBar addSubview:line];
    
    
    //顶部工具栏背景层
    UIView *topToolBarBG = [UIView new];
    topToolBarBG.backgroundColor = [UIColor colorWithHex:0xF9F9F9];
    [topToolBar addSubview:topToolBarBG];
    _toolbarBackground = topToolBarBG;
    
    //输入框
    [self _initTextView];
    
    //表情按钮
    _toolbarEmoticonButton = [self _creatToolbarButton];
    [self _setupBtnImage:_toolbarEmoticonButton];
    
    //"发送"按钮
    _toolbarSendButton = [self _creatToolbarButton];
    [self _setupBtnImage:_toolbarSendButton];
    
    
    [_toolbarButtonArr addObjectsFromArray:@[_toolbarEmoticonButton,_toolbarSendButton]];
    
    //底部容器
    [self _initBotContainer];
    
    [self _layoutUI];
}

- (void)_initTextView {
    
    _textView = [FEIIExpressionTextView new];
    _textView.layer.cornerRadius =3;
    _textView.layer.borderWidth  = 1;
    _textView.layer.masksToBounds = YES;
    _textView.layer.borderColor = [UIColor colorWithRed:222/255.0 green:222/255.0 blue:222/255.0 alpha:1.0].CGColor;
    _textView.showsVerticalScrollIndicator = YES;
    _textView.alwaysBounceVertical = NO;
    _textView.font = [UIFont systemFontOfSize:14];
    _textView.delegate = self;
    
    [_topToolBar addSubview:_textView];
    
    _height_oneRowText = [_textView.layoutManager usedRectForTextContainer:_textView.textContainer].size.height;
    _height_Toolbar    = kTopToolbarH;
}

- (UIButton *)_creatToolbarButton{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.backgroundColor = [UIColor grayColor];
    button.exclusiveTouch = YES;
    [button addTarget:self action:@selector(_onToolbarBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_topToolBar addSubview:button];
    return button;
}

- (void)_initBotContainer{
    _botContainer = [UIView new];
//    _botContainer.backgroundColor = [UIColor colorWithHex:0xF9F9F9];
    _botContainer.backgroundColor = [UIColor colorWithHex:0xffffff];
    [self addSubview:_botContainer];
    
    //表情
    FEIIExpressionInputView *inputV =[FEIIExpressionInputView sharedView];
    inputV.backgroundColor = [UIColor blueColor];
    inputV.delegate = self;
    [_botContainer addSubview:inputV];
    _inputV = inputV;

}

#pragma mark - UITextViewDelegate
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView{
    for (UIButton *b in _toolbarButtonArr) {
        b.selected = NO;
        [self _setupBtnImage:b];
    }
    return YES;
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if ([text isEqualToString:@""]) {
        [_textView deleteEmoticon];
    }
    return YES;
}

- (void)textViewDidChange:(UITextView *)textView{
    
    [self _textViewChangeText];
    
    
}

-(void)_textViewChangeText{
    
    CGFloat textH = [_textView.layoutManager usedRectForTextContainer:_textView.textContainer].size.height;
    
    int numberOfRowsShow;
    if (!_maxNumberOfRowsToShow) {
        numberOfRowsShow = 4;
    }
    else{
        numberOfRowsShow = _maxNumberOfRowsToShow;
    }
    
    CGFloat rows_h = _height_oneRowText*numberOfRowsShow;
    textH = textH>rows_h?rows_h:textH;
    
    //输入框高度
    CGFloat h_inputV = kTopToolbarH - 2*kTextVTopMargin;
    
    if (textH < h_inputV) {
        [_topToolBar mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(kTopToolbarH);
        }];
        _height_Toolbar = kTopToolbarH;
    }else{
        //工具栏高度
        CGFloat toolbarH = ceil(textH) + 2*kTextVTopMargin ;
        [_topToolBar mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(toolbarH);
        }];
        _height_Toolbar = toolbarH;
    }
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:DURTAION animations:^{
        [weakSelf.superView layoutIfNeeded];
    }];
    
    [_textView scrollRangeToVisible:NSMakeRange(self.textView.text.length, 1)];
    
    
}

#pragma mark - @protocol FEIIExpressionInputViewDelegate
- (void)emoticonInputDidTapText:(NSString *)text{
    
    
    if (text.length) {
        //设置表情符号
        _textView.emoticon = text;
        [self _textViewChangeText];
    }
    
    
}

- (void)emoticonInputDidTapBackspace{
    
    [_textView deleteEmoticon];
    [self _textViewChangeText];
    
    
    
}

#pragma mark - Action

/**
 设置btn图片
 */
- (void)_setupBtnImage:(UIButton *)btn{
    
    
    if (btn == _toolbarEmoticonButton) {
        if (!btn.selected) {
            [btn setImage:[FEIIExpressionHelper imageNamed:@"compose_emoticonbutton_background"] forState:UIControlStateNormal];
            [btn setImage:[FEIIExpressionHelper imageNamed:@"compose_emoticonbutton_background_highlighted"] forState:UIControlStateHighlighted];
        }else{
            [btn setImage:[FEIIExpressionHelper imageNamed:@"compose_keyboardbutton_background"] forState:UIControlStateNormal];
            [btn setImage:[FEIIExpressionHelper imageNamed:@"compose_keyboardbutton_background_highlighted"] forState:UIControlStateHighlighted];
            
        }
    }else if(btn == _toolbarSendButton){
        if (!btn.selected) {
            [btn setImage:[FEIIExpressionHelper imageNamed:@"message_add_background"] forState:UIControlStateNormal];
            [btn setImage:[FEIIExpressionHelper imageNamed:@"message_add_background_highlighted"] forState:UIControlStateHighlighted];
        }
        
    }
    
}

/**
 点击toolBarButton
 */
- (void)_onToolbarBtn:(UIButton *)button {
    
    _toolbarButtonSelected = button;
    
    _toolbarButtonTap = YES;
    
    //重设toolBar其他按钮的selected状态
    for (UIButton *btn in _toolbarButtonArr) {
        if (btn != button) {
            btn.selected = NO;
            [self _setupBtnImage:btn];
        }
    }
    
    //设置选中button的selected状态
    button.selected = !button.selected;
    [self _setupBtnImage:button];
    
    if (button == _toolbarEmoticonButton) {
        
        if (!button.selected) {
            //显示键盘
            [_textView becomeFirstResponder];
            
        }else{
            
            //显示表情
            if (![_textView isFirstResponder]) {
                [self _showExpressionKeyboard];
            }else{
                [_textView resignFirstResponder];
            }
            
            
        }
        
        
    }else if (button == _toolbarSendButton) {
        
        if (!button.selected){
            [self _onlyShowToolbar];
        }else {
            //发送内容
            if (![_textView isFirstResponder]) {
                
            }else{
                [_textView resignFirstResponder];
            }
            
        }
    }
}

/**
 只显示toolBar
 */
- (void)_onlyShowToolbar{
    __weak typeof(self) weakSelf = self;
    
    [_inputV mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(weakSelf.botContainer).offset(kBotContainerH);
    }];
    [self mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(weakSelf.superView).offset(kBotContainerH);
    }];
    [UIView animateWithDuration:DURTAION animations:^{
        [weakSelf.superView layoutIfNeeded];
    }];
    
}

/**
 显示表情键盘
 */
- (void)_showExpressionKeyboard{
    //表情键盘上移，addView下移
    __weak typeof(self) weakSelf = self;
    [_inputV mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(weakSelf.botContainer);
    }];
    [self mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(weakSelf.superView);
    }];
    [UIView animateWithDuration:DURTAION animations:^{
        [weakSelf.superView layoutIfNeeded];
    }];
    
}

#pragma mark - NSNotification

- (void)keyBoardHidden:(NSNotification*)noti{
    
    //隐藏键盘
    
    if (!_toolbarButtonTap) {
        
        
        [self _onlyShowToolbar];
        
        
    }else{
        _toolbarButtonTap = NO;
        
        if (_toolbarButtonSelected == _toolbarEmoticonButton) {
            [self _showExpressionKeyboard];
        }else{
            [self _onlyShowToolbar];
        }
    }
    
}

- (void)keyBoardShow:(NSNotification*)noti{
    //显示键盘
    __weak typeof(self) weakSelf = self;
    CGRect endF = [[noti.userInfo valueForKey:UIKeyboardFrameEndUserInfoKey]CGRectValue];
    if (!_toolbarButtonTap) {
        
        NSTimeInterval duration = [[noti.userInfo valueForKey:UIKeyboardAnimationDurationUserInfoKey] floatValue];
        CGFloat diffH = endF.size.height - kBotContainerH;//高度差
        [self mas_updateConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(weakSelf.superView).offset(-diffH);
        }];
        [UIView animateWithDuration:duration animations:^{
            [weakSelf.superView layoutIfNeeded];
        }];
        
    }else{
        _toolbarButtonTap = NO;
        
        CGFloat diffH = endF.size.height - kBotContainerH;//高度差
        [self mas_updateConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(weakSelf.superView).offset(-diffH);
            
        }];
        
    }
    
}


@end


