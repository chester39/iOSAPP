//
//  ChatCell.h
//      CCChatInterface
//      Chen Chen @ June 3rd, 2015
//

#import <UIKit/UIKit.h>

@class ChatFrame;

@interface ChatCell : UITableViewCell

/**
 *  聊天尺寸
 */
@property (strong, nonatomic) ChatFrame *chatFrame;

/**
 *  ChatCell指定初始化方法
 */
+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
