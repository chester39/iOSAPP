//
//  CarGroup.m
//      CCCarGroup
//      Chen Chen @ Apirl 22nd, 2015
//

#import "CarGroup.h"
#import "CarModel.h"

@implementation CarGroup

/**
 *  字典转模型实例方法
 */
- (instancetype)initWithDict:(NSDictionary *)dict
{
    self = [super init];
    if (self) {
        self.title = dict[@"title"];
        NSArray *dictArray = dict[@"cars"];
        NSMutableArray *carArray = [NSMutableArray array];
        for (NSDictionary *dict in dictArray) {
            CarModel *car = [CarModel carModelWithDict:dict];
            [carArray addObject:car];
        }
        self.cars = carArray;
    }
    return self;
}

/**
 *  字典转模型类方法
 */
+ (instancetype)carGroupWithDict:(NSDictionary *)dict
{
    return [[self alloc] initWithDict:dict];
}

@end
