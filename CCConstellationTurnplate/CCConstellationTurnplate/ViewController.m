//
//	iOS培训
//		传智播客 & 黑马
//		Chen Chen @ July 4th, 2015
//

#import "ViewController.h"
#import "TurnplateView.h"

@interface ViewController ()

/**
 *  转盘视图
 */
@property (weak, nonatomic) TurnplateView *turnplate;

@end

@implementation ViewController

#pragma mark - 系统方法

/**
 *  视图已经加载方法
 */
- (void)viewDidLoad
{
    [super viewDidLoad];
    TurnplateView *turnplate = [TurnplateView turnplateView];
    turnplate.center = CGPointMake(self.view.frame.size.width / 2, self.view.frame.size.height / 2);
    [self.view addSubview:turnplate];
    self.turnplate = turnplate;
}

#pragma mark - 转盘方法

/**
 *  开始转盘方法
 */
- (IBAction)startTurnplate
{
    [self.turnplate startRotating];
}

/**
 *  结束转盘方法
 */
- (IBAction)stopTurnplate
{
    [self.turnplate stopRotating];
}

@end
