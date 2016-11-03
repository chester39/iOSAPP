//
//	ViewController.m
//		CCButtonUse
//		Chen Chen @ Apirl 13th, 2015
//

#import "ViewController.h"

/// 按钮功能枚举数组
typedef NS_ENUM(NSInteger, kButtonType) {
    /// 上移按钮
    kButtonTypeTop = 10,
    /// 下移按钮
    kButtonTypeBottom,
    /// 左移按钮
    kButtonTypeLeft,
    /// 右移按钮
    kButtonTypeRight,
    /// 左转按钮
    kButtonTypeLeftRotate,
    /// 右转按钮
    kButtonTypeRightRotate,
    /// 放大按钮
    kButtonTypePlus,
    /// 缩小按钮
    kButtonTypeMinus,
};

/// 移动量
static const CGFloat kMovingDistance = 10.0;

@interface ViewController ()

/// 头像照片
@property (weak, nonatomic) IBOutlet UIButton *imageButton;

@end

@implementation ViewController

#pragma mark - 系统方法

/**
 *  视图已经加载方法
 */
- (void)viewDidLoad {
    
    [super viewDidLoad];
}

#pragma mark - 图片变化方法

/**
 *  移动图片方法
 */
- (IBAction)moveButtonDidClick:(UIButton *)button {
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:1.0];
    
    CGRect tempFrame = self.imageButton.frame;
    switch (button.tag) {
        case kButtonTypeTop:
            tempFrame.origin.y -= kMovingDistance;
            break;
            
        case kButtonTypeBottom:
            tempFrame.origin.y += kMovingDistance;
            break;
            
        case kButtonTypeLeft:
            tempFrame.origin.x -= kMovingDistance;
            break;
            
        case kButtonTypeRight:
            tempFrame.origin.x += kMovingDistance;
            break;
    }
    
    self.imageButton.frame = tempFrame;
    [UIView commitAnimations];
}

/**
 *  旋转图片方法
 */
- (IBAction)rotateButtonDidClick:(UIButton *)button {
    

    [UIView animateWithDuration:2.0 animations:^{
        switch (button.tag) {
            case kButtonTypeLeftRotate:
                self.imageButton.transform = CGAffineTransformRotate(self.imageButton.transform, -M_PI_4);
                break;
                
            case kButtonTypeRightRotate:
                self.imageButton.transform = CGAffineTransformRotate(self.imageButton.transform, M_PI_4);
                break;
        }
    }];
}

/**
 *  放缩图片方法
 */
- (IBAction)scalingButtonDidClick:(UIButton *)button {
    
    [UIView animateWithDuration:1.0 animations:^{
        switch (button.tag) {
            case kButtonTypePlus:
                self.imageButton.transform = CGAffineTransformScale(self.imageButton.transform, 1.2, 1.2);
                break;
                
            case kButtonTypeMinus:
                self.imageButton.transform = CGAffineTransformScale(self.imageButton.transform, 0.8, 0.8);
                break;
        }
    } completion:^(BOOL finished) {
        NSLog(@"%d", finished);
    }];
}

@end
