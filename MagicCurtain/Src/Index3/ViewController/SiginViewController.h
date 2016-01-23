//
//  SiginViewController.h
//  MagicCurtain
//
//  Created by macbook pro on 15/12/9.
//  Copyright © 2015年 com.honglangya. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SiginViewController : UIViewController
- (IBAction)postAction:(id)sender;
@property (assign, nonatomic)NSInteger changeType;
@property (strong, nonatomic)NSString *detailString;
@property (weak, nonatomic) IBOutlet UITextField *singDetail;
@end
