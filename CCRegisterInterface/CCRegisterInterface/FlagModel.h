//
//	iOS培训
//		传智播客 & 黑马
//		Chen Chen @ June 7th, 2015
//

#import <Foundation/Foundation.h>

@interface FlagModel : NSObject

/**
 *  国名
 */
@property (copy, nonatomic) NSString *name;
/**
 *  国旗
 */
@property (copy, nonatomic) NSString *icon;

/**
 *  字典转模型实例方法
 */
- (instancetype)initWithDict:(NSDictionary *)dict;
/**
 *  字典转模型类方法
 */
+ (instancetype)flagModelWithDict:(NSDictionary *)dict;

@end
