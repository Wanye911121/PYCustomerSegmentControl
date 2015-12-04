//
//  PYSegmentControl.m
//  PYCustomerSegmentControl
//
//  Created by ZpyZp on 15/12/1.
//  Copyright © 2015年 zpy. All rights reserved.
//

static float const DURATION = 0.2;
static float const LineHeight = 5;
static float const TextFont = 16;
static float const SelectedTextFont = 18;

#import "PYSegmentControl.h"

@interface PYSegmentControl()
@property (nonatomic,assign) CGFloat textLabelWidth;
@property (nonatomic,assign) CGFloat viewHeight;
@property (nonatomic,assign) CGFloat viewWidth;
@property (nonatomic,weak) UIView *lineView;
@property (nonatomic,copy) ButtonOnClickBlock buttonClickBlock;

@end

@implementation PYSegmentControl

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _viewWidth = frame.size.width;
        _viewHeight = frame.size.height;
        _duration = DURATION;
    }
    return self;
}

-(void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    
    //获取上下文
    
    CGContextRef ref = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(ref, [UIColor whiteColor].CGColor);
    CGContextFillRect(ref, rect);
    
    //创建路径
    
    CGMutablePathRef path =CGPathCreateMutable();
    
    //竖线高度
    CGFloat verticalLineHeight = (_viewHeight - LineHeight)/2;
    
    for (int i = 1; i<_textArray.count; i++) {
        //设置路径起点
        CGPathMoveToPoint(path,nil,i*_textLabelWidth,verticalLineHeight/2);
        
        //添加路径内容
        
        CGPathAddLineToPoint(path, nil,i*_textLabelWidth,verticalLineHeight*3/2);
    }
    
    [[UIColor grayColor] setStroke];
    
    CGContextSetLineWidth(ref, 1);
    
    CGContextAddPath(ref, path);
    
    CGContextDrawPath(ref, kCGPathStroke);
    
    CGContextRelease(ref);
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    [self initDefaultStyle];
    [self initButton];
    [self initLine];
}

/**
 默认样式
 */
-(void)initDefaultStyle
{
    if (_textColor == nil) {
        _textColor          = [UIColor grayColor];
    }
    if (_highlightTextColor == nil) {
        _highlightTextColor = [UIColor blackColor];
    }
    if (_lineColor == nil) {
        _lineColor          = [UIColor redColor];
    }
    if (_textArray == nil) {
        _textArray          = @[@"test1",@"test2",@"test3"];
    }
    _textLabelWidth = _viewWidth / _textArray.count;
}

-(CGRect)caculateCurrentRectOfIndex:(NSInteger)index
{
    return CGRectMake(index * _textLabelWidth, 0, _textLabelWidth, _viewHeight-LineHeight);
}

-(CGRect)caculateLineRectOfIndex:(NSInteger)index;
{
    return CGRectMake(index * _textLabelWidth,_viewHeight-LineHeight, _textLabelWidth, LineHeight);
}

-(void)initButton
{
    for (int i = 0; i < _textArray.count; i++) {
        CGRect btnFrame = [self caculateCurrentRectOfIndex:i];
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = btnFrame;
        [btn setTitle:_textArray[i] forState:UIControlStateNormal];
        [btn setTitleColor:_textColor forState:UIControlStateNormal];
        [btn setTitleColor:_highlightTextColor forState:UIControlStateSelected];
        btn.tag = i;
        [btn addTarget:self action:@selector(tapButton:) forControlEvents:UIControlEventTouchUpInside];
        btn.titleLabel.font = [UIFont systemFontOfSize:TextFont];
        [self addSubview:btn];
    }
}

-(void)initLine
{
    UIView *lineView = [[UIView alloc] init];
    lineView.frame = CGRectMake(0, _viewHeight-LineHeight, _textLabelWidth, LineHeight);
    lineView.backgroundColor = _lineColor;
    [self addSubview:lineView];
    _lineView = lineView;
}

-(void)tapButton:(UIButton *)btn
{
    for (id subView in self.subviews) {
        if ([subView isKindOfClass:[UIButton class]]) {
            UIButton *subBtn = (UIButton *)subView;
            subBtn.selected = NO;
            subBtn.titleLabel.font = [UIFont systemFontOfSize:TextFont];
        }
    }
    btn.selected = !btn.selected;
    btn.titleLabel.font = [UIFont systemFontOfSize:SelectedTextFont];
    
    if (_buttonClickBlock && btn.tag < _textArray.count) {
        _buttonClickBlock(btn.tag, _textArray[btn.tag]);
    }
    CGRect changeFrame = [self caculateLineRectOfIndex:btn.tag];
    [UIView animateWithDuration:_duration animations:^{
        _lineView.frame = changeFrame;
    } completion:^(BOOL finished) {
        [self shakeAnimationForView:_lineView];
    }];
}

/**
 *  抖动效果
 */
- (void)shakeAnimationForView:(UIView *) view {
    CALayer *viewLayer = view.layer;
    CGPoint position = viewLayer.position;
    CGPoint x = CGPointMake(position.x + 1, position.y);
    CGPoint y = CGPointMake(position.x - 1, position.y);
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"position"];
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault]];
    [animation setFromValue:[NSValue valueWithCGPoint:x]];
    [animation setToValue:[NSValue valueWithCGPoint:y]];
    [animation setAutoreverses:YES];
    [animation setDuration:.02];
    [animation setRepeatCount:3];
    [viewLayer addAnimation:animation forKey:nil];
}

-(void)setBlockCallBack:(ButtonOnClickBlock)block
{
    if (block) {
        _buttonClickBlock = block;
    }
}

@end
