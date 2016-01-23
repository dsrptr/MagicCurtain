//
//  MyMesageViewController.m
//  MagicCurtain
//
//  Created by macbook pro on 15/12/19.
//  Copyright © 2015年 com.honglangya. All rights reserved.
//

#import "MyMesageViewController.h"
#import "MymessageCell.h"
#import "MemberMessageModel.h"
#import "NSString+MT.h"
@interface MyMesageViewController ()

@end

@implementation MyMesageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.tableFooterView=[UIView new];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    MemberMessageDetailInfo *model =self.dataSouce[row];
    MymessageCell *cell =[tableView dequeueReusableCellWithIdentifier:@"MymessageCell" forIndexPath:indexPath];
    cell.title.text=model.title;
    cell.message.text=model.message;
    cell.regTime.text=model.reg_time;
    cell.contentHeight.constant=[NSString heightWithString:model.message font:[UIFont systemFontOfSize:14] maxSize:CGSizeMake(DeviceFrame.size.width-24, 120)];
    if ([model.block_type isEqualToString:@"1"]) {
        cell.cate.text=@"课程留言";
    }else{
        cell.cate.text=@"课程留言";
    }
    cell.datasouce=model.message_reply;
    [self.view layoutIfNeeded];
    [cell.tableView reloadData];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath  {
    MemberMessageDetailInfo *model =self.dataSouce[indexPath.row];
    CGFloat messageHeight =[NSString heightWithString:model.message font:[UIFont systemFontOfSize:13] maxSize:CGSizeMake(DeviceFrame.size.width-24, 180)];
    CGFloat replyHeight = 0.0;
    for (int i=0; i<model.message_reply.count; i++) {
        MemberMessageReplyDetailInfo *replymodel=model.message_reply[i];
        replyHeight=replyHeight+[NSString heightWithString:replymodel.message font:[UIFont systemFontOfSize:13] maxSize:CGSizeMake(120, 80)]+20+17;
    }
    return (messageHeight+50+replyHeight);
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
