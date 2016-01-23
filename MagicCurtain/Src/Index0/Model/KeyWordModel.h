//
//  KeyWordModel.h
//  MagicCurtain
//
//  Created by macbook pro on 15/11/27.
//  Copyright © 2015年 com.honglangya. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface KeyWordModelInfo : JSONModel
@property(nonatomic,strong)NSArray<Optional>*keyword;
@end
@interface KeyWordModel : JSONModel
@property(nonatomic,strong)KeyWordModelInfo<Optional> *info;
@property(nonatomic,assign)NSInteger status;
@property(nonatomic,strong)NSString<Optional> *msg;
@end
