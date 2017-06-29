//
//  ViewController.m
//      CCHTTPRequest
//      Chen Chen @ July 21st, 2015
//

#import "ViewController.h"
#import "NSString+CC.h"
#import "Reachability.h"
#import "MBProgressHUD+MJ.h"

@interface ViewController ()

/**
 *  网络可达性
 */
@property (strong, nonatomic) Reachability *reachability;
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
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didChangeNetworkState) name:kReachabilityChangedNotification object:nil];
    self.reachability = [Reachability reachabilityForInternetConnection];
    [self.reachability startNotifier];
}

/**
 *  释放内存方法
 */
- (void)dealloc
{
    [self.reachability stopNotifier];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - 登录方法

/**
 *  同步登录网站方法
 */
- (IBAction)loginSynchronousWeb
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
    password = [self MD5Salt:password];
    NSString *stringURL = [NSString stringWithFormat:@"http://192.168.1.110:8080/MJServer/login?username=%@&pwd=%@", username, password];
    stringURL = [stringURL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *url = [NSURL URLWithString:stringURL];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
    NSString *success = dict[@"success"];
    NSString *error = dict[@"error"];
    if (error)
        [MBProgressHUD showError:error];
    else
        [MBProgressHUD showSuccess:success];
}

/**
 *  异步登录网站方法
 */
- (IBAction)loginAsynchronousWeb
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
    mark = [self MD5Unorder:mark];
    NSURL *url = [NSURL URLWithString:@"http://192.168.1.110:8080/MJServer/login"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    request.HTTPMethod = @"POST";
    NSString *stringURL = [NSString stringWithFormat:@"username=%@&pwd=%@", name, mark];
    request.HTTPBody = [stringURL dataUsingEncoding:NSUTF8StringEncoding];
    request.timeoutInterval = 10;
    [request setValue:@"Mozilla/5.0 (iPhone; CPU iPhone OS 8_4 like Mac OS X) AppleWebKit/600.1.4 (KHTML, like Gecko) Mobile/12H141" forHTTPHeaderField:@"User-Agent"];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        if (connectionError || data == nil) {
            [MBProgressHUD showError:@"请求失败"];
            return;
        }
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
        NSString *success = dict[@"success"];
        NSString *error = dict[@"error"];
        if (error)
            [MBProgressHUD showError:error];
        else
            [MBProgressHUD showSuccess:success];
    }];
}

#pragma mark - HTTP请求方法

/**
 *  发送JSON请求方法
 */
- (IBAction)sendJSONRequest
{
    NSURL *url = [NSURL URLWithString:@"http://192.168.1.110:8080/MJServer/order"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    request.HTTPMethod = @"POST";
    NSDictionary *orderDict = @{@"shop_id" : @"1896", @"shop_name" : @"Arsenal", @"user_id" : @"910309", @"user_name" : @"Chester Chen"};
    NSData *json = [NSJSONSerialization dataWithJSONObject:orderDict options:NSJSONWritingPrettyPrinted error:nil];
    request.HTTPBody = json;
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        if (connectionError || data == nil) {
            [MBProgressHUD showError:@"请求失败"];
            return;
        }
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
        NSString *success = dict[@"success"];
        NSString *error = dict[@"error"];
        if (error)
            [MBProgressHUD showError:error];
        else
            [MBProgressHUD showSuccess:success];
    }];
}

/**
 *  发送多值请求方法
 */
- (IBAction)sendMultiValueRequest
{
    NSURL *url = [NSURL URLWithString:@"http://192.168.1.110:8080/MJServer/weather"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    request.HTTPMethod = @"POST";
    NSMutableString *multiString = [NSMutableString string];
    [multiString appendString:@"place=北京"];
    [multiString appendString:@"&place=成都"];
    [multiString appendString:@"&place=上海"];
    multiString = [[multiString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding] mutableCopy];
    request.HTTPBody = [multiString dataUsingEncoding:NSUTF8StringEncoding];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        if (connectionError || data == nil) {
            [MBProgressHUD showError:@"请求失败"];
            return;
        }
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
        NSArray *weatherArray = dict[@"weathers"];
        NSString *success = dict[@"success"];
        NSString *error = dict[@"error"];
        if (error)
            [MBProgressHUD showError:error];
        else {
            [MBProgressHUD showSuccess:success];
            NSLog(@"%@", weatherArray);
        }
    }];
}

#pragma mark - MD5再加密方法

/**
 *  MD5加盐方法
 */
- (NSString *)MD5Salt:(NSString *)text
{
    NSString *salt = @"";
    if (text.length > 5)
        salt = [text stringByAppendingString:@"cc"];
    else
        salt = [text stringByAppendingFormat:@"cc%@", text];
    return [salt md5String];
}

/**
 *  MD5乱序方法
 */
- (NSString *)MD5Unorder:(NSString *)text
{
    NSString *password = [text md5String];
    NSString *prefix = [password substringFromIndex:5];
    NSString *subfix = [password substringToIndex:5];
    NSString *result = [prefix stringByAppendingString:subfix];
    return result;
}

#pragma mark - 网络状态方法

/**
 *  已经改变网络状态方法
 */
- (void)didChangeNetworkState
{
    NSLog(@"网络状态已改变");
    [self checkNetworkState];
}

/**
 *  监测网络状态方法
 */
- (void)checkNetworkState
{
    if ([[Reachability reachabilityForLocalWiFi] currentReachabilityStatus] != NotReachable)
        NSLog(@"WiFi网络");
    else if ([[Reachability reachabilityForInternetConnection] currentReachabilityStatus] != NotReachable)
        NSLog(@"3G/4G网络");
    else
        NSLog(@"没有网络");
}

@end
