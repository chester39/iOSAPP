//
//  ContactsViewController.m
//      CCPersonalContacts
//      Chen Chen @ June 11th, 2015
//

#import "ContactsViewController.h"
#import "ContactModel.h"
#import "ContactCell.h"
#import "AddViewController.h"
#import "EditViewController.h"

/**
 *  联系人文件地址
 */
#define CCContactPath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"contact.data"]

@interface ContactsViewController () <UIActionSheetDelegate, AddViewControllerDelegate, EditViewControllerDelegate>

/**
 *  联系人数组
 */
@property (strong, nonatomic) NSMutableArray *contactArray;

@end

@implementation ContactsViewController

#pragma mark - 初始化方法

/**
 *  联系人数组惰性初始化方法
 */
- (NSMutableArray *)contactArray
{
    if (_contactArray == nil) {
        _contactArray = [NSKeyedUnarchiver unarchiveObjectWithFile:CCContactPath];
        if (_contactArray == nil) {
            _contactArray = [NSMutableArray array];
        }
    }
    return _contactArray;
}

#pragma mark - 系统方法

/**
 *  视图已经加载方法
 */
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    UIBarButtonItem *addItem = self.navigationItem.rightBarButtonItem;
    UIBarButtonItem *trashItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemTrash target:self action:@selector(clickTrash)];
    self.navigationItem.rightBarButtonItems = @[addItem, trashItem];
}

#pragma mark - UITableViewDataSource数据源方法

/**
 *  共有组数方法
 */
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

/**
 *  每组行数方法
 */
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.contactArray.count;
}

/**
 *  每行内容方法
 */
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ContactCell *cell = [ContactCell cellWithTableView:tableView];
    cell.contact = self.contactArray[indexPath.row];
    return cell;
}

/**
 *  编辑表格方法
 */
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.contactArray removeObjectAtIndex:indexPath.row];
        [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationTop];
        [NSKeyedArchiver archiveRootObject:self.contactArray toFile:CCContactPath];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        ContactModel *contact = self.contactArray[indexPath.row];
        [self.contactArray insertObject:contact atIndex:indexPath.row + 1];
        NSIndexPath *path = [NSIndexPath indexPathForRow:indexPath.row + 1 inSection:indexPath.section];
        [self.tableView insertRowsAtIndexPaths:@[path] withRowAnimation:UITableViewRowAnimationFade];
        [NSKeyedArchiver archiveRootObject:self.contactArray toFile:CCContactPath];
    }
}

/**
 *  移动表格方法
 */
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath
{
    ContactModel *contact = self.contactArray[sourceIndexPath.row];
    [self.contactArray removeObjectAtIndex:sourceIndexPath.row];
    [self.contactArray insertObject:contact atIndex:destinationIndexPath.row];
    self.tableView.editing = NO;
}


#pragma mark - UITableViewDelegate代理方法

/**
 *  每行编辑模式方法
 */
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return indexPath.row % 2 ? UITableViewCellEditingStyleDelete : UITableViewCellEditingStyleInsert;
}


#pragma mark - 注销方法

/**
 *  注销方法
 */
- (IBAction)logoutContact
{
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"确定要注销？" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"确定" otherButtonTitles:nil];
    [actionSheet showInView:self.view];
}

/**
 *  segue跳转方法
 */
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    id vc = segue.destinationViewController;
    if ([vc isKindOfClass:[AddViewController class]]) {
        AddViewController *addvc = (AddViewController *)vc;
        addvc.delegate = self;
    } else if ([vc isKindOfClass:[EditViewController class]]) {
        EditViewController *editvc = (EditViewController *)vc;
        NSIndexPath *path = [self.tableView indexPathForSelectedRow];
        editvc.contact = self.contactArray[path.row];
        editvc.delegate = self;
    }
}

#pragma mark - 删除方法

/**
 *  点击删除按钮方法
 */
- (void)clickTrash
{
    [self.tableView setEditing:!self.tableView.isEditing animated:YES];
}

#pragma mark - UIActionSheetDelegate代理方法

/**
 *  提示框按钮方法
 */
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex != 0)
        return;
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - AddViewControllerDelegate代理方法

/**
 *  添加联系人方法
 */
- (void)addViewController:(AddViewController *)addvc didAddContact:(ContactModel *)contact
{
    [self.contactArray addObject:contact];
    [self.tableView reloadData];
    [NSKeyedArchiver archiveRootObject:self.contactArray toFile:CCContactPath];
}

#pragma mark - EditViewControllerDelegate代理方法

/**
 *  编辑联系人方法
 */
- (void)editViewController:(EditViewController *)editvc didSaveContact:(ContactModel *)contact
{
    [self.tableView reloadData];
    [NSKeyedArchiver archiveRootObject:self.contactArray toFile:CCContactPath];
}

@end
