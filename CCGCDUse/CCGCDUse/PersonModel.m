//
//	iOS培训
//		传智播客 & 黑马
//		Chen Chen @ July 16th, 2015
//

#import "PersonModel.h"

@implementation PersonModel

/**
 *  单例对象
 */
static id _sharedInstance = nil;

#pragma mark - 系统方法

/**
 *  分配空间方法
 */
+ (instancetype)allocWithZone:(struct _NSZone *)zone
{
    if (_sharedInstance == nil) {
        @synchronized(self) {
            if (_sharedInstance == nil)
                _sharedInstance = [super allocWithZone:zone];
        }
    }
    return _sharedInstance;
}

/**
 *  复制空间方法
 */
- (instancetype)copyWithZone:(NSZone *)zone
{
    return _sharedInstance;
}

#pragma mark - 初始化方法

+ (instancetype)sharedPersonModel
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[self alloc] init];
    });
    return _sharedInstance;
}

@end
