//
//  ContentViewController.h
//  MagicCurtain
//
//  Created by macbook pro on 15/11/19.
//  Copyright © 2015年 com.honglangya. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CaseInfoModel.h"
@interface ContentViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIView *audioPlayView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *audioHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *audioWidth;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *detailHeight;
@property (weak, nonatomic) IBOutlet UIWebView *myWebVIew;
@property (weak, nonatomic) IBOutlet UIScrollView *myScrollView;
@property (nonatomic,strong)CaseInfoModelLessonInfo *model;
@property (nonatomic,strong)NSString *detail;
@property (nonatomic,strong)NSMutableArray *dataSouce;
@property (nonatomic,strong)NSString *lessonid;
@property (nonatomic,strong)NSString *demo;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottonFram;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIButton *collect;

- (IBAction)shareAction:(id)sender;
@property (weak, nonatomic) IBOutlet UITextView *myTextView;
- (IBAction)postAction:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *textViewBackView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tableViewHeight;
- (IBAction)backAction:(id)sender;
- (IBAction)cancellAction:(id)sender;
- (IBAction)messageAction:(id)sender;
- (IBAction)collectionAction:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *mengban;
@property (weak, nonatomic) IBOutlet UIButton *btn1;
@property (weak, nonatomic) IBOutlet UIButton *btn2;

@end
