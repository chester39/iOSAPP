//
//  ViewController.m
//      CCCarGroup
//      Chen Chen @ Apirl 22nd, 2015
//

#import "ViewController.h"
#import "CarModel.h"
#import "CarGroup.h"

@interface ViewController () <UITableViewDataSource, UITableViewDelegate, UIAlertViewDelegate>

/**
 *  表格视图
 */
@property (strong, nonatomic) UITableView *tableView;
/**
 *  汽车数组
 */
@property (strong, nonatomic) NSMutableArray *carArray;
/**
 *  汽车组别标识
 */
@property (assign, nonatomic) NSInteger tempTag;

@end

@implementation ViewController

#pragma mark - 初始化方法

/**
 *  汽车数组惰性初始化方法
 */
- (NSMutableArray *)carArray
{
    if (_carArray == nil) {
        NSArray *dictArray = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"cars_total" ofType:@"plist"]];
        NSMutableArray *cars = [NSMutableArray array];
        for (NSDictionary *dict in dictArray) {
            CarGroup *carGroup = [CarGroup carGroupWithDict:dict];
            [cars addObject:carGroup];
        }
        _carArray = cars;
    }
    return _carArray;
}

/**
 *  表格视图惰性初始化方法
 */
- (UITableView *)tableView
{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStyleGrouped];
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
    return self.carArray.count;
}

/**
 *  每组行数方法
 */
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    CarGroup *carGroup = self.carArray[section];
    return carGroup.cars.count;
}

/**
 *  每行内容方法
 */
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"CAR";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil)
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    CarGroup *carGroup = self.carArray[indexPath.section];
    CarModel *car = carGroup.cars[indexPath.row];
    cell.textLabel.text = car.name;
    cell.imageView.image = [UIImage imageNamed:car.icon];
    return cell;
}

/**
 *  每组标题方法
 */
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    CarGroup *carGroup = self.carArray[section];
    return carGroup.title;
}

/**
 *  每组索引方法
 */
- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    return [self.carArray valueForKeyPath:@"title"];
}

#pragma mark - UITableViewDelegate代理方法

/**
 *  选中行方法
 */
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    CarGroup *carGroup = self.carArray[indexPath.section];
    CarModel *car = carGroup.cars[indexPath.row];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"详情" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    alert.alertViewStyle = UIAlertViewStylePlainTextInput;
    [alert textFieldAtIndex:0].text = car.name;
    [alert show];
    alert.delegate = self;
    alert.tag = indexPath.row;
    self.tempTag = indexPath.section;
}

#pragma mark - UIAlertViewDelegate代理方法

/**
 *  警告框按钮点击方法
 */
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0)
        return;
    NSString *name = [alertView textFieldAtIndex:0].text;
    NSInteger row = alertView.tag;
    CarGroup *carGroup = self.carArray[self.tempTag];
    CarModel *car = carGroup.cars[row];
    car.name = name;
    NSIndexPath *path = [NSIndexPath indexPathForRow:row inSection:self.tempTag];
    [self.tableView reloadRowsAtIndexPaths:@[path] withRowAnimation:UITableViewRowAnimationFade];
}

@end
