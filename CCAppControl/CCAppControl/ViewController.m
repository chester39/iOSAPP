//
//	ViewController.m
//		CCAppControl
//		Chen Chen @ Apirl 15th, 2015
//

#import "ViewController.h"
#import "AppModel.h"
#import "AppView.h"

@interface ViewController () <AppViewDelegate>

/// 提示标签
@property (strong, nonatomic) UILabel *tipLabel;
/// 应用数组
@property (strong, nonatomic) NSArray *appArray;

@end

@implementation ViewController

#pragma mark - 初始化方法

/**
 *  应用数组惰性初始化方法
 */
- (NSArray *)appArray {
    
    if (_appArray == nil) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"AppList.plist" ofType:nil];
        NSArray *dictArray = [NSArray arrayWithContentsOfFile:path];
        NSMutableArray *apps = [NSMutableArray array];
        for (NSDictionary *dict in dictArray) {
            AppModel *app = [[AppModel alloc] initWithDict:dict];
            [apps addObject:app];
        }
        
        _appArray = apps;
    }
    
    return  _appArray;
}

/**
 *  提示标签惰性初始化方法
 */
- (UILabel *)tipLabel {
    
    if (_tipLabel == nil) {
        _tipLabel = [[UILabel alloc] init];
        _tipLabel.textColor = [UIColor whiteColor];
        _tipLabel.backgroundColor = [UIColor grayColor];
        _tipLabel.textAlignment = NSTextAlignmentCenter;
        _tipLabel.alpha = 0.0;
        _tipLabel.layer.cornerRadius = 10;
        _tipLabel.layer.masksToBounds = YES;
        
        CGFloat labelWidth = 200;
        CGFloat labelHeight = 44;
        CGFloat labelX = (self.view.frame.size.width - labelWidth) / 2;
        CGFloat labelY = (self.view.frame.size.height) * 3 / 4;
        _tipLabel.frame = CGRectMake(labelX, labelY, labelWidth, labelHeight);
        [self.view addSubview:_tipLabel];
    }
    
    return _tipLabel;
}

#pragma mark - 系统方法

/**
 *  视图已经加载方法
 */
- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    int totalColumns = 3;
    CGFloat appWidth = 85;
    CGFloat appHeight = 90;
    CGFloat marginX = (self.view.frame.size.width - totalColumns * appWidth) / (totalColumns + 1);
    CGFloat marginY = 30;
    
    for (int i = 0; i < self.appArray.count; ++i) {
        AppView *appView = [AppView appViewWithAppModel:self.appArray[i]];
        appView.delegate = self;
        [self.view addSubview:appView];
        
        int row = i / totalColumns;
        int col = i % totalColumns;
        CGFloat appX = marginX + col * (appWidth + marginX);
        CGFloat appY = marginY + row * (appHeight + marginY);
        appView.frame = CGRectMake(appX, appY, appWidth, appHeight);
    }
}

#pragma mark - AppViewDelegate代理方法

/**
 *  点击下载按钮方法
 */
- (void)appViewDidClickDownloadButton:(AppView *)appView {
    
    self.tipLabel.text = [NSString stringWithFormat:@"成功下载%@", appView.appModel.name];
    [UIView animateWithDuration:1.0 animations:^{
        self.tipLabel.alpha = 0.5;
        
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:1.0 delay:2.0 options:UIViewAnimationOptionCurveLinear animations:^{
            self.tipLabel.alpha = 0.0;
            
        } completion:^(BOOL finished) {
        }];
    }];
}

@end
