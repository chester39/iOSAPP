//
//  HeroModel.m
//      CCHeroEdit
//      Chen Chen @ May 31st, 2015
//

#import "HeroModel.h"

@implementation HeroModel

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
+ (instancetype)heroModelWithDict:(NSDictionary *)dict
{
    return [[self alloc] initWithDict:dict];
}

@end
