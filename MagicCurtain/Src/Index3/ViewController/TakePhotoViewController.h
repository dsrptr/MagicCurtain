//
//  TakePhotoViewController.h
//  MagicCurtain
//
//  Created by macbook pro on 15/11/21.
//  Copyright © 2015年 com.honglangya. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TakePhotoViewController : UIViewController
- (IBAction)nextAction:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *view2;
@property (weak, nonatomic) IBOutlet UIView *view3;
@property (weak, nonatomic) IBOutlet UIImageView *shoopImage;
@property (weak, nonatomic) IBOutlet UIImageView *idCardimage;
@property (weak, nonatomic) IBOutlet UIImageView *shoooimage;
@property (weak, nonatomic) IBOutlet UIImageView *idcardimage;

@end
