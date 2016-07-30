//
//	iOS培训
//		传智播客 & 黑马
//		Chen Chen @ Apirl 23rd, 2015
//

#import "GroupCell.h"
#import "GroupModel.h"

@interface GroupCell()

/**
 *  店标视图
 */
@property (weak, nonatomic) IBOutlet UIImageView *iconView;
/**
 *  店名视图
 */
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
/**
 *  价格视图
 */
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
/**
 *  购买人数视图
 */
@property (weak, nonatomic) IBOutlet UILabel *buyCountLabel;

@end

@implementation GroupCell

#pragma mark - 初始化方法

/**
 *  重写团购模型的setter方法
 */
- (void)setGroup:(GroupModel *)group
{
    _group = group;
    self.iconView.image = [UIImage imageNamed:group.icon];
    self.titleLabel.text = group.title;
    self.priceLabel.text = [NSString stringWithFormat:@"人均：￥%@", group.price];
    self.buyCountLabel.text = [NSString stringWithFormat:@"%@人已购买", group.buyCount];
}

/**
 *  GroupCell指定初始化方法
 */
+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"GROUP";
    GroupCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil)
        cell = [[[NSBundle mainBundle] loadNibNamed:@"GroupCell" owner:nil options:nil] lastObject];
    return cell;
}

#pragma mark - 系统方法

/**
 *  cell选中方法
 */
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

@end
