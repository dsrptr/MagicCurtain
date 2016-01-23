//
//  MuneViewController.h
//  MagicCurtain
//
//  Created by macbook pro on 15/10/27.
//  Copyright © 2015年 com.honglangya. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LessonDetailModel.h"
@protocol MuneViewControllerDelegate<NSObject>
-(void)palyVideoWithIndex:(NSInteger)index andUrl:(NSString *)urlString;
@end
@interface MuneViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak,nonatomic)id<MuneViewControllerDelegate>delegate;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tableViewHeight;
@property (nonatomic,strong)    NSArray *dataSouce;
@property (nonatomic,assign)NSInteger selectIndex;
@end
