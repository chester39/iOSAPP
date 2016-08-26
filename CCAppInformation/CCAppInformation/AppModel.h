//
//	iOS培训
//		传智播客 & 黑马
//		Chen Chen @ July 19th, 2015
//

#import <Foundation/Foundation.h>

@interface AppModel : NSObject

/**
 *  图标
 */
@property (copy, nonatomic) NSString *icon;
/**
 *  名称
 */
@property (copy, nonatomic) NSString *name;
/**
 *  下载量
 */
@property (copy, nonatomic) NSString *download;

/**
 *  字典转模型实例方法
 */
- (instancetype)initWithDict:(NSDictionary *)dict;
/**
 *  字典转模型类方法
 */
+ (instancetype)appModelWithDict:(NSDictionary *)dict;

@end
