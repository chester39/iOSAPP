//
//	ViewController.m
//		CCTomCat
//		Chen Chen @ Apirl 14th, 2015
//

#import "ViewController.h"

@interface ViewController ()

/// 汤姆猫图片视图
@property (weak, nonatomic) IBOutlet UIImageView *tomCat;

@end

@implementation ViewController

#pragma mark - 系统方法

/**
 *  视图已经加载方法
 */
- (void)viewDidLoad {
    
    [super viewDidLoad];
}

#pragma mark - 帧动画方法

/**
 *  连续帧动画方法
 */
- (void)runAnimationWithCount:(int)count name:(NSString *)name {
    
    if (self.tomCat.isAnimating) {
        return;
    }
    
    NSMutableArray *imageArray = [NSMutableArray array];
    for (int i = 0; i < count; ++i) {
        NSString *filename = [NSString stringWithFormat:@"%@_%02d", name, i];
        NSString *path = [[NSBundle mainBundle] pathForResource:filename ofType:@"jpg"];
        UIImage *image = [UIImage imageWithContentsOfFile:path];
        [imageArray addObject:image];
    }
    
    self.tomCat.animationImages = imageArray;
    self.tomCat.animationRepeatCount = 1;
    self.tomCat.animationDuration = imageArray.count * 0.05;
    [self.tomCat startAnimating];
    
    CGFloat delay = self.tomCat.animationDuration + 1.0;
    [self.tomCat performSelector:@selector(setAnimationImages:) withObject:nil afterDelay:delay];
}

#pragma mark - 动作方法

/**
 *  吃饭按钮点击方法
 */
- (IBAction)eatButtonDidClick {
    
    [self runAnimationWithCount:39 name:@"eat"];
}

/**
 *  铜钹按钮点击方法
 */
- (IBAction)cymbalButtonDidClick {
    
    [self runAnimationWithCount:12 name:@"cymbal"];
}

/**
 *  喝水按钮点击方法
 */
- (IBAction)drinkButtonDidClick {
    
    [self runAnimationWithCount:80 name:@"drink"];
}

/**
 *  放屁按钮点击方法
 */
- (IBAction)fartButtonDidClick {
    
    [self runAnimationWithCount:27 name:@"fart"];
}

/**
 *  扔饼按钮点击方法
 */
- (IBAction)pieButtonDidClick {
    
    [self runAnimationWithCount:23 name:@"pie"];
}

/**
 *  抓屏按钮点击方法
 */
- (IBAction)scratchButtonDidClick {
    
    [self runAnimationWithCount:55 name:@"scratch"];
}

/**
 *  打头按钮点击方法
 */
- (IBAction)headButtonDidClick {
    
    [self runAnimationWithCount:80 name:@"knockout"];
}

/**
 *  生气按钮点击方法
 */
- (IBAction)angryButtonDidClick {
    
    [self runAnimationWithCount:25 name:@"angry"];
}

/**
 *  打胃按钮点击方法
 */
- (IBAction)stomachButtonDidClick {
    
    [self runAnimationWithCount:33 name:@"stomach"];
}

/**
 *  左脚按钮点击方法
 */
- (IBAction)leftFootButtonDidClick {
    
    [self runAnimationWithCount:29 name:@"footLeft"];
}

/**
 *  右脚按钮点击方法
 */
- (IBAction)rightFootButtonDidClick {
    
    [self runAnimationWithCount:29 name:@"footRight"];
}

@end
