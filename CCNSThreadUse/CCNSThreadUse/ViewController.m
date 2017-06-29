//
//  ViewController.m
//      CCNSThreadUse
//      Chen Chen @ July 15th, 2015
//

#import "ViewController.h"

@interface ViewController ()

/**
 *  剩余票数
 */
@property (nonatomic) int surplusTickets;
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
    NSLog(@"%s", __func__);
    NSLog(@"Thread:%@", [NSThread currentThread]);
    NSLog(@"Thread:%@", [NSThread mainThread]);
    self.surplusTickets = 20;
    NSThread *threadA = [[NSThread alloc] initWithTarget:self selector:@selector(saleTickets) object:nil];
    threadA.name = @"售票员A";
    threadA.threadPriority = 1.0;
    [threadA start];
    NSThread *threadB = [[NSThread alloc] initWithTarget:self selector:@selector(saleTickets) object:nil];
    threadB.name = @"售票员B";
    threadB.threadPriority = 0.0;
    [threadB start];
}

#pragma mark - 触摸方法

/**
 *  触摸开始方法
 */
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self createThread];
    [self performSelectorInBackground:@selector(downloadImage) withObject:nil];
}

#pragma mark - 线程方法

/**
 *  新建线程方法
 */
- (void)createThread
{
    [NSThread detachNewThreadSelector:@selector(runThread:) toTarget:self withObject:@"thread"];
}

/**
 *  运行线程方法
 */
- (void)runThread:(NSString *)thread
{
    NSLog(@"%s", __func__);
    for (int i = 0; i < 5; ++i) {
        NSLog(@"Thread:%@  %@  %d", [NSThread currentThread], thread, i);
        if (i == 2) {
            [NSThread exit];
        }
    }
}

#pragma mark - 售票方法

/**
 *  售票方法
 */
- (void)saleTickets
{
    NSLog(@"%s", __func__);
    while (1) {
        @synchronized (self) {
            if (self.surplusTickets > 0) {
                [NSThread sleepForTimeInterval:0.05];
                self.surplusTickets--;
                NSLog(@"%@卖了一张票, 剩余%d张票", [NSThread currentThread].name, self.surplusTickets);
            } else {
                [NSThread exit];
            }
        }
    }
}

#pragma mark - 下载方法

/**
 *  下载图片方法
 */
- (void)downloadImage
{
    NSLog(@"%s", __func__);
    NSURL *url = [NSURL URLWithString:@"http://d.hiphotos.baidu.com/zhidao/pic/item/d009b3de9c82d158e7c217d0820a19d8bc3e420a.jpg"];
    NSData *data = [NSData dataWithContentsOfURL:url];
    UIImage *image = [UIImage imageWithData:data];
    NSLog(@"Thread:%@", [NSThread currentThread]);
    [self.imageView performSelectorOnMainThread:@selector(setImage:) withObject:image waitUntilDone:NO];
}

@end
