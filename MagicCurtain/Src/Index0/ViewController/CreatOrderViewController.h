//
//  CreatOrderViewController.h
//  MagicCurtain
//
//  Created by macbook pro on 15/12/10.
//  Copyright © 2015年 com.honglangya. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CreatOrderViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UILabel *price;
@property (nonatomic,strong)NSString *payMoney;
@property (nonatomic,strong)NSString *lessonName;
@property (nonatomic,strong)NSString *lessonId;
@property (nonatomic,strong)NSString *lessonType;
@property (nonatomic,strong)NSString *indexPath;
- (IBAction)dismissAction:(id)sender;
- (IBAction)postAction:(id)sender;
@property (nonatomic,strong)NSString *needPrice;
@end
