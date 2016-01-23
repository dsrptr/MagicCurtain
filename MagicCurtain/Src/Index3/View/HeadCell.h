//
//  HeadCell.h
//  MagicCurtain
//
//  Created by macbook pro on 15/11/1.
//  Copyright © 2015年 com.honglangya. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol HeadCellDelegate<NSObject>
-(void)showBigPic;
@end

@interface HeadCell : UITableViewCell
@property (weak,nonatomic)id<HeadCellDelegate>delegate;
@property (weak, nonatomic) IBOutlet UIImageView *headPic;

@end
