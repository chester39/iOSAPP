//
//	iOS培训
//		传智播客 & 黑马
//		Chen Chen @ June 4th, 2015
//

#import "ViewController.h"
#import "FriendModel.h"
#import "FriendGroup.h"
#import "FriendCell.h"
#import "FriendHeaderView.h"

@interface ViewController () <FriendHeaderViewDelegate>

/**
 *  好友数组
 */
@property (strong, nonatomic) NSArray *groupArray;

@end

@implementation ViewController

#pragma mark - 初始化方法

/**
 *  好友数组惰性初始化方法
 */
- (NSArray *)groupArray
{
    if (_groupArray == nil) {
        NSArray *dictArray = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"friends" ofType:@"plist"]];
        NSMutableArray *groups = [NSMutableArray array];
        for (NSDictionary *dict in dictArray) {
            FriendGroup *friendGroup = [FriendGroup friendGroupModelWithDict:dict];
            [groups addObject:friendGroup];
        }
        _groupArray = groups;
    }
    return _groupArray;
}

#pragma mark - 系统方法

/**
 *  视图已经加载方法
 */
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tableView.sectionHeaderHeight = 44;
    self.tableView.rowHeight = 50;
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
    return self.groupArray.count;
}

/**
 *  每组行数方法
 */
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    FriendGroup *friendGroup = self.groupArray[section];
    return (friendGroup.isOpen ? friendGroup.friends.count : 0);
}

/**
 *  每行内容方法
 */
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    FriendCell *cell = [FriendCell cellWithTableView:tableView];
    FriendGroup *friendGroup = self.groupArray[indexPath.section];
    cell.friendModel = friendGroup.friends[indexPath.row];
    return cell;
}

#pragma mark - UITableViewDelegate代理方法

/**
 *  每组头视图内容方法
 */
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    FriendHeaderView *headerView = [FriendHeaderView headerViewWithTableView:tableView];
    headerView.delegate = self;
    headerView.friendGroup = self.groupArray[section];
    return headerView;
}

#pragma mark - FriendHeaderViewDelegate代理方法

/**
 *  点击头视图方法
 */
- (void)headerViewDidClickNameView:(FriendHeaderView *)headerView
{
    [self.tableView reloadData];
}

@end
