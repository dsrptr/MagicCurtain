//
//  ChangeArrayViewController.h
//  MagicCurtain
//
//  Created by macbook pro on 15/12/9.
//  Copyright © 2015年 com.honglangya. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChangeArrayViewController : UIViewController
- (IBAction)chooseAction:(id)sender;
@property (weak, nonatomic) IBOutlet UITextView *myTextView;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UIButton *arreaPlace;
- (IBAction)postAction:(id)sender;

@end
