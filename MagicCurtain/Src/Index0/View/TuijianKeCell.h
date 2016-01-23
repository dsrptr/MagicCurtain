//
//  TuijianKeCell.h
//  MagicCurtain
//
//  Created by macbook pro on 15/11/1.
//  Copyright © 2015年 com.honglangya. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TuijianKeCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *picture;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *time;
@property (weak, nonatomic) IBOutlet UILabel *paly_nums;
@property (weak, nonatomic) IBOutlet UILabel *point;
@property (weak, nonatomic) IBOutlet UIButton *iscollect;
- (IBAction)collectAction:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *likeNumbs;

@end
