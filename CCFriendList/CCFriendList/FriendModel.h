//
//	iOS培训
//		传智播客 & 黑马
//		Chen Chen @ June 4th, 2015
//

#import <Foundation/Foundation.h>

@interface FriendModel : NSObject

/**
 *  好友姓名
 */
@property (copy, nonatomic) NSString *name;
/**
 *  好友头像
 */
@property (copy, nonatomic) NSString *icon;
/**
 *  好友签名
 */
@property (copy, nonatomic) NSString *intro;
/**
 *  VIP会员
 */
@property (nonatomic, getter = isVip) BOOL vip;

/**
 *  字典转模型实例方法
 */
- (instancetype)initWithDict:(NSDictionary *)dict;
/**
 *  字典转模型类方法
 */
+ (instancetype)friendModelWithDict:(NSDictionary *)dict;

@end
