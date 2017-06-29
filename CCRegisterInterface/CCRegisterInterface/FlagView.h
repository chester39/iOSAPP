//
//  FlagView.h
//      CCRegisterInterface
//      Chen Chen @ June 7th, 2015
//

#import <UIKit/UIKit.h>

@class FlagModel;

@interface FlagView : UIView

/**
 *  国旗模型
 */
@property (strong, nonatomic) FlagModel *flag;

/**
 *  FlagView指定初始化方法
 */
+ (instancetype)flagViewWithReusingView:(UIView *)view;
/**
 *  FlagView高度方法
 */
+ (CGFloat)flagViewHeight;

@end
