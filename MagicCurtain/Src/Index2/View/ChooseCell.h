//
//  ChooseCell.h
//  MagicCurtain
//
//  Created by macbook pro on 15/11/19.
//  Copyright © 2015年 com.honglangya. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol ChooseCellDelegate<NSObject>
-(void)chooseList;
@end
@interface ChooseCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *choseBtn;
@property (weak,nonatomic)id<ChooseCellDelegate>delegate;
@property (weak, nonatomic) IBOutlet UIImageView *pictureView;
- (IBAction)choseAction:(id)sender;
@end
