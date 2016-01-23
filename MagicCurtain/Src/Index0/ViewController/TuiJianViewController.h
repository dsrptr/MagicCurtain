//
//  TuiJianViewController.h
//  MagicCurtain
//
//  Created by macbook pro on 15/10/27.
//  Copyright © 2015年 com.honglangya. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LessonDetailModel.h"
@protocol TuiJianDelegate<NSObject>
-(void)playCoursWithLessonId:(NSString *)lessonId withPicture:(NSString *)picture;
@end
@interface TuiJianViewController : UIViewController
@property (nonatomic,weak)id<TuiJianDelegate>delegate;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tableViewHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *botton;
@property (strong,nonatomic)NSMutableArray *dataSouce;
@end
