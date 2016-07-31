//
//	iOS培训
//		传智播客 & 黑马
//		Chen Chen @ June 2nd, 2015
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface WeiboModel : NSObject

/**
 *  用户头像
 */
@property (copy, nonatomic) NSString *icon;
/**
 *  用户昵称
 */
@property (copy, nonatomic) NSString *name;
/**
 *  微博内容
 */
@property (copy, nonatomic) NSString *text;
/**
 *  微博图片
 */
@property (copy, nonatomic) NSString *picture;
/**
 *  VIP会员
 */
@property (assign, nonatomic) BOOL vip;
/**
 *  微博图片尺寸
 */
@property (assign, nonatomic) CGRect pictureFrame;
/**
 *  WeiboCell高度
 */
@property (assign, nonatomic, readonly) CGFloat cellHeight;

/**
 *  字典转模型实例方法
 */
- (instancetype)initWithDict:(NSDictionary *)dict;
/**
 *  字典转模型类方法
 */
+ (instancetype)weiboModelWithDict:(NSDictionary *)dict;

@end
