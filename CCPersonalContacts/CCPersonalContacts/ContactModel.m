//
//  ContactModel.m
//      CCPersonalContacts
//      Chen Chen @ June 11th, 2015
//

#import "ContactModel.h"

@implementation ContactModel

/**
 *  数据编码方法
 */
- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.name forKey:@"name"];
    [aCoder encodeObject:self.phone forKey:@"phone"];
}

/**
 *  数据解码方法
 */
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if (self) {
        self.name = [aDecoder decodeObjectForKey:@"name"];
        self.phone = [aDecoder decodeObjectForKey:@"phone"];
    }
    return self;
}

@end
