//
//	iOS培训
//		传智播客 & 黑马
//		Chen Chen @ July 29th, 2015
//

#import "ViewController.h"
#import "ZipArchive.h"

/**
 *  编码字符串数据
 */
#define CCEncoding(str) [str dataUsingEncoding:NSUTF8StringEncoding]

@interface ViewController ()

@end

@implementation ViewController

#pragma mark - 系统方法

/**
 *  视图已经加载方法
 */
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self uploadImage];
    [self uploadText];
    [self uploadZip];
    [self unzipFile];
}

#pragma mark - 上传方法

/**
 *  网络上传方法
 */
- (void)upload:(NSString *)filename MIMEType:(NSString *)MIMEType fileData:(NSData *)fileData parameterDict:(NSDictionary *)parameterDict
{
    NSURL *url = [NSURL URLWithString:@"http://192.168.1.110:8080/MJServer/upload"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    request.HTTPMethod = @"POST";
    NSMutableData *bodyData = [NSMutableData data];
    [bodyData appendData:CCEncoding(@"--")];
    [bodyData appendData:CCEncoding(@"Chester\r\n")];
    NSString *contentDisposition = [NSString stringWithFormat:@"Content-Disposition: form-data; name=\"file\"; filename=\"%@\"\r\n", filename];
    [bodyData appendData:CCEncoding(contentDisposition)];
    NSString *bodyContentType = [NSString stringWithFormat:@"Content-Type: %@\r\n", MIMEType];
    [bodyData appendData:CCEncoding(bodyContentType)];
    [bodyData appendData:CCEncoding(@"\r\n")];
    [bodyData appendData:fileData];
    [bodyData appendData:CCEncoding(@"\r\n")];
    [parameterDict enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        [bodyData appendData:CCEncoding(@"--")];
        [bodyData appendData:CCEncoding(@"Chester\r\n")];
        NSString *contentDisposition = [NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n", key];
        [bodyData appendData:CCEncoding(contentDisposition)];
        [bodyData appendData:CCEncoding(@"\r\n")];
        [bodyData appendData:CCEncoding([obj description])];
        [bodyData appendData:CCEncoding(@"\r\n")];
    }];
    [bodyData appendData:CCEncoding(@"--")];
    [bodyData appendData:CCEncoding(@"Chester")];
    [bodyData appendData:CCEncoding(@"--\r\n")];
    request.HTTPBody = bodyData;
    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=Chester"];
    [request setValue:contentType forHTTPHeaderField:@"Content-Type"];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
        NSLog(@"%@", dict);
    }];
}

/**
 *  上传图片方法
 */
- (void)uploadImage
{
    UIImage *image = [UIImage imageNamed:@"uploadTest"];
    NSData *imageData = UIImagePNGRepresentation(image);
    NSDictionary *dict = @{@"username" : @"CC"};
    [self upload:@"test.png" MIMEType:@"image/png" fileData:imageData parameterDict:dict];
}

/**
 *  上传文本方法
 */
- (void)uploadText
{
    NSDictionary *dict = @{@"username" : @"CC", @"password" : @"chester39", @"age" : @24, @"height" : @1.72};
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"江东英雄传41-48关攻略" withExtension:@"txt"];
    NSData *textData = [NSData dataWithContentsOfURL:url];
    NSString *MIMEType = [self MIMEType:url];
    [self upload:@"test.txt" MIMEType:MIMEType fileData:textData parameterDict:dict];
}

/**
 *  上传压缩包方法
 */
- (void)uploadZip
{
    NSString *document = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *filePath = [document stringByAppendingPathComponent:@"MyFiles"];
    NSString *zipPath = [document stringByAppendingPathComponent:@"File.zip"];
    BOOL result = [Main createZipFileAtPath:zipPath withContentsOfDirectory:filePath];
    if (result) {
        NSDictionary *dict = @{@"username" : @"CC", @"password" : @"chester39", @"age" : @24, @"height" : @1.72};
        NSURL *url = [NSURL fileURLWithPath:zipPath];
        NSData *zipData = [NSData dataWithContentsOfURL:url];
        NSString *MIMEType = [self MIMEType:url];
        [self upload:@"test.zip" MIMEType:MIMEType fileData:zipData parameterDict:dict];
    } else
        NSLog(@"Zip Failed");
}

#pragma mark - 文件方法

/**
 *  获取文件类型方法
 */
- (NSString *)MIMEType:(NSURL *)url
{
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSURLResponse *response = nil;
    [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:nil];
    return response.MIMEType;
}

/**
 *  解压缩文件方法
 */
- (void)unzipFile
{
    NSString *document = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *zipPath = [document stringByAppendingPathComponent:@"File.zip"];
    [Main unzipFileAtPath:zipPath toDestination:document];
}

@end