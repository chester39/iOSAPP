//
//  ViewController.m
//      CCQQFramework
//      Chen Chen @ June 16th, 2015
//

#import "ViewController.h"

@interface ViewController ()

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

#pragma mark - UITableViewDataSource数据源方法

/**
 *  共有组数方法
 */
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

/**
 *  每组行数方法
 */
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 0;
}

/**
 *  每行内容方法
 */
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 0;
}

#pragma mark - Modal方法

/**
 *  改变分段卡值方法
 */
- (IBAction)changeSegmented:(UISegmentedControl *)sender
{
    if (sender.selectedSegmentIndex == 1) {
        UIViewController *vcA = [[UIViewController alloc] init];
        vcA.view.backgroundColor = [UIColor blueColor];
        [self presentViewController:vcA animated:YES completion:^{
            NSLog(@"Modal打开");
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self dismissViewControllerAnimated:YES completion:^{
                    NSLog(@"Modal关闭");
                }];
            });
        }];
    }
}

@end
