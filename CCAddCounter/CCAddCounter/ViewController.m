//
//	ViewController.m
//		CCAddCounter
//		Chen Chen @ Apirl 12th, 2015
//

#import "ViewController.h"

@interface ViewController ()

/// 加数文本框
@property (weak, nonatomic) IBOutlet UITextField *numberA;
/// 被加数文本框
@property (weak, nonatomic) IBOutlet UITextField *numberB;
/// 加法和标签
@property (weak, nonatomic) IBOutlet UILabel *sumAnswer;

@end

@implementation ViewController

#pragma mark - 系统方法

/**
 *  视图已经加载方法
 */
- (void)viewDidLoad {
    
    [super viewDidLoad];
}

#pragma mark - 加法方法

/**
 *  加法计算方法
 */
- (IBAction)addCounter {
    
    NSInteger a = [self.numberA.text integerValue];
    NSInteger b = [self.numberB.text integerValue];
    self.sumAnswer.text = [NSString stringWithFormat:@"%ld", a + b];
    
    [self.view endEditing:YES];
}

@end
