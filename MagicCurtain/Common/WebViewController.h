//
//  WebViewController.h
//  Club
//
//  Created by MartinLi on 15/7/1.
//  Copyright (c) 2015年 DsrProject. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WebViewController : UIViewController<UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *webview;
@property(nonatomic,copy)NSString *urlString;
@property (nonatomic,assign)NSInteger loadType;
@property (nonatomic,strong)NSString *htmlString;
-(void)loadWebPageWithString:(NSString *)urlString inWebView:(UIWebView *)webview;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *webViewHeight;
@end
