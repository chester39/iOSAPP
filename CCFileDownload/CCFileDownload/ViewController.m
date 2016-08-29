//
//	iOS培训
//		传智播客 & 黑马
//		Chen Chen @ July 26th, 2015
//

#import "ViewController.h"

/**
 *  视频文件地址
 */
#define CCVideoFilePath [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"videos.rar"]

@interface ViewController () <NSURLConnectionDataDelegate>

/**
 *  图片视图
 */
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
/**
 *  进度条
 */
@property (weak, nonatomic) IBOutlet UIProgressView *progressView;
/**
 *  控制按钮
 */
@property (weak, nonatomic) IBOutlet UIButton *controlButton;
/**
 *  网络连接
 */
@property (strong, nonatomic) NSURLConnection *connection;
/**
 *  写入文件操作
 */
@property (strong, nonatomic) NSFileHandle *writeHandle;
/**
 *  文件总大小
 */
@property (nonatomic) long long totalLength;
/**
 *  当前写入文件大小
 */
@property (nonatomic) long long currentLength;

@end

@implementation ViewController

#pragma mark - 系统方法

/**
 *  视图已经加载方法
 */
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self downloadImage];
    self.progressView.progress = 0.0;
}

#pragma mark - 下载方法

/**
 *  图片下载方法
 */
- (void)downloadImage
{
    NSURL *url = [NSURL URLWithString:@"http://192.168.1.110:8080/MJServer/resources/images/minion_01.png"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        if (connectionError) {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:@"图片下载失败" delegate:nil cancelButtonTitle:@"确认" otherButtonTitles:nil];
            [alertView show];
        } else {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:@"图片下载成功" delegate:nil cancelButtonTitle:@"确认" otherButtonTitles:nil];
            [alertView show];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            self.imageView.image = [UIImage imageWithData:data];
        });
    }];
}

/**
 *  视频下载方法
 */
- (IBAction)downloadVideo
{
    self.controlButton.selected = !self.controlButton.isSelected;
    if (self.controlButton.isSelected) {
        NSURL *url = [NSURL URLWithString:@"http://192.168.1.110:8080/MJServer/resources/videos.rar"];
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
        NSString *range = [NSString stringWithFormat:@"bytes=%lld-", self.currentLength];
        [request setValue:range forHTTPHeaderField:@"Range"];
        self.connection = [NSURLConnection connectionWithRequest:request delegate:self];
    } else {
        [self.connection cancel];
        self.connection = nil;
    }
}

#pragma mark - NSURLConnectionDataDelegate数据代理方法

/**
 *  请求失败方法
 */
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    NSLog(@"%s", __func__);
}

/**
 *  接收服务器响应方法
 */
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    if (self.currentLength)
        return;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    [fileManager createFileAtPath:CCVideoFilePath contents:nil attributes:nil];
    self.writeHandle = [NSFileHandle fileHandleForWritingAtPath:CCVideoFilePath];
    self.totalLength = response.expectedContentLength;
}

/**
 *  接收服务器数据方法
 */
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [self.writeHandle seekToEndOfFile];
    [self.writeHandle writeData:data];
    self.currentLength += data.length;
    self.progressView.progress = (double)self.currentLength / self.totalLength;
}

/**
 *  请求结束方法
 */
- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    self.currentLength = 0;
    self.totalLength = 0;
    [self.writeHandle closeFile];
    self.writeHandle = nil;
    if (self.progressView.progress == 1.0) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:@"视频下载成功" delegate:nil cancelButtonTitle:@"确认" otherButtonTitles:nil];
        [alertView show];
        self.controlButton.selected = NO;
    }
}

@end
