//
//	iOS培训
//		传智播客 & 黑马
//		Chen Chen @ June 4th, 2015
//

#import "FriendCell.h"
#import "FriendModel.h"

@implementation FriendCell

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"FRIEND";
    FriendCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil)
        cell = [[FriendCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    return cell;
}

/**
 *  重写好友模型的setter方法
 */
- (void)setFriendModel:(FriendModel *)friendModel
{
    _friendModel = friendModel;
    self.imageView.image = [UIImage imageNamed:friendModel.icon];
    self.textLabel.text = friendModel.name;
    self.textLabel.textColor = friendModel.isVip ? [UIColor redColor] : [UIColor blackColor];
    self.detailTextLabel.text = friendModel.intro;
}

@end
