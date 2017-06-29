//
//  QuestionModel.h
//      CCFigureGuess
//      Chen Chen @ June 1st, 2015
//

#import <Foundation/Foundation.h>

@interface QuestionModel : NSObject

/**
 *  答案
 */
@property (copy, nonatomic) NSString *answer;
/**
 *  图标
 */
@property (copy, nonatomic) NSString *icon;
/**
 *  标题
 */
@property (copy, nonatomic) NSString *title;
/**
 *  备选项
 */
@property (strong, nonatomic) NSArray *options;

/**
 *  字典转模型实例方法
 */
- (instancetype)initWithDict:(NSDictionary *)dict;
/**
 *  字典转模型类方法
 */
+ (instancetype)questionModelWithDict:(NSDictionary *)dict;
/**
 *  备选项乱序方法
 */
- (void)randomOptions;

@end
