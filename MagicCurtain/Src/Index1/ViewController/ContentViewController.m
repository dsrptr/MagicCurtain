//
//  ContentViewController.m
//  MagicCurtain
//
//  Created by macbook pro on 15/11/19.
//  Copyright © 2015年 com.honglangya. All rights reserved.
//

#import "ContentViewController.h"
#import <MediaPlayer/MediaPlayer.h>
#import "AppDelegate.h"
#import <AVKit/AVKit.h>
#import "Index1Service.h"
#import "StatusModel.h"
#import "MessageCell.h"
#import <UIImageView+WebCache.h>
#import "UserNavigationController.h"
#import "NSString+MT.h"
#define Lesson_Share_URL [BaseUrl stringByAppendingString:@"Lesson/lesson_share/mid/%@/secret/%@/lesson_id/%@/to/%@"]
@interface ContentViewController ()
{
    UITapGestureRecognizer *hidKeyBoardtap;
    Index1Service *index1Service;
    LoginModel *user;
    CGFloat webViewHeight;
}
@property MPMoviePlayerController *player;
@end

@implementation ContentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(begainFullScreen) name:UIWindowDidBecomeVisibleNotification object:nil];//进入全屏
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(endFullScreen) name:UIWindowDidBecomeHiddenNotification object:nil];//退出全屏

    
    
    webViewHeight=0;
    self.detailHeight.constant = 0;
    self.tableView.tableFooterView=[UIView new];
       index1Service=[Index1Service new];
    self.myWebVIew.scrollView.scrollEnabled=NO;
    self.mengban.hidden=YES;
    if ([self.model.vedio_url isEqualToString:@""]||self.model.vedio_url==nil) {
        self.audioPlayView.hidden=YES;
        self.audioHeight.constant=0;
    }else{
        [self setPlayer];
    }
    self.title=self.model.title;
    [self loadWebPageWithString:self.model.intro_html inWebView:self.myWebVIew];
    hidKeyBoardtap =[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboard)];
    self.textViewBackView.hidden=YES;
    
    
    self.btn1.layer.cornerRadius=3;
    self.btn2.layer.cornerRadius=3;
    self.collect.layer.cornerRadius=3;
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
    }
    
}
#pragma - mark 退出全屏
-(NSUInteger)endFullScreen
{
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    appDelegate.allowRotation = YES;
    return UIInterfaceOrientationMaskLandscapeLeft|UIInterfaceOrientationMaskLandscapeRight;
    
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [[UIApplication sharedApplication]setStatusBarHidden:NO];
    self.navigationController.navigationBar.hidden=NO;
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[UIApplication sharedApplication]setStatusBarHidden:YES];
    SharedData *sharedData =[SharedData sharedInstance];
    user=sharedData.user;

    self.navigationController.navigationBar.hidden=YES;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSouce.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger row =indexPath.row;
    MessageCell *cell =[tableView dequeueReusableCellWithIdentifier:@"MessageCell" forIndexPath:indexPath];
    LessonMessageInfoModelInfo *model =self.dataSouce[row];
    [cell.headPicture sd_setImageWithURL:[NSURL URLWithString:model.head_image] placeholderImage:nil];
    cell.contentHeight.constant=[NSString heightWithString:model.message font:[UIFont systemFontOfSize:13] maxSize:CGSizeMake(DeviceFrame.size.width-74, 120)];
    [cell layoutIfNeeded];
    cell.name.text=model.reg_name;
    cell.regtime.text=model.reg_time;
    cell.content.text=model.message;
    cell.dataSouce=model.message_reply;
    [cell.tableView reloadData];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath  {
    LessonMessageInfoModelInfo *model =self.dataSouce[indexPath.row];
    CGFloat messageHeight =[NSString heightWithString:model.message font:[UIFont systemFontOfSize:13] maxSize:CGSizeMake(240, 180)];
    CGFloat replyHeight = 0.0;
    for (int i=0; i<model.message_reply.count; i++) {
        LessonMessageReplyModelInfo *replymodel=model.message_reply[i];
        replyHeight=replyHeight+[NSString heightWithString:replymodel.message font:[UIFont systemFontOfSize:13] maxSize:CGSizeMake(120, 80)]+50;
    }
    return (messageHeight+50+replyHeight);
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

-(void)setPlayer{
    NSString *urlStr=self.model.vedio_url;
    NSURL *url =[NSURL URLWithString:urlStr];
    _player =[[MPMoviePlayerController alloc] initWithContentURL:url];
    _player.controlStyle=MPMovieControlStyleEmbedded;
    [_player prepareToPlay];
    [_player.view setFrame:CGRectMake(0, 0, DeviceFrame.size.width, 182)];  // player的尺寸
    [self.audioPlayView addSubview: _player.view];
    _player.shouldAutoplay=YES;
}
- (void)loadWebPageWithString:(NSString*)urlString inWebView:(UIWebView *)webView{
    NSURL *url =[NSURL URLWithString:urlString];
    NSURLRequest *request =[NSURLRequest requestWithURL:url];
    [webView loadRequest:request];
}

#pragma UIWebViewDelegate
- (void)webViewDidStartLoad:(UIWebView *)webView{
//    [SVProgressHUD show];
}
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    CGRect frame = webView.frame;
    CGSize mWebViewTextSize = [webView sizeThatFits:CGSizeMake(1.0f, 1.0f)];
    frame.size = mWebViewTextSize;
    self.myWebVIew.frame = frame;
    self.detailHeight.constant = mWebViewTextSize.height;
    self.tableViewHeight.constant=0;
    for (int i=0; i<self.dataSouce.count; i++) {
        LessonMessageInfoModelInfo *model =self.dataSouce[i];
        CGFloat messageHeight =[NSString heightWithString:model.message font:[UIFont systemFontOfSize:13] maxSize:CGSizeMake(240, 180)];
            CGFloat replyHeight = 0.0;
            for (int i=0; i<model.message_reply.count; i++) {
                LessonMessageReplyModelInfo *replymodel=model.message_reply[i];
                 replyHeight=replyHeight+[NSString heightWithString:replymodel.message font:[UIFont systemFontOfSize:13] maxSize:CGSizeMake(120, 80)]+50;
            }
            self.tableViewHeight.constant=self.tableViewHeight.constant +(messageHeight+50+replyHeight);
    }
    [self.view layoutIfNeeded];
    if ([self.model.vedio_url isEqualToString:@""]||self.model.vedio_url==nil) {
        webViewHeight=mWebViewTextSize.height;
        [self.myScrollView setContentSize:CGSizeMake(DeviceFrame.size.width, mWebViewTextSize.height+self.tableViewHeight.constant)];
    }else{
        webViewHeight=mWebViewTextSize.height+182;
        [self.myScrollView setContentSize:CGSizeMake(DeviceFrame.size.width, mWebViewTextSize.height+self.tableViewHeight.constant+182)];
    }
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)shareAction:(id)sender {
    if (user.mid==nil||[user.mid isEqualToString:@""]||user.secret==nil||[user.secret isEqualToString:@""]) {
        UIStoryboard *storyboard =[UIStoryboard storyboardWithName:@"User" bundle:nil];
        UserNavigationController *userNavi=[storyboard instantiateViewControllerWithIdentifier:@"UserNavigationController"];
        [self presentViewController:userNavi animated:YES completion:nil];
        return;
    }
    NSString *message=[NSString stringWithFormat:self.demo,self.model.title];
    [SharedAction shareWithTitle:self.model.title andDesinationUrl:self.model.share_url Text:message andImageUrl:@"" InViewController:self];
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
        NSString *urlString =[NSString stringWithFormat:Lesson_Share_URL,user.mid,user.secret,self.model.lesson_id,to];
        [StatusModel getModelFromURLWithString:urlString completion:^(StatusModel *model,JSONModelError *error){
            [SVProgressHUD showSuccessWithStatus:@"分享成功"];
        }];
        
    }else{
        [SVProgressHUD showErrorWithStatus:response.message];
    }
}
- (IBAction)postAction:(id)sender {
    [index1Service caseMessageWithMid:user.mid andSecret:user.secret andMessage:self.myTextView.text andLseeonId:self.lessonid withViewController:self WithDone:^(StatusModel *model){
        if (model.status==2) {
            [SVProgressHUD showSuccessWithStatus:@"留言成功!"];
            [self hideKeyboard];
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            [dateFormatter setDateFormat:@"yyyy-MM-dd hh:mm"];
            LessonMessageInfoModelInfo *lessonMessage=[LessonMessageInfoModelInfo new];
            lessonMessage.message=self.myTextView.text;
            lessonMessage.reg_name=user.nick_name;
            lessonMessage.head_image=user.head_image;
            lessonMessage.reg_time = [dateFormatter stringFromDate:[NSDate date]];
            [self.dataSouce insertObject:lessonMessage atIndex:0];
            [self.tableView reloadData];
            [self reloadScrollViewHeight];
        }else{
            [SVProgressHUD showSuccessWithStatus:model.msg];
        }
    }];
}

-(void)reloadScrollViewHeight{
    self.tableViewHeight.constant=0;
    for (int i=0; i<self.dataSouce.count; i++) {
        LessonMessageInfoModelInfo *model =self.dataSouce[i];
        CGFloat messageHeight =[NSString heightWithString:model.message font:[UIFont systemFontOfSize:13] maxSize:CGSizeMake(240, 180)];
        CGFloat replyHeight = 0.0;
        for (int i=0; i<model.message_reply.count; i++) {
            LessonMessageReplyModelInfo *replymodel=model.message_reply[i];
            replyHeight=replyHeight+[NSString heightWithString:replymodel.message font:[UIFont systemFontOfSize:13] maxSize:CGSizeMake(120, 80)]+50;
        }
        self.tableViewHeight.constant=self.tableViewHeight.constant +(messageHeight+50+replyHeight);
    }
    [self.view layoutIfNeeded];

    [self.myScrollView setContentSize:CGSizeMake(DeviceFrame.size.width, webViewHeight+self.tableViewHeight.constant)];
    
}
- (IBAction)backAction:(id)sender {
    [_player stop];
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)cancellAction:(id)sender {
    self.mengban.hidden=YES;
    [self.mengban removeGestureRecognizer:hidKeyBoardtap];
    [UIView animateWithDuration:0.5 animations:^{
        self.bottonFram.constant=0;
        [self.view layoutIfNeeded];
    } completion:^(BOOL status){
        if (status) {
            self.myTextView.text=@"";
            self.textViewBackView.hidden=YES;
            [self.view endEditing:YES];
        }
    }];

}

- (IBAction)messageAction:(id)sender {
    if (user.mid==nil||[user.mid isEqualToString:@""]||user.secret==nil||[user.secret isEqualToString:@""]) {
        UIStoryboard *storyboard =[UIStoryboard storyboardWithName:@"User" bundle:nil];
        UserNavigationController *userNavi=[storyboard instantiateViewControllerWithIdentifier:@"UserNavigationController"];
        [self presentViewController:userNavi animated:YES completion:nil];
        return;
    }
    self.mengban.hidden=NO;
    [self.mengban addGestureRecognizer:hidKeyBoardtap];
    self.myTextView.text=@"";
    [UIView animateWithDuration:0.5 animations:^{
        [self.myTextView becomeFirstResponder];
        self.textViewBackView.hidden=NO;
        NSLog(@"%f",DeviceFrame.size.height);
        if(DeviceFrame.size.width<=320){
            self.bottonFram.constant=190;
        }else{
            self.bottonFram.constant=190;
        }
        
        [self.view layoutIfNeeded];
    }];

}
-(void)hideKeyboard{
    self.mengban.hidden=YES;
    [self.mengban removeGestureRecognizer:hidKeyBoardtap];
    [UIView animateWithDuration:0.5 animations:^{
        self.bottonFram.constant=0;
        [self.view layoutIfNeeded];
    } completion:^(BOOL status){
        if (status) {
            [self.myTextView resignFirstResponder];
            self.myTextView.text=@"";
            self.textViewBackView.hidden=YES;
        }
    }];
}
- (IBAction)collectionAction:(id)sender {
    if (user.mid==nil||[user.mid isEqualToString:@""]||user.secret==nil||[user.secret isEqualToString:@""]) {
        UIStoryboard *storyboard =[UIStoryboard storyboardWithName:@"User" bundle:nil];
        UserNavigationController *userNavi=[storyboard instantiateViewControllerWithIdentifier:@"UserNavigationController"];
        [self presentViewController:userNavi animated:YES completion:nil];
        return;
    }
    [index1Service caseCollectWithMid:user.mid andSecret:user.secret andLessonId:self.lessonid withViewController:self withDone:^(StatusModel *model){
        [SVProgressHUD showSuccessWithStatus:model.msg];
    }];
}
@end
