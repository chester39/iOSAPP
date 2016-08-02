//
//	iOS培训
//		传智播客 & 黑马
//		Chen Chen @ June 4th, 2015
//

#import <UIKit/UIKit.h>

@class FriendModel;

@interface FriendCell : UITableViewCell

/**
 *  好友模型
 */
@property (strong, nonatomic) FriendModel *friendModel;

/**
 *  FriendCell指定初始化方法
 */
+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
