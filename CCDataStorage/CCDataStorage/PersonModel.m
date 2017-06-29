//
//  PersonModel.m
//      CCDataStorage
//      Chen Chen @ June 13th, 2015
//

#import "PersonModel.h"

@implementation PersonModel

/**
 *  数据编码方法
 */
- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.name forKey:@"name"];
    [aCoder encodeInteger:self.age forKey:@"age"];
    [aCoder encodeBool:self.man forKey:@"man"];
}

/**
 *  数据解码方法
 */
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if (self) {
        self.name = [aDecoder decodeObjectForKey:@"name"];
        self.age = [aDecoder decodeIntegerForKey:@"age"];
        self.man = [aDecoder decodeBoolForKey:@"man"];
    }
    return self;
}

@end
