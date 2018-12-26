//
//  StartFigureManager.m
//  LifeCollection
//
//  Created by gozap on 2018/12/26.
//  Copyright © 2018 com.longdai. All rights reserved.
//

#import "StartFigureManager.h"
#import "LCWebViewViewController.h"

/** 以下连接供测试使用 */
/** 静态图 */
#define imageURL1 @"http://yun.it7090.com/image/XHLaunchAd/pic_test01.jpg"
/** 动态图 */
#define imageURL3 @"http://yun.it7090.com/image/XHLaunchAd/gif_test01.gif"

@implementation LaunchAdModel

- (void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:self.content forKey:@"content"];
    [aCoder encodeObject:self.openUrl forKey:@"openUrl"];
    [aCoder encodeObject:self.contentSize forKey:@"contentSize"];
    [aCoder encodeObject:self.duration forKey:@"duration"];
}
- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super init];
    if(self){
        if ([aDecoder containsValueForKey:@"content"])
            self.content = [aDecoder decodeObjectForKey:@"content"];
        if ([aDecoder containsValueForKey:@"openUrl"])
            self.openUrl = [aDecoder decodeObjectForKey:@"openUrl"];
        if ([aDecoder containsValueForKey:@"contentSize"])
            self.contentSize = [aDecoder decodeObjectForKey:@"contentSize"];
        if ([aDecoder containsValueForKey:@"duration"])
            self.duration = [aDecoder decodeObjectForKey:@"duration"];
    }
    return self;
}
@end

@implementation StartFigureManager

+(void)load{
    [self shareManager];
}

+(StartFigureManager *)shareManager{
    static StartFigureManager *instance = nil;
    static dispatch_once_t oneToken;
    dispatch_once(&oneToken,^{
        instance = [[StartFigureManager alloc] init];
    });
    return instance;
}

- (instancetype)init{
    self = [super init];
    if (self) {
        //在UIApplicationDidFinishLaunching时初始化开屏广告,做到对业务层无干扰,当然你也可以直接在AppDelegate didFinishLaunchingWithOptions方法中初始化
        [[NSNotificationCenter defaultCenter] addObserverForName:UIApplicationDidFinishLaunchingNotification object:nil queue:nil usingBlock:^(NSNotification * _Nonnull note) {
            //读缓存初始化开屏广告
            [self setupXHLaunchAd];
            //获取广告数据
            [self getWelcomePhoto];
        }];
    }
    return self;
}

-(void)getWelcomePhoto{
    NSString * url = @"https://www.gezhipu.com/services/LifeCollectionAD.json";
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        LaunchAdModel * launchAdModel = [LaunchAdModel yy_modelWithDictionary:responseObject[@"data"]];
        if (launchAdModel) {
            [[LCSettings sharedInstance] setObject:launchAdModel forKey:kLaunchScreenModel];
            //缓存图片
            if(launchAdModel.content.length > 0 && ![XHLaunchAd checkImageInCacheWithURL:[NSURL URLWithString:launchAdModel.content]]) {
                [XHLaunchAd downLoadImageAndCacheWithURLArray:@[[NSURL URLWithString:launchAdModel.content]]];
            }
        }else{
            [[LCSettings sharedInstance] setObject:nil forKey:kLaunchScreenModel];
        }
    } failure:nil];
}

#pragma mark - 图片开屏广告-网络数据-示例
//图片开屏广告 - 网络数据
-(void)setupXHLaunchAd{

    LaunchAdModel * model =  [[LCSettings sharedInstance] objectForKey:kLaunchScreenModel];
    
    //配置广告数据
    XHLaunchImageAdConfiguration *imageAdconfiguration = [XHLaunchImageAdConfiguration new];
    //广告frame
    imageAdconfiguration.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height * 0.8);
    //图片已缓存 - 显示一个 "已预载" 视图 (可选)
    if([XHLaunchAd checkImageInCacheWithURL:[NSURL URLWithString:model.content]]){
        //广告停留时间
        imageAdconfiguration.duration = [model.duration integerValue];
        //广告图片URLString/或本地图片名(.jpg/.gif请带上后缀)
        imageAdconfiguration.imageNameOrURLString = model.content;
    }else{
        //广告停留时间
        imageAdconfiguration.duration = 5;
        //广告图片URLString/或本地图片名(.jpg/.gif请带上后缀)
        imageAdconfiguration.imageNameOrURLString = @"image12.gif";
    }
    //设置GIF动图是否只循环播放一次(仅对动图设置有效)
    imageAdconfiguration.GIFImageCycleOnce = NO;
    //缓存机制(仅对网络图片有效)
    //为告展示效果更好,可设置为XHLaunchAdImageCacheInBackground,先缓存,下次显示
    imageAdconfiguration.imageOption = XHLaunchAdImageDefault;
    //图片填充模式
    imageAdconfiguration.contentMode = UIViewContentModeScaleAspectFill;
    //广告点击打开页面参数(openModel可为NSString,模型,字典等任意类型)
    imageAdconfiguration.openModel = model.openUrl;
    //广告显示完成动画
    imageAdconfiguration.showFinishAnimate =ShowFinishAnimateLite;
    //广告显示完成动画时间
    imageAdconfiguration.showFinishAnimateTime = 0.8;
    //跳过按钮类型
    imageAdconfiguration.skipButtonType = SkipTypeTimeText;
    //后台返回时,是否显示广告
    imageAdconfiguration.showEnterForeground = NO;

    //显示开屏广告
    [XHLaunchAd imageAdWithImageAdConfiguration:imageAdconfiguration delegate:self];
}

#pragma mark - subViews
-(NSArray<UIView *> *)launchAdSubViews_alreadyView{
    
    CGFloat y = XH_FULLSCREEN ? 46:22;
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width-140, y, 60, 30)];
    label.text  = @"已预载";
    label.font = [UIFont systemFontOfSize:12];
    label.textColor = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.layer.cornerRadius = 5.0;
    label.layer.masksToBounds = YES;
    label.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    return [NSArray arrayWithObject:label];
    
}

#pragma mark - XHLaunchAd delegate - 其他
/**
 广告点击事件回调
 */
-(void)xhLaunchAd:(XHLaunchAd *)launchAd clickAndOpenModel:(id)openModel clickPoint:(CGPoint)clickPoint{
    
    NSLog(@"广告点击事件");
    
    /** openModel即配置广告数据设置的点击广告时打开页面参数(configuration.openModel) */
    if(openModel==nil) return;
    
    LCWebViewViewController *VC = [[LCWebViewViewController alloc] init];
    NSString *urlString = (NSString *)openModel;
    VC.urlStr = urlString;
    //此处不要直接取keyWindow
    UIViewController* rootVC = [[UIApplication sharedApplication].delegate window].rootViewController;
    [rootVC.navigationController pushViewController:VC animated:YES];
    
}

/**
 *  图片本地读取/或下载完成回调
 *
 *  @param launchAd  XHLaunchAd
 *  @param image 读取/下载的image
 *  @param imageData 读取/下载的imageData
 */
-(void)xhLaunchAd:(XHLaunchAd *)launchAd imageDownLoadFinish:(UIImage *)image imageData:(NSData *)imageData{
    
    NSLog(@"图片下载完成/或本地图片读取完成回调");
}

@end
