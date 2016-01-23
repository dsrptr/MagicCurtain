//
//  CourseViewController.m
//  MagicCurtain
//
//  Created by macbook pro on 15/10/27.
//  Copyright © 2015年 com.honglangya. All rights reserved.
//

#import "CourseViewController.h"
#import <MediaPlayer/MediaPlayer.h>
#import "MuneViewController.h"
#import "DetailViewController.h"
#import "TuiJianViewController.h"
#import "DsrMainScrollView.h"
#import "RootTabBarController.h"
#import "UserNavigationController.h"
#import "PayNavigationViewController.h"
#import "IndexService.h"
#import "StatusModel.h"
#import <AVKit/AVKit.h>
#import "AppDelegate.h"
#define Lesson_Share_URL [BaseUrl stringByAppendingString:@"Lesson/lesson_share/mid/%@/secret/%@/lesson_id/%@/to/%@"]
//#import "MPMoviePlayerController+Subtitles.h"
@interface CourseViewController ()<MuneViewControllerDelegate,DsrMainScrollViewDelegate,TuiJianDelegate,UINavigationControllerDelegate>
{
    UIStoryboard *storyboard0;
    UITapGestureRecognizer *hidKeyBoardtap;
    LoginModel *user;
    NSInteger selectIndex;
    NSArray *dataSouce;
    IndexService *indexService;
    DetailViewController *detailViewController;
}
@property MPMoviePlayerController *player;
@end

@implementation CourseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(begainFullScreen) name:UIWindowDidBecomeVisibleNotification object:nil];//进入全屏
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(endFullScreen) name:UIWindowDidBecomeHiddenNotification object:nil];//退出全屏
    selectIndex=0;
    indexService=[IndexService new];
    hidKeyBoardtap =[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboard)];
    self.textViewBackView.hidden=YES;
    UIView *views =[[UIView alloc] initWithFrame:CGRectMake(0, 0, DeviceFrame.size.width, 22)];
    views.backgroundColor=[UIColor blackColor];
    [self.view addSubview:views];
    self.selectViewWidth.constant=DeviceFrame.size.width/3;
    self.titleWidth.constant=(DeviceFrame.size.width-8)/3;
    self.like.layer.cornerRadius=2;
    self.btn1.layer.cornerRadius=3;
    self.bth2.layer.cornerRadius=3;
    self.collect.layer.cornerRadius=3;
    self.navigationController.delegate=self;
    if (self.iscollect == 2) {
        [self.collect setTitle:@"已收藏" forState:UIControlStateNormal];
    }else{
        [self.collect setTitle:@"收藏" forState:UIControlStateNormal];
    }
    [self.view layoutIfNeeded];
    [self setScrollView];
}


#pragma - mark  进入全屏
-(void)begainFullScreen
{
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    appDelegate.allowRotation = NO;
    
    //强制归正：
    if ([[UIDevice currentDevice] respondsToSelector:@selector(setOrientation:)]) {
        SEL selector = NSSelectorFromString(@"setOrientation:");
        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:[UIDevice instanceMethodSignatureForSelector:selector]];
        [invocation setSelector:selector];
        [invocation setTarget:[UIDevice currentDevice]];
        int val =UIInterfaceOrientationPortrait;
        [invocation setArgument:&val atIndex:2];
        [invocation invoke];
        [_player play];
    }
    
}
#pragma - mark 退出全屏
-(NSUInteger)endFullScreen
{
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    appDelegate.allowRotation = YES;
    return UIInterfaceOrientationMaskLandscapeLeft|UIInterfaceOrientationMaskLandscapeRight;
}



- (void)showViewController:(UIViewController *)vc sender:(nullable id)sender{
    if ([vc isKindOfClass:[self.navigationController.viewControllers[0] class]]) {
        [_player stop];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    SharedData *sharedData =[SharedData sharedInstance];
    user=sharedData.user;
    self.navigationController.navigationBar.hidden=YES;
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden=NO;
}

-(void)setScrollView{
    DsrMainScrollView *dsrScrollview =[[DsrMainScrollView alloc] initWithFrame:CGRectMake(0, 246+27-self.navigationController.navigationBar.frame.size.height, DeviceFrame.size.width, DeviceFrame.size.height-31-246-27+self.navigationController.navigationBar.frame.size.height)];
//    dsrScrollview.backgroundColor=[UIColor redColor];
    dsrScrollview.delegates=self;
    UIStoryboard *storyboard =[UIStoryboard storyboardWithName:@"Index0" bundle:nil];
    MuneViewController *muneViewController=[storyboard instantiateViewControllerWithIdentifier:@"MuneViewController"];
    muneViewController.dataSouce=self.models.lesson_sub;
    dataSouce=self.models.lesson_sub;
    muneViewController.delegate=self;
    detailViewController=[storyboard instantiateViewControllerWithIdentifier:@"DetailViewController"];
    detailViewController.intor=self.models.intro;
    if (!detailViewController.dataSouce) {
        detailViewController.dataSouce=[[NSMutableArray alloc] initWithArray:self.models.lesson_message];
    }else{
        detailViewController.dataSouce=(NSMutableArray*)self.models.lesson_message;
    }
    dsrScrollview.topFrame=27;
    TuiJianViewController *tuiJianViewController=[storyboard instantiateViewControllerWithIdentifier:@"TuiJianViewController"];
    tuiJianViewController.delegate=self;
    tuiJianViewController.dataSouce=(NSMutableArray *)self.models.lesson_with;
    [dsrScrollview initWithViewControllers:@[muneViewController,detailViewController,tuiJianViewController]];
    dsrScrollview.scrollEnabled=YES;
    [self.view insertSubview:dsrScrollview atIndex:1];
}

#pragma MuneViewControllerDelegate

-(void)palyVideoWithIndex:(NSInteger)index andUrl:(NSString *)urlString{
    selectIndex=index;
    NSURL *url=[NSURL URLWithString:urlString];
    if(!_player){
    _player =[[MPMoviePlayerController alloc] init];
    }else{
        [_player stop];
    }
    _player.contentURL=url;
    _player.controlStyle=MPMovieControlStyleEmbedded;
     [_player setControlStyle:MPMovieControlStyleDefault];
    [_player prepareToPlay];
    [_player.view setFrame:CGRectMake(0, 0, DeviceFrame.size.width, 182)];  // player的尺寸
    [self.mediaView addSubview: _player.view];
    _player.shouldAutoplay=YES;
    [_player play];
}

- (IBAction)backAction:(id)sender {
    [_player stop];
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)selectIndex:(NSInteger)index
{
    [UIView animateWithDuration:0.2 animations:^{
        self.selectView.frame=CGRectMake(index*DeviceFrame.size.width/3, self.selectView.frame.origin.y, self.selectViewWidth.constant, 2);
    }];
}

- (IBAction)muneAction:(id)sender {
    if (self.selectView.frame.origin.x==0) {
        return;
    }
    [UIView animateWithDuration:0.2 animations:^{
        self.selectView.frame=CGRectMake(0, self.selectView.frame.origin.y, self.selectViewWidth.constant, 2);
    }];
     NSDictionary *dict =[[NSDictionary alloc] initWithObjectsAndKeys:@"first",@"scrollIndex",nil];
    NSNotification *notification =[NSNotification notificationWithName:@"ScrollNow" object:nil userInfo:dict];
    [[NSNotificationCenter defaultCenter]postNotification:notification];
}

- (IBAction)detailAction:(id)sender {
    if (self.selectView.frame.origin.x==DeviceFrame.size.width/3) {
        return;
    }
    [UIView animateWithDuration:0.2 animations:^{
        self.selectView.frame=CGRectMake(DeviceFrame.size.width/3, self.selectView.frame.origin.y, self.selectViewWidth.constant, 2);
    }];
    NSDictionary *dict =[[NSDictionary alloc] initWithObjectsAndKeys:@"second",@"scrollIndex",nil];
    NSNotification *notification =[NSNotification notificationWithName:@"ScrollNow" object:nil userInfo:dict];
    [[NSNotificationCenter defaultCenter]postNotification:notification];
}

- (IBAction)tuijianAction:(id)sender {
    if (self.selectView.frame.origin.x==DeviceFrame.size.width/3*2) {
        return;
    }
    [UIView animateWithDuration:0.2 animations:^{
        self.selectView.frame=CGRectMake(DeviceFrame.size.width/3*2, self.selectView.frame.origin.y, self.selectViewWidth.constant, 2);
    }];
    NSDictionary *dict =[[NSDictionary alloc] initWithObjectsAndKeys:@"third",@"scrollIndex",nil];
    NSNotification *notification =[NSNotification notificationWithName:@"ScrollNow" object:nil userInfo:dict];
    [[NSNotificationCenter defaultCenter]postNotification:notification];
}

- (IBAction)shareAction:(id)sender {
    if ([self.models.share_url isEqualToString:@""]||self.models.share_url==nil) {
        [SVProgressHUD showErrorWithStatus:@"该视频暂时不支持分享!"];
        return;
    }
    if(user.mid==nil||[user.mid isEqualToString:@""]||user.secret==nil||[user.secret isEqualToString:@""]){
        [SVProgressHUD showErrorWithStatus:@"只有登录后的会员才能分享!"];
        return;
    }
    
    //分享内嵌文字
    [SharedAction shareWithTitle:self.models.title
                andDesinationUrl:self.models.share_url
                            Text:self.models.intro
                     andImageUrl:self.picUrlString
                InViewController:self];
}
#pragma UMSocialUIDelegate
//实现回调方法（可选）：
-(void)didFinishGetUMSocialDataInViewController:(UMSocialResponseEntity *)response
{
    //根据`responseCode`得到发送结果,如果分享成功
    if(response.responseCode == UMSResponseCodeSuccess)
    {
        //得到分享到的微博平台名
        NSLog(@"share to sns name is %@",[[response.data allKeys] objectAtIndex:0]);
        NSString *to;
        if ([[[response.data allKeys] objectAtIndex:0] isEqualToString:@"wxtimeline"]||[[[response.data allKeys] objectAtIndex:0] isEqualToString:@"wxsession"]) {
            to=@"weixin";
        }else{
            to=@"qq";
        }
        NSString *urlString =[NSString stringWithFormat:Lesson_Share_URL,user.mid,user.secret,self.models.lesson_id,to];
        [StatusModel getModelFromURLWithString:urlString completion:^(StatusModel *model,JSONModelError *error){
            [SVProgressHUD showSuccessWithStatus:@"分享成功"];
        }];
        
    }else{
        [SVProgressHUD showErrorWithStatus:response.message];
    }
}

-(void)hideKeyboard{
    
    [UIView animateWithDuration:0.5 animations:^{
        self.bottomFarme.constant=0;
        [self.view layoutIfNeeded];
    } completion:^(BOOL status){
        if (status) {
            [self.mytextView resignFirstResponder];
            self.mytextView.text=@"";
            self.textViewBackView.hidden=YES;
//             [self.view endEditing:YES];
        }
    }];
}

-(void)keyboardWasHidden{
    [UIView setAnimationDuration:0.5];
    [UIView commitAnimations]; 
}
- (IBAction)requestAction:(id)sender {
    if (user.mid==nil||[user.mid isEqualToString:@""]||user.secret==nil||[user.secret isEqualToString:@""]) {
        UIStoryboard *storyboard =[UIStoryboard storyboardWithName:@"User" bundle:nil];
        UserNavigationController *userNavi=[storyboard instantiateViewControllerWithIdentifier:@"UserNavigationController"];
        [self presentViewController:userNavi animated:YES completion:nil];
        return;
    }
    [self.view addGestureRecognizer:hidKeyBoardtap];
    self.mytextView.text=@"";
    [UIView animateWithDuration:0.5 animations:^{
        [self.mytextView becomeFirstResponder];
        self.textViewBackView.hidden=NO;
        NSLog(@"%f",DeviceFrame.size.height);
        if(DeviceFrame.size.width<=320){
         self.bottomFarme.constant=190;
        }else{
         self.bottomFarme.constant=190;
        }
       
        [self.view layoutIfNeeded];
    }];
}

- (IBAction)collectionAction:(id)sender {
    if (user.mid==nil||[user.mid isEqualToString:@""]||user.secret==nil||[user.secret isEqualToString:@""]) {
        UIStoryboard *storyboard =[UIStoryboard storyboardWithName:@"User" bundle:nil];
        UserNavigationController *userNavi=[storyboard instantiateViewControllerWithIdentifier:@"UserNavigationController"];
        [self presentViewController:userNavi animated:YES completion:nil];
        return;
    }
    [indexService lessonCollectWithMid:user.mid andSecret:user.secret andLessonId:self.models.lesson_id withViewController:self withDone:^(StatusModel *model){
        [SVProgressHUD showSuccessWithStatus:model.msg];
    }];
}
- (IBAction)likeAction:(id)sender {
    [indexService lessonLikeWithMid:user.mid andSecret:user.secret andLessonId:self.models.lesson_id withViewController:self withDone:^(StatusModel *model){
        [SVProgressHUD showSuccessWithStatus:model.msg];
    }];
}

- (IBAction)callceAction:(id)sender {
    
    [UIView animateWithDuration:0.5 animations:^{
        self.bottomFarme.constant=0;
        [self.view layoutIfNeeded];
    } completion:^(BOOL status){
        if (status) {
            self.mytextView.text=@"";
            self.textViewBackView.hidden=YES;
            [self.view endEditing:YES];
        }
    }];
}

-(void)playCoursWithLessonId:(NSString *)lessonId withPicture:(NSString *)picture{
    
      [indexService lessonInfoWithLesson_id:lessonId andMid:user.mid andSecret:user.secret withViewController:self withDone:^(LessonDetailModelInfo *models){
        LessonDetailInfoModelInfo *object=models.lesson;
        UIStoryboard *storyboard =[UIStoryboard storyboardWithName:@"Index0" bundle:nil];
        CourseViewController *courseViewController =[storyboard instantiateViewControllerWithIdentifier:@"CourseViewController"];
        courseViewController.models=object;
        courseViewController.picUrlString=picture;
        courseViewController.hidesBottomBarWhenPushed=YES;
        [self.navigationController pushViewController:courseViewController animated:YES];
    }];
}


- (IBAction)postAction:(id)sender {
   
    if ([user.mid isEqualToString:@""]||user.mid==nil||[user.secret isEqualToString:@""]||user.secret==nil) {
        [SVProgressHUD showErrorWithStatus:@"请先登录才能留言!"];
        return;
    }
    [indexService lessonMessageWithMid:user.mid andSecret:user.secret andLesson_id:self.models.lesson_id andMessage:self.mytextView.text withViewController:self withDone:^(StatusModel *model){
        if (model.status==2) {
            [UIView animateWithDuration:0.5 animations:^{
                self.bottomFarme.constant=0;
                [self.view layoutIfNeeded];
            } completion:^(BOOL status){
                if (status) {
                    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
                    [dateFormatter setDateFormat:@"yyyy-MM-dd hh:mm"];
                    LessonMessageInfoModelInfo *lessonMessage=[LessonMessageInfoModelInfo new];
                    lessonMessage.message=self.mytextView.text;;
                    lessonMessage.reg_name=user.nick_name;
                    lessonMessage.head_image=user.head_image;
                    lessonMessage.reg_time = [dateFormatter stringFromDate:[NSDate date]];
                    [detailViewController.dataSouce insertObject:lessonMessage atIndex:0];
//                    [detailViewController.dataSouce addObject:lessonMessage];
                    [detailViewController.tableView reloadData];
                    [detailViewController reloadScrollViewHeight];
                    self.mytextView.text=@"";
                    self.textViewBackView.hidden=YES;
                    [self.view endEditing:YES];
                }
            }];
        }
    }];
}

- (IBAction)nextAction:(id)sender {
    if (selectIndex+1<dataSouce.count) {
        selectIndex++;
    }else{
        [SVProgressHUD showErrorWithStatus:@"没有更多章节了!"];
        return;
    }
    [[NSNotificationCenter defaultCenter]postNotificationName:@"next" object:nil];
    LessonSubInfoModelInfo *model =dataSouce[selectIndex];
    [self palyVideoWithIndex:selectIndex andUrl:model.video_url];
}

- (IBAction)lastAction:(id)sender {
    if (selectIndex-1>=0) {
        selectIndex--;
    }else{
        [SVProgressHUD showErrorWithStatus:@"已经是第一章节了!"];
        return;
    }
    [[NSNotificationCenter defaultCenter]postNotificationName:@"last" object:nil];
    LessonSubInfoModelInfo *model =dataSouce[selectIndex];
    [self palyVideoWithIndex:selectIndex andUrl:model.video_url];
}
@end
