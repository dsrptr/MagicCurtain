//
//  SeachViewController.h
//  MagicCurtain
//
//  Created by macbook pro on 15/11/19.
//  Copyright © 2015年 com.honglangya. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SeachViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,assign)NSInteger seachType;
- (IBAction)seachAgain:(id)sender;
@property (nonatomic,strong)NSArray *dataSouce;
@end
