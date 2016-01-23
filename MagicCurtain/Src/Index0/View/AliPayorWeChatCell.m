//
//  AliPayorWeChatCell.m
//  MagicCurtain
//
//  Created by macbook pro on 15/12/10.
//  Copyright © 2015年 com.honglangya. All rights reserved.
//

#import "AliPayorWeChatCell.h"

@implementation AliPayorWeChatCell

- (void)awakeFromNib {
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    self.choose.layer.borderColor=[SharedAction colorWithHexString:@"00B050"].CGColor;
    self.choose.layer.borderWidth=2;
}

- (IBAction)choseAction:(id)sender {
    [self.delegate choosePayType:self.tag inCell:self];
}
@end
