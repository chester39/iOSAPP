//
//	iOS培训
//		传智播客 & 黑马
//		Chen Chen @ June 13th, 2015
//

#import "StudentModel.h"

@implementation StudentModel

/**
 *  数据编码方法
 */
- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [super encodeWithCoder:aCoder];
    [aCoder encodeInt:self.no forKey:@"no"];
    [aCoder encodeObject:self.degree forKey:@"degree"];
    [aCoder encodeObject:self.grade forKey:@"grade"];
}

/**
 *  数据解码方法
 */
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.no = [aDecoder decodeIntForKey:@"no"];
        self.degree = [aDecoder decodeObjectForKey:@"degree"];
        self.grade = [aDecoder decodeObjectForKey:@"grade"];
    }
    return self;
}

@end
