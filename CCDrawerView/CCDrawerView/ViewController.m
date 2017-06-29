//
//  ViewController.m
//      CCDrawerView
//      Chen Chen @ July 6th, 2015
//

#import "ViewController.h"

@interface ViewController ()

/**
 *  主视图
 */
@property (weak, nonatomic, readonly) UIView *mainView;
/**
 *  左视图
 */
@property (weak, nonatomic, readonly) UIView *leftView;
/**
 *  右视图
 */
@property (weak, nonatomic, readonly) UIView *rightView;
/**
 *  是否拉拽
 */
@property (nonatomic) BOOL isDragging;

@end

@implementation ViewController

#pragma mark - 系统方法

/**
 *  视图已经加载方法
 */
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self addDrawerView];
    [_mainView addObserver:self forKeyPath:@"frame" options:NSKeyValueObservingOptionNew context:nil];
}

#pragma mark - 视图方法

/**
 *  增加抽屉视图方法
 */
- (void)addDrawerView
{
    UIView *leftView = [[UIView alloc] initWithFrame:self.view.bounds];
    leftView.backgroundColor = [UIColor redColor];
    [self.view addSubview:leftView];
    _leftView = leftView;
    UIView *rightView = [[UIView alloc] initWithFrame:self.view.bounds];
    rightView.backgroundColor = [UIColor greenColor];
    [self.view addSubview:rightView];
    _rightView = rightView;
    UIView *mainView = [[UIView alloc] initWithFrame:self.view.bounds];
    mainView.backgroundColor = [UIColor blueColor];
    [self.view addSubview:mainView];
    _mainView = mainView;
}

/**
 *  偏移量获取尺寸方法
 */
- (CGRect)getFrameWithOffsetX:(CGFloat)offsetX
{
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    CGFloat screenHeight = [UIScreen mainScreen].bounds.size.height;
    CGFloat drawerMaxY = 60;
    CGFloat offsetY = offsetX * drawerMaxY / screenWidth;
    CGFloat scale = (screenHeight - 2 * offsetY) / screenHeight;
    if (_mainView.frame.origin.x < 0)
        scale = (screenHeight + 2 * offsetY) / screenHeight;
    CGRect frame = _mainView.frame;
    frame.origin.x += offsetX;
    frame.origin.y = (screenHeight - frame.size.height) / 2;
    frame.size.width = frame.size.width * scale;
    frame.size.height = frame.size.height * scale;
    return frame;
}

#pragma mark - 触摸方法

/**
 *  触摸移动方法
 */
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint currentPoint = [touch locationInView:self.view];
    CGPoint previousPoint = [touch previousLocationInView:self.view];
    CGFloat offsetX = currentPoint.x - previousPoint.x;
    _mainView.frame = [self getFrameWithOffsetX:offsetX];
    self.isDragging = YES;
}

/**
 *  触摸结束方法
 */
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (_mainView.frame.origin.x != 0 && self.isDragging == NO) {
        [UIView animateWithDuration:0.25 animations:^{
            _mainView.frame = self.view.bounds;
        }];
    }
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    CGFloat target = 0;
    CGFloat leftTarget = -220;
    CGFloat rightTarget = 250;
    if (_mainView.frame.origin.x > screenWidth / 2)
        target = rightTarget;
    else if (CGRectGetMaxX(_mainView.frame) < screenWidth / 2)
        target = leftTarget;
    [UIView animateWithDuration:0.25 animations:^{
        if (target) {
            CGFloat offsetX = target - _mainView.frame.origin.x;
            _mainView.frame = [self getFrameWithOffsetX:offsetX];
        } else
            _mainView.frame = self.view.bounds;
    }];
    self.isDragging = NO;
}

#pragma mark - 观察者方法

/**
 *  观察者响应方法
 */
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if (_mainView.frame.origin.x < 0) {
        _leftView.hidden = YES;
        _rightView.hidden = NO;
    } else if (_mainView.frame.origin.x > 0) {
        _rightView.hidden = YES;
        _leftView.hidden = NO;
    }
}

@end
