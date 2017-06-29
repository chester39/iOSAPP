//
//  VideoModel.h
//      CCWebInteraction
//      Chen Chen @ July 22nd, 2015
//

#import <Foundation/Foundation.h>

@interface VideoModel : NSObject

/**
 *  视频ID
 */
@property (nonatomic) int id;
/**
 *  视频图片
 */
@property (copy, nonatomic) NSString *image;
/**
 *  视频长度
 */
@property (nonatomic) int length;
/**
 *  视频名称
 */
@property (copy, nonatomic) NSString *name;
/**
 *  视频URL
 */
@property (copy, nonatomic) NSString *url;

/**
 *  字典转模型实例方法
 */
- (instancetype)initWithDict:(NSDictionary *)dict;
/**
 *  字典转模型类方法
 */
+ (instancetype)videoModelWithDict:(NSDictionary *)dict;

@end
