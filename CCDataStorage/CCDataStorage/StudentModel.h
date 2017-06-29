//
//  StudentModel.h
//      CCDataStorage
//      Chen Chen @ June 13th, 2015
//

#import "PersonModel.h"

@interface StudentModel : PersonModel <NSCoding>

/**
 *  学号
 */
@property (nonatomic) int no;
/**
 *  学位
 */
@property (copy, nonatomic) NSString *degree;
/**
 *  成绩
 */
@property (strong, nonatomic) NSNumber *grade;

@end
