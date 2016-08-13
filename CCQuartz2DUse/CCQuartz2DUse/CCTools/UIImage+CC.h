//
//	iOS培训
//		传智播客 & 黑马
//		Chen Chen @ June 20th, 2015
//

#import <UIKit/UIKit.h>

@interface UIImage (CC)

/**
 *  自定义切割图片方法
 */
+ (UIImage *)resizableImage:(NSString *)name scale:(CGFloat)scale;
/**
 *  自定义添加图片水印方法
 */
+ (instancetype)watermarkWithImage:(NSString *)name watermark:(NSString *)watermark scale:(CGFloat)scale;
/**
 *  自定义裁剪图片方法
 */
+ (instancetype)clipCircleWithImage:(NSString *)name borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor;
/**
 *  自定义截图方法
 */
+ (instancetype)captureWithView:(UIView *)view;
/**
 *  自定义条纹背景方法
 */
+ (instancetype)stripeBackgroundWithView:(UIView *)view rowHeight:(CGFloat)rowHeight rowColor:(UIColor *)rowColor lineWidth:(CGFloat)lineWidth lineColor:(UIColor *)lineColor;

@end
