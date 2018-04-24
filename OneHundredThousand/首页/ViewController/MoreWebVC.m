//
//  MoreWebVC.m
//  OneHundredThousand
//
//  Created by ZhuKK on 2017/12/27.
//  Copyright © 2017年 ZhuKK. All rights reserved.
//

#import "MoreWebVC.h"

#import "VideoWebVC.h"


#import "ZKKCustomView.h"

@interface MoreWebVC ()<ZKKCustomViewDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *bgScrollView;
@property(strong,nonatomic)NSMutableArray * urlArrays;
@property(strong,nonatomic)NSMutableArray * titleArrays ;
@end

@implementation MoreWebVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"更多分类";
    CGFloat width = (APP_Width-15*4)/3;
    CGFloat height = 190;
    self.bgScrollView.contentSize = CGSizeMake(APP_Width, (height)*6);
   _titleArrays = [[NSMutableArray alloc]initWithObjects:@"乐视视频",@"腾讯视频",@"爱奇艺",@"优酷视频",@"土豆视频",@"芒果TV",@"搜狐视频",@"Ac弹幕网",@"哔哩哔哩",@"风行网",@"华数视频",@"1905电影",@"PPTV",@"优酷云C",@"糖豆视频",@"音悦台",@"凤凰视频",@"虎牙视频", nil];
//    土豆
    
//    private String[] urls = {"http://vip.le.com/", "http://m.v.qq.com/", "http://vip.iqiyi.com/", "http://vip.youku.com/", "http://www.tudou.com/category", "http://www.mgtv.com/vip/",
//        "https://film.sohu.com/", "http://www.acfun.tv/", "http://www.bilibili.com/", "http://www.fun.tv/", "http://www.wasu.cn/", "http://www.1905.com/",
//        "http://www.pptv.com/", "http://vip.youku.com/", "http://tv.tangdou.com/", "http://www.yinyuetai.com/", "http://v.ifeng.com/", "http://v.huya.com/"
//    };
    
    _urlArrays = [[NSMutableArray   alloc]initWithObjects:@"http://www.le.com/",@"https://v.qq.com/",@"http://www.iqiyi.com",@"http://www.youku.com/",@"http://www.tudou.com/category",@"http://www.mgtv.com/vip/",@"https://tv.sohu.com/",@"http://www.acfun.cn/",@"https://www.bilibili.com/",@"http://www.fun.tv/",@"https://www.wasu.cn/",@"http://www.1905.com/",@"http://www.pptv.com/",@"http://vip.youku.com/",@"http://www.tangdou.com/",@"http://www.yinyuetai.com/",@"http://v.ifeng.com/",@"http://ahuya.duowan.com/", nil];
    NSMutableArray * imageArrays = [[NSMutableArray alloc]initWithObjects:@"ic_letv",@"ic_tencent",@"ic_aqy",@"ic_youku",@"tudoulogo",@"hunantvlogo",@"sohulogo",@"acfun",@"bilibili.jpg",@"fengxing.gif",@"wasulogo",@"oneninezerofivelogo",@"pptv",@"ykcloud",@"tangdoulogo",@"yinyuetailogo",@"ifenglogo",@"huya", nil];
    
    for (int i = 0; i<_titleArrays.count; i++) {
        ZKKCustomView *customView = [ZKKCustomView nibFromXib];
        customView.frame = CGRectMake(15+i%3*(width+15),25+(i/3)*(height), width, height);
        customView.titleLabel.text = _titleArrays[i];
        customView.imageV.image = [UIImage imageNamed:imageArrays[i]];
        customView.delegate = self;
        [self.bgScrollView addSubview:customView];
    }
}
-(void)ZKKCustomViewDelegateSelectWithButtonText:(NSString *)text{
    
    NSString * days = User_Default_ObjectForKey(@"vipLeft");
    if ([days floatValue] <= 0) {
        Show_Toast(@"请充值VIP", 0.8)
        return;
    }
    VideoWebVC * vc = [[VideoWebVC alloc]init];
    NSInteger index = [self.titleArrays indexOfObject:text];
    vc.urlStr = self.urlArrays[index];
    vc.titleStr = text;
    [self.navigationController pushViewController:vc animated:YES];
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
