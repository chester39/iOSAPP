//
//	iOS培训
//		传智播客 & 黑马
//		Chen Chen @ Apirl 13th, 2015
//

#import "ViewController.h"

@interface ViewController ()

/**
 *  图片视图
 */
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
/**
 *  计数器标签
 */
@property (weak, nonatomic) IBOutlet UILabel *numberLabel;
/**
 *  标题标签
 */
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
/**
 *  内容标签
 */
@property (weak, nonatomic) IBOutlet UILabel *textLabel;
/**
 *  前一个按钮
 */
@property (weak, nonatomic) IBOutlet UIButton *previousButton;
/**
 *  后一个按钮
 */
@property (weak, nonatomic) IBOutlet UIButton *nextButton;
/**
 *  图片下标
 */
@property (assign, nonatomic) NSInteger index;
/**
 *  图片数组
 */
@property (strong, nonatomic) NSArray *imageArray;

@end

@implementation ViewController

#pragma mark - 初始化方法

/**
 *  图片数组惰性初始化方法
 */
- (NSArray *)imageArray
{
    if (_imageArray == nil) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"imageData" ofType:@"plist"];
        _imageArray = [NSArray arrayWithContentsOfFile:path];
    }
    return _imageArray;
}

#pragma mark - 系统方法

/**
 *  视图已经加载方法
 */
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self changeImage];
}

#pragma mark - 图片方法

/**
 *  改变图片方法
 */
- (void)changeImage
{
    self.numberLabel.text = [NSString stringWithFormat:@"%ld/%ld", self.index + 1, self.imageArray.count];
    NSDictionary *imageDict = self.imageArray[self.index];
    self.imageView.image = [UIImage imageNamed:imageDict[@"no"]];
    self.titleLabel.text = imageDict[@"title"];
    self.textLabel.text = imageDict[@"text"];
    self.previousButton.enabled = (self.index != 0);
    self.nextButton.enabled = (self.index != self.imageArray.count - 1);
}

/**
 *  移动图片方法
 */
- (IBAction)moveImage:(id)sender
{
    if (sender == self.previousButton)
        self.index--;
    else if (sender == self.nextButton)
        self.index++;
    [self changeImage];
}

@end
