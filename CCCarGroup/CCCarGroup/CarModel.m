//
//  CarModel.m
//      CCCarGroup
//      Chen Chen @ Apirl 22nd, 2015
//

#import "CarModel.h"

@implementation CarModel

/**
 *  字典转模型实例方法
 */
- (instancetype)initWithDict:(NSDictionary *)dict
{
    self = [super init];
    if (self)
        [self setValuesForKeysWithDictionary:dict];
    return self;
}

/**
 *  字典转模型类方法
 */
+ (instancetype)carModelWithDict:(NSDictionary *)dict
{
    return [[self alloc] initWithDict:dict];
}

@end
