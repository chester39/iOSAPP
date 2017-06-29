//
//  TXJViewController.m
//      CCNavigationUse
//      Chen Chen @ June 11th, 2015
//

#import "TXJViewController.h"
#import "CTViewController.h"

@interface TXJViewController ()

@end

@implementation TXJViewController

#pragma mark - 系统方法

/**
 *  视图已经加载方法
 */
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = @"TXJViewController";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit target:nil action:nil];
}

#pragma mark - 移动方法

/**
 *  移到CTViewController方法
 */
- (IBAction)jumpToCt
{
    CTViewController *ctvc = [[CTViewController alloc] init];
    [self.navigationController pushViewController:ctvc animated:YES];
}

@end
