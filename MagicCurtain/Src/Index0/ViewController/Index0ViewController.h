//
//  ViewController.h
//  MagicCurtain
//
//  Created by macbook pro on 15/10/27.
//  Copyright © 2015年 com.honglangya. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Index0ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITableView *tableView1;
@property (weak, nonatomic) IBOutlet UIView *backView;
- (IBAction)moreAction:(id)sender;
- (IBAction)seachAction:(id)sender;
@property (weak, nonatomic) IBOutlet UITableView *tableView2;
@property (weak, nonatomic) IBOutlet UIView *allCateView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *cateTableHeight;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (assign, nonatomic)NSInteger index;
@property (strong, nonatomic)NSString *lessonType;
@end

