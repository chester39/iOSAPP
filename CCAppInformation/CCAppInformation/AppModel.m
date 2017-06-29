//
//  AppModel.m
//      CCAppInformation
//      Chen Chen @ July 19th, 2015
//

#import "AppModel.h"

@implementation AppModel

- (instancetype)initWithDict:(NSDictionary *)dict
{
    self = [super init];
    if (self)
        [self setValuesForKeysWithDictionary:dict];
    return self;
}

+ (instancetype)appModelWithDict:(NSDictionary *)dict
{
    return [[self alloc] initWithDict:dict];
}

@end
