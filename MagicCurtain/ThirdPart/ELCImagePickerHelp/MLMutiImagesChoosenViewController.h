//
//  MLMutiImagesChoosenViewController.h
//  MartinDemos
//
//  Created by Gao Huang on 14-12-20.
//  Copyright (c) 2014年 Martin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ChoosenImageCell.h"
#import <ELCImagePickerController.h>
#import <MobileCoreServices/UTCoreTypes.h>
#import <AssetsLibrary/ALAsset.h>
#import "LLLocalImageViewController.h"
enum ImagesMode{
    getImagesMode,
    browseImagesMode
};
@protocol MLMutiImagesChoosenViewControllerDelegate<NSObject>
-(void)choseImage:(UIImage *)image;
-(void)pushToTargate:(UIViewController *)targate;
@end
@interface MLMutiImagesChoosenViewController : UICollectionViewController<UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UICollectionViewDataSource,UICollectionViewDelegate,ELCImagePickerControllerDelegate,LLLocalImageViewControllerDelegate>
@property(nonatomic,strong)NSMutableArray *chooseImages;
@property(nonatomic,weak)id<MLMutiImagesChoosenViewControllerDelegate>delegate;
@property(nonatomic,strong)UIViewController *fatherController;
@property(nonatomic,strong)UIView *superView;
@property(nonatomic,assign)float collectionviewHeight;
@property (nonatomic,assign) NSInteger maximumImagesCount;
@property(nonatomic)enum ImagesMode imageMode;//必选
@property(nonatomic,strong)NSArray *imageUrls;
@property(nonatomic,assign)NSInteger type;//获取相册的方法 0ECLPick 1LLLocalImageViewController
@property(nonatomic,assign)NSInteger lookType;//0点击在上面显示 1点击放大查看
@property(nonatomic,assign)BOOL isAlumni;
@end

