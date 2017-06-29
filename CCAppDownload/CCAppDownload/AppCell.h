//
//  AppCell.h
//      CCAppDownload
//      Chen Chen @ June 5th, 2015
//

#import <UIKit/UIKit.h>

@class AppModel, AppCell;

/**
 *  自定义AppCellDelegate代理协议
 */
@protocol AppCellDelegate <NSObject>
@optional

- (void)appCellDidClickDownloadButton:(AppCell *)appCell;

@end

@interface AppCell : UITableViewCell

/**
 *  应用模型
 */
@property (strong, nonatomic) AppModel *app;
/**
 *  AppCellDelegate代理
 */
@property (weak, nonatomic) id<AppCellDelegate> delegate;

@end
