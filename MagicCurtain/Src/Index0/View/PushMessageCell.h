//
//  PushMessageCell.h
//  MagicCurtain
//
//  Created by macbook pro on 15/11/26.
//  Copyright © 2015年 com.honglangya. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PushMessageCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *picture;
@property (weak, nonatomic) IBOutlet UILabel *messageType;
@property (weak, nonatomic) IBOutlet UILabel *creatTime;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UIView *isread;

@end
