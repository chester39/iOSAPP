//
//	iOS培训
//		传智播客 & 黑马
//		Chen Chen @ July 19th, 2015
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
        NSURL *url = [NSURL URLWithString:self.imageURL];
        NSData *data = [NSData dataWithContentsOfURL:url];
        UIImage *image = [UIImage imageWithData:data];
        if (self.isCancelled)
            return;
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            if ([self.delegate respondsToSelector:@selector(downloadOperation:didFinishWithImage:)])
                [self.delegate downloadOperation:self didFinishWithImage:image];
        }];
    }
}

@end
