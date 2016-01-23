//
//  LessonTypeInfoModel.h
//  MagicCurtain
//
//  Created by macbook pro on 15/11/28.
//  Copyright © 2015年 com.honglangya. All rights reserved.
//

#import <JSONModel/JSONModel.h>
@protocol LessonTypeInfoModel<NSObject>

@end

@interface LessonTypeInfoModel : JSONModel
@property(nonatomic,strong)NSString<Optional> *lesson_type;
@property(nonatomic,strong)NSString<Optional> *name;
@property(nonatomic,strong)NSString<Optional> *picture;

@end
