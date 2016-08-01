//
//	iOS培训
//		传智播客 & 黑马
//		Chen Chen @ June 3rd, 2015
//

#import "UIImage+CC.h"

@implementation UIImage (CC)

+ (UIImage *)resizableImage:(NSString *)name scale:(CGFloat)scale
{
    UIImage *normal = [UIImage imageNamed:name];
    CGFloat width = normal.size.width * scale;
    CGFloat height = normal.size.height * scale;
    return [normal resizableImageWithCapInsets:UIEdgeInsetsMake(height, width, height, width)];
}

@end
