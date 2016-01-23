//
//  ArreaViewController.h
//  MagicCurtain
//
//  Created by macbook pro on 15/12/9.
//  Copyright © 2015年 com.honglangya. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ArreaViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,strong)NSArray *nameArray;
@property (nonatomic,assign)NSInteger getType;
@property (nonatomic,strong)NSString *address;
@end
