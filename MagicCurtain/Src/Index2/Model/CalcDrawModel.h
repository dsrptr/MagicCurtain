//
//  CalcDrawModel.h
//  MagicCurtain
//
//  Created by macbook pro on 15/12/8.
//  Copyright © 2015年 com.honglangya. All rights reserved.
//

#import <JSONModel/JSONModel.h>
@interface CalcDrawModelInfo : JSONModel
@property(nonatomic,strong)NSString<Optional> *draw_url;
@end
@interface CalcDrawModel : JSONModel
@property(nonatomic,strong)CalcDrawModelInfo<Optional> *info;
@property(nonatomic,assign)NSInteger status;
@property(nonatomic,strong)NSString<Optional> *msg;
@end
