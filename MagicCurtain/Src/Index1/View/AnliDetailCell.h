//
//  AnliDetailCell.h
//  MagicCurtain
//
//  Created by macbook pro on 15/11/1.
//  Copyright © 2015年 com.honglangya. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AnliDetailCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *demo;
@property (weak, nonatomic) IBOutlet UILabel *playNum;
@property (weak, nonatomic) IBOutlet UILabel *money;
@property (weak, nonatomic) IBOutlet UIButton *collect;
@property (weak, nonatomic) IBOutlet UIImageView *picture;

@end
