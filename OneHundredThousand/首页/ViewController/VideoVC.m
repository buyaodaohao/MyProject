
//
//  VideoVC.m
//  TestVideo
//
//  Created by ZhuKK on 2017/12/21.
//  Copyright © 2017年 ZhuKK. All rights reserved.
//

#import "VideoVC.h"
#import <WebKit/WebKit.h>
#import "VideoAlertView.h"


#define APP_Width [UIScreen mainScreen].bounds.size.width
#define APP_Height [UIScreen mainScreen].bounds.size.height

//#define Open_URL @"http://at520.cn/atjx/jiexi.php?url=http://v.qq.com/cover/6/641dgjmod92qq07.html?vid=j0025ehlgjj&amp"

//#define Open_URL @"http://m.haodou.com/topic-327282.html?id=327282"


@interface VideoVC ()


@property(strong,nonatomic)NSURL * baseURL ;
@property(strong,nonatomic) NSString * htmlCont ;

//@property(strong,nonatomic)UIWebView * webView;
@property(strong,nonatomic)WKWebView * WKWeb;

@end

@implementation VideoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"视频播放";
    
    if ([self.titleStr containsString:@"优酷"] || [self.titleStr containsString:@"土豆"] || [self.titleStr containsString:@"芒果"]|| [self.titleStr containsString:@"乐视"]|| [self.titleStr containsString:@"PPTV"]|| [self.titleStr containsString:@"搜狐"]|| [self.titleStr containsString:@"风行"]|| [self.titleStr containsString:@"华数"]||[self.titleStr containsString:@"1905"]||[self.titleStr containsString:@"凤凰"]) {
        NSDictionary *dictionnary = [[NSDictionary alloc] initWithObjectsAndKeys:@"Mozilla/5.0 (iPhone; CPU iPhone OS 9_3_1 like Mac OS X) AppleWebKit/601.1.46 (KHTML, like Gecko) Mobile/13E238", @"UserAgent", nil];
        [[NSUserDefaults standardUserDefaults] registerDefaults:dictionnary];
    }else{
        NSDictionary *dictionnary = [[NSDictionary alloc] initWithObjectsAndKeys:@"Mozilla/4.0 (compatible; MSIE 7.0; Windows NT 5.1; 360SE)", @"UserAgent", nil];
        [[NSUserDefaults standardUserDefaults] registerDefaults:dictionnary];
//       http://jiexi.92fz.cn/player/vip.php?url=http://v.youku.com/v_show/id_XMzI3NDAwMTg0MA==.html?spm=a2h0j.8191423.vpofficiallistv5_wrap.5~5~5~5!41~A
        
    }

//    NSDictionary *dictionnary = [[NSDictionary alloc] initWithObjectsAndKeys:@"Mozilla/4.0 (compatible; MSIE 7.0; Windows NT 5.1; 360SE)", @"UserAgent", nil];
//    [[NSUserDefaults standardUserDefaults] registerDefaults:dictionnary];
    
   
    
    [self.view addSubview:self.WKWeb];
   
    NSString *path = [[NSBundle mainBundle] bundlePath];
    self.baseURL = [NSURL fileURLWithPath:path];
    NSString * htmlPath = [[NSBundle mainBundle] pathForResource:@"play3"
                                                          ofType:@"html"];
    self.htmlCont = [NSString stringWithContentsOfFile:htmlPath encoding:NSUTF8StringEncoding   error:nil];

    [self changeVideoUrl];
    UIBarButtonItem * item = [[UIBarButtonItem alloc] initWithTitle:@"切换线路" style:UIBarButtonItemStylePlain target:self action:@selector(changeVideoUrl)];
    item.tintColor = [UIColor blackColor];
    self.navigationItem.rightBarButtonItem = item;
    
    UIButton *button = [[UIButton alloc] init];
    [button setImage:[UIImage imageNamed:@"ic_info_arrow_back"] forState:UIControlStateNormal];
    button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [button addTarget:self action:@selector(backVideoWebVC) forControlEvents:UIControlEventTouchUpInside];
    button.bounds = CGRectMake(0, 2, 40, 30);
    button.contentEdgeInsets = UIEdgeInsetsMake(0, -5, 0, 0);
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    
    [self showAlertMessage];
}
-(void)backVideoWebVC{
    
    if ([_delegate respondsToSelector:@selector(VideoVCDelegateSelectBackBotton)]) {
        [_delegate VideoVCDelegateSelectBackBotton];
    }
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)showAlertMessage{
    
    VideoAlertView * videoView = [VideoAlertView nibFromXib];
    videoView.frame = CGRectMake(0, 0, APP_Width, APP_Height);
    [Window addSubview:videoView];
    
}
-(void)changeVideoUrl{
    
    static NSInteger i = 0;
    NSInteger currentUrl = i % (self.videoArrays.count - 1);
    self.urlStr = [NSString stringWithFormat:@"%@%@",self.videoArrays[currentUrl] [@"value1"],self.onlyVideoUrl];
    i ++;
    
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"\"src\",[^>]*" options:NSRegularExpressionAllowCommentsAndWhitespace error:nil];
    NSArray *result = [regex matchesInString:self.htmlCont options:NSMatchingReportCompletion range:NSMakeRange(0, self.htmlCont.length)];
    NSMutableDictionary *urlDicts = [[NSMutableDictionary alloc] init];
    
    for (NSTextCheckingResult *item in result) {
        
        NSString *imgHtml = [self.htmlCont substringWithRange:[item rangeAtIndex:0]];
        
        NSArray *tmpArray = nil;
        if ([imgHtml rangeOfString:@"\"src\",\""].location != NSNotFound) {
            tmpArray = [imgHtml componentsSeparatedByString:@"\"src\",\""];
        } else if ([imgHtml rangeOfString:@"src="].location != NSNotFound) {
            tmpArray = [imgHtml componentsSeparatedByString:@"src="];
        }
        
        if (tmpArray.count >= 2) {
            NSString *src = tmpArray[1];
            
            NSUInteger loc = [src rangeOfString:@"\""].location;
            if (loc != NSNotFound) {
                src = [src substringToIndex:loc];
                
                if (src.length > 0) {
                    //                    NSString *localPath = [docPath stringByAppendingPathComponent:self.loadUrlStr];
                    https://v.qq.com/x/cover/i57sqefkulqgkb5.html?vid=w0025isxyy
                    // 先将链接取个本地名字，且获取完整路径
                    [urlDicts setObject:self.urlStr forKey:src];
                    NSLog(@"正在播放的链接--：%@", self.urlStr);

                }
            }
        }
    }
    
    // 遍历所有的URL，替换成本地的URL，并异步获取图片
    for (NSString *src in urlDicts.allKeys) {
        
        NSString *localPath = [urlDicts objectForKey:src];
        
        self.htmlCont = [self.htmlCont stringByReplacingOccurrencesOfString:src withString:localPath];
    }
    http://api.baiyug.cn/vip/index.php?url=https://v.qq.com/x/cover/i57sqefkulqgkb5.html?vid=w0025isxyy
    
    [self loadHTMLFile];
}
-(void)webViewDidFinishLoad:(UIWebView *)webView{
    
    ////    [webView stringByEvaluatingJavaScriptFromString:@"document.documentElement.getElementsByClassName('adpic')[0].style.display = 'none'"];
            NSString *jsToGetHTMLSource = @"document.getElementsByTagName('html')[0].innerHTML";//获取整个页面的HTMLstring
//     NSString *lJs = @"document.documentElement.innerHTML";//获取当前网页的html
    
    NSString * allHtmlStr  = [webView stringByEvaluatingJavaScriptFromString:jsToGetHTMLSource];
    
        NSLog(@"--allHtmlStr--\n%@",allHtmlStr);
    
}
//Load
-(void)loadHTMLFile{
    
    [self.WKWeb loadHTMLString:self.htmlCont baseURL:self.baseURL];
//    [self.webView loadHTMLString:self.htmlCont baseURL:self.baseURL];
//    https://v.qq.com/x/cover/i57sqefkulqgkb5.html
//    https://v.qq.com/x/cover/i57sqefkulqgkb5.html?vid=w0025isxyy
    
}

//-(UIWebView *)webView{
//
//    if (!_webView) {
//
//        _webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 20, APP_Width, APP_Height)];
//        _webView.delegate = self;
//    }
//    return _webView;
//}
-(WKWebView *)WKWeb{
    if (!_WKWeb) {
        _WKWeb = [[WKWebView alloc]initWithFrame:CGRectMake(0, 0, APP_Width, APP_Height)];
    }
    return _WKWeb;
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
