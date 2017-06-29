//
//  ContactCell.h
//      CCPersonalContacts
//      Chen Chen @ June 11th, 2015
//

#import <UIKit/UIKit.h>

@class ContactModel;

@interface ContactCell : UITableViewCell

/**
 *  联系人模型
 */
@property (strong, nonatomic) ContactModel *contact;

/**
 *  ContactCell指定初始化方法
 */
+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
