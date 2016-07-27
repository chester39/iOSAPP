//
//	iOS培训
//		传智播客 & 黑马
//		Chen Chen @ May 31st, 2015
//

#import <Foundation/Foundation.h>

@interface HeroModel : NSObject

/**
 *  图标
 */
@property (copy, nonatomic) NSString *icon;
/**
 *  姓名
 */
@property (copy, nonatomic) NSString *name;
/**
 *  介绍
 */
@property (copy, nonatomic) NSString *intro;

/**
 *  字典转模型实例方法
 */
- (instancetype)initWithDict:(NSDictionary *)dict;
/**
 *  字典转模型类方法
 */
+ (instancetype)heroModelWithDict:(NSDictionary *)dict;

@end
