//
//  ContactModel.h
//      CCPersonalContacts
//      Chen Chen @ June 11th, 2015
//

#import <Foundation/Foundation.h>

@interface ContactModel : NSObject <NSCoding>

/**
 *  姓名
 */
@property (copy, nonatomic) NSString *name;
/**
 *  电话
 */
@property (copy, nonatomic) NSString *phone;

@end
