//
//  AliPayorWeChatCell.h
//  MagicCurtain
//
//  Created by macbook pro on 15/12/10.
//  Copyright © 2015年 com.honglangya. All rights reserved.
//

#import <UIKit/UIKit.h>
@class AliPayorWeChatCell;
@protocol AliPayorWeChatDelegate<NSObject>
-(void)choosePayType:(NSInteger)index inCell:(AliPayorWeChatCell*)cell;
@end
@interface AliPayorWeChatCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *picture;
@property (weak,nonatomic)id<AliPayorWeChatDelegate>delegate;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *detaile;
- (IBAction)choseAction:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *choose;
@property (weak, nonatomic) IBOutlet UIView *backVIew;

@end
