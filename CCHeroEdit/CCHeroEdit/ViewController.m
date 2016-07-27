//
//	iOS培训
//		传智播客 & 黑马
//		Chen Chen @ May 31st, 2015
//

#import "ViewController.h"
#import "HeroModel.h"

@interface ViewController () <UITableViewDataSource, UITableViewDelegate>

/**
 *  表格视图
 */
@property (strong, nonatomic) UITableView *tableView;
/**
 *  英雄数组
 */
@property (strong, nonatomic) NSMutableArray *heroArray;

@end

@implementation ViewController

#pragma mark - 初始化方法

/**
 *  英雄数组惰性初始化方法
 */
- (NSMutableArray *)heroArray
{
    if (_heroArray == nil) {
        NSArray *dictArray = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"heros" ofType:@"plist"]];
        NSMutableArray *heros = [NSMutableArray array];
        for (NSDictionary *dict in dictArray) {
            HeroModel *hero = [HeroModel heroModelWithDict:dict];
            [heros addObject:hero];
        }
        _heroArray = heros;
    }
    return _heroArray;
}

/**
 *  表格视图惰性初始化方法
 */
- (UITableView *)tableView
{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
        _tableView.rowHeight = 60;
        _tableView.dataSource = self;
        _tableView.delegate = self;
        [self.view addSubview:_tableView];
    }
    return _tableView;
}

#pragma mark - 系统方法

/**
 *  视图已经加载方法
 */
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self tableView];
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
    return self.heroArray.count;
}

/**
 *  每行内容方法
 */
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"HERO";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil)
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    HeroModel *hero = self.heroArray[indexPath.row];
    cell.textLabel.text = hero.name;
    cell.detailTextLabel.text = hero.intro;
    cell.imageView.image = [UIImage imageNamed:hero.icon];
    cell.accessoryType = UITableViewCellAccessoryDetailButton;
    return cell;
}

/**
 *  编辑表格方法
 */
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.tableView.editing = YES;
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.heroArray removeObjectAtIndex:indexPath.row];
        [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationTop];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        HeroModel *hero = self.heroArray[indexPath.row];
        [self.heroArray insertObject:hero atIndex:indexPath.row + 1];
        NSIndexPath *path = [NSIndexPath indexPathForRow:indexPath.row + 1 inSection:indexPath.section];
        [self.tableView insertRowsAtIndexPaths:@[path] withRowAnimation:UITableViewRowAnimationFade];
    }
    self.tableView.editing = NO;
}

/**
 *  移动表格方法
 */
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath
{
    HeroModel *hero = self.heroArray[sourceIndexPath.row];
    [self.heroArray removeObjectAtIndex:sourceIndexPath.row];
    [self.heroArray insertObject:hero atIndex:destinationIndexPath.row];
    self.tableView.editing = NO;
}

#pragma mark - UITableViewDelegate代理方法

/**
 *  辅助按钮点击方法
 */
- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"警告" message:@"暂无详细信息" delegate:self cancelButtonTitle:@"返回" otherButtonTitles:nil];
    [alertView show];
}

/**
 *  每行编辑模式方法
 */
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row % 5)
        return UITableViewCellEditingStyleDelete;
    else
        return UITableViewCellEditingStyleInsert;
}

@end