//
//  CarModel.h
//      CCCarGroup
//      Chen Chen @ Apirl 22nd, 2015
//

#import <Foundation/Foundation.h>

@interface CarModel : NSObject

/**
 *  汽车名字
 */
@property (copy, nonatomic) NSString *name;
/**
 *  汽车商标
 */
@property (copy, nonatomic) NSString *icon;

/**
 *  字典转模型实例方法
 */
- (instancetype)initWithDict:(NSDictionary *)dict;
/**
 *  字典转模型类方法
 */
+ (instancetype)carModelWithDict:(NSDictionary *)dict;

@end
