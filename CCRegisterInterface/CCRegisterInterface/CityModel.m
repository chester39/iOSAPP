//
//  CityModel.m
//      CCRegisterInterface
//      Chen Chen @ June 7th, 2015
//

#import "CityModel.h"

@implementation CityModel

- (instancetype)initWithDict:(NSDictionary *)dict
{
    self = [super init];
    if (self)
        [self setValuesForKeysWithDictionary:dict];
    return self;
}

+ (instancetype)cityModelWithDict:(NSDictionary *)dict
{
    return [[self alloc] initWithDict:dict];
}

@end
