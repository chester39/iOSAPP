//
//	iOS培训
//		传智播客 & 黑马
//		Chen Chen @ June 4th, 2015
//

#import <Foundation/Foundation.h>

@interface FriendGroup : NSObject

/**
 *  组别名称
 */
@property (copy, nonatomic) NSString *name;
/**
 *  组别好友
 */
@property (strong, nonatomic) NSArray *friends;
/**
 *  在线人数
 */
@property (nonatomic) int online;
/**
 *  是否展开组别
 */
@property (nonatomic, getter = isOpen) BOOL open;

/**
 *  字典转模型实例方法
 */
- (instancetype)initWithDict:(NSDictionary *)dict;
/**
 *  字典转模型类方法
 */
+ (instancetype)friendGroupModelWithDict:(NSDictionary *)dict;

@end
