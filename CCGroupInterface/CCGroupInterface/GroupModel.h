//
//	iOS培训
//		传智播客 & 黑马
//		Chen Chen @ Apirl 23rd, 2015
//

#import <Foundation/Foundation.h>

@interface GroupModel : NSObject

/**
 *  商店名字
 */
@property (copy, nonatomic) NSString *title;
/**
 *  商店标志
 */
@property (copy, nonatomic) NSString *icon;
/**
 *  商店价格
 */
@property (copy, nonatomic) NSString *price;
/**
 *  购买人数
 */
@property (copy, nonatomic) NSString *buyCount;

/**
 *  字典转模型实例方法
 */
- (instancetype)initWithDict:(NSDictionary *)dict;
/**
 *  字典转模型类方法
 */
+ (instancetype)groupModelWithDict:(NSDictionary *)dict;

@end
