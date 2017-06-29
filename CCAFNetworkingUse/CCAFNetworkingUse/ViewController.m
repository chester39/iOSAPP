//
//  ViewController.m
//      CCAFNetworkingUse
//      Chen Chen @ August 1st, 2015
//

#import "ViewController.h"
#import "AFNetworking.h"
#import "MBProgressHUD+MJ.h"

@interface ViewController ()

/**
 *  用户文本框
 */
@property (weak, nonatomic) IBOutlet UITextField *userField;
/**
 *  密码文本框
 */
@property (weak, nonatomic) IBOutlet UITextField *passwordField;
/**
 *  姓名文本框
 */
@property (weak, nonatomic) IBOutlet UITextField *nameField;
/**
 *  标识文本框
 */
@property (weak, nonatomic) IBOutlet UITextField *markField;

@end

@implementation ViewController

#pragma mark - 系统方法

/**
 *  视图已经加载方法
 */
- (void)viewDidLoad
{
    [super viewDidLoad];
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusReachableViaWiFi:
                NSLog(@"WiFi网络");
                break;
            case AFNetworkReachabilityStatusReachableViaWWAN:
                NSLog(@"3G/4G网络");
                break;
            case AFNetworkReachabilityStatusNotReachable:
                NSLog(@"没有网络");
                break;
            case AFNetworkReachabilityStatusUnknown:
                NSLog(@"未知网络");
                break;
        }
    }];
    [manager startMonitoring];
}

/**
 *  释放内存方法
 */
- (void)dealloc
{
    [[AFNetworkReachabilityManager sharedManager] stopMonitoring];
}

#pragma mark - 登录方法

/**
 *  GET登录JSON方法
 */
- (IBAction)loginGetJSON
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
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[@"username"] = username;
    dict[@"pwd"] = password;
    NSString *url = @"http://192.168.1.110:8080/MJServer/login";
    [manager GET:url parameters:dict success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"%@", [responseObject class]);
        NSString *success = responseObject[@"success"];
        NSString *error = responseObject[@"error"];
        if (error)
            [MBProgressHUD showError:error];
        else
            [MBProgressHUD showSuccess:success];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [MBProgressHUD showError:@"请求失败"];
    }];
}

/**
 *  GET登录XML方法
 */
- (IBAction)loginGetXML
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
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFXMLParserResponseSerializer serializer];
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[@"username"] = username;
    dict[@"pwd"] = password;
    dict[@"type"] = @"XML";
    NSString *url = @"http://192.168.1.110:8080/MJServer/login";
    [manager GET:url parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"%@", [responseObject class]);
        [MBProgressHUD showSuccess:@"请求成功"];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [MBProgressHUD showError:@"请求失败"];
    }];
}

/**
 *  POST登录JSON方法
 */
- (IBAction)loginPostJSON
{
    NSString *name = self.nameField.text;
    if (name.length == 0) {
        [MBProgressHUD showError:@"姓名不能为空"];
        return;
    }
    NSString *mark = self.markField.text;
    if (mark.length == 0) {
        [MBProgressHUD showError:@"标识不能为空"];
        return;
    }
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[@"username"] = name;
    dict[@"pwd"] = mark;
    NSString *url = @"http://192.168.1.110:8080/MJServer/login";
    [manager POST:url parameters:dict success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"%@", [responseObject class]);
        NSString *success = responseObject[@"success"];
        NSString *error = responseObject[@"error"];
        if (error)
            [MBProgressHUD showError:error];
        else
            [MBProgressHUD showSuccess:success];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [MBProgressHUD showError:@"请求失败"];
    }];
}

/**
 *  POST登录数据方法
 */
- (IBAction)loginPostData
{
    NSString *name = self.nameField.text;
    if (name.length == 0) {
        [MBProgressHUD showError:@"姓名不能为空"];
        return;
    }
    NSString *mark = self.markField.text;
    if (mark.length == 0) {
        [MBProgressHUD showError:@"标识不能为空"];
        return;
    }
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[@"username"] = name;
    dict[@"pwd"] = mark;
    NSString *url = @"http://192.168.1.110:8080/MJServer/login";
    [manager POST:url parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"%@", [responseObject class]);
        [MBProgressHUD showSuccess:@"请求成功"];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [MBProgressHUD showError:@"请求失败"];
    }];
}

#pragma mark - 文件方法

/**
 *  下载文件方法
 */
- (IBAction)downloadFile
{
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    NSURL *url = [NSURL URLWithString:@"http://192.168.1.110:8080/MJServer/resources/images/minion_01.png"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSURLSessionDownloadTask *downloadTask = [manager downloadTaskWithRequest:request progress:nil destination:^NSURL * (NSURL *targetPath, NSURLResponse *response) {
        NSURL *documentDirectoryURL = [[NSFileManager defaultManager] URLForDirectory:NSDocumentDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:nil];
        return [documentDirectoryURL URLByAppendingPathComponent:[response suggestedFilename]];
    } completionHandler:^(NSURLResponse *response, NSURL *filePath, NSError *error) {
        [MBProgressHUD showSuccess:@"图片下载成功"];
        NSLog(@"文件下载到：%@", filePath);
    }];
    [downloadTask resume];
}

/**
 *  上传文件方法
 */
- (IBAction)uploadFile
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSDictionary *dict = @{@"username" : @"CC", @"password" : @"chester39", @"age" : @24, @"height" : @1.72};
    NSString *url = @"http://192.168.1.110:8080/MJServer/upload";
    [manager POST:url parameters:dict constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        NSURL *textURL = [[NSBundle mainBundle] URLForResource:@"江东英雄传41-48关攻略" withExtension:@"txt"];
        NSData *fileData = [NSData dataWithContentsOfURL:textURL];
        [formData appendPartWithFileData:fileData name:@"file" fileName:@"test.txt" mimeType:@"text/plain"];
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"上传成功：%@ %@", [responseObject class], responseObject);
        [MBProgressHUD showSuccess:@"文件上传成功"];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"上传失败%@", error);
        [MBProgressHUD showError:@"文件上传失败"];
    }];
}

@end
