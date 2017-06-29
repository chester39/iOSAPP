//
//  ViewController.m
//      CCGCDUse
//      Chen Chen @ July 16th, 2015
//

#import "ViewController.h"
#import "PersonModel.h"
#import "StudentModel.h"

@interface ViewController ()

/**
 *  图片视图
 */
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
/**
 *  图片按钮
 */
@property (weak, nonatomic) IBOutlet UIButton *imageButton;

@end

@implementation ViewController

#pragma mark - 系统方法

/**
 *  视图已经加载方法
 */
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self asyncGlobalQueue];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self asyncSerialQueue];
    });
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self asyncMainQueue];
    });
    [self singletonPattern];
}

#pragma mark - 触摸方法

/**
 *  触摸开始方法
 */
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self syncGlobalQueue];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self syncSerialQueue];
    });
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self downloadImage];
    });
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self downloadGroupImages];
    });
}

#pragma mark - 异步方法

/**
 *  异步并发队列方法
 */
- (void)asyncGlobalQueue
{
    NSLog(@"%s", __func__);
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(queue, ^{
        NSLog(@"Thread:%@", [NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        NSLog(@"Thread:%@", [NSThread currentThread]);
    });
}

/**
 *  异步串行队列方法
 */
- (void)asyncSerialQueue
{
    NSLog(@"%s", __func__);
    dispatch_queue_t queue = dispatch_queue_create("com.chenchen", NULL);
    dispatch_async(queue, ^{
        NSLog(@"Thread:%@", [NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        NSLog(@"Thread:%@", [NSThread currentThread]);
    });
}

/**
 *  异步全局队列方法
 */
- (void)asyncMainQueue
{
    NSLog(@"%s", __func__);
    dispatch_queue_t queue = dispatch_get_main_queue();
    dispatch_async(queue, ^{
        NSLog(@"Thread:%@", [NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        NSLog(@"Thread:%@", [NSThread currentThread]);
    });
}

#pragma mark - 同步方法

/**
 *  同步并发队列方法
 */
- (void)syncGlobalQueue
{
    NSLog(@"%s", __func__);
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_sync(queue, ^{
        NSLog(@"Thread:%@", [NSThread currentThread]);
    });
    dispatch_sync(queue, ^{
        NSLog(@"Thread:%@", [NSThread currentThread]);
    });
}

/**
 *  同步串行队列方法
 */
- (void)syncSerialQueue
{
    NSLog(@"%s", __func__);
    dispatch_queue_t queue = dispatch_queue_create("com.chenchen", NULL);
    dispatch_sync(queue, ^{
        NSLog(@"Thread:%@", [NSThread currentThread]);
    });
    dispatch_sync(queue, ^{
        NSLog(@"Thread:%@", [NSThread currentThread]);
    });
}

/**
 *  同步全局队列方法
 */
- (void)syncMainQueue
{
    NSLog(@"%s", __func__);
    dispatch_queue_t queue = dispatch_get_main_queue();
    dispatch_sync(queue, ^{
        NSLog(@"Thread:%@", [NSThread currentThread]);
    });
    dispatch_sync(queue, ^{
        NSLog(@"Thread:%@", [NSThread currentThread]);
    });
}

#pragma mark - 下载方法

/**
 *  下载图片方法
 */
- (void)downloadImage
{
    NSLog(@"%s", __func__);
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSURL *url = [NSURL URLWithString:@"http://d.hiphotos.baidu.com/zhidao/pic/item/d009b3de9c82d158e7c217d0820a19d8bc3e420a.jpg"];
        NSData *data = [NSData dataWithContentsOfURL:url];
        UIImage *image = [UIImage imageWithData:data];
        NSLog(@"Thread:%@", [NSThread currentThread]);
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.imageView setImage:image];
            NSLog(@"Thread:%@", [NSThread currentThread]);
        });
    });
}

/**
 *  下载图片组方法
 */
- (void)downloadGroupImages
{
    NSLog(@"%s", __func__);
    dispatch_group_t group = dispatch_group_create();
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    __block UIImage *imageA = nil;
    dispatch_group_async(group, queue, ^{
        NSURL *urlA = [NSURL URLWithString:@"http://d.hiphotos.baidu.com/zhidao/pic/item/d009b3de9c82d158e7c217d0820a19d8bc3e420a.jpg"];
        NSData *dataA = [NSData dataWithContentsOfURL:urlA];
        imageA = [UIImage imageWithData:dataA];
        NSLog(@"Thread:%@", [NSThread currentThread]);
    });
    __block UIImage *imageB = nil;
    dispatch_group_async(group, queue, ^{
        NSURL *urlB = [NSURL URLWithString:@"file:///Users/Chester/Pictures/CIMG7765.JPG"];
        NSData *dataB = [NSData dataWithContentsOfURL:urlB];
        imageB = [UIImage imageWithData:dataB];
        NSLog(@"Thread:%@", [NSThread currentThread]);
    });
    dispatch_group_notify(group, queue, ^{
        NSLog(@"Thread:%@", [NSThread currentThread]);
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.imageButton setImage:imageA forState:UIControlStateNormal];
            [self.imageButton setBackgroundImage:imageB forState:UIControlStateNormal];
            NSLog(@"Thread:%@", [NSThread currentThread]);
        });
    });
}

#pragma mark - 单例方法

/**
 *  单例模式方法
 */
- (void)singletonPattern
{
    PersonModel *personA = [[PersonModel alloc] init];
    PersonModel *personB = [PersonModel sharedPersonModel];
    NSLog(@"%@ %@", personA, personB);
    StudentModel *studentA = [[StudentModel alloc] init];
    StudentModel *studentB = [StudentModel sharedStudentModel];
    NSLog(@"%@ %@", studentA, studentB);
}

@end
