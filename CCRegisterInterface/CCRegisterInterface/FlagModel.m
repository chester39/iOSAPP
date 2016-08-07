//
//	iOS培训
//		传智播客 & 黑马
//		Chen Chen @ June 7th, 2015
//

#import "FlagModel.h"

@implementation FlagModel

- (instancetype)initWithDict:(NSDictionary *)dict
{
    self = [super init];
    if (self)
        [self setValuesForKeysWithDictionary:dict];
    return self;
}

+ (instancetype)flagModelWithDict:(NSDictionary *)dict
{
    return [[self alloc] initWithDict:dict];
}

@end
