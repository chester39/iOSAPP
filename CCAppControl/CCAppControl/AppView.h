//
//	iOS培训
//		传智播客 & 黑马
//		Chen Chen @ Apirl 15th, 2015
//

#import <UIKit/UIKit.h>

@class AppModel, AppView;

/**
 *  自定义AppViewDelegate代理协议
 */
@protocol AppViewDelegate <NSObject>
@optional

/**
 *  点击下载按钮方法
 */
- (void)appViewDidClickDownloadButton:(AppView *)appView;

@end

@interface AppView : UIView

/**
 *  应用模型
 */
@property (strong, nonatomic) AppModel *appModel;
/**
 *  AppViewDelegate代理
 */
@property (weak, nonatomic) id<AppViewDelegate> delegate;

/**
 *  AppView指定初始化方法
 */
+ (instancetype)appViewWithAppModel:(AppModel *)appModel;
/**
 *  AppView无模型初始化方法
 */
+ (instancetype)appView;

@end
