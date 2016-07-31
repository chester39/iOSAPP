//
//	iOS培训
//		传智播客 & 黑马
//		Chen Chen @ June 2nd, 2015
//

#import "WeiboCell.h"
#import "WeiboModel.h"

@interface WeiboCell()

/**
 *  用户头像
 */
@property (weak, nonatomic) IBOutlet UIImageView *iconView;
/**
 *  用户昵称
 */
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
/**
 *  VIP会员
 */
@property (weak, nonatomic) IBOutlet UIImageView *vipView;
/**
 *  微博内容
 */
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
/**
 *  微博图片
 */
@property (strong, nonatomic) UIImageView *pictureView;

@end

@implementation WeiboCell

#pragma mark - 初始化方法

/**
 *  微博图片惰性初始化方法
 */
- (UIImageView *)pictureView
{
    if (_pictureView == nil) {
        _pictureView = [[UIImageView alloc] init];
        [self.contentView addSubview:_pictureView];
    }
    return _pictureView;
}

/**
 *  重写微博模型的setter方法
 */
- (void)setWeibo:(WeiboModel *)weibo
{
    _weibo = weibo;
    self.iconView.image = [UIImage imageNamed:weibo.icon];
    self.nameLabel.text = weibo.name;
    self.vipView.hidden = (weibo.vip == 0);
    if (self.vipView.hidden)
        self.nameLabel.textColor = [UIColor blackColor];
    else
        self.nameLabel.textColor = [UIColor redColor];
    self.contentLabel.text = weibo.text;
    self.pictureView.hidden = (weibo.picture.length == 0);
    if (!self.pictureView.hidden) {
        self.pictureView.image = [UIImage imageNamed:weibo.picture];
        self.pictureView.frame = _weibo.pictureFrame;
    }
}

@end
