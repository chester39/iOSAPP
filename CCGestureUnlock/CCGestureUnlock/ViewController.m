//
//  ViewController.m
//      CCGestureUnlock
//      Chen Chen @ June 24th, 2015
//

#import "ViewController.h"
#import "UnlockView.h"

@interface ViewController () <UnlockViewDelegate>

/**
 *  解锁视图
 */
@property (weak, nonatomic) IBOutlet UnlockView *unlockView;

@end

@implementation ViewController

#pragma mark - 系统方法

/**
 *  视图已经加载方法
 */
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.unlockView.delegate = self;
}

/**
 *  状态栏偏好方法
 */
- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

#pragma mark - UnlockViewDelegate代理方法

/**
 *  路径完成方法
 */
- (void)unlockView:(UnlockView *)unlockView didFinishPath:(NSString *)path
{
    NSString *answerString = @"24576301";
    if ([path isEqualToString:answerString]) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"通知" message:@"您已经解锁" delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil];
        [alertView show];
    } else {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"通知" message:@"解锁失败" delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil];
        [alertView show];
    }
}

@end
