//
//  LoginOutCell.m
//  MagicCurtain
//
//  Created by macbook pro on 15/12/11.
//  Copyright © 2015年 com.honglangya. All rights reserved.
//

#import "LoginOutCell.h"

@implementation LoginOutCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)loginoutAction:(id)sender {
    [self.delegate loginOut];
}
@end
