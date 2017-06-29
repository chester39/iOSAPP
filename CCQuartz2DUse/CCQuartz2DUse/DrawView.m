//
//  DrawView.m
//      CCQuartz2DUse
//      Chen Chen @ June 17th, 2015
//

#import "DrawView.h"

@implementation DrawView

#pragma mark - 初始化方法

/**
 *  重写圆半径的setter方法
 */
- (void)setCircleRadius:(CGFloat)circleRadius
{
    _circleRadius = circleRadius;
    [self setNeedsDisplay];
}

#pragma mark - 系统方法

/**
 *  绘制图形方法
 */
- (void)drawRect:(CGRect)rect
{
    drawQuartzLine();
    drawQuartzTriangle();
    drawQuartzRect();
    drawQuartzArc();
    drawQuartzCircle();
    [self drawSliderCircle];
    [self drawAnimation:rect];
    drawQuartzText();
    drawQuartzImage();
}

/**
 *  xib唤醒方法
 */
- (void)awakeFromNib
{
    CADisplayLink *link = [CADisplayLink displayLinkWithTarget:self selector:@selector(setNeedsDisplay)];
    [link addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
}

#pragma mark - 绘制图形方法

/**
 *  绘制线方法
 */
void drawQuartzLine()
{
    CGContextRef crLine = UIGraphicsGetCurrentContext();
    CGContextSaveGState(crLine);
    CGContextSetLineWidth(crLine, 10);
    CGContextSetLineCap(crLine, kCGLineCapRound);
    CGContextSetLineJoin(crLine, kCGLineJoinRound);
    CGContextSetRGBStrokeColor(crLine, 0 / 255, 0 / 255, 255 / 255, 1);
    CGContextMoveToPoint(crLine, 10, 20);
    CGContextAddLineToPoint(crLine, 10, 70);
    CGContextAddLineToPoint(crLine, 100, 100);
    CGContextStrokePath(crLine);
    CGContextRestoreGState(crLine);
    CGMutablePathRef mprLine = CGPathCreateMutable();
    CGPathMoveToPoint(mprLine, NULL, 50, 50);
    CGPathAddLineToPoint(mprLine, NULL, 70, 150);
    CGContextAddPath(crLine, mprLine);
    CGContextStrokePath(crLine);
    CGPathRelease(mprLine);
}

/**
 *  绘制三角形方法
 */
void drawQuartzTriangle()
{
    CGContextRef crTriangle = UIGraphicsGetCurrentContext();
    CGContextSaveGState(crTriangle);
    CGContextRotateCTM(crTriangle, M_PI_4 * 0.3);
    CGContextMoveToPoint(crTriangle, 150, 150);
    CGContextAddLineToPoint(crTriangle, 200, 170);
    CGContextAddLineToPoint(crTriangle, 170, 200);
    CGContextClosePath(crTriangle);
    CGContextSetRGBFillColor(crTriangle, 0 / 255, 255 / 255, 0 / 255, 1);
    CGContextFillPath(crTriangle);
    CGContextRestoreGState(crTriangle);
}

/**
 *  绘制矩形方法
 */
void drawQuartzRect()
{
    CGContextRef crRect = UIGraphicsGetCurrentContext();
    CGContextSaveGState(crRect);
    CGContextScaleCTM(crRect, 0.7, 0.7);
    CGContextAddRect(crRect, CGRectMake(200, 200, 50, 50));
    [[UIColor cyanColor] setStroke];
    CGContextStrokePath(crRect);
    CGContextRestoreGState(crRect);
}

/**
 *  绘制圆弧方法
 */
void drawQuartzArc()
{
    CGContextRef crArc = UIGraphicsGetCurrentContext();
    CGContextSaveGState(crArc);
    CGContextTranslateCTM(crArc, 0, 200);
    CGContextAddArc(crArc, 300, 300, 50, M_PI_4, M_PI, 0);
    [[UIColor purpleColor] setFill];
    CGContextFillPath(crArc);
    CGContextRestoreGState(crArc);
}

/**
 *  绘制圆方法
 */
void drawQuartzCircle()
{
    CGContextRef crCircle = UIGraphicsGetCurrentContext();
    CGContextAddEllipseInRect(crCircle, CGRectMake(130, 270, 100, 100));
    [[UIColor blackColor] set];
    CGContextDrawPath(crCircle, kCGPathEOFill);
}

#pragma mark - 绘制其他方法

/**
 *  绘制文字方法
 */
void drawQuartzText()
{
    CGContextRef crText = UIGraphicsGetCurrentContext();
    CGRect textRect = CGRectMake(200, 400, 100, 50);
    CGContextSetLineWidth(crText, 1);
    CGContextAddRect(crText, textRect);
    CGContextStrokePath(crText);
    NSString *str = @"我是Chester Chen，哈哈！";
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = [UIFont systemFontOfSize:15];
    attrs[NSBackgroundColorAttributeName] = [UIColor whiteColor];
    [str drawInRect:textRect withAttributes:attrs];
}

/**
 *  绘制图片方法
 */
void drawQuartzImage()
{
    UIImage *image = [UIImage imageNamed:@"icon_11"];
    [image drawAsPatternInRect:CGRectMake(0, 400, 150, 150)];
}

#pragma mark - 特殊绘制方法

/**
 *  滑动条调整圆方法
 */
- (void)drawSliderCircle
{
    CGContextRef crSlider = UIGraphicsGetCurrentContext();
    CGContextAddArc(crSlider, 250, 100, self.circleRadius, 0, M_PI * 2, 0);
    CGContextFillPath(crSlider);
}

/**
 *  绘制动画方法
 */
- (void)drawAnimation:(CGRect)rect
{
    self.imageY += 5;
    if (self.imageY >= rect.size.height)
        self.imageY = -100;
    UIImage *image = [UIImage imageNamed:@"icon_11"];
    [image drawAtPoint:CGPointMake(300, self.imageY)];
}

@end
