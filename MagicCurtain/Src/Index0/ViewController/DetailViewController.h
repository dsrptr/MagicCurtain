//
//  DetailViewController.h
//  MagicCurtain
//
//  Created by macbook pro on 15/10/27.
//  Copyright © 2015年 com.honglangya. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LessonDetailModel.h"

@interface DetailViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tableViewHeight;
@property (strong,nonatomic)NSString *intor;
@property (strong,nonatomic)NSMutableArray *dataSouce;
@property (weak, nonatomic) IBOutlet UIScrollView *myScrollview;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *myWebviewHeight;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *weviewWidth;
@property (weak, nonatomic) IBOutlet UIWebView *myWebview;
-(void)reloadScrollViewHeight;
@end
