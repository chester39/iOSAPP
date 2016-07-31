//
//	iOS培训
//		传智播客 & 黑马
//		Chen Chen @ June 2nd, 2015
//

#import "ViewController.h"
#import "WeiboModel.h"
#import "WeiboCell.h"

/**
 *  cell重用标识符
 */
static NSString *ID = @"WEIBO";

@interface ViewController ()

/**
 *  微博数组
 */
@property (strong, nonatomic) NSArray *weiboArray;

@end

@implementation ViewController

#pragma mark - 初始化方法

/**
 *  微博数组惰性初始化方法
 */
- (NSArray *)weiboArray
{
    if (_weiboArray == nil) {
        NSArray *dictArray = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"statuses" ofType:@"plist"]];
        NSMutableArray *weibos = [NSMutableArray array];
        for (NSDictionary *dict in dictArray) {
            WeiboModel *weibo = [WeiboModel weiboModelWithDict:dict];
            [weibos addObject:weibo];
        }
        _weiboArray = weibos;
    }
    return _weiboArray;
}

#pragma mark - 系统方法

/**
 *  视图已经加载方法
 */
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.tableView registerNib:[UINib nibWithNibName:@"WeiboCell" bundle:nil] forCellReuseIdentifier:ID];
}

/**
 *  状态栏隐藏方法
 */
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
    return self.weiboArray.count;
}

/**
 *  每行内容方法
 */
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WeiboCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    cell.weibo = self.weiboArray[indexPath.row];
    return cell;
}

#pragma mark - UITableViewDelegate数据源方法

/**
 *  每行高度方法
 */
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WeiboModel *weibo = self.weiboArray[indexPath.row];
    return weibo.cellHeight;
}

@end
