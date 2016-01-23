//
//  PushHistoryViewController.m
//  MagicCurtain
//
//  Created by macbook pro on 15/11/26.
//  Copyright © 2015年 com.honglangya. All rights reserved.
//

#import "PushHistoryViewController.h"
#import "WebViewController.h"
#import <UIImageView+WebCache.h>
#import "PushMessageCell.h"
#import "IndexService.h"
#import "StatusModel.h"
@interface PushHistoryViewController ()
{
    SharedData  *sharedData;
    LoginModel *user;
}
@end

@implementation PushHistoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self getDataSouceWithmid];
    self.title=@"消息";
//    self.tableViewtop.constant=64;
    [self.view layoutIfNeeded];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(changeFrame) name:@"change" object:nil];
    self.tableView.tableFooterView=[UIView new];
//    [self.tableView setScrollIndicatorInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
}

-(void)getDataSouceWithmid{
    sharedData=[SharedData sharedInstance];
    user=sharedData.user;
    IndexService *indexService=[IndexService new];
    [indexService pushListwithMid:user.mid
                        andSecret:user.secret
               withViewController:self
                         withDone:^(StatusModel *model){
                             if (model.status==2) {
                                 StatusModelInfo *object=model.info;
                                 self.dataSouce=object.push;
                                 [self.tableView reloadData];
                             }
                         }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSouce.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger row =indexPath.row;
    PushListModel *model =self.dataSouce[row];
    PushMessageCell *cell =[tableView dequeueReusableCellWithIdentifier:@"PushMessageCell" forIndexPath:indexPath];
    cell.messageType.text=model.demo;
    
//    [cell.picture sd_setImageWithURL:[NSURL URLWithString:model.] placeholderImage:<#(UIImage *)#>]
    if ([model.is_read isEqualToString:@"1"]) {
        cell.isread.hidden=YES;
    }else{
        cell.isread.hidden=YES;
    }
    cell.creatTime.text=model.reg_time;
    cell.title.text=model.title;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath  {
    return 56;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger row =indexPath.row;
    PushListModel *model =self.dataSouce[row];
    WebViewController *target = [[WebViewController alloc] initWithNibName:@"WebViewController" bundle:nil];
    target.navigationController.navigationItem.leftBarButtonItem.title=@"消息";
    target.title=model.title;
    target.urlString = model.push_url;
    [self.navigationController pushViewController:target animated:YES];
}

-(void)changeFrame{
//    self.tableViewtop.constant=0;
//    [self.view layoutIfNeeded];
}

@end
