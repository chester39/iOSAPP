//
//	iOS培训
//		传智播客 & 黑马
//		Chen Chen @ June 11th, 2015
//

#import "CTViewController.h"

@interface CTViewController ()

@end

@implementation CTViewController

#pragma mark - 系统方法

/**
 *  视图已经加载方法
 */
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = @"CTViewController";
    self.navigationItem.titleView = [UIButton buttonWithType:UIButtonTypeContactAdd];
}

#pragma mark - 移动方法

/**
 *  回到TXJViewController方法
 */
- (IBAction)backToTxj
{
    [self.navigationController popViewControllerAnimated:YES];
}

/**
 *  回到CCViewController方法
 */
- (IBAction)backToCc
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

@end
