//
//  MessageCell.m
//  MagicCurtain
//
//  Created by macbook pro on 15/10/28.
//  Copyright © 2015年 com.honglangya. All rights reserved.
//

#import "MessageCell.h"
#import "RequestCell.h"
#import <UIImageView+WebCache.h>
@implementation MessageCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSouce.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LessonMessageReplyModelInfo *model =self.dataSouce[indexPath.row];
    RequestCell *cell =[tableView dequeueReusableCellWithIdentifier:@"RequestCell" forIndexPath:indexPath];
    [cell.picture sd_setImageWithURL:[NSURL URLWithString:model.head_image] placeholderImage:nil];
    cell.title.text=model.reg_name;
    cell.content.text=model.message;
    cell.regTIme.text=model.reg_time;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
  
    return 51;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
@end
