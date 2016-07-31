//
//	iOS培训
//		传智播客 & 黑马
//		Chen Chen @ June 2nd, 2015
//

#import "NSString+CC.h"

@implementation NSString (CC)

- (CGSize)textSizeWithFont:(UIFont *)font maxSize:(CGSize)maxSize
{
    NSDictionary *attributes = @{NSFontAttributeName: font};
    return [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
}

@end
