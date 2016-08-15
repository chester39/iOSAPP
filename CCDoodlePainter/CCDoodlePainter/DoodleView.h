//
//  DoodleView.h
//  CCDoodlePainter
//
//  Created by sogou on 15/6/23.
//  Copyright (c) 2015年 Chen Chen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DoodleView : UIView

/**
 *  路径颜色
 */
@property (strong, nonatomic) UIColor *doodleColor;
/**
 *  路径宽度
 */
@property (nonatomic) CGFloat pathWidth;

/**
 *  清空涂鸦方法
 */
- (void)clearPainter;
/**
 *  撤销涂鸦方法
 */
- (void)undoPainter;


@end
