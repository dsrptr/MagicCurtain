//
//  TakePhotoViewController.m
//  MagicCurtain
//
//  Created by macbook pro on 15/11/21.
//  Copyright © 2015年 com.honglangya. All rights reserved.
//

#import "TakePhotoViewController.h"
#import "WaitingViewController.h"
#import "Index3Service.h"
#import "StatusModel.h"
#import <UIImageView+WebCache.h>
@interface TakePhotoViewController ()<UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
{
    NSInteger imageType;
    Index3Service *index3Service;
    LoginModel *user;
}
@end

@implementation TakePhotoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    SharedData *sharedData =[SharedData sharedInstance];
    user=sharedData.user;
   
    index3Service=[Index3Service new];
    
    if (user.store_image==nil||[user.store_image isEqualToString:@""]) {
        UITapGestureRecognizer *takePhoto2=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(takePhotoAction2)];
        [self.view2 addGestureRecognizer:takePhoto2];
        UITapGestureRecognizer *takePhoto3=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(takePhotoAction3)];
        [self.view3 addGestureRecognizer:takePhoto3];
        self.idcardimage.hidden=YES;
        self.shoooimage.hidden=YES;
    }else{
        [self.idcardimage sd_setImageWithURL:[NSURL URLWithString:user.card_image] placeholderImage:nil];
        self.idCardimage.hidden=YES;
        self.shoopImage.hidden=YES;
        [self.shoooimage sd_setImageWithURL:[NSURL URLWithString:user.store_image] placeholderImage:nil];
    }
    self.view2.layer.borderWidth=0.5;
    self.view2.layer.cornerRadius=3;
    self.view2.layer.borderColor=[UIColor grayColor].CGColor;
    self.view3.layer.borderWidth=0.5;
    self.view3.layer.cornerRadius=3;
    self.view3.layer.borderColor=[UIColor grayColor].CGColor;
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden=NO;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)takePhotoAction2{
    UIActionSheet *action = [[UIActionSheet alloc] initWithTitle:@"选取照片" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"拍照" otherButtonTitles:@"相册", nil];
    action.tag=1;
    imageType=1;
    [action showInView:self.view.window];
}

-(void)takePhotoAction3{
    UIActionSheet *action = [[UIActionSheet alloc] initWithTitle:@"选取照片" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"拍照" otherButtonTitles:@"相册", nil];
    action.tag=1;
    imageType=2;
    [action showInView:self.view.window];
}




//相机相关
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    [[UINavigationBar appearance] setBarTintColor:[SharedAction colorWithHexString:@"00B050"]];
//    [[UINavigationBar appearance] setBackgroundColor:[SharedAction colorWithHexString:@"00B050"]];
    if (buttonIndex==0) {
        [self showImagePickerControllerWithSourceType:UIImagePickerControllerSourceTypeCamera];
    }else if(buttonIndex==1){
        [self showImagePickerControllerWithSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
    }
}

#pragma UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    UIImage *image=nil;
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    [[UINavigationBar appearance] setBackgroundColor:[SharedAction colorWithHexString:@"00B050"]];
    if (picker.allowsEditing) {
        image = info[UIImagePickerControllerEditedImage];
    }else{
        image = info[UIImagePickerControllerOriginalImage];
    }
    if (imageType==1) {
        self.shoooimage.image=image;
        self.shoooimage.hidden=NO;
        self.shoopImage.hidden=YES;
    }else{
        self.idcardimage.hidden=NO;
        self.idCardimage.hidden=YES;
        self.idcardimage.image=image;
    }
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [picker dismissViewControllerAnimated:YES completion:nil];
}

-(void)showImagePickerControllerWithSourceType:(UIImagePickerControllerSourceType)sourceType{
   
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.navigationBar.backgroundColor=[SharedAction colorWithHexString:@"00B050"];
    picker.sourceType = sourceType;
    picker.allowsEditing = YES;
    picker.delegate = self;
    [self presentViewController:picker animated:YES completion:nil];
}

- (IBAction)nextAction:(id)sender {
    [index3Service memberAuditWithMid:user.mid andSercet:user.secret andRealName:@"" andCardNo:@"" andCardImage:self.idcardimage.image andStoreName:@"" andStoreImage:self.shoooimage.image withViewController:self withDone:^(StatusModel *model){
        if(model.status==2){
//            user.member_audit=2;
            SharedData *sharedData =[SharedData sharedInstance];
            sharedData.user.member_audit=2;
        }
        UIStoryboard *storyboard =[UIStoryboard storyboardWithName:@"Index3" bundle:nil];
        WaitingViewController *waitingViewController=[storyboard instantiateViewControllerWithIdentifier:@"WaitingViewController"];
        waitingViewController.hidesBottomBarWhenPushed=YES;
        [self.navigationController pushViewController:waitingViewController animated:YES];

    }];    
}
@end
