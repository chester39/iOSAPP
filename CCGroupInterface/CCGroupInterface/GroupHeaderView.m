//
//  GroupHeaderView.m
//      CCGroupInterface
//      Chen Chen @ Apirl 23rd, 2015
//

#import "GroupHeaderView.h"

/**
 *  总图片数
 */
static const NSInteger totalImages = 5;

@interface GroupHeaderView() <UIScrollViewDelegate>

/**
 *  广告界面
 */
@property (weak, nonatomic) IBOutlet UIScrollView *adView;
/**
 *  页码控制器
 */
@property (strong, nonatomic) IBOutlet UIPageControl *pageControl;
/**
 *  定时器
 */
@property (strong, nonatomic) NSTimer *timer;

@end

@implementation GroupHeaderView

#pragma mark - 初始化方法

/**
 *  GroupHeaderView指定初始化方法
 */
+ (instancetype)headerView
{
    return [[[NSBundle mainBundle] loadNibNamed:@"GroupHeaderView" owner:nil options:nil] lastObject];
}

#pragma mark - 系统方法

/**
 *  xib唤醒方法
 */
- (void)awakeFromNib
{
    self.adView.delegate = self;
    [self addAd];
}

#pragma mark - 广告界面方法

/**
 *  添加广告方法
 */
- (void)addAd
{
    int imageWidth = self.adView.frame.size.width;
    int imageHeight = self.adView.frame.size.height;
    int imageY = 0;
    for (int i = 0; i < totalImages; ++i) {
        UIImageView *imageView = [[UIImageView alloc] init];
        int imageX = i * imageWidth;
        imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"ad_0%d", i]];
        imageView.frame = CGRectMake(imageX, imageY, imageWidth, imageHeight);
        [self.adView addSubview:imageView];
    }
    CGFloat contentWidth = totalImages * imageWidth;
    self.adView.contentSize = CGSizeMake(contentWidth, 0);
    self.adView.showsHorizontalScrollIndicator = NO;
    self.adView.pagingEnabled = YES;
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
    CGFloat offsetX = page * self.adView.frame.size.width;
    CGFloat offsetY = 0;
    CGPoint offset = CGPointMake(offsetX, offsetY);
    [self.adView setContentOffset:offset animated:YES];
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
 *  滚动视图开始滚动方法
 */
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat scrollWidth = scrollView.frame.size.width;
    int page = (scrollView.contentOffset.x + scrollWidth / 2) / scrollWidth;
    self.pageControl.currentPage = page;
}

/**
 *  滚动视图将被抓拽方法
 */
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self removeTimer];
}

/**
 *  滚动视图将结束抓拽方法
 */
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [self addTimer];
}

@end
