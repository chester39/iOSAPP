//
//	iOS培训
//		传智播客 & 黑马
//		Chen Chen @ Apirl 15th, 2015
//

#import "AppView.h"
#import "AppModel.h"

@interface AppView()

/**
 *  图标视图
 */
@property (weak, nonatomic) IBOutlet UIImageView *iconView;
/**
 *  名称标签
 */
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@end

@implementation AppView

#pragma mark - 初始化方法

/**
 *  AppView指定初始化方法
 */
+ (instancetype)appViewWithAppModel:(AppModel *)appModel
{
    NSArray *objectArray = [[NSBundle mainBundle] loadNibNamed:@"AppView" owner:nil options:nil];
    AppView *appView = [objectArray lastObject];
    appView.appModel = appModel;
    return appView;
}

/**
 *  AppView无模型初始化方法
 */
+ (instancetype)appView
{
    return [self appViewWithAppModel:nil];
}

/**
 *  重写应用模型的setter方法
 */
- (void)setAppModel:(AppModel *)appModel
{
    _appModel = appModel;
    self.iconView.image = [UIImage imageNamed:appModel.icon];
    self.nameLabel.text = appModel.name;
}

#pragma mark - 下载方法

/**
 *  下载方法
 */
- (IBAction)download:(UIButton *)sender
{
    [sender setTitle:@"已下载" forState:UIControlStateNormal];
    sender.enabled = NO;
    if ([self.delegate respondsToSelector:@selector(appViewDidClickDownloadButton:)])
        [self.delegate appViewDidClickDownloadButton:self];
}

@end
