//
//  PushMessageCell.m
//  MagicCurtain
//
//  Created by macbook pro on 15/11/26.
//  Copyright © 2015年 com.honglangya. All rights reserved.
//

#import "PushMessageCell.h"

@implementation PushMessageCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    self.isread.layer.cornerRadius=6.5;
    
    // Configure the view for the selected state
}

@end
