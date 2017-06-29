//
//  ViewController.m
//      CCASIHTTPRequestUse
//      Chen Chen @ August 1st, 2015
//

#import "ViewController.h"
#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"

@interface ViewController () <ASIHTTPRequestDelegate>

/**
 *  GET请求
 */
@property (strong, nonatomic) ASIHTTPRequest *getRequest;
/**
 *  POST请求
 */
@property (strong, nonatomic) ASIFormDataRequest *postRequest;
/**
 *  下载进度条
 */
@property (weak, nonatomic) IBOutlet UIProgressView *downloadProgressView;
/**
 *  上传进度条
 */
@property (weak, nonatomic) IBOutlet UIProgressView *uploadProgressView;


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

/**
 *  释放内存方法
 */
- (void)dealloc
{
    [self.getRequest clearDelegatesAndCancel];
}

#pragma mark - 请求方法

/**
 *  GET同步方法
 */
- (IBAction)SynchronousGet
{
    NSURL *url = [NSURL URLWithString:@"http://192.168.1.110:8080/MJServer/resources/video"];
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    request.timeOutSeconds = 15;
    [request startSynchronous];
    if ([request error])
        NSLog(@"请求失败：%@", [request error]);
    else {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:[request responseData] options:NSJSONReadingMutableLeaves error:nil];
        NSLog(@"%@ %@", [request responseHeaders], [request responseString]);
        NSLog(@"请求成功：%@", dict);
    }
}

/**
 *  GET异步代理方法
 */
- (IBAction)AsynchronousGetDelegate
{
    NSURL *url = [NSURL URLWithString:@"http://192.168.1.110:8080/MJServer/resources/video"];
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    request.timeOutSeconds = 15;
    request.delegate = self;
    [request startAsynchronous];
    self.getRequest = request;
}

/**
 *  GET异步Block方法
 */
- (IBAction)AsynchronousGetBlock
{
    NSURL *url = [NSURL URLWithString:@"http://192.168.1.110:8080/MJServer/resources/video"];
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    [request startAsynchronous];
    [request setStartedBlock:^{
        NSLog(@"setStartedBlock:");
    }];
    [request setHeadersReceivedBlock:^(NSDictionary *responseHeaders) {
        NSLog(@"setHeadersReceivedBlock: %@", responseHeaders);
    }];
    [request setDataReceivedBlock:^(NSData *data) {
        NSLog(@"setDataReceivedBlock:");
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
        NSLog(@"%@", dict);
    }];
    [request setCompletionBlock:^{
        NSLog(@"setCompletionBlock:");
    }];
    [request setFailedBlock:^{
        NSLog(@"setFailedBlock:");
    }];
}

/**
 *  POST登录方法
 */
- (IBAction)loginPost
{
    NSURL *url = [NSURL URLWithString:@"http://192.168.1.110:8080/MJServer/login"];
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    [request setPostValue:@"cc" forKey:@"username"];
    [request setPostValue:@"139" forKey:@"pwd"];
    request.delegate = self;
    [request setDidStartSelector:@selector(startWithRequest:)];
    [request setDidFinishSelector:@selector(finishWithRequest:)];
    [request setDidFailSelector:@selector(failWithRequest:)];
    [request startAsynchronous];
    self.postRequest = request;
}

#pragma mark - ASIHTTPRequestDelegate代理方法

/**
 *  请求开始方法
 */
- (void)requestStarted:(ASIHTTPRequest *)request
{
    NSLog(@"%s", __func__);
}

/**
 *  接收响应头方法
 */
- (void)request:(ASIHTTPRequest *)request didReceiveResponseHeaders:(NSDictionary *)responseHeaders
{
    NSLog(@"%s %@", __func__, responseHeaders);
}

/**
 *  接收数据方法
 */
- (void)request:(ASIHTTPRequest *)request didReceiveData:(NSData *)data
{
    NSLog(@"%s", __func__);
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
    NSLog(@"%@", dict);
}

/**
 *  请求完成方法
 */
- (void)requestFinished:(ASIHTTPRequest *)request
{
    NSLog(@"%s", __func__);
}

/**
 *  请求失败方法
 */
- (void)requestFailed:(ASIHTTPRequest *)request
{
    NSLog(@"%s", __func__);
}

#pragma mark - 自定义ASIHTTPRequestDelegate代理方法

/**
 *  请求开始方法
 */
- (void)startWithRequest:(ASIFormDataRequest *)request
{
    NSLog(@"%s", __func__);
}

/**
 *  请求结束方法
 */
- (void)finishWithRequest:(ASIFormDataRequest *)request
{
    NSLog(@"%s %d %@ %@ %@", __func__, [request responseStatusCode], [request responseStatusMessage], [request responseHeaders], [request responseString]);
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:[request responseData] options:NSJSONReadingMutableLeaves error:nil];
    NSLog(@"%@", dict);
}

/**
 *  请求失败方法
 */
- (void)failWithRequest:(ASIFormDataRequest *)request
{
    NSLog(@"%s", __func__);
}

#pragma mark - 文件方法

/**
 *  下载文件方法
 */
- (IBAction)downloadFile
{
    NSURL *url = [NSURL URLWithString:@"http://192.168.1.110:8080/MJServer/resources/videos.rar"];
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    NSString *filePath = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"videos.rar"];
    request.downloadDestinationPath = filePath;
    request.downloadProgressDelegate = self.downloadProgressView;
    request.allowResumeForFileDownloads = YES;
    request.temporaryFileDownloadPath = [NSTemporaryDirectory() stringByAppendingPathComponent:@"test.tmp"];
    [request startAsynchronous];
    __weak typeof(request) weakRequest = request;
    [request setCompletionBlock:^{
        NSLog(@"%@", [weakRequest responseString]);
    }];
}

/**
 *  上传文件方法
 */
- (IBAction)uploadFile
{
    NSURL *url = [NSURL URLWithString:@"http://192.168.1.110:8080/MJServer/upload"];
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    [request setPostValue:@"CC" forKey:@"username"];
    [request setPostValue:@"chester39" forKey:@"password"];
    [request setPostValue:@24 forKey:@"age"];
    [request setPostValue:@172 forKey:@"height"];
    NSString *file = [[NSBundle mainBundle] pathForResource:@"江东英雄传41-48关攻略" ofType:@"txt"];
    [request setFile:file forKey:@"file"];
    request.uploadProgressDelegate = self.uploadProgressView;
    [request startAsynchronous];
    __weak typeof(request) weakRequest = request;
    [request setCompletionBlock:^{
        NSLog(@"%@", [weakRequest responseString]);
    }];
}

@end
