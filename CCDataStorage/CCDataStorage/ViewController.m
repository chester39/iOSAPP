//
//  ViewController.m
//      CCDataStorage
//      Chen Chen @ June 13th, 2015
//

#import "ViewController.h"
#import "PersonModel.h"
#import "StudentModel.h"

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
}

#pragma mark - 按钮方法

/**
 *  保存数据方法
 */
- (IBAction)saveData
{
    [self savePropertyList];
    [self saveUserDefaults];
    [self saveKeyedArchiver];
}

/**
 *  读取数据方法
 */
- (IBAction)loadData
{
    [self loadPropertyList];
    [self loadUserDefaults];
    [self loadKeyedArchiver];
}

#pragma mark - 属性列表方法

/**
 *  保存属性列表方法
 */
- (void)savePropertyList
{
    NSString *home = NSHomeDirectory();
    NSLog(@"%@", home);
    NSString *documents = [home stringByAppendingPathComponent:@"Documents"];
    NSString *path = [documents stringByAppendingPathComponent:@"data.plist"];
    NSArray *data = @[@"Chester", @24, @"man"];
    [data writeToFile:path atomically:YES];
}

/**
 *  读取属性列表方法
 */
- (void)loadPropertyList
{
    NSString *home = NSHomeDirectory();
    NSString *documents = [home stringByAppendingPathComponent:@"Documents"];
    NSString *path = [documents stringByAppendingPathComponent:@"data.plist"];
    NSArray *data = [NSArray arrayWithContentsOfFile:path];
    NSLog(@"PropertyList: %@", data);
}

#pragma mark - 偏好设置方法

/**
 *  保存偏好设置方法
 */
- (void)saveUserDefaults
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:@"Chester" forKey:@"name"];
    [defaults setInteger:24 forKey:@"age"];
    [defaults setBool:YES forKey:@"man"];
    [defaults synchronize];
}

/**
 *  读取偏好设置方法
 */
- (void)loadUserDefaults
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *name = [defaults objectForKey:@"name"];
    NSInteger age = [defaults integerForKey:@"age"];
    BOOL man = [defaults boolForKey:@"man"];
    NSLog(@"NSUserDefaults: %@ %ld %d", name, age, man);
}

#pragma mark - 持久化方法

/**
 *  归档方法
 */
- (void)saveKeyedArchiver
{
    StudentModel *student = [[StudentModel alloc] init];
    student.name = @"Chester";
    student.age = 24;
    student.man = YES;
    student.no = 39;
    student.degree = @"master";
    student.grade = @85;
    NSString *documents = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *path = [documents stringByAppendingPathComponent:@"person.data"];
    [NSKeyedArchiver archiveRootObject:student toFile:path];
}

/**
 *  读档方法
 */
- (void)loadKeyedArchiver
{
    NSString *documents = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *path = [documents stringByAppendingPathComponent:@"person.data"];
    StudentModel *student = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
    NSLog(@"NSKeyedArchiver: %@ %ld %d %d %@ %@", student.name, student.age, student.man, student.no, student.degree, student.grade);
}

@end
