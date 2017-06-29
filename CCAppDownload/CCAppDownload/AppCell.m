//
//  AppCell.m
//      CCAppDownload
//      Chen Chen @ June 5th, 2015
//

#import "AppCell.h"
#import "AppModel.h"

@interface AppCell ()

/**
 *  图标
 */
@property (weak, nonatomic) IBOutlet UIImageView *iconView;
/**
 *  名称
 */
@property (weak, nonatomic) IBOutlet UILabel *nameView;
/**
 *  介绍
 */
@property (weak, nonatomic) IBOutlet UILabel *introView;
/**
 *  下载按钮
 */
@property (weak, nonatomic) IBOutlet UIButton *downloadButton;

@end

@implementation AppCell

#pragma mark - 初始化方法

/**
 *  重写应用模型的setter方法
 */
- (void)setApp:(AppModel *)app
{
    _app = app;
    self.iconView.image = [UIImage imageNamed:app.icon];
    self.nameView.text = app.name;
    self.introView.text = [NSString stringWithFormat:@"大小: %@   |   下载量: %@", app.size, app.download];
}

#pragma mark - 下载方法

/**
 *  下载方法
 */
- (IBAction)download:(UIButton *)sender
{
    [sender setTitle:@"已下载" forState:UIControlStateNormal];
    self.app.isDownload = YES;
    sender.enabled = NO;
    if ([self.delegate respondsToSelector:@selector(appCellDidClickDownloadButton:)])
        [self.delegate appCellDidClickDownloadButton:self];
}

@end
