//
//  CityModel.h
//      CCRegisterInterface
//      Chen Chen @ June 7th, 2015
//

#import <Foundation/Foundation.h>

@interface CityModel : NSObject

/**
 *  省份
 */
@property (copy, nonatomic) NSString *name;
/**
 *  城市
 */
@property (strong, nonatomic) NSArray *cities;

/**
 *  字典转模型实例方法
 */
- (instancetype)initWithDict:(NSDictionary *)dict;
/**
 *  字典转模型类方法
 */
+ (instancetype)cityModelWithDict:(NSDictionary *)dict;

@end
