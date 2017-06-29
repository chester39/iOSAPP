//
//  FriendGroup.m
//      CCFriendList
//      Chen Chen @ June 4th, 2015
//

#import "FriendGroup.h"
#import "FriendModel.h"

@implementation FriendGroup

- (instancetype)initWithDict:(NSDictionary *)dict
{
    self = [super init];
    if (self) {
        [self setValuesForKeysWithDictionary:dict];
        NSMutableArray *friendArray = [NSMutableArray array];
        for (NSDictionary *dict in self.friends) {
            FriendModel *friend = [FriendModel friendModelWithDict:dict];
            [friendArray addObject:friend];
        }
        self.friends = friendArray;
    }
    return self;
}

+ (instancetype)friendGroupModelWithDict:(NSDictionary *)dict
{
    return [[self alloc] initWithDict:dict];
}

@end
