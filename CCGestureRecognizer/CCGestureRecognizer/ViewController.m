//
//  ViewController.m
//      CCGestureRecognizer
//      Chen Chen @ June 28th, 2015
//

#import "ViewController.h"

@interface ViewController () <UIGestureRecognizerDelegate>

/**
 *  图片视图
 */
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation ViewController

#pragma mark - 系统方法

/**
 *  视图已经加载方法
 */
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self tapGesture];
    [self longPressGesture];
    [self swipeGesture];
    [self pinchGesture];
    [self rotationGesture];
    [self panGesture];
}

#pragma mark - 手势方法

/**
 *  点按手势方法
 */
- (void)tapGesture
{
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] init];
    tap.numberOfTapsRequired = 2;
    tap.numberOfTouchesRequired = 2;
    tap.delegate = self;
    [tap addTarget:self action:@selector(gestureRecognizerImageView:)];
    [self.imageView addGestureRecognizer:tap];
}

/**
 *  长按手势方法
 */
- (void)longPressGesture
{
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] init];
    longPress.minimumPressDuration = 1;
    longPress.allowableMovement = 50;
    longPress.delegate = self;
    [longPress addTarget:self action:@selector(gestureRecognizerImageView:)];
    [self.imageView addGestureRecognizer:longPress];
}

/**
 *  滑动手势方法
 */
- (void)swipeGesture
{
    UISwipeGestureRecognizer *swipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(gestureRecognizerImageView:)];
    swipe.direction = UISwipeGestureRecognizerDirectionUp;
    swipe.delegate = self;
    [self.imageView addGestureRecognizer:swipe];
}

/**
 *  捏合手势方法
 */
- (void)pinchGesture
{
    UIPinchGestureRecognizer *pinch = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(pinchImageView:)];
    pinch.delegate = self;
    [self.imageView addGestureRecognizer:pinch];
}

/**
 *  旋转手势方法
 */
- (void)rotationGesture
{
    UIRotationGestureRecognizer *rotation = [[UIRotationGestureRecognizer alloc] initWithTarget:self action:@selector(rotationImageView:)];
    rotation.delegate = self;
    [self.imageView addGestureRecognizer:rotation];
}

/**
 *  拖拽手势方法
 */
- (void)panGesture
{
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panImageView:)];
    pan.delegate = self;
    [self.imageView addGestureRecognizer:pan];
}

#pragma mark - 图片方法

/**
 *  手势图片方法
 */
- (void)gestureRecognizerImageView:(UIGestureRecognizer *)gestureRecognizer
{
    switch (gestureRecognizer.state) {
        case UIGestureRecognizerStatePossible:
        case UIGestureRecognizerStateBegan:
        case UIGestureRecognizerStateChanged:
        case UIGestureRecognizerStateEnded:
        case UIGestureRecognizerStateCancelled:
        case UIGestureRecognizerStateFailed:
            NSLog(@"%@ %@", [gestureRecognizer class], NSStringFromCGPoint([gestureRecognizer locationInView:gestureRecognizer.view]));
            break;
    }
}

/**
 *  捏合图片方法
 */
- (void)pinchImageView:(UIPinchGestureRecognizer *)pinchGesture
{
    pinchGesture.view.transform = CGAffineTransformScale(pinchGesture.view.transform, pinchGesture.scale, pinchGesture.scale);
    pinchGesture.scale = 1;
    NSLog(@"%@ %@", [pinchGesture class], NSStringFromCGPoint([pinchGesture locationInView:pinchGesture.view]));
}

/**
 *  旋转图片方法
 */
- (void)rotationImageView:(UIRotationGestureRecognizer *)rotationGesture
{
    rotationGesture.view.transform = CGAffineTransformRotate(rotationGesture.view.transform, rotationGesture.rotation);
    rotationGesture.rotation = 0;
    NSLog(@"%@ %@", [rotationGesture class], NSStringFromCGPoint([rotationGesture locationInView:rotationGesture.view]));
}

/**
 *  拖拽图片方法
 */
- (void)panImageView:(UIPanGestureRecognizer *)panGesture
{
    CGPoint translation = [panGesture translationInView:panGesture.view];
    panGesture.view.transform = CGAffineTransformTranslate(panGesture.view.transform, translation.x, translation.y);
    [panGesture setTranslation:CGPointZero inView:panGesture.view];
    NSLog(@"%@ %@", [panGesture class], NSStringFromCGPoint([panGesture locationInView:panGesture.view]));
}

#pragma mark - UIGestureRecognizerDelegate代理方法

/**
 *  是否允许触摸方法
 */
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    CGPoint position = [touch locationInView:touch.view];
    if (position.x >= self.imageView.frame.size.width / 3)
        return YES;
    return NO;
}

/**
 *  是否同时接收手势方法
 */
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return YES;
}

@end
