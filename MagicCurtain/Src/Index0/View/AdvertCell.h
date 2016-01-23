//
//  AdvertCell.h
//  MagicCurtain
//
//  Created by macbook pro on 15/11/1.
//  Copyright © 2015年 com.honglangya. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MartinLiPageScrollView.h"
@interface AdvertCell : UITableViewCell
@property (weak, nonatomic) IBOutlet MartinLiPageScrollView *pageView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *pageViewHeight;

@end
