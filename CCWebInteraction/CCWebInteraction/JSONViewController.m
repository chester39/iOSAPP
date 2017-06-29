//
//  JSONViewController.m
//      CCWebInteraction
//      Chen Chen @ July 22nd, 2015
//

#import "JSONViewController.h"
#import "VideoModel.h"
#import <MediaPlayer/MediaPlayer.h>
#import "UIImageView+WebCache.h"

/**
 *  视频URL地址
 */
#define CCVideoURL(path) [NSURL URLWithString:[NSString stringWithFormat:@"http://192.168.1.110:8080/MJServer/%@", path]]

@interface JSONViewController ()

/**
 *  视频数组
 */
@property (strong, nonatomic) NSMutableArray *videoArray;

@end

@implementation JSONViewController

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
    NSURL *url = CCVideoURL(@"video");
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        if (connectionError || data == nil) {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"通知" message:@"请求失败" delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil];
            [alertView show];
            return;
        }
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
        NSArray *array = dict[@"videos"];
        for (NSDictionary *videoDict in array) {
            VideoModel *video = [VideoModel videoModelWithDict:videoDict];
            [self.videoArray addObject:video];
        }
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

@end
