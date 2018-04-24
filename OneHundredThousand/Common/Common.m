

#import "Common.h"
#import "SDImageCache.h"

#import "MBProgressHUD.h"
#import "BaseService.h"


@implementation Common

#pragma mark - 富文本部分字体飘灰
+ (NSAttributedString *)fuWenBenWithStr:(NSString *)str HeightColor:(UIColor *)heightColor HeightText:(NSString *)heightText{
    
    NSRange hightlightTextRange = [str rangeOfString:heightText];
    NSMutableAttributedString *attributedStrs = [[NSMutableAttributedString alloc]initWithString:str];
    [attributedStrs beginEditing];
    //高亮颜色
    [attributedStrs addAttribute:NSForegroundColorAttributeName
                           value:heightColor
                           range:hightlightTextRange];
    return  attributedStrs;
  
}
+ (void)shareTextToPlatformWithShareType:(UMSocialPlatformType)platformType  ShareImage:(id)image ShareUrl:(NSString *)shareUrl ShareTitle:(NSString *)title ShareContent:(NSString *)content{

    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    
    UIImage *shareImage;
    if ([image isKindOfClass:[UIImage class]]) {
        shareImage = image;
    }else if([image isKindOfClass:[NSString class]]){
        NSData *imageData =[NSData dataWithContentsOfURL:[NSURL URLWithString:image]];
        shareImage = [UIImage imageWithData:imageData];
    }else{
        shareImage = [UIImage imageNamed:@"ic_launcher1.png"];
    }
    //创建网页内容对象
    UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:title descr:content thumImage:shareImage];
    //设置网页地址
    shareObject.webpageUrl = shareUrl;
    //分享消息对象设置分享 内容对象
    messageObject.shareObject = shareObject;
    //调用分享接口
    [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:nil completion:^(id data, NSError *error) {
        
        if (error) {
            Show_Toast(@"分享失败", 1.0)
        }else{
            Show_Toast(@"分享成功", 1.0)
        }
    }];
    
}
+ (void)alertWithTitle:(NSString *)title Message:(NSString *)message ShowVC:(UIViewController *)vc{
    
    UIAlertController * xiangCeAlertC = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction * sheZhi = [UIAlertAction actionWithTitle:@"去设置" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
    }];
    [xiangCeAlertC addAction:sheZhi];
    [vc presentViewController:xiangCeAlertC animated:YES completion:nil];
    
}
#pragma make--检测银行卡号
+(BOOL)checkCardNo:(NSString*)cardNo{
    int oddsum = 0;     //奇数求和
    int evensum = 0;    //偶数求和
    int allsum = 0;
    int cardNoLength = (int)[cardNo length];
    int lastNum = [[cardNo substringFromIndex:cardNoLength-1] intValue];
    
    cardNo = [cardNo substringToIndex:cardNoLength - 1];
    for (int i = cardNoLength -1 ; i>=1;i--) {
        NSString *tmpString = [cardNo substringWithRange:NSMakeRange(i-1, 1)];
        int tmpVal = [tmpString intValue];
        if (cardNoLength % 2 ==1 ) {
            if((i % 2) == 0){
                tmpVal *= 2;
                if(tmpVal>=10)
                    tmpVal -= 9;
                evensum += tmpVal;
            }else{
                oddsum += tmpVal;
            }
        }else{
            if((i % 2) == 1){
                tmpVal *= 2;
                if(tmpVal>=10)
                    tmpVal -= 9;
                evensum += tmpVal;
            }else{
                oddsum += tmpVal;
            }
        }
    }
    
    allsum = oddsum + evensum;
    allsum += lastNum;
    if((allsum % 10) == 0)
        return YES;
    else
        return NO;
}
#pragma mark - 获取path路径下文件夹大小
+ (NSString *)getCacheSize{
    
    NSUInteger  curerentSzie = [[SDImageCache sharedImageCache] getSize]/1000;
    return [NSString stringWithFormat:@"%.1fkb",(float)curerentSzie];
}

+ (void)setStatusBarBackgroundColor:(UIColor *)color {
    
    UIView *statusBar = [[[UIApplication sharedApplication] valueForKey:@"statusBarWindow"] valueForKey:@"statusBar"];
    
    if ([statusBar respondsToSelector:@selector(setBackgroundColor:)]) {
        statusBar.backgroundColor = color;
    }
}

+(NSString *)timestampSwitchTime:(NSString *)timestamp Format:(NSString *)format{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:format]; // （@"YYYY-MM-dd hh:mm:ss"）
    NSTimeZone *timeZone = [NSTimeZone timeZoneWithName:@"Asia/Beijing"];
    [formatter setTimeZone:timeZone];
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:[timestamp integerValue]];
    NSString *confromTimespStr = [formatter stringFromDate:confromTimesp];

    return confromTimespStr;
    
}
//+(NSAttributedString *)contentWithCerStyleStr:(NSString *)str FirstToRange:(NSInteger)firstToRange TwoToRange:(NSInteger)twoToRange{
//    
//    NSMutableAttributedString *attributedStrs = [[NSMutableAttributedString alloc]initWithString:str];
//    [attributedStrs beginEditing];
//    // 前面字体大小 //按照范围切割字符串，包括 fromRange和toRange
//    [attributedStrs addAttribute:NSFontAttributeName
//                           value:[UIFont systemFontOfSize:12.f]
//                           range:NSMakeRange(0, str.length-1)];
//    
//    //前面
//    [attributedStrs addAttribute:NSForegroundColorAttributeName
//                           value:Block_Text_COLOR
//                           range:NSMakeRange(0, firstToRange+1)];
//    //中间
//    [attributedStrs addAttribute:NSForegroundColorAttributeName
//                           value:Other_COLOR
//                           range:NSMakeRange(firstToRange+1, twoToRange-firstToRange+1)];
//    //后面
//    [attributedStrs addAttribute:NSForegroundColorAttributeName
//                           value:Block_Text_COLOR
//                           range:NSMakeRange(twoToRange+1, str.length-twoToRange-1)];
//    return  attributedStrs;
//    
//}

+(BOOL)checkNetWork{
    
    BaseService * service = [BaseService sharedWGNetworking];
    if (service.networkStats == -1 || service.networkStats == 0) {
        Show_Toast(@"请检查网络", 0.5)
        return NO;
    }
    return YES;
}
#pragma mark--展示提示框
+ (UIAlertController *)showAlertControllerTitle:(NSString *)title Message:(NSString *)message OneAlertActionTitle:(NSString *)actionTitle{
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:actionTitle style:UIAlertActionStyleDefault handler:nil];
    [alertController addAction:okAction];
    
    return alertController;
    
}

#pragma mark--判断手机号的真假
+ (BOOL)phonePredicateWithNumberStr:(NSString *)str{

    NSString * mobile = @"^1[3|4|5|7|8][0-9]\\d{8}$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", mobile];
    return [pred evaluateWithObject:str];

    
}
#pragma mark--判断字符串是否为空 YES:为空

+ (BOOL)isNullString:(NSString *)str {
    
    NSString * string =[str stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    if (string.length == 0) {
        return YES;
    }
    return NO;
}
#pragma mark--判断字符串中只有数字／字母／汉字的谓词
+ (BOOL)isNumberOrLetterOrChineseString:(NSString *)str{
    
    NSString *regex = @"[a-zA-Z0-9-_\u4e00-\u9fa5]+";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
//    ^[\u4e00-\u9fa5]{0,}$
    return [pred evaluateWithObject:str];
    
}

#pragma mark -根据字符串返回字符串的宽度
+(CGFloat)getWidthWithText:(NSString *)text Font:(CGFloat)font{
    
    NSDictionary *attrDic = @{NSFontAttributeName: [UIFont systemFontOfSize:font], NSForegroundColorAttributeName:[UIColor blackColor]};
    
    CGRect textRect = [text boundingRectWithSize:CGSizeMake(MAXFLOAT, 25) options:NSStringDrawingTruncatesLastVisibleLine|NSStringDrawingUsesFontLeading|NSStringDrawingUsesLineFragmentOrigin  attributes:attrDic context:nil];
    return textRect.size.width;
    
}
#pragma mark -根据字符串返回字符串的高度
+(CGFloat)getHeightText:(NSString *)text WithWidth:(CGFloat)width  Font:(CGFloat)font{
    
    NSDictionary *attrDic = @{NSFontAttributeName: [UIFont systemFontOfSize:font], NSForegroundColorAttributeName:[UIColor blackColor]};
    
    CGRect textRect = [text boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options:NSStringDrawingTruncatesLastVisibleLine|NSStringDrawingUsesFontLeading|NSStringDrawingUsesLineFragmentOrigin  attributes:attrDic context:nil];
    
    return textRect.size.height;
}
#pragma mark--计算字符串的长度
+(NSInteger)stringWithContent:(NSString *)content
{
    NSInteger i,n=[content length],l=0,a=0,b=0;
    unichar c;
    for(i=0;i<n;i++){
        c=[content characterAtIndex:i];
        if(isblank(c)){
            b++;
        }else if(isascii(c)){
            a++;
        }else{
            l++;
        }
    }
    if(a==0 && l==0) return 0;
    return l+(int)ceilf((float)(a+b));
    
}
#pragma mark--正则表达式：限定6-18位 返回YES条件符合，NO条件不符合
+(BOOL)passwordStyleWithString:(NSString *)password{

    NSString *realnameFilter = @"^.{6,18}$";
    
    NSPredicate *fliter = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",realnameFilter];
    
    return [fliter evaluateWithObject:password];
    
}
#pragma mark--正则表达式：验证邮箱的正确与否
+(BOOL)isEmail:(NSString *)email{
    
   email = [email stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}
#pragma mark--YES 是身份证 NO 不是
+(BOOL)isUserIdCardString:(NSString *)idCard{
    
    idCard = [idCard stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    if (idCard.length == 15) {
                           //|  地址  |   年    |   月    |   日    |
        NSString *regex = @"^(\\d{6})([3-9][0-9][01][0-9][0-3])(\\d{4})$";
        NSPredicate *identityCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
        return [identityCardPredicate evaluateWithObject:idCard];
    } else if (idCard.length == 18) {
                           //|  地址  |      年       |   月    |   日    |
        NSString *regex = @"^(\\d{6})([1][9][3-9][0-9][01][0-9][0-3])(\\d{4})(\\d|[X])$";
        NSPredicate *identityCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
        return [identityCardPredicate evaluateWithObject:idCard];
    } else {
        
        return NO;
    }
    
}

#pragma mark--文件的路径--Documnets文件夹下
+(NSString *)getFilePath:(NSString *)fileName
{
    //    获得Documnets路径
    NSArray *pathArray =  NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    NSString *documentsPath = [pathArray objectAtIndex:0];
        
    NSString *newFilePath = [documentsPath stringByAppendingPathComponent:fileName];
    
    return newFilePath;
}
#pragma mark--删除线
+(void)deleteLineLabel:(UILabel *)label{
    
    //增加删除线
    NSUInteger length = [label.text length];
    NSMutableAttributedString *attri = [[NSMutableAttributedString alloc] initWithString:label.text];
    [attri addAttribute:NSStrikethroughStyleAttributeName value:@(NSUnderlinePatternSolid | NSUnderlineStyleSingle) range:NSMakeRange(0, length)];
    [attri addAttribute:NSStrikethroughColorAttributeName value:[UIColor redColor] range:NSMakeRange(0, length)];
    [label setAttributedText:attri];
}
#pragma mark--获得北京时间的时间戳——截止到秒
+ (NSString *)getNowTime{
    
    NSDate * date =[NSDate date];
    NSString *dateStr = [NSString stringWithFormat:@"%ld", (long)[date timeIntervalSince1970]];    
    return dateStr; // 这个时间是北京时间戳
}
#pragma mark-- 获得当前小时的时间
+(NSString *)getNowHour{
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
//    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    [dateFormatter setDateFormat:@"HH"];
    NSString *currentHourStr = [dateFormatter stringFromDate:[NSDate date]];
    return currentHourStr;
}
#pragma mark-- 获得当前 月 的时间
+(NSString *)getNowMonth{
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    [dateFormatter setDateFormat:@"MM"];
    NSString *currentHourStr = [dateFormatter stringFromDate:[NSDate date]];
    return currentHourStr;
}
#pragma mark-- 获得当前 年 的时间
+(NSString *)getNowYear{
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    [dateFormatter setDateFormat:@"yyyy"];
    NSString *currentHourStr = [dateFormatter stringFromDate:[NSDate date]];
    return currentHourStr;
    
}
#pragma mark--根据某个模式 分割字符串
+(NSArray *)componentStr:(NSString *)str ContentStr:(NSString *)contentStr{
    
    return [contentStr componentsSeparatedByString:str];
}
#pragma mark--如果字符串为空，用 @“” 代替
+(NSString *)contentStr:(NSString *)str{
    
    if (str.length == 0) {
        
        return @"";
    }

    return str;
}
#pragma mark--富文本编辑
+(NSAttributedString *)contentStr:(NSString *)str FirstToRange:(NSInteger)firstToRange{
    
    NSMutableAttributedString *attributedStrs = [[NSMutableAttributedString alloc]initWithString:str];
    [attributedStrs beginEditing];
    // 前面字体大小 //按照范围切割字符串，包括 fromRange和toRange
    [attributedStrs addAttribute:NSFontAttributeName
                           value:[UIFont systemFontOfSize:15.0]
                           range:NSMakeRange(0, firstToRange+1)];
    //前面字体颜色
    [attributedStrs addAttribute:NSForegroundColorAttributeName
                           value:[UIColor blackColor]
                           range:NSMakeRange(0, firstToRange+1)];
    // 后面字体大小
    [attributedStrs addAttribute:NSFontAttributeName
                           value:[UIFont systemFontOfSize:13.0]
                           range:NSMakeRange(firstToRange+1, str.length-firstToRange-1)];
    //后面字体颜色
    [attributedStrs addAttribute:NSForegroundColorAttributeName
                           value:RGB_Alpha(85, 85, 85, 1)
                           range:NSMakeRange(firstToRange+1, str.length-firstToRange-1)];
    
    return  attributedStrs;
    
}
//+(NSAttributedString *)contentWithCerStyleStr:(NSString *)str FirstToRange:(NSInteger)firstToRange FirstFont:(CGFloat)firstFont OtherFont:(CGFloat)otherFont OtherColor:(UIColor *)color{
//
//    NSMutableAttributedString *attributedStrs = [[NSMutableAttributedString alloc]initWithString:str];
//    [attributedStrs beginEditing];
//    // 前面字体大小 //按照范围切割字符串，包括 fromRange和toRange
//    [attributedStrs addAttribute:NSFontAttributeName
//                           value:[UIFont systemFontOfSize:firstFont]
//                           range:NSMakeRange(0, firstToRange+1)];
//    //前面字体颜色
//    [attributedStrs addAttribute:NSForegroundColorAttributeName
//                           value:[UIColor blackColor]
//                           range:NSMakeRange(0, firstToRange+1)];
//    // 后面字体大小
//    [attributedStrs addAttribute:NSFontAttributeName
//                           value:[UIFont systemFontOfSize:otherFont]
//                           range:NSMakeRange(firstToRange+1, str.length-firstToRange-1)];
//    //后面字体颜色
//    [attributedStrs addAttribute:NSForegroundColorAttributeName
//                           value:color
//                           range:NSMakeRange(firstToRange+1, str.length-firstToRange-1)];
//
//    return  attributedStrs;
//
//}

//- (BOOL)shareTextToPlatformWithType:(UMSocialPlatformType)platformType ShareImage:(UIImage *)image{
//    
//    //创建分享消息对象
//    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
//    
//    //创建网页内容对象
//    UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:@"【证照大师】" descr:@"我在证照大师APP拍摄了一张好看的证件照哦，你也来试试吧。" thumImage:image];
//    
//    //设置网页地址
//    NSString * shareUrlStr = User_Default_ObjectForKey(@"shareUrl");
//    
//    if ([Common isNullString:shareUrlStr]) {
//        shareUrlStr = Share_URL;
//    }
//    shareObject.webpageUrl = shareUrlStr;
//    //分享消息对象设置分享 内容对象
//    messageObject.shareObject = shareObject;
//    __block BOOL isShare = YES;
//    //调用分享接口
//    [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:nil completion:^(id data, NSError *error) {
//        
//        if (error) {
//            Show_One_Button(@"分享失败",0.8)
//            isShare = NO;
//        }else{
//            Show_One_Button(@"分享成功",0.5)
//            
//        }
//    }];
//    
//    return isShare;
//}
#pragma mark--用户登陆的提示框
+(void)loginUserWithShowViewController:(UIViewController *)VC Result:(resultBlock)result{
    
    UIAlertController * alertC = [UIAlertController  alertControllerWithTitle:@"温馨提示" message:@"请您登陆账号" preferredStyle:UIAlertControllerStyleAlert];

    UIAlertAction * sureAlert = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
      
        if (result) {
            result();
        }
    }];
    UIAlertAction * cancelAlert = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [alertC addAction:sureAlert];
    [alertC addAction:cancelAlert];
    [VC presentViewController:alertC animated:YES completion:nil];
    
}
//#pragma mark-- 分享APP
//-(void)shareAPPWithViewController:(UIViewController *)viewController{
//    
//    UIImage* image = [UIImage imageNamed:@"Lo_aboutAPPLogo_n"];
//    BOOL shareQQ = [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"mqq://"]];
//    BOOL shareWx = [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"weixin://"]];
//    
//    if (!shareQQ && !shareWx) {
//        Show_Toast(@"请安装微信或者QQ", 0.5)
//        return ;
//    }
//    
//    UIAlertController * alertC = [UIAlertController  alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleAlert];
//    
//    UIAlertAction * QQKongJianAlert = [UIAlertAction actionWithTitle:@"分享到QQ空间" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//        [self shareTextToPlatformWithType:UMSocialPlatformType_Qzone ShareImage:image];
//    }];
//    UIAlertAction * QQHaoYouAlert = [UIAlertAction actionWithTitle:@"分享到QQ好友" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//        [self shareTextToPlatformWithType:UMSocialPlatformType_QQ ShareImage:image];
//        
//    }];
//    UIAlertAction * WXKongJianAlert = [UIAlertAction actionWithTitle: @"分享到微信好友" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//        [self shareTextToPlatformWithType:UMSocialPlatformType_WechatSession ShareImage:image];
//        
//    }];
//    UIAlertAction * WXHaoYouAlert = [UIAlertAction actionWithTitle:@"分享到微信朋友圈" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//        [self shareTextToPlatformWithType:UMSocialPlatformType_WechatTimeLine ShareImage:image];
//    }];
//    UIAlertAction * cancelAlert = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
//    
//    if (shareWx) {
//        [alertC addAction:WXKongJianAlert];
//        [alertC addAction:WXHaoYouAlert];
//    }
//    if (shareQQ) {
//        [alertC addAction:QQKongJianAlert];
//        [alertC addAction:QQHaoYouAlert];
//    }
//    
//    [alertC addAction:cancelAlert];
//    [viewController presentViewController:alertC animated:YES completion:nil];
//}
#pragma mark-- 左右震动效果
+(void)shakeWithView:(UIView *)view {
    CGRect frame = view.frame;
    CAKeyframeAnimation *shakeAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    
    CGMutablePathRef shakePath = CGPathCreateMutable();
    CGPathMoveToPoint(shakePath, NULL, frame.origin.x+frame.size.width/2, frame.origin.y+frame.size.height/2);
    int index;
    for (index = 3; index >=0; --index) {
        CGPathAddLineToPoint(shakePath, NULL, frame.origin.x+frame.size.width/2 - frame.size.width * 0.02f * index, frame.origin.y+frame.size.height/2);
        CGPathAddLineToPoint(shakePath, NULL, frame.origin.x+frame.size.width/2 + frame.size.width * 0.02f * index, frame.origin.y+frame.size.height/2);
    }
    CGPathCloseSubpath(shakePath);
    
    shakeAnimation.path = shakePath;
    shakeAnimation.duration = 0.8f;
    shakeAnimation.removedOnCompletion = YES;
    
    [view.layer addAnimation:shakeAnimation forKey:nil];
    CFRelease(shakePath);
}

#pragma mark-- 获取某个字符串或者汉字的首字母.
+ (NSString *)firstCharactorWithString:(NSString *)string{
    
    NSMutableString *str = [NSMutableString stringWithString:string];
    CFStringTransform((CFMutableStringRef) str, NULL, kCFStringTransformMandarinLatin, NO);
    CFStringTransform((CFMutableStringRef)str, NULL, kCFStringTransformStripDiacritics, NO);
    NSString *pinYin = [str capitalizedString];
    return [pinYin substringToIndex:1];
}
#pragma mark--始终让拍的照片放置在竖直向上
+ (UIImage *)normalizedImage:(UIImage *)image{
    
    if (image.imageOrientation == UIImageOrientationUp)
        return image;
    UIGraphicsBeginImageContextWithOptions(image.size, NO, image.scale);
    [image drawInRect:(CGRect){0, 0, image.size}];
    UIImage *normalizedImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return normalizedImage;
}
#pragma mark--根据总的
/**
 根据总的数据和每页的数据获得页数
 */
+ (NSInteger)getAllPageWithEachPageNumber:(NSInteger)number AllBillNumber:(NSInteger)bill{
    NSInteger temp = bill % number;
    NSInteger allPageNumber = bill/number +(temp == 0?0:1);
    return allPageNumber;
}
#pragma mark--获得月末的时间
+ (NSString *)getMonthEndTimeWithYear:(NSInteger)year Month:(NSInteger)month{
    NSString * endTime ;
    if (month!=2) {
        if (month == 4 || month==6 || month ==9 || month ==11) {
            endTime = [NSString stringWithFormat:@"%ld-%ld-30 23:59:59",(long)year,(long)month];
        }
        else {
            endTime = [NSString stringWithFormat:@"%ld-%ld-31 23:59:59",(long)year,(long)month];
        }
    }else {
        if ((year%4==0 && year%100!=0) || year%400==0) {
            endTime = [NSString stringWithFormat:@"%ld-%ld-28 23:59:59",(long)year,(long)month];
        }
        else {
            endTime = [NSString stringWithFormat:@"%ld-%ld-29 23:59:59",(long)year,(long)month];
        }
    }
    
    if (month<10) {
        //替换某一个范围的内容
        endTime = [endTime stringByReplacingCharactersInRange:NSMakeRange(5, 1) withString:[NSString stringWithFormat:@"0%ld",(long)month]];
        
    }
    
    return endTime ;
}
@end
