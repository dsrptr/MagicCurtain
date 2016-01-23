//
//  ChooseCell.m
//  MagicCurtain
//
//  Created by macbook pro on 15/11/19.
//  Copyright © 2015年 com.honglangya. All rights reserved.
//

#import "ChooseCell.h"

@implementation ChooseCell

- (void)awakeFromNib {
    self.choseBtn.layer.borderWidth=0.5;
    self.choseBtn.layer.borderColor=[UIColor lightGrayColor].CGColor;
    self.pictureView.layer.borderWidth=0.5;
    self.pictureView.layer.borderColor=[UIColor lightGrayColor].CGColor;

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)choseAction:(id)sender{
    [self.delegate chooseList];
}
@end
