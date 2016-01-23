//
//  TuijianListViewController.h
//  MagicCurtain
//
//  Created by macbook pro on 15/12/19.
//  Copyright © 2015年 com.honglangya. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RefModel.h"
@interface TuijianListViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,strong)NSMutableArray *dataSouce;
@end
