//
//  CaseInfoModel.h
//  MagicCurtain
//
//  Created by macbook pro on 15/12/6.
//  Copyright © 2015年 com.honglangya. All rights reserved.
//

#import <JSONModel/JSONModel.h>
#import "LessonDetailModel.h"

@interface CaseInfoModelLessonInfo : JSONModel
@property(nonatomic,strong)NSString<Optional> *share_url;
@property(nonatomic,strong)NSString<Optional> *lesson_id;
@property(nonatomic,strong)NSString<Optional> *title;
@property(nonatomic,strong)NSString<Optional> *picture;
@property(nonatomic,strong)NSString<Optional> *intro_html;
@property(nonatomic,strong)NSString<Optional> *vedio_url;
@property(nonatomic,strong)NSArray<LessonMessageInfoModelInfo,Optional> *lesson_message;
@end
@interface CaseInfoModelInfo : JSONModel
@property(nonatomic,strong)CaseInfoModelLessonInfo<Optional> *lesson;

@end
@interface CaseInfoModel : JSONModel
@property(nonatomic,strong)CaseInfoModelInfo<Optional> *info;
@property(nonatomic,assign)NSInteger status;
@property(nonatomic,strong)NSString<Optional> *msg;

@end
