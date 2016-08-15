//
//	iOS培训
//		传智播客 & 黑马
//		Chen Chen @ June 23rd, 2015
//

#import "UIImage+CC.h"

@implementation UIImage (CC)

#pragma mark - 修改图片方法

+ (UIImage *)resizableImage:(NSString *)name scale:(CGFloat)scale
{
    UIImage *normal = [UIImage imageNamed:name];
    CGFloat width = normal.size.width * scale;
    CGFloat height = normal.size.height * scale;
    return [normal resizableImageWithCapInsets:UIEdgeInsetsMake(height, width, height, width)];
}

#pragma mark - Quartz2D图片方法

+ (instancetype)watermarkWithImage:(NSString *)name watermark:(NSString *)watermark scale:(CGFloat)scale
{
    UIImage *backgroundImage = [UIImage imageNamed:name];
    UIGraphicsBeginImageContextWithOptions(backgroundImage.size, NO, 0.0);
    [backgroundImage drawInRect:CGRectMake(0, 0, backgroundImage.size.width, backgroundImage.size.height)];
    UIImage *watermarkImage = [UIImage imageNamed:watermark];
    CGFloat margin = 5;
    CGFloat watermarkWidth = watermarkImage.size.width * scale;
    CGFloat watermarkHeight = watermarkImage.size.height * scale;
    CGFloat watermarkX = watermarkImage.size.width - watermarkWidth - margin;
    CGFloat watermarkY = watermarkImage.size.height - watermarkHeight - margin;
    [watermarkImage drawInRect:CGRectMake(watermarkX, watermarkY, watermarkWidth, watermarkHeight)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

+ (instancetype)clipCircleWithImage:(NSString *)name borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor
{
    UIImage *originImage = [UIImage imageNamed:name];
    CGFloat originWidth = originImage.size.width + borderWidth * 2;
    CGFloat originHeight = originImage.size.height + borderWidth * 2;
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(originWidth, originHeight), NO, 0.0);
    CGContextRef cr = UIGraphicsGetCurrentContext();
    [borderColor set];
    CGFloat bigRadius = originWidth * 0.5;
    CGFloat centerX = bigRadius;
    CGFloat centerY = bigRadius;
    CGContextAddArc(cr, centerX, centerY, bigRadius, 0, M_PI * 2, 0);
    CGContextFillPath(cr);
    CGFloat smallRadius = bigRadius - borderWidth;
    CGContextAddArc(cr, centerX, centerY, smallRadius, 0, M_PI * 2, 0);
    CGContextClip(cr);
    [originImage drawInRect:CGRectMake(borderWidth, borderWidth, originImage.size.width, originImage.size.height)];
    UIImage *clipImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return clipImage;
}

+ (instancetype)captureWithView:(UIView *)view
{
    UIGraphicsBeginImageContextWithOptions(view.frame.size, NO, 0.0);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *captureImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return captureImage;
}

+ (instancetype)stripeBackgroundWithView:(UIView *)view rowHeight:(CGFloat)rowHeight rowColor:(UIColor *)rowColor lineWidth:(CGFloat)lineWidth lineColor:(UIColor *)lineColor
{
    CGFloat rowWidth = view.frame.size.width;
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(rowWidth, rowHeight), NO, 0.0);
    CGContextRef cr = UIGraphicsGetCurrentContext();
    [rowColor set];
    CGContextAddRect(cr, CGRectMake(0, 0, rowWidth, rowHeight));
    CGContextFillPath(cr);
    [lineColor set];
    CGContextSetLineWidth(cr, lineWidth);
    CGFloat dividerX = 0;
    CGFloat dividerY = rowHeight - lineWidth;
    CGContextMoveToPoint(cr, dividerX, dividerY);
    CGContextAddLineToPoint(cr, rowWidth - dividerX, dividerY);
    CGContextStrokePath(cr);
    UIImage *stripeImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return stripeImage;
}

@end
