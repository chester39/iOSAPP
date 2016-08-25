//
//	iOS培训
//		传智播客 & 黑马
//		Chen Chen @ July 18th, 2015
//

#import "DownloadOperation.h"

@implementation DownloadOperation

/**
 *  主方法
 */
- (void)main
{
    @autoreleasepool {
        if (self.isCancelled)
            return;
        NSLog(@"%s", __func__);
        NSURL *url = [NSURL URLWithString:@"http://d.hiphotos.baidu.com/zhidao/pic/item/d009b3de9c82d158e7c217d0820a19d8bc3e420a.jpg"];
        NSData *data = [NSData dataWithContentsOfURL:url];
        UIImage *image = [UIImage imageWithData:data];
        NSLog(@"Thread:%@", [NSThread currentThread]);
        if ([self.delegate respondsToSelector:@selector(downloadFinishWithImage:)])
            [self.delegate downloadFinishWithImage:image];
    }
}

@end
