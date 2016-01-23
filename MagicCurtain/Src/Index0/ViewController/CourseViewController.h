//
//  CourseViewController.h
//  MagicCurtain
//
//  Created by macbook pro on 15/10/27.
//  Copyright © 2015年 com.honglangya. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LessonDetailModel.h"


@interface CourseViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIView *mediaView;
- (IBAction)backAction:(id)sender;
- (IBAction)muneAction:(id)sender;
- (IBAction)detailAction:(id)sender;
- (IBAction)tuijianAction:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *selectView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *selectViewWidth;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *selectVIewFrame;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *titleWidth;
@property (strong, nonatomic) LessonDetailInfoModelInfo *models;
@property (strong,nonatomic)NSString *picUrlString;
@property (assign,nonatomic)NSInteger iscollect;;
- (IBAction)shareAction:(id)sender;
- (IBAction)requestAction:(id)sender;
- (IBAction)collectionAction:(id)sender;
@property (weak, nonatomic) IBOutlet UITextView *mytextView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomFarme;
@property (weak, nonatomic) IBOutlet UIView *textViewBackView;
- (IBAction)likeAction:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *collect;
@property (weak, nonatomic) IBOutlet UIButton *like;

- (IBAction)callceAction:(id)sender;
- (IBAction)postAction:(id)sender;
- (IBAction)nextAction:(id)sender;
- (IBAction)lastAction:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *btn1;
@property (weak, nonatomic) IBOutlet UIButton *bth2;

@end
