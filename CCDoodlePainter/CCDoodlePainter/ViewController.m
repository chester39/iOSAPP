//
//	iOS培训
//		传智播客 & 黑马
//		Chen Chen @ June 23rd, 2015
//

#import "ViewController.h"
#import "DoodleView.h"
#import "UIImage+CC.h"
#import "MBProgressHUD+MJ.h"

/**
 *  颜色按钮枚举数组
 */
typedef enum {
    /**
     *  红色按钮
     */
    CCColorRed = 10,
    /**
     *  绿色按钮
     */
    CCColorGreen,
    /**
     *  蓝色按钮
     */
    CCColorBlue,
    /**
     *  黄色按钮
     */
    CCColorYellow,
    /**
     *  紫色按钮
     */
    CCColorPurple,
    /**
     *  黑色按钮
     */
    CCColorBlack,
} CCColorType;

@interface ViewController ()

/**
 *  涂鸦视图
 */
@property (weak, nonatomic) IBOutlet DoodleView *doodleView;

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

#pragma mark - 涂鸦方法

/**
 *  清空方法
 */
- (IBAction)clearView
{
    [self.doodleView clearPainter];
}

/**
 *  撤销方法
 */
- (IBAction)undoView
{
    [self.doodleView undoPainter];
}

/**
 *  保存方法
 */
- (IBAction)saveView
{
    UIImage *image = [UIImage captureWithView:self.doodleView];
    UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
}

/**
 *  图片保存方法
 */
- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    if (error) {
        [MBProgressHUD showError:@"保存失败"];
    } else {
        [MBProgressHUD showSuccess:@"保存成功"];
    }
}

#pragma mark - 画笔方法

/**
 *  滑动条改变方法
 */
- (IBAction)sliderChange:(UISlider *)sender
{
    self.doodleView.pathWidth = sender.value;
}

/**
 *  改变颜色方法
 */
- (IBAction)colorChange:(UIButton *)sender
{
    switch (sender.tag) {
        case CCColorRed:
            self.doodleView.doodleColor = [UIColor redColor];
            break;
        case CCColorGreen:
            self.doodleView.doodleColor = [UIColor greenColor];
            break;
        case CCColorBlue:
            self.doodleView.doodleColor = [UIColor blueColor];
            break;
        case CCColorYellow:
            self.doodleView.doodleColor = [UIColor yellowColor];
            break;
        case CCColorPurple:
            self.doodleView.doodleColor = [UIColor purpleColor];
            break;
        case CCColorBlack:
            self.doodleView.doodleColor = [UIColor blackColor];
            break;
    }
}

@end
