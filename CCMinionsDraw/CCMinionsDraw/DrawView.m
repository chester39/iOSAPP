//
//	iOS培训
//		传智播客 & 黑马
//		Chen Chen @ June 17th, 2015
//

#import "DrawView.h"

@implementation DrawView

/**
 *  身体宽度
 */
static const CGFloat bodyWidth = 150;
/**
 *  头顶圆心x值
 */
static const CGFloat topCenterX = 187.5;
/**
 *  头顶圆心y值
 */
static const CGFloat topCenterY = 150;
/**
 *  头顶圆半径
 */
static const CGFloat topRadius = bodyWidth / 2;

#pragma mark - 系统方法

/**
 *  绘制图形方法
 */
- (void)drawRect:(CGRect)rect
{
    CGContextRef crMinions = UIGraphicsGetCurrentContext();
    drawBody(crMinions);
    drawEyes(crMinions);
    drawMouse(crMinions);
    drawHair(crMinions);
}

#pragma mark - 绘制方法

/**
 *  绘制身体方法
 */
void drawBody(CGContextRef cr)
{
    CGContextAddArc(cr, topCenterX, topCenterY, topRadius, 0, M_PI, 1);
    CGFloat middleX = topCenterX - topRadius;
    CGFloat middleHeight = 100;
    CGContextAddLineToPoint(cr, middleX, middleHeight);
    CGFloat bottomCenterX = topCenterX;
    CGFloat bottomCenterY = topCenterY + middleHeight;
    CGFloat bottomRadius = topRadius;
    CGContextAddArc(cr, bottomCenterX, bottomCenterY, bottomRadius, M_PI, 0, 1);
    [[UIColor colorWithRed:252 / 255.0 green:221 / 255.0 blue:12 / 255.0 alpha:1.0] set];
    CGContextFillPath(cr);
}

/**
 *  绘制眼睛方法
 */
void drawEyes(CGContextRef cr)
{
    [[UIColor blackColor] set];
    CGFloat margin = 2;
    CGFloat padding = 10;
    CGFloat bagdeX = topCenterX - topRadius - margin;
    CGFloat bagdeY = topCenterY - padding;
    CGFloat bagdeWidth = bodyWidth + margin * 2;
    CGFloat bagdeHeight = 15;
    CGContextAddRect(cr, CGRectMake(bagdeX, bagdeY, bagdeWidth, bagdeHeight));
    CGContextFillPath(cr);
    [[UIColor colorWithRed:79 / 255.0 green:78 / 255.0 blue:83 / 255.0 alpha:1.0] set];
    CGFloat eyeWidth = bodyWidth * 0.23;
    CGFloat leftEyeX = topCenterX - topRadius + eyeWidth + padding;
    CGFloat leftEyeY = bagdeY + bagdeHeight / 2;
    CGContextAddArc(cr, leftEyeX, leftEyeY, eyeWidth, 0, M_PI * 2, 0);
    CGFloat rightEyeX = topCenterX + topRadius - eyeWidth - padding;
    CGFloat rightEyeY = leftEyeY;
    CGContextAddArc(cr, rightEyeX, rightEyeY, eyeWidth, 0, M_PI * 2, 0);
    CGContextFillPath(cr);
    [[UIColor whiteColor] set];
    CGFloat innerEyeWidth = bodyWidth * 0.16;
    CGContextAddArc(cr, leftEyeX, leftEyeY, innerEyeWidth, 0, M_PI * 2, 0);
    CGContextAddArc(cr, rightEyeX, rightEyeY, innerEyeWidth, 0, M_PI * 2, 0);
    CGContextFillPath(cr);
    [[UIColor colorWithRed:99 / 255.0 green:29 / 255.0 blue:10 / 255.0 alpha:1.0] set];
    CGFloat leftInnerEyeX = leftEyeX + padding;
    CGFloat rightInnerEyeX = rightEyeX - padding;
    CGContextAddArc(cr, leftInnerEyeX, leftEyeY, padding, 0, M_PI * 2, 0);
    CGContextAddArc(cr, rightInnerEyeX, rightEyeY, padding, 0, M_PI * 2, 0);
    CGContextFillPath(cr);
    [[UIColor blackColor] set];
    CGContextAddArc(cr, leftInnerEyeX, leftEyeY, padding / 2, 0, M_PI * 2, 0);
    CGContextAddArc(cr, rightInnerEyeX, rightEyeY, padding / 2, 0, M_PI * 2, 0);
    CGContextFillPath(cr);
    [[UIColor whiteColor] set];
    CGContextAddArc(cr, leftInnerEyeX - margin, leftEyeY - margin, padding / 4, 0, M_PI * 2, 0);
    CGContextAddArc(cr, rightInnerEyeX - margin, rightEyeY - margin, padding / 4, 0, M_PI * 2, 0);
    CGContextFillPath(cr);
}

/**
 *  绘制嘴巴方法
 */
void drawMouse(CGContextRef cr)
{
    CGFloat controlX = topCenterX;
    CGFloat controlY = topCenterY + 70;
    CGFloat marginX = 30;
    CGFloat marginY = 15;
    CGFloat currentX = controlX - marginX;
    CGFloat currentY = controlY - marginY;
    CGContextMoveToPoint(cr, currentX, currentY);
    CGFloat endX = controlX + marginX;
    CGFloat endY = currentY;
    CGContextAddQuadCurveToPoint(cr, controlX, controlY, endX, endY);
    [[UIColor blackColor] set];
    CGContextStrokePath(cr);
}

/**
 *  绘制头发方法
 */
void drawHair(CGContextRef cr)
{
    CGFloat marginX = 5;
    CGFloat marginY = 30;
    CGContextMoveToPoint(cr, topCenterX, topCenterY - topRadius + marginX);
    CGContextAddLineToPoint(cr, topCenterX, topCenterX - topRadius - marginY);
    CGContextMoveToPoint(cr, topCenterX - 10, topCenterY - topRadius + marginX);
    CGContextAddLineToPoint(cr, topCenterX - 20, topCenterX - topRadius - marginY);
    CGContextMoveToPoint(cr, topCenterX + 10, topCenterY - topRadius + marginX);
    CGContextAddLineToPoint(cr, topCenterX + 20, topCenterX - topRadius - marginY);
    CGContextMoveToPoint(cr, topCenterX - 20, topCenterY - topRadius + marginX * 1.5);
    CGContextAddLineToPoint(cr, topCenterX - 30, topCenterX - topRadius - marginY);
    CGContextMoveToPoint(cr, topCenterX + 20, topCenterY - topRadius + marginX * 1.5);
    CGContextAddLineToPoint(cr, topCenterX + 30, topCenterX - topRadius - marginY);
    CGContextStrokePath(cr);
}

@end
