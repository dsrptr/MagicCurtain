//
//  AuthenticationViewController.h
//  MagicCurtain
//
//  Created by macbook pro on 15/11/21.
//  Copyright © 2015年 com.honglangya. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AuthenticationViewController : UIViewController
- (IBAction)startAuthentication:(id)sender;
- (IBAction)dismissAction:(id)sender;
@property (weak, nonatomic) IBOutlet UIImageView *headImage;
@property (weak, nonatomic) IBOutlet UIButton *status;
@property (weak, nonatomic) IBOutlet UILabel *authenName;
@property (weak, nonatomic) IBOutlet UITextField *realName;
@property (weak, nonatomic) IBOutlet UITextField *idCade;
@property (weak, nonatomic) IBOutlet UITextField *shoopName;
@property (weak, nonatomic) IBOutlet UILabel *realname;
@property (weak, nonatomic) IBOutlet UILabel *idcade;
@property (weak, nonatomic) IBOutlet UILabel *shoopname;
@property (weak, nonatomic) IBOutlet UIButton *authTitle;
@property (weak, nonatomic) IBOutlet UIButton *startAuth;

@end
