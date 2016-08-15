//
//  DoodleView.m
//  CCDoodlePainter
//
//  Created by sogou on 15/6/23.
//  Copyright (c) 2015年 Chen Chen. All rights reserved.
//

#import "DoodleView.h"

@interface DoodleView ()

/**
 *  路径数组
 */
@property (strong, nonatomic) NSMutableArray *pathArray;

@end

@implementation DoodleView

#pragma mark - 初始化方法

/**
 *  路径数组惰性初始化方法
 */
- (NSMutableArray *)pathArray
{
    if (_pathArray == nil) {
        _pathArray = [NSMutableArray array];
    }
    return _pathArray;
}

#pragma mark - 系统方法

/**
 *  绘制图形方法
 */
- (void)drawRect:(CGRect)rect
{
    [self.doodleColor set];
    for (UIBezierPath *path in self.pathArray) {
        path.lineWidth = self.pathWidth;
        [path stroke];
    }
}

#pragma mark - 触摸方法

/**
 *  触摸开始方法
 */
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint startPosition = [touch locationInView:touch.view];
    UIBezierPath *currentPath = [UIBezierPath bezierPath];
    currentPath.lineCapStyle = kCGLineCapRound;
    currentPath.lineJoinStyle = kCGLineJoinRound;
    [currentPath moveToPoint:startPosition];
    [self.pathArray addObject:currentPath];
    [self setNeedsDisplay];
}

/**
 *  触摸移动方法
 */
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint currentPosition = [touch locationInView:touch.view];
    UIBezierPath *currentPath = [self.pathArray lastObject];
    [currentPath addLineToPoint:currentPosition];
    [self setNeedsDisplay];
}

/**
 *  触摸结束方法
 */
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self touchesMoved:touches withEvent:event];
}

#pragma mark - 涂鸦方法

- (void)clearPainter
{
    [self.pathArray removeAllObjects];
    [self setNeedsDisplay];
}

- (void)undoPainter
{
    [self.pathArray removeLastObject];
    [self setNeedsDisplay];
}

@end
