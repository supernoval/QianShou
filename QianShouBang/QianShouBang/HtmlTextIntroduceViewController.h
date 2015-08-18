//
//  HtmlTextIntroduceViewController.h
//  QianShouBang
//
//  Created by ucan on 15/8/18.
//  Copyright (c) 2015年 zhuhaikun. All rights reserved.
//

#import "BaseViewController.h"

@interface HtmlTextIntroduceViewController : BaseViewController<UIWebViewDelegate>
{
    UIWebView *myWebView;
    NSString *htmlName;
    UILabel *titleFontLabel;
    NSString *title;
    
}
@property(retain,nonatomic)UILabel *titleFontLabel;
@property(retain,nonatomic)NSString *htmlName;
@property(copy,nonatomic)NSString *title;


@end
