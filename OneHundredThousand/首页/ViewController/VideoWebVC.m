
//
//  VideoWebVC.m
//  OneHundredThousand
//
//  Created by ZhuKK on 2017/12/29.
//  Copyright © 2017年 ZhuKK. All rights reserved.
//

#import "VideoWebVC.h"
#import "MBProgressHUD.h"
#import "VideoAlertView.h"
#import "VideoVC.h"

#import "WYWebProgressLayer.h"
#import "WLWebProgressLayer.h"

@interface VideoWebVC ()<UIWebViewDelegate,VideoVCDelegate>

@property (weak, nonatomic) IBOutlet UIWebView *webV;

@property(strong,nonatomic)NSString * videoUrlStr;
@property(strong,nonatomic)NSMutableArray * resultArrays;
@property(strong,nonatomic)NSString * currentUrl;
@property(nonatomic,strong)NSString *tempUrl;

@property(nonatomic,strong)VideoVC * tengXunVideoVc;
@property(strong,nonatomic)WYWebProgressLayer * progressLayer; ///< 网页加载进度条
@property(assign,nonatomic)BOOL  isBack;

@property (weak, nonatomic) IBOutlet UIButton *videoBt;

@end

@implementation VideoWebVC

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    self.tempUrl = @"";
    self.isBack = NO;
    self.videoBt.hidden = NO;
    
}
-(WYWebProgressLayer *)progressLayer{
    if (!_progressLayer) {
        _progressLayer = [WYWebProgressLayer layerWithFrame:CGRectMake(0, 0, APP_Width, 2)];
        [self.view.layer addSublayer:_progressLayer];
    }
    return _progressLayer;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = self.titleStr;
    self.resultArrays = [[NSMutableArray alloc]init];
    
    [self.titleStr containsString:@"芒果"];
    
    [self systemUA];
    
    if ([self.titleStr containsString:@"优酷"] || [self.titleStr containsString:@"芒果"] || [self.titleStr containsString:@"土豆"]) {
        [self PCUA];
    }else{
        [self systemUA];
    }
    NSURLRequest * request = [NSURLRequest requestWithURL:[NSURL URLWithString:self.urlStr]];
    [self.webV loadRequest:request];
    
    if ([self.titleStr isEqualToString:@"优酷视频"]) {
        self.videoUrlStr = @"http://39.108.151.95:8000/MyApp/user/getDicByGroup/15";
    }else if ([self.titleStr isEqualToString:@"爱奇艺"]) {
        self.videoUrlStr = @"http://39.108.151.95:8000/MyApp/user/getDicByGroup/16";
    }else if ([self.titleStr isEqualToString:@"腾讯视频"]) {
        self.videoUrlStr = @"http://39.108.151.95:8000/MyApp/user/getDicByGroup/17";
    }else if ([self.titleStr isEqualToString:@"芒果视频"]) {
        self.videoUrlStr = @"http://39.108.151.95:8000/MyApp/user/getDicByGroup/18";
    }else if ([self.titleStr isEqualToString:@"乐视视频"]) {
        self.videoUrlStr = @"http://39.108.151.95:8000/MyApp/user/getDicByGroup/19";
    }else{
        self.videoUrlStr = @"http://39.108.151.95:8000/MyApp/user/getDicByGroup/22";
    }
    
    [ServiceTool getBaseWithUrl:self.videoUrlStr Params:nil ShowHUD:NO success:^(id results) {
        self.resultArrays = results;
        NSLog(@"self.resultArrays----%@",self.resultArrays);
    } fail:^(NSError *error) {
        
    }];
    
    UIButton *button = [[UIButton alloc] init];
    [button setImage:[UIImage imageNamed:@"ic_info_arrow_back"] forState:UIControlStateNormal];
    button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [button addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    button.bounds = CGRectMake(0, 2, 40, 30);
    button.contentEdgeInsets = UIEdgeInsetsMake(0, -5, 0, 0);
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    [self showAlertMessage];

}
#pragma mark - UIWebViewDelegate
- (void)webViewDidStartLoad:(UIWebView *)webView {
    
    self.videoBt.hidden = YES;
    
    self.progressLayer.hidden = NO;
    [self.progressLayer startLoad];

}
- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [_progressLayer finishedLoad];
    self.videoBt.hidden = NO;

//    self.title = [webView stringByEvaluatingJavaScriptFromString:@"document.title"];
    
    if (self.tempUrl.length > 0 || self.isBack) {
//        if (![webView.request.URL.absoluteString containsString:self.currentUrl]) {
        if (![webView isEqual:self.webV]) {
           
            if (webView.isLoading) {
                return;
            }
            if (![webView.request.URL.absoluteString containsString:self.currentUrl]) {
                
                self.currentUrl = webView.request.URL.absoluteString;

                NSLog(@"---------222222self.currentUrl-------%@---",webView.request.URL.absoluteString);
                
                if ([self.titleStr containsString:@"腾讯"]) {
                    self.currentUrl = [self.currentUrl componentsSeparatedByString:@"?"][0];
                }
                _tengXunVideoVc = [[VideoVC alloc]init];
                self.tengXunVideoVc.titleStr = self.titleStr;
                self.tengXunVideoVc.delegate = self;
                self.tengXunVideoVc.videoArrays = self.resultArrays;
                self.tengXunVideoVc.onlyVideoUrl = self.currentUrl;
                [self.navigationController pushViewController:self.tengXunVideoVc animated:YES];
            }
           
        }
        
        
//    }
    }else{
        self.currentUrl = webView.request.URL.absoluteString;
//        if ([self.titleStr containsString:@"腾讯"]) {
//            self.tempUrl = self.currentUrl ;
//        }
    }
}
-(void)VideoVCDelegateSelectBackBotton{
    self.isBack = YES;
    self.currentUrl = @"返回";
    [self back];
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    [_progressLayer finishedLoad];
}
- (IBAction)actionBtClick:(id)sender {
    self.videoBt.hidden = YES;

    if (self.resultArrays.count >0) {
        if ([self.titleStr containsString:@"腾讯"]) {
            self.tempUrl = self.currentUrl;
            [self PCUA];
            UIWebView * webView = [[UIWebView alloc]init];
            webView.delegate = self;
            NSURLRequest * request = [NSURLRequest requestWithURL:[NSURL URLWithString:self.currentUrl]];
            [webView loadRequest:request];
            [self.view addSubview:webView];
        }else{
            VideoVC * vc = [[VideoVC alloc]init];
            vc.videoArrays = self.resultArrays;
            vc.onlyVideoUrl = self.currentUrl;
            vc.titleStr = self.titleStr;
            [self.navigationController pushViewController:vc animated:YES];
        }
    }else{
        Show_Toast(@"请重新请求VIP视频解析网页", 0.8)
    }
    
}
-(void)PCUA{
    NSDictionary *dictionnary = [[NSDictionary alloc] initWithObjectsAndKeys:@"Mozilla/4.0 (compatible; MSIE 7.0; Windows NT 5.1; 360SE)", @"UserAgent", nil];
    [[NSUserDefaults standardUserDefaults] registerDefaults:dictionnary];
}
-(void)systemUA{
    
    NSDictionary *dictionnary = [[NSDictionary alloc] initWithObjectsAndKeys:@"Mozilla/5.0 (iPhone; CPU iPhone OS 9_3_1 like Mac OS X) AppleWebKit/601.1.46 (KHTML, like Gecko) Mobile/13E238", @"UserAgent", nil];
    [[NSUserDefaults standardUserDefaults] registerDefaults:dictionnary];
}
-(void)back{
    
    if (self.webV.canGoBack) {
        [self.webV goBack];
    }else{
        [self.navigationController popViewControllerAnimated:YES];
    }
}
-(void)showAlertMessage{
    
    VideoAlertView * videoView = [VideoAlertView nibFromXib];
    videoView.frame = CGRectMake(0, 0, APP_Width, APP_Height);
    videoView.contentLabel.text = @"如果遇到播放需要Flash，或者浏览器版本过低，请忽略，进入想看的视频播放页，点击迈思影视APP的播放按钮，点击右上角切换链接找到合适的播放链接！！";
    [Window addSubview:videoView];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
