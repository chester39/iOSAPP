//
//  PersonModel.h
//      CCDataStorage
//      Chen Chen @ June 13th, 2015
//

#import <Foundation/Foundation.h>

@interface PersonModel : NSObject <NSCoding>

/**
 *  姓名
 */
@property (copy, nonatomic) NSString *name;
/**
 *  年龄
 */
@property (nonatomic) NSInteger age;
/**
 *  性别
 */
@property (nonatomic) BOOL man;

@end
