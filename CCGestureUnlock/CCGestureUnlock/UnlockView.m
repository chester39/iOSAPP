//
//  UnlockView.m
//      CCGestureUnlock
//      Chen Chen @ June 24th, 2015
//

#import "UnlockView.h"
#import "CircleButton.h"

@interface UnlockView ()

/**
 *  选中按钮数组
 */
@property (strong, nonatomic) NSMutableArray *selectedButtonArray;
/**
 *  当前触摸点
 */
@property (nonatomic) CGPoint currentTouchPoint;

@end

@implementation UnlockView

#pragma mark - 初始化方法

/**
 *  选中按钮数组惰性初始化方法
 */
- (NSMutableArray *)selectedButtonArray
{
    if (_selectedButtonArray == nil)
        _selectedButtonArray = [NSMutableArray array];
    return _selectedButtonArray;
}

/**
 *  初始化界面方法
 */
- (void)initializeUnlock
{
    for (int i = 0; i < 9; ++i) {
        CircleButton *button = [CircleButton buttonWithType:UIButtonTypeCustom];
        button.tag = i;
        [self addSubview:button];
    }
}

#pragma mark - 系统方法

/**
 *  尺寸初始化方法
 */
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
        [self initializeUnlock];
    return self;
}

/**
 *  数据解码方法
 */
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self)
        [self initializeUnlock];
    return self;
}

/**
 *  绘制图形方法
 */
- (void)drawRect:(CGRect)rect
{
    if (self.selectedButtonArray.count == 0)
        return;
    UIBezierPath *path = [UIBezierPath bezierPath];
    [self.selectedButtonArray enumerateObjectsUsingBlock:^(CircleButton *button, NSUInteger idx, BOOL *stop) {
        if (idx == 0)
            [path moveToPoint:button.center];
        else
            [path addLineToPoint:button.center];
    }];
    if (CGPointEqualToPoint(self.currentTouchPoint, CGPointZero) == NO)
        [path addLineToPoint:self.currentTouchPoint];
    path.lineWidth = 10;
    path.lineJoinStyle = kCGLineJoinRound;
    [[UIColor colorWithRed:32 / 255.0 green:210 / 255.0 blue:254 / 255.0 alpha:0.7] set];
    [path stroke];
}

/**
 *  更新父控件尺寸方法
 */
- (void)layoutSubviews
{
    [super layoutSubviews];
    int totalColumns = 3;
    CGFloat buttonWidth =  74;
    CGFloat buttonHeight = 74;
    CGFloat margin = (self.frame.size.width - totalColumns * buttonWidth) / (totalColumns + 1);
    for (int i = 0; i < self.subviews.count; ++i) {
        UIButton *button = self.subviews[i];
        int row = i / totalColumns;
        int col = i % totalColumns;
        CGFloat buttonX = margin + col * (buttonWidth + margin);
        CGFloat buttonY = margin + row * (buttonHeight + margin);
        button.frame = CGRectMake(buttonX, buttonY, buttonWidth, buttonHeight);
    }
}

#pragma mark - 触摸方法

/**
 *  触摸开始方法
 */
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    self.currentTouchPoint = CGPointZero;
    UITouch *touch = [touches anyObject];
    CGPoint position = [touch locationInView:touch.view];
    for (UIButton *button in self.subviews) {
        if (CGRectContainsPoint(button.frame, position)) {
            if (button && button.selected == NO) {
                button.selected = YES;
                [self.selectedButtonArray addObject:button];
            }
        }
    }
    [self setNeedsDisplay];
}

/**
 *  触摸移动方法
 */
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint position = [touch locationInView:touch.view];
    for (UIButton *button in self.subviews) {
        if (CGRectContainsPoint(button.frame, position)) {
            if (button && button.selected == NO) {
                button.selected = YES;
                [self.selectedButtonArray addObject:button];
            } else
                self.currentTouchPoint = position;
        }
    }
    [self setNeedsDisplay];
}

/**
 *  触摸结束方法
 */
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    if ([self.delegate respondsToSelector:@selector(unlockView:didFinishPath:)]) {
        NSMutableString *path = [NSMutableString string];
        for (CircleButton *button in self.selectedButtonArray)
            [path appendFormat:@"%ld", button.tag];
        [self.delegate unlockView:self didFinishPath:path];
    }
    [self.selectedButtonArray makeObjectsPerformSelector:@selector(setSelected:) withObject:@(NO)];
    [self.selectedButtonArray removeAllObjects];
    [self setNeedsDisplay];
}

/**
 *  触摸取消方法
 */
- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self touchesEnded:touches withEvent:event];
}
    
@end
