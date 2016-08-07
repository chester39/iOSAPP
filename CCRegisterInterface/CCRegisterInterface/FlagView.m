//
//	iOS培训
//		传智播客 & 黑马
//		Chen Chen @ June 7th, 2015
//

#import "FlagView.h"
#import "FlagModel.h"

@interface FlagView()

/**
 *  国名
 */
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
/**
 *  国旗
 */
@property (weak, nonatomic) IBOutlet UIImageView *iconView;

@end

@implementation FlagView

#pragma mark - 初始化方法

/**
 *  重写国旗模型的setter方法
 */
- (void)setFlag:(FlagModel *)flag
{
    _flag = flag;
    self.nameLabel.text = flag.name;
    self.iconView.image = [UIImage imageNamed:flag.icon];
}

+ (instancetype)flagViewWithReusingView:(UIView *)view
{
    if (view == nil) {
        return [[[NSBundle mainBundle] loadNibNamed:@"FlagView" owner:nil options:nil] lastObject];
    } else {
        return (FlagView *)view;
    }
}

#pragma mark - 基本方法

+ (CGFloat)flagViewHeight
{
    return 44;
}

@end
