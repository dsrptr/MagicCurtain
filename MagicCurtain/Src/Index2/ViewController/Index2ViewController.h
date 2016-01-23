//
//  Index2ViewController.h
//  MagicCurtain
//
//  Created by macbook pro on 15/10/27.
//  Copyright © 2015年 com.honglangya. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Index2ViewController : UIViewController
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *btnWidth;
@property (weak, nonatomic) IBOutlet UITableView *inputTableView;
@property (weak, nonatomic) IBOutlet UITableView *printtableView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *inputHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *printHeight;
- (IBAction)calculateAction:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *calculateBtn;
- (IBAction)deleatAction:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *deleatBtn;
- (IBAction)DemonstrationAction:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *demonstrationBtn;


@end
