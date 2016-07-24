//
//	iOS培训
//		传智播客 & 黑马
//		Chen Chen @ Apirl 15th, 2015
//

#import "AppModel.h"

@implementation AppModel

/**
 *  字典转模型实例方法
 */
- (instancetype)initWithDict:(NSDictionary *)dict
{
    self = [super init];
    if (self) {
        self.icon = dict[@"icon"];
        self.name = dict[@"name"];
    }
    return self;
}

/**
 *  字典转模型类方法
 */
+ (instancetype)appModelWithDict:(NSDictionary *)dict
{
    return [[self alloc] initWithDict:dict];
}

@end
