//
//  GroupFooterView.m
//      CCGroupInterface
//      Chen Chen @ Apirl 23rd, 2015
//

#import "GroupFooterView.h"

@interface GroupFooterView()

/**
 *  读取按钮
 */
@property (weak, nonatomic) IBOutlet UIButton *loadButton;
/**
 *  读取视图
 */
@property (weak, nonatomic) IBOutlet UIView *loadView;

@end

@implementation GroupFooterView

#pragma mark - 初始化方法

/**
 *  GroupFooterView指定初始化方法
 */
+ (instancetype)footView
{
    return [[[NSBundle mainBundle] loadNibNamed:@"GroupFooterView" owner:nil options:nil] lastObject];
}

#pragma mark - 更新界面方法

/**
 *  点击读取按钮方法
 */
- (IBAction)clickLoadButton
{
    self.loadButton.hidden = YES;
    self.loadView.hidden = NO;
    if ([self.delegate respondsToSelector:@selector(groupFooterViewDidClickLoadButton:)])
        [self.delegate groupFooterViewDidClickLoadButton:self];
}

/**
 *  完成刷新方法
 */
- (void)endRefresh
{
    self.loadButton.hidden = NO;
    self.loadView.hidden = YES;
}

@end
