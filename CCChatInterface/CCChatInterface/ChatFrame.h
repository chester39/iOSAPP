//
//	iOS培训
//		传智播客 & 黑马
//		Chen Chen @ June 3rd, 2015
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

/**
 *  消息时间字体
 */
#define CCChatTimeFont [UIFont systemFontOfSize:13]
/**
 *  消息内容字体
 */
#define CCChatTextFont [UIFont systemFontOfSize:16]
/**
 *  消息内容内边距
 */
#define CCTextPadding 20

@class ChatModel;

@interface ChatFrame : NSObject

/**
 *  消息时间尺寸
 */
@property (nonatomic, readonly) CGRect timeFrame;
/**
 *  用户头像尺寸
 */
@property (nonatomic, readonly) CGRect iconFrame;
/**
 *  消息内容尺寸
 */
@property (nonatomic, readonly) CGRect textFrame;
/**
 *  ChatCell高度
 */
@property (nonatomic, readonly) CGFloat cellHeight;
/**
 *  聊天模型
 */
@property (strong, nonatomic) ChatModel *chat;

@end
