//
//  VideoModel.m
//      CCWebInteraction
//      Chen Chen @ July 22nd, 2015
//

#import "VideoModel.h"

@implementation VideoModel

- (instancetype)initWithDict:(NSDictionary *)dict
{
    self = [super init];
    if (self)
        [self setValuesForKeysWithDictionary:dict];
    return self;
}

+ (instancetype)videoModelWithDict:(NSDictionary *)dict
{
    return [[self alloc] initWithDict:dict];
}

@end
