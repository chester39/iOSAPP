//
//  FriendHeaderView.h
//      CCFriendList
//      Chen Chen @ June 4th, 2015
//

#import <UIKit/UIKit.h>

@class FriendGroup, FriendHeaderView;

/**
 *  自定义FriendHeaderViewDelegate代理协议
 */
@protocol FriendHeaderViewDelegate <NSObject>
@optional

- (void)headerViewDidClickNameView:(FriendHeaderView *)headerView;

@end

@interface FriendHeaderView : UITableViewHeaderFooterView

/**
 *  组别好友
 */
@property (strong, nonatomic) FriendGroup *friendGroup;
/**
 *  FriendHeaderViewDelegate代理
 */
@property (weak, nonatomic) id<FriendHeaderViewDelegate> delegate;

/**
 *  HeaderView指定初始化方法
 */
+ (instancetype)headerViewWithTableView:(UITableView *)tableView;

@end
