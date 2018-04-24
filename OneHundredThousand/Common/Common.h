

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <UMSocialCore/UMSocialCore.h>


typedef void(^resultBlock)();

@interface Common : NSObject

/**
高亮处的文本
 */
+(NSAttributedString *)fuWenBenWithStr:(NSString *)str HeightColor:(UIColor *)heightColor HeightText:(NSString *)heightText;
/**
 设置状态栏的背景色
 */
+ (void)setStatusBarBackgroundColor:(UIColor *)color;
/*s*
 *  获取path路径下文件夹的大小
 */
+ (NSString *)getCacheSize;

/**
 去设置允许访问 相册／相机
 */
+ (void)alertWithTitle:(NSString *)title Message:(NSString *)message ShowVC:(UIViewController *)vc;

/**
检查网络，YES为有网络
 */
+(BOOL)checkNetWork;


/**
   根据时间戳返回时间
 */
+(NSString *)timestampSwitchTime:(NSString *)timestamp Format:(NSString *)format;

/**
 培训费是其他颜色
 NSString * str = @"冲关成功后，培训费才到教练账户哦\n确认冲关成功？";
 self.messageLable.attributedText = [Common contentWithCerStyleStr:str FirstToRange:5 TwoToRange:8];
 */
//+(NSAttributedString *)contentWithCerStyleStr:(NSString *)str FirstToRange:(NSInteger)firstToRange TwoToRange:(NSInteger)twoToRange;


/**
 友盟分享
 */
+ (void)shareTextToPlatformWithShareType:(UMSocialPlatformType)platformType  ShareImage:(id)image ShareUrl:(NSString *)shareUrl ShareTitle:(NSString *)title ShareContent:(NSString *)content;

#pragma make--
/**
检测银行卡号,YES为银行卡号
 */
+ (BOOL)checkCardNo:(NSString*)cardNo;




#pragma mark--提示框
+ (UIAlertController *)showAlertControllerTitle:(NSString *)title Message:(NSString *)message OneAlertActionTitle:(NSString *)actionTitle;

#pragma mark--用户登陆的提示框
+(void)loginUserWithShowViewController:(UIViewController *)VC Result:(resultBlock)result;
 
#pragma mark--判断手机号的真假
+ (BOOL)phonePredicateWithNumberStr:(NSString *)str;

#pragma mark--YES 是身份证 NO 不是
+ (BOOL)isUserIdCardString:(NSString *)idCard;

#pragma mark--判断字符串中只有数字／字母／汉字的谓词 yes 为符合
+ (BOOL)isNumberOrLetterOrChineseString:(NSString *)str;

#pragma mark--判断字符串是否为空 YES:为空；NO：不为空
/**
判断字符串是否为空 YES:为空；NO：不为空
 */
+ (BOOL)isNullString:(NSString *)str;

#pragma mark --根据字符串返回字符串的宽度
+(CGFloat)getWidthWithText:(NSString *)text Font:(CGFloat)font;
#pragma mark -根据字符串返回字符串的高度
+(CGFloat)getHeightText:(NSString *)text WithWidth:(CGFloat)width Font:(CGFloat)font;

#pragma mark--计算字符串的长度
+(NSInteger)stringWithContent:(NSString *)content;

#pragma mark--正则表达式：限定6-18位的英文大小写，数字
+(BOOL)passwordStyleWithString:(NSString *)password;
#pragma mark--正则表达式：验证邮箱的正确与否
+(BOOL)isEmail:(NSString *)email;

#pragma mark--文件的路径--Documnets文件夹下
+(NSString *)getFilePath:(NSString *)fileName;


#pragma mark--删除线
+(void)deleteLineLabel:(UILabel *)label;


#pragma mark--获得北京时间的时间戳
+ (NSString *)getNowTime;

/**
 获得当前的小时时间
 */
+(NSString *)getNowHour;

/**
 获得当前的 年 的时间
 */
+(NSString *)getNowYear;

/**
 获得当前 月 的时间
 */
+(NSString *)getNowMonth;

#pragma mark--根据某个模式 分割字符串
/**
 -根据某个模式 分割字符串
 
 @param str 根据某个模式分割字符串例如空格
 @param contentStr 需要分割的字符串
 */
+(NSArray *)componentStr:(NSString *)str ContentStr:(NSString *)contentStr;

#pragma mark--如果字符串为空，用 @“” 代替
+(NSString *)contentStr:(NSString *)str;

#pragma mark--富文本编辑 FirstToRange是从 0 开始数的序号
+(NSAttributedString *)contentStr:(NSString *)str FirstToRange:(NSInteger)firstToRange;

/**
 可变的富文本编辑－选择证件类型的
 */
//+(NSAttributedString *)contentWithCerStyleStr:(NSString *)str FirstToRange:(NSInteger)firstToRange FirstFont:(CGFloat)firstFont OtherFont:(CGFloat)otherFont OtherColor:(UIColor *)color;

#pragma mark-- 左右震动效果
+(void)shakeWithView:(UIView *)view;

#pragma mark-- 分享APP
//-(void)shareAPPWithViewController:(UIViewController *)viewController;
//
//-(BOOL)shareTextToPlatformWithType:(UMSocialPlatformType)platformType ShareImage:(UIImage *)image;

#pragma mark-- 获取某个字符串或者汉字的首字母.
+ (NSString *)firstCharactorWithString:(NSString *)string;

#pragma mark--始终让拍的照片放置在竖直向上
+ (UIImage *)normalizedImage:(UIImage *)image;


/**
 根据总的数据和每页的数据获得页数
 */
+ (NSInteger)getAllPageWithEachPageNumber:(NSInteger)number AllBillNumber:(NSInteger)bill;
/**
 获得月末的时间
 @param year 年
 @param month 月
 */
+ (NSString *)getMonthEndTimeWithYear:(NSInteger)year Month:(NSInteger)month;
@end
