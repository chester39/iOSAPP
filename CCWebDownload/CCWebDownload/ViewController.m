//
//	iOS培训
//		传智播客 & 黑马
//		Chen Chen @ July 27th, 2015
//

#import "ViewController.h"
#import "MBProgressHUD+MJ.h"

@interface ViewController () <NSURLSessionDownloadDelegate>

/**
 *  用户文本框
 */
@property (weak, nonatomic) IBOutlet UITextField *userField;
/**
 *  密码文本框
 */
@property (weak, nonatomic) IBOutlet UITextField *passwordField;
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
 *  网络会话
 */
@property (strong, nonatomic) NSURLSession *session;
/**
 *  会话下载任务
 */
@property (strong, nonatomic) NSURLSessionDownloadTask *task;
/**
 *  重新开始数据
 */
@property (strong, nonatomic) NSData *resumeData;

@end

@implementation ViewController

#pragma mark - 初始化方法

/**
 *  网络会话惰性初始化方法
 */
- (NSURLSession *)session
{
    if (_session == nil) {
        _session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:self delegateQueue:[NSOperationQueue mainQueue]];;
    }
    return _session;
}

#pragma mark - 系统方法

/**
 *  视图已经加载方法
 */
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self downloadImage];
}

#pragma mark - 登录方法

/**
 *  网络登录方法
 */
- (IBAction)loginWeb
{
    NSString *username = self.userField.text;
    if (username.length == 0) {
        [MBProgressHUD showError:@"用户名不能为空"];
        return;
    }
    NSString *password = self.passwordField.text;
    if (password.length == 0) {
        [MBProgressHUD showError:@"密码不能为空"];
        return;
    }
    NSURL *url = [NSURL URLWithString:@"http://192.168.1.110:8080/MJServer/login"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    request.HTTPMethod = @"POST";
    NSString *stringURL = [NSString stringWithFormat:@"username=%@&pwd=%@", username, password];
    request.HTTPBody = [stringURL dataUsingEncoding:NSUTF8StringEncoding];
    NSURLSessionDataTask *dataTask = [[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (error || data == nil) {
            [MBProgressHUD showError:@"请求失败"];
            return;
        }
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
        NSString *requestError = dict[@"error"];
        NSString *requestSuccess = dict[@"success"];
        dispatch_async(dispatch_get_main_queue(), ^{
            if (requestError)
                [MBProgressHUD showError:requestError];
            else
                [MBProgressHUD showSuccess:requestSuccess];
        });
    }];
    [dataTask resume];
}

#pragma mark - 下载方法

/**
 *  图片下载方法
 */
- (void)downloadImage
{
    NSURL *url = [NSURL URLWithString:@"http://192.168.1.110:8080/MJServer/resources/images/minion_01.png"];
    NSURLSessionDownloadTask *downloadTask = [[NSURLSession sharedSession] downloadTaskWithURL:url completionHandler:^(NSURL *location, NSURLResponse *response, NSError *error) {
        NSString *imagePath = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:response.suggestedFilename];
        NSFileManager *fileManager = [NSFileManager defaultManager];
        [fileManager moveItemAtPath:location.path toPath:imagePath error:nil];
        dispatch_async(dispatch_get_main_queue(), ^{
            [MBProgressHUD showSuccess:@"图片下载成功"];
            self.imageView.image = [UIImage imageWithContentsOfFile:imagePath];
        });
    }];
    [downloadTask resume];
}

/**
 *  视频下载方法
 */
- (IBAction)downloadVideo
{
    self.controlButton.selected = !self.controlButton.isSelected;
    if (self.task == nil) {
        if (self.resumeData) {
            self.task = [self.session downloadTaskWithResumeData:self.resumeData];
            [self.task resume];
            self.resumeData = nil;
        } else {
            NSURL *url = [NSURL URLWithString:@"http://192.168.1.110:8080/MJServer/resources/videos.rar"];
            self.task = [self.session downloadTaskWithURL:url];
            [self.task resume];
        }
    } else {
        [self.task cancelByProducingResumeData:^(NSData *resumeData) {
            self.resumeData = resumeData;
            self.task = nil;
        }];
    }
}

#pragma mark - NSURLSessionDownloadDelegate代理方法

/**
 *  完成下载任务方法
 */
- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask
didFinishDownloadingToURL:(NSURL *)location
{
    NSString *videoPath = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:downloadTask.response.suggestedFilename];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    [fileManager moveItemAtPath:location.path toPath:videoPath error:nil];
    if (self.progressView.progress == 1.0) {
        [MBProgressHUD showSuccess:@"视频下载成功"];
        self.controlButton.selected = NO;
    }
}

/**
 *  下载写入数据方法
 */
- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask
      didWriteData:(int64_t)bytesWritten
 totalBytesWritten:(int64_t)totalBytesWritten
totalBytesExpectedToWrite:(int64_t)totalBytesExpectedToWrite
{
    self.progressView.progress = (double)totalBytesExpectedToWrite / totalBytesExpectedToWrite;
}

/**
 *  恢复下载任务方法
 */
- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask
 didResumeAtOffset:(int64_t)fileOffset
expectedTotalBytes:(int64_t)expectedTotalBytes
{
    NSLog(@"%s", __func__);
}

@end
