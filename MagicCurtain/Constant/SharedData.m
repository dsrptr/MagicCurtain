//
//  SharedData.m
//  MagicCurtain
//
//  Created by macbook pro on 15/11/24.
//  Copyright © 2015年 com.honglangya. All rights reserved.
//

#import "SharedData.h"

@implementation SharedData
+(SharedData *)sharedInstance{
    static SharedData *sharedUser = nil;
    static dispatch_once_t once;
    dispatch_once(&once,^{
        sharedUser = [[SharedData alloc] init];
    });
    return sharedUser;
}

-(void)setStarStatus:(NSString *)starStatus{
    NSUserDefaults  *userDefaults =[NSUserDefaults standardUserDefaults];
    [userDefaults setObject:starStatus forKey:@"starStatus"];
    [userDefaults synchronize];
}

-(NSString *)starStatus{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    return [userDefaults objectForKey:@"starStatus"];
}

-(void)setLoginStatus:(NSString *)loginStatus{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:loginStatus forKey:@"loginStatus"];
    [userDefaults synchronize];
}

-(NSString *)loginStatus{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    return [userDefaults objectForKey:@"loginStatus"];
}

-(void)setLoginname:(NSString *)loginname{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:loginname forKey:@"loginname"];
    [userDefaults synchronize];
}

-(NSString *)loginname{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    return [userDefaults objectForKey:@"loginname"];
}

-(void)setPassword:(NSString *)password{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:password forKey:@"password"];
    [userDefaults synchronize];
}

-(NSString *)password{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    return [userDefaults objectForKey:@"password"];
}
-(void)setChannelId:(NSString *)channelId{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:channelId forKey:@"channelId"];
    [userDefaults synchronize];
}

-(NSString *)channelId{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    return [userDefaults objectForKey:@"channelId"];
}
-(void)setLessonId:(NSString *)lessonId{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:lessonId forKey:@"lessonId"];
    [userDefaults synchronize];
}

-(NSString *)lessonId{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    return [userDefaults objectForKey:@"lessonId"];
}
-(void)setLessonType:(NSString *)lessonType{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:lessonType forKey:@"lessonType"];
    [userDefaults synchronize];
}

-(NSString *)lessonType{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    return [userDefaults objectForKey:@"lessonType"];
}
-(void)setIndexPath:(NSString *)indexPath{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:indexPath forKey:@"indexPath"];
    [userDefaults synchronize];
}

-(NSString *)indexPath{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    return [userDefaults objectForKey:@"indexPath"];
}
-(void)setIndex:(NSString *)index{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:index forKey:@"index"];
    [userDefaults synchronize];
}

-(NSString *)index{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    return [userDefaults objectForKey:@"index"];
}
-(void)setDevice_token:(NSString *)device_token{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:device_token forKey:@"device_token"];
    [userDefaults synchronize];
}


-(NSString *)device_token{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    return [userDefaults objectForKey:@"device_token"];
}

@end
