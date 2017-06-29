//
//  ContactCell.m
//      CCPersonalContacts
//      Chen Chen @ June 11th, 2015
//

#import "ContactCell.h"
#import "ContactModel.h"

@interface ContactCell ()

/**
 *  分隔符
 */
@property (weak, nonatomic) UIView *divider;

@end

@implementation ContactCell

#pragma mark - 初始化方法

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"CONTACT";
    ContactCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    return cell;
}

/**
 *  重写联系人模型的setter方法
 */
- (void)setContact:(ContactModel *)contact
{
    _contact = contact;
    self.textLabel.text = contact.name;
    self.detailTextLabel.text = contact.phone;
}

#pragma mark - 系统方法

/**
 *  xib唤醒方法
 */
- (void)awakeFromNib
{
    UIView *divider = [[UIView alloc] init];
    divider.backgroundColor = [UIColor blackColor];
    divider.alpha = 0.2;
    [self.contentView addSubview:divider];
    self.divider = divider;
}

/**
 *  cell选中方法
 */
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

/**
 *  更新父控件尺寸方法
 */
- (void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat dividerWidth = self.frame.size.width;
    CGFloat dividerHeight = 1;
    CGFloat dividerX = 0;
    CGFloat dividerY = self.frame.size.height - dividerHeight;
    self.divider.frame = CGRectMake(dividerX, dividerY, dividerWidth, dividerHeight);
}

@end
