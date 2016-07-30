//
//	iOS培训
//		传智播客 & 黑马
//		Chen Chen @ Apirl 23rd, 2015
//

#import "GroupModel.h"

@implementation GroupModel

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
+ (instancetype)groupModelWithDict:(NSDictionary *)dict
{
    return [[self alloc] initWithDict:dict];
}

@end