//
//  InputCell.m
//  MagicCurtain
//
//  Created by macbook pro on 15/11/19.
//  Copyright © 2015年 com.honglangya. All rights reserved.
//

#import "InputCell.h"

@implementation InputCell

- (void)awakeFromNib {
    self.inputSize.layer.borderColor=[UIColor lightGrayColor].CGColor;
    self.inputSize.layer.borderWidth=0.5;
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
