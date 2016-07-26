//
//	iOS培训
//		传智播客 & 黑马
//		Chen Chen @ Apirl 19th, 2015
//

#import "ViewController.h"

/**
 *  总图片数
 */
static const NSInteger totalImages = 5;

@interface ViewController () <UIScrollViewDelegate>

/**
 *  主界面
 */
@property (weak, nonatomic) IBOutlet UIScrollView *MainScrollView;
/**
 *  广告界面
 */
@property (weak, nonatomic) IBOutlet UIScrollView *adScrollView;
/**
 *  底部按钮界面
 */
@property (weak, nonatomic) IBOutlet UIView *bottomView;
/**
 *  最后一个按钮
 */
@property (weak, nonatomic) IBOutlet UIButton *lastButton;
/**
 *  页码控制器
 */
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;
/**
 *  定时器
 */
@property (strong, nonatomic) NSTimer *timer;

@end

@implementation ViewController

#pragma mark - 系统方法

/**
 *  视图已经加载方法
 */
- (void)viewDidLoad
{
    [super viewDidLoad];
    CGFloat contentWidth = 0;
    CGFloat contentHeight = CGRectGetMaxY(self.lastButton.frame) + 20;
    self.MainScrollView.contentSize = CGSizeMake(contentWidth, contentHeight);
    self.MainScrollView.contentInset = UIEdgeInsetsMake(self.adScrollView.frame.size.height, 0, self.bottomView.frame.size.height, 0);
    self.MainScrollView.contentOffset = CGPointMake(0, -self.adScrollView.frame.size.height);
    [self addAd];
}

#pragma mark - 广告界面方法

/**
 *  添加广告方法
 */
- (void)addAd
{
    int imageWidth = self.adScrollView.frame.size.width;
    int imageHeight = self.adScrollView.frame.size.height;
    int imageY = 0;
    for (int i = 0; i < totalImages; ++i) {
        UIImageView *imageView = [[UIImageView alloc] init];
        int imageX = i * imageWidth;
        imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"img_0%d", i + 1]];
        imageView.frame = CGRectMake(imageX, imageY, imageWidth, imageHeight);
        [self.adScrollView addSubview:imageView];
    }
    CGFloat contentWidth = totalImages * imageWidth;
    self.adScrollView.contentSize = CGSizeMake(contentWidth, 0);
    self.adScrollView.showsHorizontalScrollIndicator = NO;
    self.adScrollView.pagingEnabled = YES;
    self.pageControl.numberOfPages = totalImages;
    [self addTimer];
}

/**
 *  下一张图片方法
 */
- (void)nextImage
{
    NSInteger page = 0;
    if (self.pageControl.currentPage == totalImages - 1)
        page = 0;
    else
        page = self.pageControl.currentPage + 1;
    CGFloat offsetX = page * self.adScrollView.frame.size.width;
    CGFloat offsetY = 0;
    CGPoint offset = CGPointMake(offsetX, offsetY);
    [self.adScrollView setContentOffset:offset animated:YES];
}

#pragma mark - 定时器方法

/**
 *  添加定时器方法
 */
- (void)addTimer
{
    self.timer = [NSTimer timerWithTimeInterval:2.0 target:self selector:@selector(nextImage) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}

/**
 *  删除定时器方法
 */
- (void)removeTimer
{
    [self.timer invalidate];
    self.timer = nil;
}

#pragma mark - UIScrollViewDelegate代理方法

/**
 *  开始滚动方法
 */
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat scrollWidth = scrollView.frame.size.width;
    int page = (scrollView.contentOffset.x + scrollWidth / 2) / scrollWidth;
    self.pageControl.currentPage = page;
}

/**
 *  将被抓拽方法
 */
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self removeTimer];
}

/**
 *  结束抓拽方法
 */
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [self addTimer];
}

@end
