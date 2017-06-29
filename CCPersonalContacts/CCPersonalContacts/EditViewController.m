//
//  EditViewController.m
//      CCPersonalContacts
//      Chen Chen @ June 11th, 2015
//

#import "EditViewController.h"
#import "ContactModel.h"

@interface EditViewController ()

/**
 *  姓名
 */
@property (weak, nonatomic) IBOutlet UITextField *nameField;
/**
 *  电话
 */
@property (weak, nonatomic) IBOutlet UITextField *phoneField;
/**
 *  保存按钮
 */
@property (weak, nonatomic) IBOutlet UIButton *saveButton;

@end

@implementation EditViewController

#pragma mark - 系统方法

/**
 *  视图已经加载方法
 */
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.nameField.text = self.contact.name;
    self.phoneField.text = self.contact.phone;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeText) name:UITextFieldTextDidChangeNotification object:self.nameField];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeText) name:UITextFieldTextDidChangeNotification object:self.phoneField];
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
    self.saveButton.enabled = (self.nameField.text.length && self.phoneField.text.length);
}

/**
 *  编辑联系人方法
 */
- (IBAction)editContact:(UIBarButtonItem *)sender
{
    if (self.nameField.enabled) {
        self.nameField.enabled = NO;
        self.phoneField.enabled = NO;
        [self.view endEditing:YES];
        self.saveButton.hidden = YES;
        sender.title = @"编辑";
        self.nameField.text = self.contact.name;
        self.phoneField.text = self.contact.phone;
    } else {
        self.nameField.enabled = YES;
        self.phoneField.enabled = YES;
        [self.phoneField becomeFirstResponder];
        self.saveButton.hidden = NO;
        sender.title = @"取消";
    }
}

/**
 *  保存联系人方法
 */
- (IBAction)saveContact
{
    [self.navigationController popViewControllerAnimated:YES];
    if ([self.delegate respondsToSelector:@selector(editViewController:didSaveContact:)]) {
        self.contact.name = self.nameField.text;
        self.contact.phone = self.phoneField.text;
        [self.delegate editViewController:self didSaveContact:self.contact];
    }
}

@end
