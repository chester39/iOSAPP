//
//	iOS培训
//		传智播客 & 黑马
//		Chen Chen @ June 2nd, 2015
//

#import "WeiboModel.h"
#import "NSString+CC.h"

/**
 *  WeiboCell内填充
 */
static const CGFloat padding = 10.0;
/**
 *  WeiboCell外边界
 */
static const CGFloat margin = 50.0;
/**
 *  微博内容字体
 */
static const CGFloat textFont = 16.0;

@implementation WeiboModel

/**
 *  自动合成WeiboCell高度
 */
@synthesize cellHeight = _cellHeight;

/**
 *  字典转模型实例方法
 */
- (instancetype)initWithDict:(NSDictionary *)dict
{
    self = [super init];
    if (self)
        [self setValuesForKeysWithDictionary:dict];
    return self;
}

/**
 *  字典转模型类方法
 */
+ (instancetype)weiboModelWithDict:(NSDictionary *)dict
{
    return [[self alloc] initWithDict:dict];
}

/**
 *  重写WeiboCell高度getter方法
 */
- (CGFloat)cellHeight
{
    if (!_cellHeight) {
        CGFloat textWidth = [UIScreen mainScreen].bounds.size.width - 2 * padding;
        CGFloat textHeight = [self.text textSizeWithFont:[UIFont systemFontOfSize:textFont] maxSize:CGSizeMake(textWidth, MAXFLOAT)].height;
        _cellHeight = textHeight + padding + margin;
        if (self.picture.length) {
            CGFloat imageWidth = 100;
            CGFloat imageHeight = 100;
            _pictureFrame = CGRectMake(padding, _cellHeight, imageWidth, imageHeight);
            _cellHeight += imageHeight + padding * 2;
        }
    }
    return _cellHeight;
}

@end
