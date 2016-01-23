//
//  FirstViewController.h
//  MagicCurtain
//
//  Created by macbook pro on 15/11/6.
//  Copyright © 2015年 com.honglangya. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FirstViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITableView *tableView;
- (IBAction)messageAction:(id)sender;
- (IBAction)seachAction:(id)sender;


@end
