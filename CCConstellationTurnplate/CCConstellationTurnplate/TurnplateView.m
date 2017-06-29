//
//  TurnplateView.m
//      CCConstellationTurnplate
//      Chen Chen @ July 4th, 2015
//

#import "TurnplateView.h"
#import "TurnplateButton.h"

@interface TurnplateView ()

/**
 *  中心转盘
 */
@property (weak, nonatomic) IBOutlet UIImageView *centerTurnplate;
/**
 *  选中按钮
 */
@property (weak, nonatomic) TurnplateButton *selectedButton;
/**
 *  定时器
 */
@property (strong, nonatomic) CADisplayLink *link;

@end

@implementation TurnplateView

#pragma mark - 初始化方法

+ (instancetype)turnplateView
{
    return [[[NSBundle mainBundle] loadNibNamed:@"TurnplateView" owner:nil options:nil] lastObject];
}

#pragma mark - 系统方法

/**
 *  xib唤醒方法
 */
- (void)awakeFromNib
{
    self.centerTurnplate.userInteractionEnabled = YES;
    UIImage *originImage = [UIImage imageNamed:@"LuckyAstrology"];
    UIImage *originSelectedImage = [UIImage imageNamed:@"LuckyAstrologyPressed"];
    CGFloat buttonWidth = originImage.size.width / 12  * [UIScreen mainScreen].scale;
    CGFloat buttonHeight = originImage.size.height * [UIScreen mainScreen].scale;
    CGFloat buttonY = 0;
    for (int i = 0; i < 12; ++i) {
        CGFloat buttonX = i * buttonWidth;
        TurnplateButton *button = [TurnplateButton buttonWithType:UIButtonTypeCustom];
        CGRect buttonRect = CGRectMake(buttonX, buttonY, buttonWidth, buttonHeight);
        CGImageRef buttonImage = CGImageCreateWithImageInRect(originImage.CGImage, buttonRect);
        [button setImage:[UIImage imageWithCGImage:buttonImage] forState:UIControlStateNormal];
        CGImageRef buttonSelectedImage = CGImageCreateWithImageInRect(originSelectedImage.CGImage, buttonRect);
        [button setImage:[UIImage imageWithCGImage:buttonSelectedImage] forState:UIControlStateSelected];
        [button setBackgroundImage:[UIImage imageNamed:@"LuckyRototeSelected"] forState:UIControlStateSelected];
        button.bounds = CGRectMake(0, 0, 68, 143);
        button.layer.anchorPoint = CGPointMake(0.5, 1);
        button.layer.position = CGPointMake(self.centerTurnplate.frame.size.width / 2, self.centerTurnplate.frame.size.height / 2);
        CGFloat angle = (i * 30) / 180.0 * M_PI;
        button.transform = CGAffineTransformMakeRotation(angle);
        [button addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchDown];
        [self.centerTurnplate addSubview:button];
        if (i == 0)
            [self clickButton:button];
    }
}

#pragma mark - 转盘方法

/**
 *  点击按钮方法
 */
- (void)clickButton:(TurnplateButton *)button
{
    self.selectedButton.selected = NO;
    button.selected = YES;
    self.selectedButton = button;
}

- (void)startRotating
{
    if (self.link)
        return;
    CADisplayLink *link = [CADisplayLink displayLinkWithTarget:self selector:@selector(updateTurnplate)];
    [link addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
    self.link = link;
}

- (void)stopRotating
{
    [self.link invalidate];
    self.link = nil;
}

/**
 *  更新转盘方法
 */
- (void)updateTurnplate
{
    self.centerTurnplate.transform = CGAffineTransformRotate(self.centerTurnplate.transform, M_PI / 500);
}

#pragma mark - 选号方法

/**
 *  开始选号方法
 */
- (IBAction)startSelectingNumber
{
    [self stopRotating];
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    animation.duration = 1.5;
    animation.toValue = @(2 * M_PI * 5);
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation.delegate = self;
    [self.centerTurnplate.layer addAnimation:animation forKey:nil];
    self.userInteractionEnabled = NO;
}

/**
 *  动画已经结束方法
 */
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    self.userInteractionEnabled = YES;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self startRotating];
    });
}

@end
