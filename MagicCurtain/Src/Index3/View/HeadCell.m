//
//  HeadCell.m
//  MagicCurtain
//
//  Created by macbook pro on 15/11/1.
//  Copyright © 2015年 com.honglangya. All rights reserved.
//

#import "HeadCell.h"

@implementation HeadCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showBigPic)];
    [self.headPic addGestureRecognizer:tap];
    // Configure the view for the selected state
}
-(void)showBigPic{
    [self.delegate showBigPic];
}
@end
