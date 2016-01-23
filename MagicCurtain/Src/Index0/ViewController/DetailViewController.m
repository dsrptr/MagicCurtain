//
//  DetailViewController.m
//  MagicCurtain
//
//  Created by macbook pro on 15/10/27.
//  Copyright © 2015年 com.honglangya. All rights reserved.
//

#import "DetailViewController.h"
#import <UIImageView+WebCache.h>
#import "MessageCell.h"
#import "DetailViewCell.h"
#import "LessonDetailModel.h"
#import "NSString+MT.h"
@interface DetailViewController ()
{
    CGFloat webViewHeight;
}
@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.tableFooterView=[UIView new];
    self.myWebview.scrollView.scrollEnabled=NO;
    [self.myWebview loadHTMLString:self.intor baseURL:[NSURL URLWithString:@"www.bywindow.com"]];
    self.weviewWidth.constant=DeviceFrame.size.width;
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
    self.myWebview.frame = frame;
    self.myWebviewHeight.constant = mWebViewTextSize.height;
    self.tableViewHeight.constant=0;
    for (int i=0; i<self.dataSouce.count; i++) {
        LessonMessageInfoModelInfo *model =self.dataSouce[i];
        CGFloat messageHeight =[NSString heightWithString:model.message font:[UIFont systemFontOfSize:13] maxSize:CGSizeMake(DeviceFrame.size.width-84, 180)];
        CGFloat replyHeight = 0.0;
        for (int i=0; i<model.message_reply.count; i++) {
            LessonMessageReplyModelInfo *replymodel=model.message_reply[i];
            replyHeight=replyHeight+[NSString heightWithString:replymodel.message font:[UIFont systemFontOfSize:13] maxSize:CGSizeMake(120, 80)]+50;
        }
        self.tableViewHeight.constant=self.tableViewHeight.constant +(messageHeight+50+replyHeight);
    }
    [self.view layoutIfNeeded];
    webViewHeight=mWebViewTextSize.height;
    [self.myScrollview setContentSize:CGSizeMake(DeviceFrame.size.width, mWebViewTextSize.height+self.tableViewHeight.constant)];
}
-(void)reloadScrollViewHeight{
    self.tableViewHeight.constant=0;
    for (int i=0; i<self.dataSouce.count; i++) {
        LessonMessageInfoModelInfo *model =self.dataSouce[i];
        CGFloat messageHeight =[NSString heightWithString:model.message font:[UIFont systemFontOfSize:13] maxSize:CGSizeMake(DeviceFrame.size.width-84, 180)];
        CGFloat replyHeight = 0.0;
        for (int i=0; i<model.message_reply.count; i++) {
            LessonMessageReplyModelInfo *replymodel=model.message_reply[i];
            replyHeight=replyHeight+[NSString heightWithString:replymodel.message font:[UIFont systemFontOfSize:13] maxSize:CGSizeMake(120, 80)]+50;
        }
        self.tableViewHeight.constant=self.tableViewHeight.constant +(messageHeight+50+replyHeight);
    }
    [self.view layoutIfNeeded];

    [self.myScrollview setContentSize:CGSizeMake(DeviceFrame.size.width, webViewHeight+self.tableViewHeight.constant)];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
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
        cell.contentHeight.constant=[NSString heightWithString:model.message font:[UIFont systemFontOfSize:13] maxSize:CGSizeMake(DeviceFrame.size.width-84, 120)];
        cell.name.text=model.reg_name;
        cell.regtime.text=model.reg_time;
        cell.content.text=model.message;
        cell.dataSouce=model.message_reply;
        [cell.tableView reloadData];
        return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath  {
    LessonMessageInfoModelInfo *model =self.dataSouce[indexPath.row];
    CGFloat messageHeight =[NSString heightWithString:model.message font:[UIFont systemFontOfSize:13] maxSize:CGSizeMake(DeviceFrame.size.width-84, 180)];
    CGFloat replyHeight = 0.0;
    for (int i=0; i<model.message_reply.count; i++) {
        LessonMessageReplyModelInfo *replymodel=model.message_reply[i];
        replyHeight=replyHeight+[NSString heightWithString:replymodel.message font:[UIFont systemFontOfSize:13] maxSize:CGSizeMake(120, 120)]+30;
    }
    return (messageHeight+50+replyHeight);
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
@end
