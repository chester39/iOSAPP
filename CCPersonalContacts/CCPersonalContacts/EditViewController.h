//
//	iOS培训
//		传智播客 & 黑马
//		Chen Chen @ June 11th, 2015
//

#import <UIKit/UIKit.h>

@class EditViewController, ContactModel;

/**
 *  自定义EditViewControllerDelegate代理协议
 */
@protocol EditViewControllerDelegate <NSObject>
@optional

- (void)editViewController:(EditViewController *)editvc didSaveContact:(ContactModel *)contact;

@end

@interface EditViewController : UIViewController

/**
 *  联系人模型
 */
@property (strong, nonatomic) ContactModel *contact;
/**
 *  EditViewControllerDelegate代理
 */
@property (weak, nonatomic) id<EditViewControllerDelegate> delegate;

@end
