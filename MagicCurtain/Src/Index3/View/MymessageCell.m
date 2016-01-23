//
//  MymessageCell.m
//  MagicCurtain
//
//  Created by macbook pro on 15/12/19.
//  Copyright © 2015年 com.honglangya. All rights reserved.
//

#import "MymessageCell.h"
#import "ReauestMeCell.h"
#import "MemberMessageModel.h"
#import "NSString+MT.h"
@implementation MymessageCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.datasouce.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger row =indexPath.row;
    MemberMessageReplyDetailInfo *replymodel=self.datasouce[row];
    ReauestMeCell *cell =[tableView dequeueReusableCellWithIdentifier:@"ReauestMeCell" forIndexPath:indexPath];
    cell.message.text=replymodel.message;
    cell.regtime.text=replymodel.reg_time;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath  {
    NSInteger row =indexPath.row;
    MemberMessageReplyDetailInfo *replymodel=self.datasouce[row];
    return [NSString heightWithString:replymodel.message font:[UIFont systemFontOfSize:14] maxSize:CGSizeMake(DeviceFrame.size.width-32, 120)]+20+17;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
@end
