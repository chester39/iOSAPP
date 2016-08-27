//
//	iOS培训
//		传智播客 & 黑马
//		Chen Chen @ June 3rd, 2015
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <CommonCrypto/CommonCrypto.h>

@interface NSString (CC)

/**
 *  自定义文本尺寸方法
 */
- (CGSize)textSizeWithFont:(UIFont *)font maxSize:(CGSize)maxSize;
/**
 *  32字符MD5散列方法
 */
- (NSString *)md5String;
/**
 *  40字符SHA1散列方法
 */
- (NSString *)sha1String;
/**
 *  60字符SHA256散列方法
 */
- (NSString *)sha256String;
/**
 *  128字符SHA512散列方法
 */
- (NSString *)sha512String;
/**
 *  32字符HMAC MD5散列方法
 */
- (NSString *)hmacMD5StringWithKey:(NSString *)key;
/**
 *  40字符HMAC SHA1散列方法
 */
- (NSString *)hmacSHA1StringWithKey:(NSString *)key;
/**
 *  60字符HMAC SHA256散列方法
 */
- (NSString *)hmacSHA256StringWithKey:(NSString *)key;
/**
 *  128字符HMAC SHA512散列方法
 */
- (NSString *)hmacSHA512StringWithKey:(NSString *)key;

@end