//
//	iOS培训
//		传智播客 & 黑马
//		Chen Chen @ June 5th, 2015
//

#import "ViewController.h"
#import "AppModel.h"
#import "AppCell.h"

@interface ViewController () <AppCellDelegate>

/**
 *  应用数组
 */
@property (strong, nonatomic) NSArray *appArray;

@end

@implementation ViewController

#pragma mark - 初始化方法

/**
 *  应用数组惰性初始化方法
 */
- (NSArray *)appArray
{
    if (_appArray == nil) {
        NSArray *dictArray = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"apps_full" ofType:@"plist"]];
        NSMutableArray *apps = [NSMutableArray array];
        for (NSDictionary *dict in dictArray) {
            AppModel *app = [AppModel appModelWithDict:dict];
            [apps addObject:app];
        }
        _appArray = apps;
    }
    return _appArray;
}

#pragma mark - 系统方法

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tableView.rowHeight = 60;
}

- (BOOL)prefersStatusBarHidden
{
    return YES;
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
    return self.appArray.count;
}

/**
 *  每行内容方法
 */
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    AppCell *cell = [tableView dequeueReusableCellWithIdentifier:@"APP"];
    cell.delegate = self;
    cell.app = self.appArray[indexPath.row];
    return cell;
}

#pragma mark - AppViewDelegate代理方法

/**
 *  点击下载按钮方法
 */
- (void)appCellDidClickDownloadButton:(AppCell *)appCell
{
    UILabel *tipLabel = [[UILabel alloc] init];
    tipLabel.text = [NSString stringWithFormat:@"成功下载%@", appCell.app.name];
    tipLabel.textColor = [UIColor whiteColor];
    tipLabel.backgroundColor = [UIColor grayColor];
    tipLabel.textAlignment = NSTextAlignmentCenter;
    tipLabel.alpha = 0.0;
    tipLabel.layer.cornerRadius = 10;
    tipLabel.layer.masksToBounds = YES;
    CGFloat labelWidth = 200;
    CGFloat labelHeight = 44;
    CGFloat labelX = (self.view.frame.size.width - labelWidth) / 2;
    CGFloat labelY = (self.view.frame.size.height) * 3 / 4;
    tipLabel.frame = CGRectMake(labelX, labelY, labelWidth, labelHeight);
    [self.view addSubview:tipLabel];
    [UIView animateWithDuration:1.0 animations:^{
        tipLabel.alpha = 0.7;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:1.0 delay:2.0 options:UIViewAnimationOptionCurveLinear animations:^{
            tipLabel.alpha = 0.0;
        } completion:^(BOOL finished) {
            [tipLabel removeFromSuperview];
        }];
    }];
}

@end
