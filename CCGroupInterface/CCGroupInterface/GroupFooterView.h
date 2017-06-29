//
//  GroupFooterView.h
//      CCGroupInterface
//      Chen Chen @ Apirl 23rd, 2015
//

#import <UIKit/UIKit.h>

@class GroupFooterView;

/**
 *  自定义GroupFooterViewDelegate代理协议
 */
@protocol GroupFooterViewDelegate <NSObject>
@optional

/**
 *  点击下载按钮方法
 */
- (void)groupFooterViewDidClickLoadButton:(GroupFooterView *)footerView;

@end

@interface GroupFooterView : UIView

/**
 *  GroupFooterViewDelegate代理
 */
@property (weak, nonatomic) id<GroupFooterViewDelegate> delegate;

/**
 *  GroupFooterView指定初始化方法
 */
+ (instancetype)footView;
/**
 *  完成刷新方法
 */
- (void)endRefresh;

@end
