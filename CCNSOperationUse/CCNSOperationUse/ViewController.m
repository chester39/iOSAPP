//
//  ViewController.m
//      CCNSOperationUse
//      Chen Chen @ July 18th, 2015
//

#import "ViewController.h"
#import "DownloadOperation.h"

@interface ViewController () <DownloadOperationDelegate>

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
    DownloadOperation *operation = [[DownloadOperation alloc] init];
    operation.delegate = self;
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    [queue addOperation:operation];
}

/**
 *  收到内存警告方法
 */
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    [[NSOperationQueue mainQueue] setSuspended:YES];
    [[NSOperationQueue mainQueue] cancelAllOperations];
}

#pragma mark - 触摸方法

/**
 *  触摸开始方法
 */
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self invocationOperation];
    [self blockOperation];
}

#pragma mark - 线程方法

/**
 *  调用队列方法
 */
- (void)invocationOperation
{
    NSLog(@"%s", __func__);
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    NSInvocationOperation *operationA = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(runThread) object:nil];
    NSInvocationOperation *operationB = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(runThread) object:nil];
    [queue addOperation:operationA];
    [queue addOperation:operationB];
}

/**
 *  块队列方法
 */
- (void)blockOperation
{
    NSLog(@"%s", __func__);
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    queue.maxConcurrentOperationCount = 3;
    NSBlockOperation *operationA = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"ThreadA:%@", [NSThread currentThread]);
    }];
    [operationA addExecutionBlock:^{
        NSLog(@"ExecutionThread:%@", [NSThread currentThread]);
    }];
    NSBlockOperation *operationB = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"ThreadB:%@", [NSThread currentThread]);
    }];
    [operationA addDependency:operationB];
    [queue addOperation:operationA];
    [queue addOperation:operationB];
    [queue addOperationWithBlock:^{
        NSLog(@"ThreadC:%@", [NSThread currentThread]);
    }];
}

/**
 *  运行线程方法
 */
- (void)runThread
{
    NSLog(@"%s", __func__);
    NSLog(@"Thread:%@", [NSThread currentThread]);
}

#pragma mark - 下载方法

/**
 *  下载图片方法
 */
- (void)downloadFinishWithImage:(UIImage *)image
{
    NSLog(@"%s", __func__);
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        [self.imageView setImage:image];
        NSLog(@"Thread:%@", [NSThread currentThread]);
    }];
}

@end
