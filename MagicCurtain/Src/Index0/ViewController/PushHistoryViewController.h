//
//  PushHistoryViewController.h
//  MagicCurtain
//
//  Created by macbook pro on 15/11/26.
//  Copyright © 2015年 com.honglangya. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PushListModel.h"
@interface PushHistoryViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *viewTop;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tableViewtop;
@property (nonatomic,strong)NSArray *dataSouce;
@end
