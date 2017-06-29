//
//  ChatModel.h
//      CCChatInterface
//      Chen Chen @ June 3rd, 2015
//

#import <Foundation/Foundation.h>

/**
 *  消息用户枚举数组
 */
typedef enum {
    /**
     *  自己消息
     */
    CCChatTypeMe = 0,
    /**
     *  别人消息
     */
    CCChatTypeOther
} CCChatType;

@interface ChatModel : NSObject

/**
 *  消息时间
 */
@property (copy, nonatomic) NSString *time;
/**
 *  消息内容
 */
@property (copy, nonatomic) NSString *text;
/**
 *  消息类型
 */
@property (nonatomic) CCChatType type;
/**
 *  是否隐藏时间
 */
@property (nonatomic) BOOL isHideTime;

/**
 *  字典转模型实例方法
 */
- (instancetype)initWithDict:(NSDictionary *)dict;
/**
 *  字典转模型类方法
 */
+ (instancetype)chatModelWithDict:(NSDictionary *)dict;

@end
