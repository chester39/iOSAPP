//
//	iOS培训
//		传智播客 & 黑马
//		Chen Chen @ June 24th, 2015
//

#import "CircleButton.h"

@implementation CircleButton

#pragma mark - 初始化方法

/**
 *  初始化按钮方法
 */
- (void)initializeButton
{
    self.userInteractionEnabled = NO;
    [self setBackgroundImage:[UIImage imageNamed:@"gesture_node_normal"] forState:UIControlStateNormal];
    [self setBackgroundImage:[UIImage imageNamed:@"gesture_node_highlighted"] forState:UIControlStateSelected];
}

#pragma mark - 系统方法

/**
 *  尺寸初始化方法
 */
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
        [self initializeButton];
    return self;
}

/**
 *  数据解码方法
 */
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self)
        [self initializeButton];
    return self;
}

@end
