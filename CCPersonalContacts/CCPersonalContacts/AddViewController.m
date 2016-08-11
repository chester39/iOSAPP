//
//	iOS培训
//		传智播客 & 黑马
//		Chen Chen @ June 11th, 2015
//

#import "AddViewController.h"
#import "ContactModel.h"

@interface AddViewController ()

/**
 *  姓名
 */
@property (weak, nonatomic) IBOutlet UITextField *nameField;
/**
 *  电话
 */
@property (weak, nonatomic) IBOutlet UITextField *phoneField;
/**
 *  增加按钮
 */
@property (weak, nonatomic) IBOutlet UIButton *addButton;

@end

@implementation AddViewController

#pragma mark - 系统方法

/**
 *  视图已经加载方法
 */
- (void)viewDidLoad
{
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeText) name:UITextFieldTextDidChangeNotification object:self.nameField];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeText) name:UITextFieldTextDidChangeNotification object:self.phoneField];
}

/**
 *  视图已经显示方法
 */
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];
    [self.nameField becomeFirstResponder];
}

/**
 *  释放内存方法
 */
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - 基本方法

/**
 *  文本改变方法
 */
- (void)changeText
{
    self.addButton.enabled = (self.nameField.text.length && self.phoneField.text.length);
}

/**
 *  添加联系人方法
 */
- (IBAction)addContact
{
    [self.navigationController popViewControllerAnimated:YES];
    if ([self.delegate respondsToSelector:@selector(addViewController:didAddContact:)]) {
        ContactModel *contact = [[ContactModel alloc] init];
        contact.name = self.nameField.text;
        contact.phone = self.phoneField.text;
        [self.delegate addViewController:self didAddContact:contact];
    }
}

@end
