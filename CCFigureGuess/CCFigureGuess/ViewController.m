//
//  ViewController.m
//      CCFigureGuess
//      Chen Chen @ June 1st, 2015
//

#import "ViewController.h"
#import "QuestionModel.h"

@interface ViewController ()

/**
 *  序号标签
 */
@property (weak, nonatomic) IBOutlet UILabel *numberLabel;
/**
 *  标题标签
 */
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
/**
 *  图片按钮
 */
@property (weak, nonatomic) IBOutlet UIButton *imageButton;
/**
 *  下一题按钮
 */
@property (weak, nonatomic) IBOutlet UIButton *nextButton;
/**
 *  答案区
 */
@property (weak, nonatomic) IBOutlet UIView *answerView;
/**
 *  备选答案区
 */
@property (weak, nonatomic) IBOutlet UIView *optionView;
/**
 *  分数
 */
@property (weak, nonatomic) IBOutlet UIButton *scoreButton;
/**
 *  遮盖层
 */
@property (strong, nonatomic) UIButton *cover;
/**
 *  问题下标
 */
@property (assign, nonatomic) NSInteger index;
/**
 *  问题数组
 */
@property (strong, nonatomic) NSArray *questionArray;
/**
 *  图标原尺寸
 */
@property (assign, nonatomic) CGRect tempFrame;

@end

@implementation ViewController

#pragma mark - 初始化方法

/**
 *  问题数组惰性初始化方法
 */
- (NSArray *)questionArray
{
    if (_questionArray == nil) {
        NSArray *dictArray = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"questionData" ofType:@"plist"]];
        NSMutableArray *questions = [NSMutableArray array];
        for (NSDictionary *dict in dictArray) {
            QuestionModel *question = [QuestionModel questionModelWithDict:dict];
            [questions addObject:question];
        }
        _questionArray = questions;
    }
    return _questionArray;
}

/**
 *  遮盖层惰性初始化方法
 */
- (UIButton *)cover
{
    if (_cover == nil) {
        _cover = [[UIButton alloc] initWithFrame:self.view.bounds];
        _cover.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.7];
        [self.view addSubview:_cover];
        _cover.alpha = 0.0;
        [_cover addTarget:self action:@selector(smallImage) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cover;
}

#pragma mark - 系统方法

/**
 *  视图已经加载方法
 */
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.index = -1;
    [self nextQuestion];
}

/**
 *  状态栏偏好方法
 */
- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

#pragma mark - 图片方法

/**
 *  放大图片方法
 */
- (IBAction)bigImage
{
    [self.view bringSubviewToFront:self.imageButton];
    self.tempFrame = self.imageButton.frame;
    CGFloat imageWidth = self.view.frame.size.width;
    CGFloat imageHeight = imageWidth;
    CGFloat imageX = 0;
    CGFloat imageY = (self.view.frame.size.height - imageHeight) / 2;
    [UIView animateWithDuration:0.5 animations:^{
        self.cover.alpha = 0.7;
        self.imageButton.frame = CGRectMake(imageX, imageY, imageWidth, imageHeight);
    }];
}

/**
 *  缩小图片方法
 */
- (void)smallImage
{
    [UIView animateWithDuration:0.5 animations:^{
        self.imageButton.frame = self.tempFrame;
        self.cover.alpha = 0.0;
    }];
}

/**
 *  点击图片方法
 */
- (IBAction)clickImage
{
    if (self.cover.alpha == 0.0)
        [self bigImage];
    else
        [self smallImage];
}

#pragma mark - 基本方法

/**
 *  改变分数方法
 */
- (void)changeScore:(NSInteger)tempScore
{
    NSInteger score = [self.scoreButton.currentTitle integerValue];
    score += tempScore;
    [self.scoreButton setTitle:[NSString stringWithFormat:@"%ld", score] forState:UIControlStateNormal];
}

/**
 *  下一题方法
 */
- (IBAction)nextQuestion
{
    if (self.index == self.questionArray.count - 1) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"恭喜" message:@"您已经通关了，敬请期待之后的更新！" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alertView show];
        return;
    }
    self.index++;
    QuestionModel *question = self.questionArray[self.index];
    [self settingData:question];
    [self addOptionButton:question];
    [self addAnswerButton:question];
}

/**
 *  设置数据方法
 */
- (void)settingData:(QuestionModel *)question
{
    self.numberLabel.text = [NSString stringWithFormat:@"%ld/%ld", self.index + 1, self.questionArray.count];
    self.titleLabel.text = question.title;
    [self.imageButton setImage:[UIImage imageNamed:question.icon] forState:UIControlStateNormal];
    self.nextButton.enabled = (self.index != self.questionArray.count - 1);
}

#pragma mark - 答案及备选答案区方法

/**
 *  添加备选答案区方法
 */
- (void)addOptionButton:(QuestionModel *)question
{
    [self.optionView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    for (int i = 0; i < question.options.count; ++i) {
        UIButton *optionButton = [[UIButton alloc] init];
        [optionButton setBackgroundImage:[UIImage imageNamed:@"btn_option"] forState:UIControlStateNormal];
        [optionButton setBackgroundImage:[UIImage imageNamed:@"btn_option_highlighted"] forState:UIControlStateHighlighted];
        [optionButton setTitle:question.options[i] forState:UIControlStateNormal];
        [optionButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        int totalColumns = 7;
        int row = i / totalColumns;
        int col = i % totalColumns;
        CGFloat optionWidth = 40;
        CGFloat optionHeight = 40;
        CGFloat margin = 10;
        CGFloat sideMargin = (self.optionView.frame.size.width - totalColumns * optionWidth - (totalColumns - 1) * margin) / 2;
        CGFloat optionX = sideMargin + col * (optionWidth + margin);
        CGFloat optionY = row * (optionHeight + margin);
        optionButton.frame = CGRectMake(optionX, optionY, optionWidth, optionHeight);
        [self.optionView addSubview:optionButton];
        [optionButton addTarget:self action:@selector(clickOptionButton:) forControlEvents:(UIControlEventTouchUpInside)];
    }
}

/**
 *  添加答案区方法
 */
- (void)addAnswerButton:(QuestionModel *)question
{
    for (UIView *button in self.answerView.subviews)
        [button removeFromSuperview];
    for (int i = 0; i < question.answer.length; ++i) {
        UIButton *answerButton = [[UIButton alloc] init];
        [answerButton setBackgroundImage:[UIImage imageNamed:@"btn_answer"] forState:UIControlStateNormal];
        [answerButton setBackgroundImage:[UIImage imageNamed:@"btn_answer_highlighted"] forState:UIControlStateHighlighted];
        [answerButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        CGFloat answerWidth = 40;
        CGFloat answerHeight = 40;
        CGFloat margin = 10;
        CGFloat sideMargin = (self.answerView.frame.size.width - question.answer.length * answerWidth - (question.answer.length - 1) * margin) / 2;
        CGFloat answerX = sideMargin + i * (answerWidth + margin);
        CGFloat answerY = 0;
        answerButton.frame = CGRectMake(answerX, answerY, answerWidth, answerHeight);
        [self.answerView addSubview:answerButton];
        [answerButton addTarget:self action:@selector(clickAnswerButton:) forControlEvents:(UIControlEventTouchUpInside)];
    }
}

/**
 *  点击备选答案区方法
 */
- (void)clickOptionButton:(UIButton *)sender
{
    sender.hidden = YES;
    for (UIButton *answerButton in self.answerView.subviews) {
        if (answerButton.currentTitle.length == 0) {
            [answerButton setTitle:sender.currentTitle forState:UIControlStateNormal];
            break;
        }
    }
    BOOL isFull = YES;
    NSMutableString *tempTitle = [NSMutableString string];
    for (UIButton *answerButton in self.answerView.subviews) {
        if (answerButton.currentTitle.length == 0)
            isFull = NO;
        else
            [tempTitle appendString:answerButton.currentTitle];
    }
    if (isFull) {
        for (UIButton *optionButton in self.optionView.subviews)
            optionButton.enabled = NO;
        QuestionModel *question = self.questionArray[self.index];
        if ([tempTitle isEqualToString:question.answer]) {
            for (UIButton *answerButton in self.answerView.subviews)
                [answerButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
            [self changeScore:500];
            [self performSelector:@selector(nextQuestion) withObject:nil afterDelay:0.5];
        } else {
            for (UIButton *answerButton in self.answerView.subviews)
                [answerButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
            [self changeScore:-100];
        }
    }
}

/**
 *  点击答案区方法
 */
- (void)clickAnswerButton:(UIButton *)sender
{
    for (UIButton *optionButton in self.optionView.subviews)
        optionButton.enabled = YES;
    for (UIButton *optionButton in self.optionView.subviews) {
        if ([optionButton.currentTitle isEqualToString:sender.currentTitle] && optionButton.hidden == YES) {
            optionButton.hidden = NO;
            break;
        }
    }
    [sender setTitle:nil forState:UIControlStateNormal];
    for (UIButton *answerButton in self.answerView.subviews)
        [answerButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
}

#pragma mark - 帮助及提示方法

/**
 *  答案提示方法
 */
- (IBAction)tipAnswer
{
    for (UIButton *answerButton in self.answerView.subviews)
        [self clickAnswerButton:answerButton];
    QuestionModel *question = self.questionArray[self.index];
    NSString *firstAnswer = [question.answer substringToIndex:1];
    for (UIButton *optionButton in self.optionView.subviews) {
        if ([optionButton.currentTitle isEqualToString:firstAnswer]) {
            [self clickOptionButton:optionButton];
            break;
        }
    }
    [self changeScore:-1000];
}

/**
 *  帮助方法
 */
- (IBAction)helpMe
{
    UILabel *helpLabel = [[UILabel alloc] init];
    [helpLabel setBackgroundColor:[UIColor whiteColor]];
    [helpLabel setTextColor:[UIColor blackColor]];
    [helpLabel setText:@"从下方待选选项中选择对应图片的正确答案"];
    helpLabel.textAlignment = NSTextAlignmentCenter;
    CGFloat helpWidth = 350;
    CGFloat helpHeight = 30;
    CGFloat helpX = (self.view.frame.size.width - helpWidth) / 2;
    CGFloat helpY = (self.view.frame.size.height - helpHeight) / 2;
    helpLabel.frame = CGRectMake(helpX, helpY, helpWidth, helpHeight);
    helpLabel.alpha = 0.7;
    [self.view addSubview:helpLabel];
    [helpLabel performSelector:@selector(removeFromSuperview) withObject:nil afterDelay:1.0];
}

@end
