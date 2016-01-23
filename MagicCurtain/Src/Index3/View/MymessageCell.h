//
//  MymessageCell.h
//  MagicCurtain
//
//  Created by macbook pro on 15/12/19.
//  Copyright © 2015年 com.honglangya. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MymessageCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *message;
@property (weak, nonatomic) IBOutlet UILabel *cate;
@property (weak, nonatomic) IBOutlet UILabel *regTime;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentHeight;
@property (nonatomic,strong)NSArray *datasouce;
@end
