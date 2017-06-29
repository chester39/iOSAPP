//
//  FriendModel.m
//      CCFriendList
//      Chen Chen @ June 4th, 2015
//

#import "FriendModel.h"

@implementation FriendModel

- (instancetype)initWithDict:(NSDictionary *)dict
{
    self = [super init];
    if (self)
        [self setValuesForKeysWithDictionary:dict];
    return self;
}

+ (instancetype)friendModelWithDict:(NSDictionary *)dict
{
    return [[self alloc] initWithDict:dict];
}

@end
