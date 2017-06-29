//
//  LoginViewController.m
//      CCPersonalContacts
//      Chen Chen @ June 11th, 2015
//

#import "LoginViewController.h"
#import "MBProgressHUD+MJ.h"

/**
 *  账号键
 */
#define CCAccountKey @"account"
/**
 *  密码键
 */
#define CCPasswordKey @"password"
/**
 *  记住密码键
 */
#define CCRememberPasswordKey @"rememberPassword"
/**
 *  自动登录键
 */
#define CCAutoLoginKey @"autoLogin"


@interface LoginViewController ()

/**
 *  账号文本框
 */
@property (weak, nonatomic) IBOutlet UITextField *accountField;
/**
 *  密码文本框
 */
@property (weak, nonatomic) IBOutlet UITextField *passwordField;
/**
 *  记住密码开关
 */
@property (weak, nonatomic) IBOutlet UISwitch *rememberSwitch;
/**
 *  自动登录开关
 */
@property (weak, nonatomic) IBOutlet UISwitch *autoSwitch;
/**
 *  登录按钮
 */
@property (weak, nonatomic) IBOutlet UIButton *loginButton;

@end

@implementation LoginViewController

#pragma mark - 系统方法

/**
 *  视图已经加载方法
 */
- (void)viewDidLoad
{
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeText) name:UITextFieldTextDidChangeNotification object:self.accountField];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeText) name:UITextFieldTextDidChangeNotification object:self.passwordField];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    self.accountField.text = [defaults objectForKey:CCAccountKey];
    self.rememberSwitch.on = [defaults boolForKey:CCRememberPasswordKey];
    self.autoSwitch.on = [defaults boolForKey:CCAutoLoginKey];
    if (self.rememberSwitch.isOn)
        self.passwordField.text = [defaults objectForKey:CCPasswordKey];
    if (self.autoSwitch.isOn)
        [self loginContact];
}

/**
 *  释放内存方法
 */
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - 界面方法

/**
 *  文本改变方法
 */
- (void)changeText
{
    self.loginButton.enabled = (self.accountField.text.length && self.passwordField.text.length);
}

/**
 *  记住密码方法
 */
- (IBAction)changeRememberPassword
{
    if (self.rememberSwitch.isOn == NO)
        [self.autoSwitch setOn:NO animated:YES];
}

/**
 *  自动登录方法
 */
- (IBAction)changeAutoLogin
{
    if (self.autoSwitch.isOn)
        [self.rememberSwitch setOn:YES animated:YES];
}

#pragma mark - 登录方法

/**
 *  登录方法
 */
- (IBAction)loginContact
{
    if (![self.accountField.text isEqualToString:@"cc"]) {
        [MBProgressHUD showError:@"账号不存在"];
        return;
    }
    if (![self.passwordField.text isEqualToString:@"139"]) {
        [MBProgressHUD showError:@"密码错误"];
        return;
    }
    [MBProgressHUD showMessage:@"正在登录中……"];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [MBProgressHUD hideHUD];
        [self performSegueWithIdentifier:@"login2contacts" sender:nil];
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setObject:self.accountField.text forKey:CCAccountKey];
        [defaults setObject:self.passwordField.text forKey:CCPasswordKey];
        [defaults setBool:self.rememberSwitch.isOn forKey:CCRememberPasswordKey];
        [defaults setBool:self.autoSwitch.isOn forKey:CCAutoLoginKey];
        [defaults synchronize];
    });
}

/**
 *  segue跳转方法
 */
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    UIViewController *contactvc = segue.destinationViewController;
    contactvc.title = [NSString stringWithFormat:@"%@的联系人列表", self.accountField.text];
}

@end
