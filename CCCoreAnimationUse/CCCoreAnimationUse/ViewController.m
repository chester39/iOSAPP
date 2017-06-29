//
//  ViewController.m
//      CCCoreAnimationUse
//      Chen Chen @ July 2nd, 2015
//

#import "ViewController.h"

@interface ViewController ()

/**
 *  红色视图
 */
@property (weak, nonatomic) IBOutlet UIView *redView;
/**
 *  蓝色视图
 */
@property (weak, nonatomic) IBOutlet UIView *blueView;
/**
 *  绿色视图
 */
@property (weak, nonatomic) IBOutlet UIView *greenView;
/**
 *  图片视图
 */
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
/**
 *  时钟视图
 */
@property (weak, nonatomic) IBOutlet UIImageView *clockView;
/**
 *  图片下标
 */
@property (nonatomic) int index;
/**
 *  时针图层
 */
@property (strong, nonatomic) CALayer *hour;
/**
 *  分针图层
 */
@property (strong, nonatomic) CALayer *minute;
/**
 *  秒针图层
 */
@property (strong, nonatomic) CALayer *second;

@end

@implementation ViewController

/**
 *  每小时时针角度
 */
static const int perHourAngle = 30;
/**
 *  每分钟时针角度
 */
static const int perMinuteHourAngle = 0.5;
/**
 *  每分钟分针角度
 */
static const int perMinuteAngle = 6;
/**
 *  每秒秒针角度
 */
static const int perSecondAngle = 6;

#pragma mark - 系统方法

/**
 *  视图已经加载方法
 */
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%d.jpg", self.index + 1]];
    [self addHourWithWidth:self.clockView.bounds.size.width Height:self.clockView.bounds.size.height];
    [self addMinuteWithWidth:self.clockView.bounds.size.width Height:self.clockView.bounds.size.height];
    [self addSecondWithWidth:self.clockView.bounds.size.width Height:self.clockView.bounds.size.height];
    [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(updateClock) userInfo:nil repeats:YES];
    [self updateClock];
}

#pragma mark - 触摸方法

/**
 *  触摸开始方法
 */
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self layerUse];
    NSArray *animationArray = [NSArray arrayWithObjects:[self rotateWithAnimationDuration:1.0 degree:M_PI_2 direction:1 repeatCount:MAXFLOAT], [self transformWithAnimationDuration:1.0 x:300 y:100 repeatCount:0], [self scaleWithAnimationDuration:1.0 start:1.0 end:0.5 repeatCount:0], nil];
    [self.blueView.layer addAnimation:[self groupWithAnimationDuration:1.0 animationArray:animationArray repeatCount:0] forKey:nil];
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddEllipseInRect(path, NULL, CGRectMake(100, 100, 200, 200));
    [self.greenView.layer addAnimation:[self pathWithKeyframeAnimationDuration:1.0 path:path repeatCount:0] forKey:nil];
    CGPathRelease(path);
    [self.greenView.layer addAnimation:[self shakeWithKeyframeAnimationDuration:0.2 repeatCount:MAXFLOAT] forKey:nil];
}

/**
 *  触摸结束方法
 */
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.blueView.layer removeAllAnimations];
        [self.greenView.layer removeAllAnimations];
    });
}

#pragma mark - 图层方法

/**
 *  图层使用方法
 */
- (void)layerUse
{
    self.redView.layer.borderWidth = 5;
    self.redView.layer.borderColor = [UIColor blueColor].CGColor;
    self.redView.layer.cornerRadius = 10;
    self.redView.layer.shadowColor = [UIColor blueColor].CGColor;
    self.redView.layer.shadowOffset = CGSizeMake(10, 10);
    self.redView.layer.shadowOpacity = 0.5;
    self.redView.layer.position = CGPointMake(0, 0);
    self.redView.layer.anchorPoint = CGPointMake(0, 0);
    self.redView.layer.transform = CATransform3DMakeRotation(M_PI_4, 1, 0, 1);
    [self.redView.layer setValue:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.5, 0.5, 0)] forKeyPath:@"transform"];
}

#pragma mark - 基本动画方法

/**
 *  旋转动画方法
 */
- (CABasicAnimation *)rotateWithAnimationDuration:(float)time degree:(float)degree direction:(int)direction repeatCount:(float)repeatCount
{
    CABasicAnimation *animation = [CABasicAnimation animation];
    animation.keyPath = @"transform";
    animation.duration = time;
    animation.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeRotation(degree, 0, 0, direction)];
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    animation.repeatCount = repeatCount;
    animation.delegate = self;
    return animation;
}

/**
 *  平移动画方法
 */
- (CABasicAnimation *)transformWithAnimationDuration:(float)duration x:(float)x y:(float)y repeatCount:(float)repeatCount
{
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.translation"];
    animation.duration = duration;
    animation.toValue = [NSValue valueWithCGPoint:CGPointMake(x, y)];
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    animation.repeatCount = repeatCount;
    animation.delegate = self;
    return animation;
}

/**
 *  放缩动画方法
 */
- (CABasicAnimation *)scaleWithAnimationDuration:(float)duration start:(float)start end:(float)end repeatCount:(float)repeatCount
{
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    animation.duration = duration;
    animation.fromValue = [NSNumber numberWithFloat:start];
    animation.toValue = [NSNumber numberWithFloat:end];
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    animation.repeatCount = repeatCount;
    animation.delegate = self;
    return animation;
}

#pragma mark - 帧动画方法

/**
 *  路径帧动画方法
 */
- (CAKeyframeAnimation *)pathWithKeyframeAnimationDuration:(float)duration path:(CGMutablePathRef)path repeatCount:(float)repeatCount
{
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    animation.duration = duration;
    animation.path = path;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    animation.repeatCount = repeatCount;
    animation.delegate = self;
    return animation;
}

/**
 *  抖动帧动画方法
 */
- (CAKeyframeAnimation *)shakeWithKeyframeAnimationDuration:(float)duration repeatCount:(float)repeatCount
{
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"transform.rotation"];
    animation.duration = duration;
    NSNumber *numberA = [NSNumber numberWithFloat:(-5 / 180.0 * M_PI)];
    NSNumber *numberB = [NSNumber numberWithFloat:(5 / 180.0 * M_PI)];
    NSNumber *numberC = [NSNumber numberWithFloat:(-5 / 180.0 * M_PI)];
    animation.values = @[numberA, numberB, numberC];
    animation.keyTimes = @[@(0.3), @(0.4), @(0.3)];
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    animation.repeatCount = repeatCount;
    animation.delegate = self;
    return animation;
}

#pragma mark - 过渡动画方法

/**
 *  上一张图片方法
 */
- (IBAction)previousImage
{
    self.index--;
    if (self.index == -1)
        self.index = 8;
    self.imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%d.jpg", self.index + 1]];
    CATransition *transition = [CATransition animation];
    transition.duration = 0.5;
    transition.type = @"cube";
    transition.subtype = kCATransitionFromRight;
    [self.imageView.layer addAnimation:transition forKey:nil];
}

/**
 *  下一张图片方法
 */
- (IBAction)nextImage
{
    self.index++;
    if (self.index == 9)
        self.index = 0;
    self.imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%d.jpg", self.index + 1]];
    [UIView transitionWithView:self.imageView duration:0.5 options:UIViewAnimationOptionTransitionCurlUp animations:nil completion:nil];
}

#pragma mark - 组动画方法

/**
 *  组动画方法
 */
- (CAAnimationGroup *)groupWithAnimationDuration:(float)duration animationArray:(NSArray *)animationArray repeatCount:(float)repeatCount
{
    CAAnimationGroup *animation = [CAAnimationGroup animation];
    animation.duration = duration;
    animation.animations = animationArray;
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    animation.repeatCount = repeatCount;
    animation.delegate = self;
    return animation;
}

#pragma mark - 时钟方法

/**
 *  添加时针方法
 */
- (void)addHourWithWidth:(CGFloat)width Height:(CGFloat)height
{
    CALayer *hour = [CALayer layer];
    hour.anchorPoint = CGPointMake(0.5, 1);
    hour.position = CGPointMake(width / 2, height / 2);
    hour.bounds = CGRectMake(0, 0, 3, height / 2 - 25);
    hour.backgroundColor = [UIColor blackColor].CGColor;
    hour.cornerRadius = 3;
    [self.clockView.layer addSublayer:hour];
    self.hour = hour;
}

/**
 *  添加分针方法
 */
- (void)addMinuteWithWidth:(CGFloat)width Height:(CGFloat)height
{
    CALayer *minute = [CALayer layer];
    minute.anchorPoint = CGPointMake(0.5, 1);
    minute.position = CGPointMake(width / 2, height / 2);
    minute.bounds = CGRectMake(0, 0, 2, height / 2 - 15);
    minute.backgroundColor = [UIColor darkGrayColor].CGColor;
    minute.cornerRadius = 3;
    [self.clockView.layer addSublayer:minute];
    self.minute = minute;
}

/**
 *  添加秒针方法
 */
- (void)addSecondWithWidth:(CGFloat)width Height:(CGFloat)height
{
    CALayer *second = [CALayer layer];
    second.anchorPoint = CGPointMake(0.5, 1);
    second.position = CGPointMake(width / 2, height / 2);
    second.bounds = CGRectMake(0, 0, 1, height / 2 - 15);
    second.backgroundColor = [UIColor redColor].CGColor;
    second.cornerRadius = 3;
    [self.clockView.layer addSublayer:second];
    self.second = second;
}

/**
 *  更新时钟方法
 */
- (void)updateClock
{
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond fromDate:[NSDate date]];
    NSInteger hour = components.hour;
    NSInteger minute = components.minute;
    NSInteger second = components.second;
    CGFloat hourAngle = hour * perHourAngle;
    CGFloat minuteAngle = minute * perMinuteAngle;
    CGFloat secondAngle = second * perSecondAngle;
    hourAngle += minute * perMinuteHourAngle;
    self.hour.transform = CATransform3DMakeRotation((hourAngle / 180.0 * M_PI), 0, 0, 1);
    self.minute.transform = CATransform3DMakeRotation((minuteAngle / 180.0 * M_PI), 0, 0, 1);
    self.second.transform = CATransform3DMakeRotation((secondAngle / 180.0 * M_PI), 0, 0, 1);
}

#pragma mark - CAAnimationDelegate代理方法

/**
 *  动画已经开始方法
 */
- (void)animationDidStart:(CAAnimation *)anim
{
    NSLog(@"%@ %s", anim.class, __func__);
}

/**
 *  动画已经结束方法
 */
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    NSLog(@"%@ %s", anim.class, __func__);
}

@end
