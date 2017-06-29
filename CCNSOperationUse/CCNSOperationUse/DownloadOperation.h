//
//  DownloadOperation.h
//      CCNSOperationUse
//      Chen Chen @ July 18th, 2015
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class DownloadOperation;

/**
 *  自定义DownloadOperationDelegate代理协议
 */
@protocol DownloadOperationDelegate <NSObject>
@optional

- (void)downloadFinishWithImage:(UIImage *)image;

@end

@interface DownloadOperation : NSOperation

/**
 *  DownloadOperationDelegate代理
 */
@property (weak, nonatomic) id<DownloadOperationDelegate> delegate;

@end
