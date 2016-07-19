//
//	iOS培训
//		传智播客 & 黑马
//		Chen Chen @ Apirl 13th, 2015
//

#import "ViewController.h"

/**
 *  按钮功能枚举数组
 */
typedef NS_ENUM(NSInteger, CCButtonType) {
    /**
     *  上移按钮
     */
    CCButtonTypeUp = 10,
    /**
     *  下移按钮
     */
    CCButtonTypeBottom,
    /**
     *  左移按钮
     */
    CCButtonTypeLeft,
    /**
     *  右移按钮
     */
    CCButtonTypeRight,
    /**
     *  放大按钮
     */
    CCButtonTypeBig,
    /**
     *  缩小按钮
     */
    CCButtonTypeSmall,
    /**
     *  左转按钮
     */
    CCButtonTypeTurnLeft,
    /**
     *  右转按钮
     */
    CCButtonTypeTurnRight,
};

/**
 *  移动量
 */
static const CGFloat CCMovingDelta = 10.0;

@interface ViewController ()

/**
 *  头像图片
 */
@property (weak, nonatomic) IBOutlet UIButton *buttonImage;

@end

@implementation ViewController

#pragma mark - 系统方法

/**
 *  视图已经加载方法
 */
- (void)viewDidLoad
{
    [super viewDidLoad];
}

#pragma mark - 图片变化方法

/**
 *  移动图片方法
 */
- (IBAction)moveImage:(UIButton *)sender
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:2.0];
    CGRect tempFrame = self.buttonImage.frame;
    switch (sender.tag) {
        case CCButtonTypeUp:
            tempFrame.origin.y -= CCMovingDelta;
            break;
        case CCButtonTypeBottom:
            tempFrame.origin.y += CCMovingDelta;
            break;
        case CCButtonTypeLeft:
            tempFrame.origin.x -= CCMovingDelta;
            break;
        case CCButtonTypeRight:
            tempFrame.origin.x += CCMovingDelta;
            break;
    }
    self.buttonImage.frame = tempFrame;
    [UIView commitAnimations];
}

/**
 *  放缩图片方法
 */
- (IBAction)changeImage:(UIButton *)sender
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:1.0];
    CGRect tempBounds = self.buttonImage.bounds;
    switch (sender.tag) {
        case CCButtonTypeBig:
            tempBounds.size.width += CCMovingDelta;
            tempBounds.size.height += CCMovingDelta;
            break;
        case CCButtonTypeSmall:
            tempBounds.size.width -= CCMovingDelta;
            tempBounds.size.height -= CCMovingDelta;
            break;
    }
    self.buttonImage.bounds = tempBounds;
    [UIView commitAnimations];
}

/**
 *  旋转图片方法
 */
- (IBAction)rotateImage:(UIButton *)sender
{
    switch (sender.tag) {
        case CCButtonTypeTurnLeft:
            self.buttonImage.transform = CGAffineTransformRotate(self.buttonImage.transform, -M_PI_4);
            break;
        case CCButtonTypeTurnRight:
            self.buttonImage.transform = CGAffineTransformRotate(self.buttonImage.transform, M_PI_4);
            break;
    }
}

@end