//
//  ViewController.m
//      CCAppInformation
//      Chen Chen @ July 19th, 2015
//

#import "ViewController.h"
#import "AppModel.h"
#import "DownloadOperation.h"

/**
 *  图片URL文件地址
 */
#define CCImagePath(URL) [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:[URL lastPathComponent]]

@interface ViewController () <DownloadOperationDelegate>

/**
 *  应用数组
 */
@property (strong, nonatomic) NSArray *appArray;
/**
 *  操作数组
 */
@property (strong, nonatomic) NSMutableDictionary *operationArray;
/**
 *  图片数组
 */
@property (strong, nonatomic) NSMutableDictionary *imageArray;
/**
 *  操作队列
 */
@property (strong, nonatomic) NSOperationQueue *queue;

@end

@implementation ViewController

#pragma mark - 初始化方法

/**
 *  应用数组惰性初始化方法
 */
- (NSArray *)appArray
{
    if (_appArray == nil) {
        NSArray *dictArray = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"apps" ofType:@"plist"]];
        NSMutableArray *apps = [NSMutableArray array];
        for (NSDictionary *dict in dictArray) {
            AppModel *app = [AppModel appModelWithDict:dict];
            [apps addObject:app];
        }
        _appArray = apps;
    }
    return _appArray;
}

/**
 *  操作数组惰性初始化方法
 */
- (NSMutableDictionary *)operationArray
{
    if (_operationArray == nil)
        _operationArray = [[NSMutableDictionary alloc] init];
    return _operationArray;
}

/**
 *  图片数组惰性初始化方法
 */
- (NSMutableDictionary *)imageArray
{
    if (_imageArray == nil)
        _imageArray = [[NSMutableDictionary alloc] init];
    return _imageArray;
}

/**
 *  操作队列惰性初始化方法
 */
- (NSOperationQueue *)queue
{
    if (_queue == nil)
        _queue = [[NSOperationQueue alloc] init];
    return _queue;
}

#pragma mark - 系统方法

/**
 *  视图已经加载方法
 */
- (void)viewDidLoad
{
    [super viewDidLoad];
}

/**
 *  收到内存警告方法
 */
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    [self.queue cancelAllOperations];
    [self.operationArray removeAllObjects];
    [self.imageArray removeAllObjects];
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
    static NSString *ID = @"APP";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil)
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    AppModel *app = self.appArray[indexPath.row];
    cell.textLabel.text = app.name;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"下载量：%@", app.download];
    UIImage *image = self.imageArray[app.icon];
    if (image == nil) {
        NSString *file = CCImagePath(app.icon);
        NSData *data = [NSData dataWithContentsOfFile:file];
        if (data == nil) {
            cell.imageView.image = [UIImage imageNamed:@"Placeholder"];
            [self downloadWithURL:app.icon atIndexPath:indexPath];
        } else
            cell.imageView.image = [UIImage imageWithData:data];
    } else
        cell.imageView.image = image;
    return cell;
}

#pragma mark - UIScrollViewDelegate代理方法

/**
 *  将被抓拽方法
 */
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.queue setSuspended:YES];
}

/**
 *  结束抓拽方法
 */
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [self.queue setSuspended:NO];
}

#pragma mark - DownloadOperationDelegate代理方法

/**
 *  完成下载图片方法
 */
- (void)downloadOperation:(DownloadOperation *)operation didFinishWithImage:(UIImage *)image
{
    if (image) {
        self.imageArray[operation.imageURL] = image;
        NSData *data = UIImagePNGRepresentation(image);
        [data writeToFile:CCImagePath(operation.imageURL) atomically:YES];
    }
    [self.operationArray removeObjectForKey:operation.imageURL];
    [self.tableView reloadRowsAtIndexPaths:@[operation.indexPath] withRowAnimation:UITableViewRowAnimationNone];
}

#pragma mark - 图片方法

/**
 *  URL下载图片方法
 */
- (void)downloadWithURL:(NSString *)imageURL atIndexPath:(NSIndexPath *)indexPath
{
    DownloadOperation *operation = self.operationArray[imageURL];
    if (operation)
        return;
    operation = [[DownloadOperation alloc] init];
    operation.imageURL = imageURL;
    operation.indexPath = indexPath;
    operation.delegate = self;
    [self.queue addOperation:operation];
    self.operationArray[imageURL] = operation;
}

@end
