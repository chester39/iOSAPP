//
//  StudentModel.m
//      CCGCDUse
//      Chen Chen @ July 16th, 2015
//

#import "StudentModel.h"

@implementation StudentModel

/**
 *  单例对象
 */
static id _sharedInstance = nil;

#pragma mark - 系统方法

/**
 *  类读取方法
 */
+ (void)load
{
    NSLog(@"%@ loaded!", [self class]);
    _sharedInstance = [[self alloc] init];
}

/**
 *  类初始化方法
 */
+ (void)initialize
{
    NSLog(@"%@ initialized!", [self class]);
}

/**
 *  分配空间方法
 */
+ (instancetype)allocWithZone:(struct _NSZone *)zone
{
    if (_sharedInstance == nil) {
        _sharedInstance = [super allocWithZone:zone];
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

+ (instancetype)sharedStudentModel
{
    return _sharedInstance;
}

@end
