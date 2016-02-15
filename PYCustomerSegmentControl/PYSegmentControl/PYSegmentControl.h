//
//  PYSegmentControl.h
//  PYCustomerSegmentControl
//
//  Created by ZpyZp on 15/12/1.
//  Copyright © 2015年 zpy. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ButtonOnClickBlock)(NSInteger index, NSString * title);

@interface PYSegmentControl : UIView

//文本颜色
@property (nonatomic,strong) UIColor *textColor;

@property (nonatomic,strong) UIColor *highlightTextColor;
//细线颜色
@property (nonatomic,strong) UIColor *lineColor;
//文本数组
@property (nonatomic,strong) NSArray *textArray;
//持续时间
@property (nonatomic, assign) CGFloat duration;

/**
 回调方法
 */
- (void)setBlockCallBack:(ButtonOnClickBlock) block;


@end
