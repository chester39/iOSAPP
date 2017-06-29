//
//  CarGroup.h
//      CCCarGroup
//      Chen Chen @ Apirl 22nd, 2015
//

#import <Foundation/Foundation.h>

@interface CarGroup : NSObject

/**
 *  组别标题
 */
@property (copy, nonatomic) NSString *title;
/**
 *  组别汽车
 */
@property (strong, nonatomic) NSArray *cars;

/**
 *  字典转模型实例方法
 */
- (instancetype)initWithDict:(NSDictionary *)dict;
/**
 *  字典转模型类方法
 */
+ (instancetype)carGroupWithDict:(NSDictionary *)dict;

@end
