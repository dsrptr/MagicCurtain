//
//  MLMutiImagesChoosenViewController.m
//  MartinDemos
//
//  Created by Gao Huang on 14-12-20.
//  Copyright (c) 2014年 Martin. All rights reserved.
//

#import "MLMutiImagesChoosenViewController.h"
#import "MLImagesBrowserViewController.h"
#import <UIImageView+AFNetworking.h>
@interface MLMutiImagesChoosenViewController ()
{
    LLLocalImageViewController *localImageCtrl;
}
@end

@implementation MLMutiImagesChoosenViewController

static NSString * const reuseIdentifier = @"ChoosenImageCell2";

-(void)loadView{
    [super loadView];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.fatherController.automaticallyAdjustsScrollViewInsets = NO;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
//    self.collectionView.backgroundColor=[UIColor redColor];
    if (self.chooseImages.count>3) {
        self.view.frame=CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y, self.view.frame.size.width, self.view.frame.size.height*2);
    }
    [self setupCollectionview];
}

-(void)setupCollectionview{
    UICollectionViewFlowLayout *flowlayout = [[UICollectionViewFlowLayout alloc] init];
    float space ;
    if (self.imageMode==getImagesMode) {
        space = 1;
    }else {
        space = 1;
    }
    if (self.isAlumni) {
        if (self.imageUrls.count<=3) {
             flowlayout.itemSize = CGSizeMake(self.collectionviewHeight-space*2, self.collectionviewHeight-space*2);
            
        }else if(self.imageUrls.count<=6) {
             flowlayout.itemSize = CGSizeMake(self.collectionviewHeight/2-space*2, self.collectionviewHeight/2-space*2);
        }else{
            flowlayout.itemSize = CGSizeMake(self.collectionviewHeight/3-space*3, self.collectionviewHeight/3-space*3);
        }
    }else{
        flowlayout.itemSize = CGSizeMake(self.collectionviewHeight-space*2, self.collectionviewHeight-space*2);
    }
   
    flowlayout.sectionInset = UIEdgeInsetsMake(space, space, space, space);
    flowlayout.minimumInteritemSpacing = 1.0f;
    flowlayout.minimumLineSpacing = 1.0f;
    flowlayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.collectionView.collectionViewLayout = flowlayout;
    self.collectionView.showsHorizontalScrollIndicator = NO;
    CGRect frame = self.superView.frame;
    frame.origin.y=0;
    frame.origin.x=0;
    self.collectionView.frame = frame;
    self.chooseImages = [NSMutableArray arrayWithObject:[UIImage imageNamed:@"bg_uploadimage_addimage_takephoto.png"]];
}

#pragma UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex==0) {
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        picker.allowsEditing = YES;
        picker.delegate = self;
        [self.fatherController presentViewController:picker animated:YES completion:nil];
    }else if(buttonIndex==1){
        if (self.type==1) {
             localImageCtrl= [[LLLocalImageViewController alloc] init];
            localImageCtrl.maximumImagesCount=self.maximumImagesCount;
            localImageCtrl.delegate = self;
            [self.delegate pushToTargate:localImageCtrl];
//            [self.navigationController pushViewController:localImageCtrl animated:YES];
        }else{
        ELCImagePickerController *elcPicker = [[ELCImagePickerController alloc] init];
        [[UINavigationBar appearance] setBarTintColor:[SharedAction colorWithHexString:@"29AAE1"]];
        [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
        elcPicker.maximumImagesCount = self.maximumImagesCount;
            //Set the maximum number of images to select to 100
        elcPicker.imagePickerDelegate = self;
        [self.fatherController presentViewController:elcPicker animated:YES completion:nil];
        }
    }
}
- (void)getSelectImage:(NSArray *)imageArr{
    for (int i=0; i<imageArr.count; i++) {
        [self insertImage:imageArr[i] toChooseImages:self.chooseImages withUpdateCollectionView:self.collectionView];
    }
    localImageCtrl.maximumImagesCount=self.maximumImagesCount;
    self.maximumImagesCount=self.maximumImagesCount-imageArr.count;
}

#pragma mark ELCImagePickerControllerDelegate Methods
- (void)elcImagePickerController:(ELCImagePickerController *)picker didFinishPickingMediaWithInfo:(NSArray *)info
{
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    [picker dismissViewControllerAnimated:YES completion:^{
        for (NSDictionary *dict in info) {
            if ([dict objectForKey:UIImagePickerControllerMediaType] == ALAssetTypePhoto){
                if ([dict objectForKey:UIImagePickerControllerOriginalImage]){
                    UIImage* image=[dict objectForKey:UIImagePickerControllerOriginalImage];
                    [self insertImage:image toChooseImages:self.chooseImages withUpdateCollectionView:self.collectionView];
                } else {
                    NSLog(@"UIImagePickerControllerReferenceURL = %@", dict);
                }
            }else {
                NSLog(@"Uknown asset type");
            }
        }
    }];
}

- (void)elcImagePickerControllerDidCancel:(ELCImagePickerController *)picker
{
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    [picker dismissViewControllerAnimated:YES completion:nil];
}

#pragma UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    UIImage *image = nil;
    if (picker.allowsEditing) {
        image = info[UIImagePickerControllerEditedImage];
    }else{
        image = info[UIImagePickerControllerOriginalImage];
    }
    [picker dismissViewControllerAnimated:YES completion:^(void){
        [self insertImage:image toChooseImages:self.chooseImages withUpdateCollectionView:self.collectionView];
    }];
}

#pragma mark <UICollectionViewDataSource>
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (self.imageMode==getImagesMode) {
//        if (self.imageUrls.count>3) {
//            return 3;
//        }
        return self.chooseImages.count;
    }else if(self.imageMode == browseImagesMode){
        if (self.isAlumni) {
            return self.imageUrls.count;
        }
        if (self.imageUrls.count>3) {
            return 3;
        }
        return self.imageUrls.count;
    }
    return 0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ChoosenImageCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    if (self.imageMode==getImagesMode) {
        cell.imgView.image = self.chooseImages[indexPath.row];
    }else if(self.imageMode == browseImagesMode){
        [cell.imgView setImageWithURL:[NSURL URLWithString:self.imageUrls[indexPath.row]]];
    }
    return cell;
}

#pragma mark <UICollectionViewDelegate>
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
   
    if (self.maximumImagesCount<0) {
        NSString *title = [NSString stringWithFormat:NSLocalizedString(@"Only %d photos please!", nil), self.maximumImagesCount];
        NSString *message =[NSString stringWithFormat:@"您一次只能发送%ld张图片",(long)self.maximumImagesCount];
        [[[UIAlertView alloc] initWithTitle:title
                                    message:message
                                   delegate:nil
                          cancelButtonTitle:nil
                          otherButtonTitles:NSLocalizedString(@"Okay", nil), nil] show];
        return;

    }
    if (self.imageMode==getImagesMode) {
        if (indexPath.row==self.chooseImages.count-1) {
            UIActionSheet *action = [[UIActionSheet alloc] initWithTitle:@"选择图片" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"拍照" otherButtonTitles:@"相册", nil];
            [action showInView:self.fatherController.view.window];
        }else{
            if(self.lookType==1){
            // Do any additional setup after loading the view from its nib.
            MLImagesBrowserViewController *target = [[MLImagesBrowserViewController alloc] initWithNibName:@"MLImagesBrowserViewController" bundle:nil];
            target.imageType = UIImageType;
            target.images = [self.chooseImages subarrayWithRange:NSMakeRange(0, self.chooseImages.count-1)];//（必填）
            // target.titles = [NSArray arrayWithObjects:@"1",@"2",@"3", @"4",nil];//设置图片对应的title（可选）
            target.defaultLocationIndex = indexPath.row;//这一步必须放在最后。（可选）
            target.hidesBottomBarWhenPushed=YES;
                [self.delegate pushToTargate:target];
//            [self.navigationController pushViewController:target animated:YES];
                
            }else{
                [self.delegate choseImage:self.chooseImages[indexPath.row]];
            }
        }
        
    }else if(self.imageMode == browseImagesMode){
        MLImagesBrowserViewController *target = [[MLImagesBrowserViewController alloc] initWithNibName:@"MLImagesBrowserViewController" bundle:nil];
        target.imageType = UIImageUrlType;
        target.imgUrls = self.imageUrls;//（必填）
        // target.titles = [NSArray arrayWithObjects:@"1",@"2",@"3", @"4",nil];//设置图片对应的title（可选）
        target.defaultLocationIndex = indexPath.row;//这一步必须放在最后。（可选）
        target.hidesBottomBarWhenPushed=YES;
        [self.delegate pushToTargate:target];
    }
}


-(void)insertImage:(UIImage *)image toChooseImages:(NSMutableArray *)images withUpdateCollectionView:(UICollectionView *)collectionView{
    [images insertObject:image atIndex:self.chooseImages.count-1];
    NSArray *array = [NSArray arrayWithObject:[NSIndexPath indexPathForRow:images.count-2 inSection:0]];
    [self.delegate choseImage:self.chooseImages[0]];
    [collectionView insertItemsAtIndexPaths:array];
    
}
@end
