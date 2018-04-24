//
//  PersonCenterViewController.m
//  OneHundredThousand
//
//  Created by SY-iMAC-001 on 2018/4/20.
//  Copyright © 2018年 ZhuKK. All rights reserved.
//

#import "PersonCenterViewController.h"
#import "ModuleCollectionViewCell.h"
#import "MySetViewController.h"
@interface PersonCenterViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property(nonatomic,strong)UICollectionView *collectionView;
@property(nonatomic,strong)NSMutableArray *modulesArray;
@end

@implementation PersonCenterViewController
-(NSMutableArray *)modulesArray
{
    if(!_modulesArray)
        {
        _modulesArray = [NSMutableArray arrayWithObjects:@{@"moduleName":@"升级会员",@"moduleIcon":@"crown_314.41860465116px_1159368_easyicon.net"}, @{@"moduleName":@"奖励中心",@"moduleIcon":@"Cup_reward_288.46153846154px_1146873_easyicon.net"},@{@"moduleName":@"我要推广",@"moduleIcon":@"light_bulb_825.1446842526px_1207346_easyicon.net"},@{@"moduleName":@"我的团队",@"moduleIcon":@"People_512px_1138467_easyicon.net"},@{@"moduleName":@"排行榜",@"moduleIcon":@"ranking_950px_1143856_easyicon.net"},@{@"moduleName":@"魔视百科",@"moduleIcon":@"book_447.59131545338px_1208780_easyicon.net"},@{@"moduleName":@"平台手册",@"moduleIcon":@"Note_534px_1191072_easyicon.net"},@{@"moduleName":@"在线客服",@"moduleIcon":@"Team_Speak_350px_1194694_easyicon.net"},@{@"moduleName":@"设置",@"moduleIcon":@"gear_266px_1182634_easyicon.net"},nil];
        
        }
    return _modulesArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBarHidden = YES;
    self.view.backgroundColor = [UIColor colorWithRed:(CGFloat)235 / 255 green:(CGFloat)235 / 255 blue:(CGFloat)235 / 255 alpha:1.0];
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    CGFloat tabBarH = [userDefaults floatForKey:@"TABBAR_H"];
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 0;
    _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - tabBarH) collectionViewLayout:layout];
    self.automaticallyAdjustsScrollViewInsets = NO;
    _collectionView.bounces = YES;
    _collectionView.backgroundColor = [UIColor colorWithRed:(CGFloat)235 / 255 green:(CGFloat)235 / 255 blue:(CGFloat)235 / 255 alpha:1.0];
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    [_collectionView registerClass:[ModuleCollectionViewCell class] forCellWithReuseIdentifier:@"ModuleCollectionViewCell"];
    [self.view addSubview:_collectionView];
    
    UIImageView *topPersonInfoView = [self createTopPersonInfoView];
    
    UIView *middleView = [self createMiddleView];
    
    topPersonInfoView.frame = CGRectMake(0, -(topPersonInfoView.frame.size.height + 10.0 + middleView.frame.size.height), kScreenWidth, topPersonInfoView.frame.size.height);
    middleView.frame =CGRectMake(0, -(middleView.frame.size.height), kScreenWidth, middleView.frame.size.height);
    [_collectionView addSubview:topPersonInfoView];
    [_collectionView addSubview:middleView];
    _collectionView.contentInset = UIEdgeInsetsMake(topPersonInfoView.frame.size.height + middleView.frame.size.height + 10.0, 0, 0, 0);
}
#pragma mark --- 添加上方个人信息视图
-(UIImageView *)createTopPersonInfoView
{
    UIImageView *backView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 172.0)];
    backView.image = [UIImage imageNamed:@"person-info-background-img"];
    CGFloat headD = 224.0 / 3.0;
    UIButton *headBtn = [[UIButton alloc]initWithFrame:CGRectMake(40.0, 40.0, headD, headD)];
    headBtn.layer.cornerRadius = headD / 2.0;
    [headBtn setBackgroundImageForState:UIControlStateNormal withURL:[NSURL URLWithString:@""] placeholderImage:[UIImage imageNamed:@"ic_login_avator_default"]];
    headBtn.layer.masksToBounds = YES;
    [backView addSubview:headBtn];
    
    //名字
    UILabel *nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(headBtn.frame.origin.x + headBtn.frame.size.width + 30.0, headBtn.frame.origin.y + 4.0, kScreenWidth - (headBtn.frame.origin.x + headBtn.frame.size.width + 30.0), 20.0)];
    nameLabel.font = FONT_SIZE_14;
    nameLabel.textColor = [UIColor whiteColor];
    NSString *nameStr = @"我的名字";
    nameLabel.text = nameStr;
    nameLabel.textAlignment = NSTextAlignmentLeft;
    [backView addSubview:nameLabel];
    //推荐码
    UILabel *tuijianLabel = [[UILabel alloc]initWithFrame:CGRectMake(nameLabel.frame.origin.x, nameLabel.frame.origin.y + nameLabel.frame.size.height + 20.0 / 3.0, nameLabel.frame.size.width, 20.0)];
    tuijianLabel.font = FONT_SIZE_12;
    tuijianLabel.textColor = [UIColor whiteColor];
    NSString *tuijianCodeStr = [NSString stringWithFormat:@"推荐码:%@",@"Txxxxxxx"];
    tuijianLabel.text = tuijianCodeStr;
    tuijianLabel.textAlignment = NSTextAlignmentLeft;
    [backView addSubview:tuijianLabel];
    
        //等级
    UILabel *levelLabel = [[UILabel alloc]initWithFrame:CGRectMake(tuijianLabel.frame.origin.x, tuijianLabel.frame.origin.y + tuijianLabel.frame.size.height + 20.0 / 3.0, nameLabel.frame.size.width, 20.0)];
    levelLabel.font = FONT_SIZE_12;
    levelLabel.textColor = [UIColor whiteColor];
    NSString *leavelStr = [NSString stringWithFormat:@"【等级】%@",@"会员"];
    levelLabel.text = leavelStr;
    levelLabel.textAlignment = NSTextAlignmentLeft;
    [backView addSubview:levelLabel];
    return backView;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
//    ￥
}
#pragma mark -- 中间部分  总收益，已结算，可结算
-(UIView *)createMiddleView
{
    CGFloat itemW = kScreenWidth / 3.0;
    CGFloat itemH = (34.0 + 34.0 + 24.0 + 30.0 + 32.0) / 3.0;
    UIView *containerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, itemH + 10.0)];
    containerView.backgroundColor = [UIColor whiteColor];
    
    //总收益
    UIButton *itemBtn1 = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, itemW, itemH)];
    itemBtn1.backgroundColor = [UIColor whiteColor];
    [containerView addSubview:itemBtn1];
    UILabel *subLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 34.0 / 3.0, itemW, 34.0 / 3.0)];
    subLabel.font = [UIFont systemFontOfSize:34.0 / 3.0];
    subLabel.textColor = [UIColor colorWithRed:(CGFloat)51 / 255 green:(CGFloat)51 / 255 blue:(CGFloat)51 / 255 alpha:1.0];
    subLabel.text = @"总收益";
    subLabel.textAlignment = NSTextAlignmentCenter;
    [itemBtn1 addSubview:subLabel];
    UILabel *subMoneyLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, subLabel.frame.origin.y + subLabel.frame.size.height + 24.0 / 3.0, itemW, 30.0 / 3.0)];
    subMoneyLabel.font = [UIFont systemFontOfSize:30.0 / 3.0];
    subMoneyLabel.textColor = [UIColor colorWithRed:(CGFloat)251 / 255 green:(CGFloat)27 / 255 blue:(CGFloat)72 / 255 alpha:1.0];
    subMoneyLabel.textAlignment = NSTextAlignmentCenter;
    NSString *subMoneyStr = [NSString stringWithFormat:@"￥ %.2f",100.00];
    subMoneyLabel.text = subMoneyStr;
    [itemBtn1 addSubview:subMoneyLabel];
    
    
        //已结算
    UIButton *itemBtn2 = [[UIButton alloc]initWithFrame:CGRectMake(itemBtn1.frame.origin.x + itemBtn1.frame.size.width, 0, itemW, itemH)];
    itemBtn2.backgroundColor = [UIColor whiteColor];
    [containerView addSubview:itemBtn2];
    UILabel *yijiesuanLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 34.0 / 3.0, itemW, 34.0 / 3.0)];
    yijiesuanLabel.font = [UIFont systemFontOfSize:34.0 / 3.0];
    yijiesuanLabel.textColor = [UIColor colorWithRed:(CGFloat)51 / 255 green:(CGFloat)51 / 255 blue:(CGFloat)51 / 255 alpha:1.0];
    yijiesuanLabel.text = @"已结算";
    yijiesuanLabel.textAlignment = NSTextAlignmentCenter;
    [itemBtn2 addSubview:yijiesuanLabel];
    UILabel *yijiesuanMoneyLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, yijiesuanLabel.frame.origin.y + yijiesuanLabel.frame.size.height + 24.0 / 3.0, itemW, 30.0 / 3.0)];
    yijiesuanMoneyLabel.font = [UIFont systemFontOfSize:30.0 / 3.0];
    yijiesuanMoneyLabel.textColor = [UIColor colorWithRed:(CGFloat)251 / 255 green:(CGFloat)27 / 255 blue:(CGFloat)72 / 255 alpha:1.0];
    yijiesuanMoneyLabel.textAlignment = NSTextAlignmentCenter;
    NSString *yijiesuanMoneyStr = [NSString stringWithFormat:@"￥ %.2f",100.00];
    yijiesuanMoneyLabel.text = yijiesuanMoneyStr;
    [itemBtn2 addSubview:yijiesuanMoneyLabel];
    
    
        //已结算
    UIButton *itemBtn3 = [[UIButton alloc]initWithFrame:CGRectMake(itemBtn2.frame.origin.x + itemBtn2.frame.size.width, 0, itemW, itemH)];
    itemBtn3.backgroundColor = [UIColor whiteColor];
    [containerView addSubview:itemBtn3];
    UILabel *kejiesuanLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 34.0 / 3.0, itemW, 34.0 / 3.0)];
    kejiesuanLabel.font = [UIFont systemFontOfSize:34.0 / 3.0];
    kejiesuanLabel.textColor = [UIColor colorWithRed:(CGFloat)51 / 255 green:(CGFloat)51 / 255 blue:(CGFloat)51 / 255 alpha:1.0];
    kejiesuanLabel.text = @"可结算";
    kejiesuanLabel.textAlignment = NSTextAlignmentCenter;
    [itemBtn3 addSubview:kejiesuanLabel];
    UILabel *kejiesuanMoneyLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, kejiesuanLabel.frame.origin.y + kejiesuanLabel.frame.size.height + 24.0 / 3.0, itemW, 30.0 / 3.0)];
    kejiesuanMoneyLabel.font = [UIFont systemFontOfSize:30.0 / 3.0];
    kejiesuanMoneyLabel.textColor = [UIColor colorWithRed:(CGFloat)251 / 255 green:(CGFloat)27 / 255 blue:(CGFloat)72 / 255 alpha:1.0];
    kejiesuanMoneyLabel.textAlignment = NSTextAlignmentCenter;
    NSString *kejiesuanMoneyStr = [NSString stringWithFormat:@"￥ %.2f",100.00];
    kejiesuanMoneyLabel.text = kejiesuanMoneyStr;
    [itemBtn3 addSubview:kejiesuanMoneyLabel];
    
    UIView *bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, itemBtn1.frame.origin.y + itemBtn1.frame.size.height, kScreenWidth, 10.0)];
    bottomView.backgroundColor = [UIColor colorWithRed:(CGFloat)235 / 255 green:(CGFloat)235 / 255 blue:(CGFloat)235 / 255 alpha:1.0];
    [containerView addSubview:bottomView];
    return containerView;
}
-(void)clickToShowDetailInfo:(UIButton *)sender
{
    
}


-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    
    return self.modulesArray.count;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(kScreenWidth / 3.0, 360.0 / 3.0);
}





- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ModuleCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ModuleCollectionViewCell" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];
    NSDictionary *moduleDic = self.modulesArray[indexPath.row];
    ModuleInfoModel *model = [[ModuleInfoModel alloc]init];
    model.module_icon = moduleDic[@"moduleIcon"];
    model.module_name = moduleDic[@"moduleName"];
    
    cell.model = model;
    return cell;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    ModuleCollectionViewCell *cell = (ModuleCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    [self openModule:cell.model];
}
-(void)openModule:(ModuleInfoModel *)model
{
    if([model.module_name isEqualToString:@"升级会员"])
        {
        NSLog(@"升级会员");
        }
    else if ([model.module_name isEqualToString:@"奖励中心"])
        {
        NSLog(@"奖励中心");
        }
    else if ([model.module_name isEqualToString:@"我要推广"])
        {
        NSLog(@"我要推广");
        }
    else if ([model.module_name isEqualToString:@"我的团队"])
        {
        NSLog(@"我的团队");
        }
    else if ([model.module_name isEqualToString:@"排行榜"])
        {
        NSLog(@"排行榜");
        }
    else if ([model.module_name isEqualToString:@"魔视百科"])
        {
        NSLog(@"魔视百科");
        }
    else if ([model.module_name isEqualToString:@"平台手册"])
        {
        NSLog(@"平台手册");
        }
    else if ([model.module_name isEqualToString:@"在线客服"])
        {
        NSLog(@"在线客服");
        }
    else//设置
        {
        NSLog(@"设置");
        MySetViewController *mySetVC = [MySetViewController new];
        [self.navigationController pushViewController:mySetVC animated:YES];
        }
}
/**用指定颜色生成指定尺寸的图片*/
-(UIImage *)createImageWithColor:(UIColor *)color size:(CGSize)size
{
    CGRect rect = CGRectMake(0.0f,0.0f,size.width,size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context =UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *myImage =UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return myImage;
}
@end
