//
//	iOS培训
//		传智播客 & 黑马
//		Chen Chen @ Apirl 23rd, 2015
//

#import <UIKit/UIKit.h>
@class GroupModel;

@interface GroupCell : UITableViewCell

/**
 *  团购模型
 */
@property (strong, nonatomic) GroupModel *group;

/**
 *  GroupCell指定初始化方法
 */
+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
