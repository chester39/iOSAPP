//
//  AppModel.h
//      CCAppDownload
//      Chen Chen @ June 5th, 2015
//

#import <Foundation/Foundation.h>

@interface AppModel : NSObject

/**
 *  图标
 */
@property (copy, nonatomic) NSString *icon;
/**
 *  名称
 */
@property (copy, nonatomic) NSString *name;
/**
 *  大小
 */
@property (copy, nonatomic) NSString *size;
/**
 *  下载量
 */
@property (copy, nonatomic) NSString *download;
/**
 *  是否下载
 */
@property (nonatomic) BOOL isDownload;

/**
 *  字典转模型实例方法
 */
- (instancetype)initWithDict:(NSDictionary *)dict;
/**
 *  字典转模型类方法
 */
+ (instancetype)appModelWithDict:(NSDictionary *)dict;

@end
