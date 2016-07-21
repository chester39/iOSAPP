//
//	iOS培训
//		传智播客 & 黑马
//		Chen Chen @ Apirl 14th, 2015
//

#import "ViewController.h"

@interface ViewController ()

/**
 *  汤姆猫视图
 */
@property (weak, nonatomic) IBOutlet UIImageView *catTom;

@end

@implementation ViewController

#pragma mark - 系统方法

- (void)viewDidLoad
{
    [super viewDidLoad];
}

#pragma mark - 帧动画方法

/**
 *  连续帧动画方法
 */
- (void)runAnimationWithCount:(int)count name:(NSString *)name
{
    if (self.catTom.isAnimating)
        return;
    NSMutableArray *imageArray = [NSMutableArray array];
    for (int i = 0; i < count; ++i) {
        NSString *filename = [NSString stringWithFormat:@"%@_%02d", name, i];
        NSString *path = [[NSBundle mainBundle] pathForResource:filename ofType:@"jpg"];
        UIImage *image = [UIImage imageWithContentsOfFile:path];
        [imageArray addObject:image];
    }
    self.catTom.animationImages = imageArray;
    self.catTom.animationRepeatCount = 1;
    self.catTom.animationDuration = imageArray.count * 0.05;
    [self.catTom startAnimating];
    CGFloat delay = self.catTom.animationDuration + 1.0;
    [self.catTom performSelector:@selector(setAnimationImages:) withObject:nil afterDelay:delay];
}

#pragma mark - 动作方法

/**
 *  喝水方法
 */
- (IBAction)drinkTom
{
    [self runAnimationWithCount:81 name:@"drink"];
}

/**
 *  铜钹方法
 */
- (IBAction)cymbalTom
{
    [self runAnimationWithCount:12 name:@"cymbal"];
}

/**
 *  吃饭方法
 */
- (IBAction)eatTom
{
    [self runAnimationWithCount:39 name:@"eat"];
}

/**
 *  放屁方法
 */
- (IBAction)fartTom
{
    [self runAnimationWithCount:27 name:@"fart"];
}

/**
 *  扔饼方法
 */
- (IBAction)pieTom
{
    [self runAnimationWithCount:23 name:@"pie"];
}

/**
 *  抓屏方法
 */
- (IBAction)scratchTom
{
    [self runAnimationWithCount:55 name:@"scratch"];
}

/**
 *  打头方法
 */
- (IBAction)headTom
{
    [self runAnimationWithCount:80 name:@"knockout"];
}

/**
 *  生气方法
 */
- (IBAction)angryTom
{
    [self runAnimationWithCount:25 name:@"angry"];
}

/**
 *  打胃方法
 */
- (IBAction)stomachTom
{
    [self runAnimationWithCount:33 name:@"stomach"];
}

/**
 *  左脚方法
 */
- (IBAction)leftfootTom
{
    [self runAnimationWithCount:29 name:@"footRight"];
}

/**
 *  右脚方法
 */
- (IBAction)rightfootTom
{
    [self runAnimationWithCount:29 name:@"footLeft"];
}

@end
