//
//  FriendHeaderView.m
//      CCFriendList
//      Chen Chen @ June 4th, 2015
//

#import "FriendHeaderView.h"
#import "FriendGroup.h"

@interface FriendHeaderView ()

/**
 *  组别名称
 */
@property (weak, nonatomic) UIButton *nameView;
/**
 *  在线人数
 */
@property (weak, nonatomic) UILabel *countView;

@end

@implementation FriendHeaderView

#pragma mark - 初始化方法

+ (instancetype)headerViewWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"HEADER";
    FriendHeaderView *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:ID];
    if (header == nil)
        header = [[FriendHeaderView alloc] initWithReuseIdentifier:ID];
    return header;
}

/**
 *  重写好友分组的setter方法
 */
- (void)setFriendGroup:(FriendGroup *)friendGroup
{
    _friendGroup = friendGroup;
    [self.nameView setTitle:friendGroup.name forState:UIControlStateNormal];
    self.countView.text = [NSString stringWithFormat:@"%d/%ld", friendGroup.online, friendGroup.friends.count];
    [self didMoveToSuperview];
}

#pragma mark - 系统方法

/**
 *  标识符初始化方法
 */
- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        UIButton *nameView = [UIButton buttonWithType:UIButtonTypeCustom];
        [nameView setBackgroundImage:[UIImage imageNamed:@"buddy_header_bg"] forState:UIControlStateNormal];
        [nameView setBackgroundImage:[UIImage imageNamed:@"buddy_header_bg_highlighted"] forState:UIControlStateHighlighted];
        [nameView setImage:[UIImage imageNamed:@"buddy_header_arrow"] forState:UIControlStateNormal];
        [nameView setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        nameView.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        nameView.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
        nameView.contentEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
        [nameView addTarget:self action:@selector(clickNameView) forControlEvents:UIControlEventTouchUpInside];
        nameView.imageView.contentMode = UIViewContentModeCenter;
        nameView.imageView.clipsToBounds = NO;
        [self.contentView addSubview:nameView];
        self.nameView = nameView;
        UILabel *countView = [[UILabel alloc] init];
        countView.textAlignment = NSTextAlignmentRight;
        countView.textColor = [UIColor grayColor];
        [self.contentView addSubview:countView];
        self.countView = countView;
    }
    return self;
}

/**
 *  更新父控件尺寸方法
 */
- (void)layoutSubviews
{
    [super layoutSubviews];
    self.nameView.frame = self.bounds;
    CGFloat padding = 10;
    CGFloat countWidth = 150;
    CGFloat countHeight = self.frame.size.height;
    CGFloat countX = self.frame.size.width - countWidth - padding;
    CGFloat countY = 0;
    self.countView.frame = CGRectMake(countX, countY, countWidth, countHeight);
}

/**
 *  子控件加入父控件方法
 */
- (void)didMoveToSuperview
{
    if (self.friendGroup.isOpen) {
        self.nameView.imageView.transform = CGAffineTransformMakeRotation(M_PI_2);
    } else {
        self.nameView.imageView.transform = CGAffineTransformMakeRotation(0);
    }
}

#pragma mark - 点击方法

/**
 *  点击组别名称方法
 */
- (void)clickNameView
{
    self.friendGroup.open = !self.friendGroup.isOpen;
    if ([self.delegate respondsToSelector:@selector(headerViewDidClickNameView:)])
        [self.delegate headerViewDidClickNameView:self];
}

@end
