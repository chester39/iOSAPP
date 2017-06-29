//
//  ViewController.m
//      CCQuartz2DUse
//      Chen Chen @ June 17th, 2015
//

#import "ViewController.h"
#import "DrawView.h"
#import "UIImage+CC.h"

@interface ViewController ()

/**
 *  绘图视图
 */
@property (weak, nonatomic) IBOutlet DrawView *circleView;
/**
 *  水印视图
 */
@property (weak, nonatomic) IBOutlet UIImageView *watermarkView;
/**
 *  裁剪视图
 */
@property (weak, nonatomic) IBOutlet UIImageView *clipView;

@end

@implementation ViewController

#pragma mark - 系统方法

/**
 *  视图已经加载方法
 */
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self saveWatermarkImage];
    [self saveClipImage];
    [self addStripeBackground];
}

#pragma mark - 控件方法

/**
 *  滑动条改变方法
 */
- (IBAction)changeSlider:(UISlider *)sender
{
    self.circleView.circleRadius = sender.value;
}

/**
 *  截图方法
 */
- (IBAction)captureView
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        UIImage *captureImage = [UIImage captureWithView:self.circleView];
        NSData *data = UIImagePNGRepresentation(captureImage);
        NSString *path = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"capture.png"];
        [data writeToFile:path atomically:YES];
    });
}

#pragma mark - 图片方法

/**
 *  保存水印图片方法
 */
- (void)saveWatermarkImage
{
    UIImage *watermarkImage = [UIImage watermarkWithImage:@"scene" watermark:@"icon_11" scale:0.2];
    self.watermarkView.image = watermarkImage;
    NSData *data = UIImagePNGRepresentation(watermarkImage);
    NSString *path = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"watermark.png"];
    [data writeToFile:path atomically:YES];
}

/**
 *  保存裁剪图片方法
 */
- (void)saveClipImage
{
    UIImage *clipImage = [UIImage clipCircleWithImage:@"icon_11" borderWidth:3 borderColor:[UIColor whiteColor]];
    self.clipView.image = clipImage;
    NSData *data = UIImagePNGRepresentation(clipImage);
    NSString *path = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"clipImage.png"];
    [data writeToFile:path atomically:YES];
}

/**
 *  添加条纹背景方法
 */
- (void)addStripeBackground
{
    UIImage *stripeImage = [UIImage stripeBackgroundWithView:self.circleView rowHeight:40 rowColor:[UIColor grayColor] lineWidth:1 lineColor:[UIColor blackColor]];
    self.circleView.backgroundColor = [UIColor colorWithPatternImage:stripeImage];
    NSData *data = UIImagePNGRepresentation(stripeImage);
    NSString *path = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"stripe.png"];
    [data writeToFile:path atomically:YES];
}

@end
