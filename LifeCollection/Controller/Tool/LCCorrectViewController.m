//
//  LCCorrectViewController.m
//  LifeCollection
//
//  Created by gozap on 2019/3/12.
//  Copyright © 2019 com.longdai. All rights reserved.
//

#import "LCCorrectViewController.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import <AVFoundation/AVFoundation.h>
#import <CoreMotion/CoreMotion.h>

@interface ZJ_HangerView : UIView

@property (nonatomic, strong) CALayer *showImageLayer;

@property (nonatomic, assign) BOOL captureFlashModeOn;
@property (nonatomic, assign) BOOL isFrontCamera;
@property (nonatomic, readonly) BOOL canTakePicture;


@property (nonatomic, strong) AVCaptureDevice *device;
@property (nonatomic, strong) AVCaptureDeviceInput *input;
@property (nonatomic, strong) AVCaptureMetadataOutput *output;
@property (nonatomic, strong) AVCaptureStillImageOutput *imageOutPut;
@property (nonatomic, strong) AVCaptureSession *session;
@property (nonatomic, strong) AVCaptureVideoPreviewLayer *previewLayer;

@property (nonatomic, assign) BOOL isCapturing;


- (ZJ_HangerView *)initWithFrame:(CGRect)frame frontCamera:(BOOL)isFront;


- (void)changeCamera;

- (void)startCapture;

@end

@implementation ZJ_HangerView

- (instancetype)initWithFrame:(CGRect)frame frontCamera:(BOOL)isFront
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.backgroundColor = [UIColor blackColor];
        self.isFrontCamera = isFront;
        [self preConfigCamera];
    }
    return self;
}

- (void)preConfigCamera
{
    AVCaptureDevicePosition position = self.isFrontCamera ? AVCaptureDevicePositionFront : AVCaptureDevicePositionBack;
    self.device = [self cameraWithPosition:position];
    self.input = [[AVCaptureDeviceInput alloc] initWithDevice:self.device error:nil];
    self.output = [[AVCaptureMetadataOutput alloc] init];
    self.imageOutPut = [[AVCaptureStillImageOutput alloc] init];
    self.session = [[AVCaptureSession alloc] init];
    if ([self.session canAddInput:self.input]) [self.session addInput:self.input];
    if ([self.session canAddOutput:self.imageOutPut]) [self.session addOutput:self.imageOutPut];
    
    [self setSessionPreset];
    self.previewLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:self.session];
    self.previewLayer.frame = self.bounds;
    
    self.previewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    [self.layer addSublayer:self.previewLayer];
    if ([self.device lockForConfiguration:nil])
    {
        if ([self.device isFlashModeSupported:AVCaptureFlashModeOff])
        {
            [self.device setFlashMode:AVCaptureFlashModeOff];
        }
        self.captureFlashModeOn = NO;
        if ([self.device isWhiteBalanceModeSupported:AVCaptureWhiteBalanceModeAutoWhiteBalance])
        {
            [self.device setWhiteBalanceMode:AVCaptureWhiteBalanceModeAutoWhiteBalance];
        }
        [self.device unlockForConfiguration];
    }
    
}

- (void)startCapture
{
    [self.session startRunning];
    self.isCapturing = YES;
}

- (void)changeCamera
{
    NSUInteger cameraCount = [[AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo] count];
    if (cameraCount > 1)
    {
        CATransition *animation = [CATransition animation];
        animation.duration = 0.5f;
        animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        animation.type = @"oglFlip";
        
        BOOL isback = NO;
        AVCaptureDevice *newCamera = nil;
        AVCaptureDevicePosition position = [[self.input device] position];
        if (position == AVCaptureDevicePositionFront)
        {
            newCamera = [self cameraWithPosition:AVCaptureDevicePositionBack];
            animation.subtype = kCATransitionFromLeft;
            isback = YES;
        }
        else
        {
            newCamera = [self cameraWithPosition:AVCaptureDevicePositionFront];
            animation.subtype = kCATransitionFromRight;
        }
        
        NSError *error;
        AVCaptureDeviceInput *newInput = [AVCaptureDeviceInput deviceInputWithDevice:newCamera error:&error];
        [self.previewLayer addAnimation:animation forKey:nil];
        if (newInput != nil)
        {
            [self.session beginConfiguration];
            [self.session removeInput:self.input];
            if ([self.session canAddInput:newInput])
            {
                [self.session addInput:newInput];
                self.input = newInput;
            }
            else
            {
                [self.session addInput:self.input];
            }
            [self setSessionPreset];
            [self.session commitConfiguration];
            self.isFrontCamera = !isback;
        }
        else if (error)
        {
            NSLog(@"切换carema失败,错误 = %@", error);
        }
    }
}

- (void)setSessionPreset
{
    NSMutableArray *array = [NSMutableArray array];
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 9.0)
    {
#ifdef __IPHONE_9_0
        [array addObject:AVCaptureSessionPreset3840x2160];
#endif
    }
    
    NSArray *arr = @[AVCaptureSessionPresetPhoto,
                     AVCaptureSessionPreset1920x1080,
                     AVCaptureSessionPreset1280x720,
                     AVCaptureSessionPreset640x480,
                     AVCaptureSessionPreset352x288];
    [array addObjectsFromArray:arr];
    
    for (NSString *preset in array)
    {
        if ([self.session canSetSessionPreset:preset])
        {
            self.session.sessionPreset = preset;
            break;
        }
    }
}

- (UIImage *)fixImageOrientation:(UIImage *)aImage
{
    if (aImage.imageOrientation == UIImageOrientationUp)
        return aImage;
    
    CGAffineTransform transform = CGAffineTransformIdentity;
    switch (aImage.imageOrientation)
    {
        case UIImageOrientationDown:
        case UIImageOrientationDownMirrored:
        {
            transform = CGAffineTransformTranslate(transform, aImage.size.width, aImage.size.height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;
        }
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
        {
            transform = CGAffineTransformTranslate(transform, aImage.size.width, 0);
            transform = CGAffineTransformRotate(transform, M_PI_2);
            break;
        }
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
        {
            transform = CGAffineTransformTranslate(transform, 0, aImage.size.height);
            transform = CGAffineTransformRotate(transform, -M_PI_2);
            break;
        }
        default:
            break;
    }
    switch (aImage.imageOrientation)
    {
        case UIImageOrientationUpMirrored:
        case UIImageOrientationDownMirrored:
        {
            transform = CGAffineTransformTranslate(transform, aImage.size.width, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
        }
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRightMirrored:
        {
            transform = CGAffineTransformTranslate(transform, aImage.size.height, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
        }
        default:
            break;
    }
    CGContextRef ctx = CGBitmapContextCreate(NULL, aImage.size.width, aImage.size.height, CGImageGetBitsPerComponent(aImage.CGImage), 0, CGImageGetColorSpace(aImage.CGImage), CGImageGetBitmapInfo(aImage.CGImage));
    CGContextConcatCTM(ctx, transform);
    switch (aImage.imageOrientation)
    {
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
        {
            CGContextDrawImage(ctx, CGRectMake(0,0,aImage.size.height,aImage.size.width), aImage.CGImage);
            break;
        }
        default:
        {
            CGContextDrawImage(ctx, CGRectMake(0,0,aImage.size.width,aImage.size.height), aImage.CGImage);
            break;
        }
    }
    CGImageRef cgimg = CGBitmapContextCreateImage(ctx);
    UIImage *img = [UIImage imageWithCGImage:cgimg];
    CGContextRelease(ctx);
    CGImageRelease(cgimg);
    return img;
}

- (BOOL)canTakePicture
{
    return self.isCapturing;
}

- (AVCaptureDevice *)cameraWithPosition:(AVCaptureDevicePosition)position
{
    NSArray *devices = [AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo];
    for (AVCaptureDevice *device in devices)
    {
        if ( device.position == position )
            return device;
    }
    return nil;
}

@end


@interface LCCorrectViewController ()

@property (nonatomic, strong) ZJ_HangerView *LyView;
@property (nonatomic,retain)UIImageView *arrowImageView;
@property (nonatomic,retain) CMMotionManager *motionManager;

@end

@implementation LCCorrectViewController

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.motionManager stopAccelerometerUpdates];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    _LyView = [[ZJ_HangerView alloc] initWithFrame:self.view.bounds frontCamera:NO];
    [self.view addSubview:_LyView];
    [_LyView startCapture];
    
    UIButton *button = [UIButton buttonWithType:(UIButtonTypeSystem)];
    button.tintColor = [UIColor whiteColor];
    button.frame = CGRectMake(15, 35, 37, 37);
    [button setImage:[UIImage imageNamed:@"tool_fanhui_left"] forState:(UIControlStateNormal)];
    [button addTarget:self action:@selector(buttonClick) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:button];
    
    self.arrowImageView =  [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"guhua"]];
    self.arrowImageView.frame = CGRectMake(ScreenWidth -200, 40, 165, 165);
    
    [self.view addSubview:self.arrowImageView];
    self.motionManager = [[CMMotionManager alloc]init];
    if (!self.motionManager.accelerometerAvailable) {
        
    }
    self.motionManager.accelerometerUpdateInterval = 0.01;
    
    [self.motionManager startAccelerometerUpdatesToQueue:[NSOperationQueue currentQueue] withHandler:^(CMAccelerometerData *accelerometerData, NSError *error)
     {
         CMAccelerometerData *newestAccel = self.motionManager.accelerometerData;
         double accelerationX = newestAccel.acceleration.x;
         double accelerationY = newestAccel.acceleration.y;
         double ra = atan2(-accelerationY, accelerationX);
         self.arrowImageView.transform = CGAffineTransformMakeRotation(ra - M_PI_2);
         
     }];
    
}

- (void)buttonClick
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
