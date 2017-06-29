//
//  CCViewController.m
//      CCNavigationUse
//      Chen Chen @ June 11th, 2015
//

#import "CCViewController.h"
#import "TXJViewController.h"

@interface CCViewController ()

@end

@implementation CCViewController

#pragma mark - 系统方法

/**
 *  视图已经加载方法
 */
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = @"CCViewController";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:nil action:nil];
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStyleDone target:nil action:nil];
}

/**
 *  视图将要显示方法
 */
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    NSLog(@"视图将要显示，%s", __func__);
}

/**
 *  视图已经显示方法
 */
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    NSLog(@"视图已经显示，%s", __func__);
}

/**
 *  视图将要消失方法
 */
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    NSLog(@"视图将要消失，%s", __func__);
}

/**
 *  视图已经消失方法
 */
- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    NSLog(@"视图已经消失，%s", __func__);
}

/**
 *  收到内存警告方法
 */
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    NSLog(@"收到内存警告，%s", __func__);
}

#pragma mark - 移动方法

/**
 *  移到TXJViewController方法
 */
- (IBAction)jumpToTxj
{
    TXJViewController *txjvc = [[TXJViewController alloc] init];
    [self.navigationController pushViewController:txjvc animated:YES];
}

@end
