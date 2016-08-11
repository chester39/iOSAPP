//
//	iOS培训
//		传智播客 & 黑马
//		Chen Chen @ June 11th, 2015
//

#import <UIKit/UIKit.h>

@class AddViewController, ContactModel;

/**
 *  自定义AddViewControllerDelegate代理协议
 */
@protocol AddViewControllerDelegate <NSObject>
@optional

- (void)addViewController:(AddViewController *)addvc didAddContact:(ContactModel *)contact;

@end

@interface AddViewController : UIViewController

/**
 *  AddViewControllerDelegate代理
 */
@property (weak, nonatomic) id<AddViewControllerDelegate> delegate;

@end
