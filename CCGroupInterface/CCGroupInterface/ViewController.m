//
//  ViewController.m
//      CCGroupInterface
//      Chen Chen @ Apirl 23rd, 2015
//

#import "ViewController.h"
#import "GroupModel.h"
#import "GroupCell.h"
#import "GroupHeaderView.h"
#import "GroupFooterView.h"

@interface ViewController () <UITableViewDataSource, GroupFooterViewDelegate>

/**
 *  表格视图
 */
@property (weak, nonatomic) IBOutlet UITableView *tableView;
/**
 *  团购数组
 */
@property (strong, nonatomic) NSMutableArray *groupArray;

@end

@implementation ViewController

#pragma mark - 初始化方法

/**
 *  团购数组惰性初始化方法
 */
- (NSMutableArray *)groupArray
{
    if (_groupArray == nil) {
        NSArray *dictArray = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"tgs.plist" ofType:nil]];
        NSMutableArray *groups = [NSMutableArray array];
        for (NSDictionary *dict in dictArray) {
            GroupModel *group = [GroupModel groupModelWithDict:dict];
            [groups addObject:group];
        }
        _groupArray = groups;
    }
    return _groupArray;
}

#pragma mark - 初始化方法

/**
 *  视图已经加载方法
 */
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tableView.dataSource = self;
    self.tableView.rowHeight = 80;
    self.tableView.contentInset = UIEdgeInsetsMake(20, 0, 0, 0);
    GroupFooterView *footer = [GroupFooterView footView];
    footer.delegate = self;
    self.tableView.tableFooterView = footer;
    GroupHeaderView *header = [GroupHeaderView headerView];
    self.tableView.tableHeaderView = header;
}

#pragma mark - GroupFooterViewDelegate代理方法

/**
 *  点击下载按钮方法
 */
- (void)groupFooterViewDidClickLoadButton:(GroupFooterView *)footerView
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSDictionary *dict = @{@"title": @"川西坝子", @"icon": @"ad_04", @"price": @"100", @"buyCount": @"200"};
        GroupModel *group = [GroupModel groupModelWithDict:dict];
        [self.groupArray addObject:group];
        NSIndexPath *path = [NSIndexPath indexPathForRow:(self.groupArray.count - 1) inSection:0];
        [self.tableView insertRowsAtIndexPaths:@[path] withRowAnimation:UITableViewRowAnimationFade];
        [footerView endRefresh];
    });
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
    return self.groupArray.count;
}

/**
 *  每行内容方法
 */
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    GroupCell *cell = [GroupCell cellWithTableView:tableView];
    cell.group = self.groupArray[indexPath.row];
    return cell;
}

@end
