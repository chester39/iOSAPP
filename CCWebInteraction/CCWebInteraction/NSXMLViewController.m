//
//	iOS培训
//		传智播客 & 黑马
//		Chen Chen @ July 22nd, 2015
//

#import "NSXMLViewController.h"
#import "VideoModel.h"
#import <MediaPlayer/MediaPlayer.h>
#import "UIImageView+WebCache.h"

/**
 *  视频URL地址
 */
#define CCVideoURL(path) [NSURL URLWithString:[NSString stringWithFormat:@"http://192.168.1.110:8080/MJServer/%@", path]]

@interface NSXMLViewController () <NSXMLParserDelegate>

/**
 *  视频数组
 */
@property (strong, nonatomic) NSMutableArray *videoArray;

@end

@implementation NSXMLViewController

#pragma mark - 初始化方法

/**
 *  视频数组惰性初始化方法
 */
- (NSMutableArray *)videoArray
{
    if (_videoArray == nil) {
        _videoArray = [[NSMutableArray alloc] init];
    }
    return _videoArray;
}

#pragma mark - 系统方法

/**
 *  视图已经加载方法
 */
- (void)viewDidLoad
{
    [super viewDidLoad];
    NSURL *url = CCVideoURL(@"video?type=XML");
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        if (connectionError || data == nil) {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"通知" message:@"请求失败" delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil];
            [alertView show];
            return;
        }
        NSXMLParser *parser = [[NSXMLParser alloc] initWithData:data];
        parser.delegate = self;
        [parser parse];
        [self.tableView reloadData];
    }];
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
    return self.videoArray.count;
}

/**
 *  每行内容方法
 */
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"VIDEO";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil)
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    VideoModel *video = self.videoArray[indexPath.row];
    cell.textLabel.text = video.name;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"视频时长：%d分钟", video.length];
    NSURL *url = CCVideoURL(video.image);
    [cell.imageView sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"Placeholder"]];
    return cell;
}

#pragma mark - UITableViewDelegate代理方法

/**
 *  选中行方法
 */
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    VideoModel *video = self.videoArray[indexPath.row];
    NSURL *url = CCVideoURL(video.url);
    MPMoviePlayerViewController *playervc = [[MPMoviePlayerViewController alloc] initWithContentURL:url];
    [self presentViewController:playervc animated:YES completion:nil];
}

#pragma mark - NSXMLParserDelegate代理方法

/**
 *  开始解析XML文档方法
 */
- (void)parserDidStartDocument:(NSXMLParser *)parser
{
    NSLog(@"%s", __func__);
}

/**
 *  结束解析XML文档方法
 */
- (void)parserDidEndDocument:(NSXMLParser *)parser
{
    NSLog(@"%s", __func__);
}

/**
 *  开始解析XML元素方法
 */
- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
    if ([elementName isEqualToString:@"videos"]) {
        NSLog(@"%@", elementName);
        return;
    }
    VideoModel *video = [VideoModel videoModelWithDict:attributeDict];
    [self.videoArray addObject:video];
}

/**
 *  结束解析XML元素方法
 */
- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    NSLog(@"%@", elementName);
}

@end