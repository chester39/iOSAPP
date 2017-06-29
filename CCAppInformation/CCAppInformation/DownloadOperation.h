//
//  DownloadOperation.h
//      CCAppInformation
//      Chen Chen @ July 19th, 2015
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class DownloadOperation;

/**
 *  自定义DownloadOperationDelegate代理协议
 */
@protocol DownloadOperationDelegate <NSObject>
@optional

- (void)downloadOperation:(DownloadOperation *)operation didFinishWithImage:(UIImage *)image;

@end

@interface DownloadOperation : NSOperation

/**
 *  图片URL
 */
@property (copy, nonatomic) NSString *imageURL;
/**
 *  表格下标
 */
@property (strong, nonatomic) NSIndexPath *indexPath;
/**
 *  DownloadOperationDelegate代理
 */
@property (weak, nonatomic) id<DownloadOperationDelegate> delegate;

@end
