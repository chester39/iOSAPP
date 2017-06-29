//
//  ChatModel.m
//      CCChatInterface
//      Chen Chen @ June 3rd, 2015
//

#import "ChatModel.h"

@implementation ChatModel

- (instancetype)initWithDict:(NSDictionary *)dict
{
    self = [super init];
    if (self)
        [self setValuesForKeysWithDictionary:dict];
    return self;
}

+ (instancetype)chatModelWithDict:(NSDictionary *)dict
{
    return [[self alloc] initWithDict:dict];
}

@end
