//
//  QuestionModel.m
//      CCFigureGuess
//      Chen Chen @ June 1st, 2015
//

#import "QuestionModel.h"

@implementation QuestionModel

#pragma mark - 字典转模型方法

/**
 *  字典转模型实例方法
 */
- (instancetype)initWithDict:(NSDictionary *)dict
{
    self = [super init];
    if (self) {
        self.icon = dict[@"icon"];
        self.answer = dict[@"answer"];
        self.title = dict[@"title"];
        self.options = dict[@"options"];
        [self randomOptions];
    }
    return self;
}

/**
 *  字典转模型类方法
 */
+ (instancetype)questionModelWithDict:(NSDictionary *)dict
{
    return [[self alloc] initWithDict:dict];
}

#pragma mark - 随机方法

/**
 *  备选项乱序方法
 */
- (void)randomOptions
{
    self.options = [self.options sortedArrayUsingComparator:^NSComparisonResult(NSString *str1, NSString *str2) {
        int seed = arc4random_uniform(2);
        if (seed)
            return [str1 compare:str2];
        else
            return [str2 compare:str1];
    }];
}

@end
