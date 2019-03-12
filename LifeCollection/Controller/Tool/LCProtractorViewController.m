//
//  LCProtractorViewController.m
//  LifeCollection
//
//  Created by gozap on 2019/3/12.
//  Copyright © 2019 com.longdai. All rights reserved.
//

#import "LCProtractorViewController.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import <AVFoundation/AVFoundation.h>
#import "UIControl+Block_Handle.h"

#define Point(x, y)         CGPointMake(x, y)
#define CenterForRect(r)    Point((r).origin.x + (r).size.width / 2, (r).origin.y + (r).size.height / 2)


#define kSingleLineWidth           (1 / [UIScreen mainScreen].scale)
#define kScreenHight    (MAX([[UIScreen mainScreen] bounds].size.height, [[UIScreen mainScreen] bounds].size.width))
#define kScreenWidth    (MIN([[UIScreen mainScreen] bounds].size.height, [[UIScreen mainScreen] bounds].size.width))

#define kcpnt(c)        ((c) / 255.0f)
#define kColorRGBA(r, g, b, a)  [UIColor colorWithRed:kcpnt(r) green:kcpnt(g) blue:kcpnt(b) alpha:kcpnt(a)]

#define Color_BK  kColorRGBA(10, 10, 10, 100)
#define Color_CN  kColorRGBA(220, 244, 244, 100)
#define Color_CI  kColorRGBA(242, 171, 228, 100)

#define Color_AC  [UIColor greenColor]
#define Color_GL  kColorRGBA(193, 195, 207, 255)
#define Color_GV  kColorRGBA(255, 255, 255, 255)
#define Color_IA  kColorRGBA(75, 211, 162, 255)

#define Color_BK_Key  @"bk"
#define Color_GL_Key  @"gl"
#define Color_GV_Key  @"gv"
#define Color_CN_Key  @"cn"
#define Color_CI_Key  @"ci"
#define Color_IA_Key  @"ia"

#define angle_to_radia(x)   ( M_PI / 180 * (x) )
#define radia_to_angle(x)   ( 180 / M_PI * (x) )

#pragma mark - protractor layer // 量角器刻度层
@interface LYProtractorLayer : CALayer

@property (nonatomic, copy) void (^callback)(CGFloat from, CGFloat to, CGFloat angle);

@property (nonatomic, strong) CATextLayer *angle_layer;
@property (nonatomic, strong) UIColor *angle_color;

@property (nonatomic, strong) UIColor *background_color;
@property (nonatomic, strong) UIColor *graduation_line_color;
@property (nonatomic, strong) UIColor *graduation_value_color;
@property (nonatomic, strong) UIColor *center_normal_color;
@property (nonatomic, strong) UIColor *center_included_angle_color;
@property (nonatomic, strong) UIColor *included_angle_line_color;

@property (nonatomic, strong) CAShapeLayer *background_layer;
@property (nonatomic, strong) CAShapeLayer *graduation_line_layer;
@property (nonatomic, strong) CAShapeLayer *graduation_value_layer;
@property (nonatomic, strong) CAShapeLayer *center_normal_layer;
@property (nonatomic, strong) CAShapeLayer *center_included_angle_layer;
@property (nonatomic, strong) CAShapeLayer *included_angle_line_layer;
@property (nonatomic, strong) CAShapeLayer *corner_radius_layer;
@property (nonatomic, strong) CAShapeLayer *start_angle_layer;
@property (nonatomic, strong) CAShapeLayer *end_angle_layer;

@property (nonatomic, assign, readonly) CGFloat protractor_nop;
@property (nonatomic, assign, readonly) CGPoint protractor_center;
@property (nonatomic, assign, readonly) CGFloat protractor_radius;

@property (nonatomic, assign, readonly) CGFloat protractor_inner_radius;

@property (nonatomic, assign, readonly) CGFloat kedur_r0;
@property (nonatomic, assign, readonly) CGFloat kedur_r1;
@property (nonatomic, assign, readonly) CGFloat kedur_r2;
@property (nonatomic, assign, readonly) CGFloat kedur_r3;
@property (nonatomic, assign, readonly) CGFloat kedur_val;

@property (nonatomic, assign) CGFloat startAngle;
@property (nonatomic, assign) CGFloat endAngle;


+ (LYProtractorLayer *)drawProtractorLayerWithColors:(NSDictionary <NSString *, UIColor *>*)colors;

- (void)redrawIncludedAngleLineFromAngle:(CGFloat)from toAngle:(CGFloat)to;

@end

@implementation LYProtractorLayer

+ (LYProtractorLayer *)drawProtractorLayerWithColors:(NSDictionary<NSString *,UIColor *> *)colors
{
    CGRect rect = CGRectMake(0, 0, kScreenWidth, kScreenHight);
    LYProtractorLayer *layer = [[LYProtractorLayer alloc] init];
    layer.bounds = rect;
    layer.position = CenterForRect(rect);
    [layer setColors:colors];
    layer.startAngle = angle_to_radia(47.321530589832726);
    layer.endAngle = angle_to_radia(132.67846941016728);
    [layer addGraduationContentLayers];
    return layer;
}

- (void)addGraduationContentLayers
{
    [self addSublayer:self.background_layer];
    [self addSublayer:self.graduation_line_layer];
    [self addSublayer:self.graduation_value_layer];
    [self addSublayer:self.center_normal_layer];
    [self addSublayer:self.center_included_angle_layer];
    [self addSublayer:self.included_angle_line_layer];
    [self addSublayer:self.corner_radius_layer];
    [self addSublayer:self.start_angle_layer];
    [self addSublayer:self.end_angle_layer];
    [self addSublayer:self.angle_layer];
}

- (void)redrawIncludedAngleLineFromAngle:(CGFloat)from toAngle:(CGFloat)to
{
    from = MIN(MAX(0, from), self.endAngle);
    to = MIN(MAX(to, self.startAngle), M_PI);
    
    self.startAngle = from;
    self.endAngle = to;
    
    self.angle_layer.string = [NSString stringWithFormat:@" %.2f°", radia_to_angle(fabs(self.endAngle - self.startAngle))];
    if (self.callback){
        self.callback(radia_to_angle(from), radia_to_angle(to), radia_to_angle(fabs(from - to)));
    }
    
    {
        [CATransaction begin];
        [CATransaction setDisableActions:YES];
        self.start_angle_layer.position = [self point_at_angle:self.startAngle r:self.protractor_inner_radius geometryFlipped:NO];
        self.start_angle_layer.affineTransform = CGAffineTransformRotate(CGAffineTransformIdentity, self.startAngle);
        
        self.end_angle_layer.position = [self point_at_angle:self.endAngle r:self.protractor_inner_radius geometryFlipped:NO];
        self.end_angle_layer.affineTransform = CGAffineTransformRotate(CGAffineTransformIdentity, self.endAngle);
        [CATransaction commit];
    }
    
    self.included_angle_line_layer.path = [self path_included_line].CGPath;
    
    self.center_included_angle_layer.path = [self path_included_angle].CGPath;
}



- (UIBezierPath *)path_inner_background
{
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path addArcWithCenter:self.protractor_center radius:self.protractor_inner_radius startAngle:M_PI / 2 endAngle:3 * M_PI / 2 clockwise:NO];
    
    [path moveToPoint:CGPointMake(0, self.protractor_center.y - self.protractor_inner_radius)];
    [path addLineToPoint:CGPointMake(self.protractor_center.x, self.protractor_center.y - self.protractor_inner_radius)];
    [path addLineToPoint:CGPointMake(self.protractor_center.x, self.protractor_center.y + self.protractor_inner_radius)];
    [path addLineToPoint:CGPointMake(0, self.protractor_center.y + self.protractor_inner_radius)];
    return path;
}

- (UIBezierPath *)path_graduation_lines
{
    UIBezierPath *path = [UIBezierPath bezierPath];
    for (NSInteger i = 0; i <= 180; i ++)
    {
        CGFloat angle = angle_to_radia(i);
        CGPoint start = [self point_r3_at_angle:angle];
        CGPoint end = CGPointZero;
        if (i % 10 == 0)
        {
            end = [self point_r0_at_angle:angle];
        }
        else if (i % 5 == 0)
        {
            end = [self point_r1_at_angle:angle];
        }
        else
        {
            end = [self point_r2_at_angle:angle];
        }
        [path moveToPoint:start];
        [path addLineToPoint:end];
    }
    return path;
}

- (UIBezierPath *)path_included_angle
{
    CGFloat angle_start = MIN(self.startAngle, self.endAngle) - M_PI / 2;
    CGFloat angle_end = MAX(self.startAngle, self.endAngle) - M_PI / 2;
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path addArcWithCenter:self.protractor_center radius:self.protractor_inner_radius startAngle:angle_start endAngle:angle_end clockwise:YES];
    [path moveToPoint:self.protractor_center];
    [path addLineToPoint:[self point_at_angle:self.startAngle r:self.protractor_inner_radius geometryFlipped:NO]];
    [path addLineToPoint:[self point_at_angle:self.endAngle r:self.protractor_inner_radius geometryFlipped:NO]];
    [path addLineToPoint:self.protractor_center];
    return path;
}

- (UIBezierPath *)path_included_line
{
    CGFloat angle_start = MIN(self.startAngle, self.endAngle);
    CGFloat angle_end = MAX(self.startAngle, self.endAngle);
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:self.protractor_center];
    [path addLineToPoint:[self edge_point_at_angle:angle_start]];
    [path moveToPoint:self.protractor_center];
    [path addLineToPoint:[self edge_point_at_angle:angle_end]];
    return path;
}

- (CGPoint)point_r3_at_angle:(CGFloat)angle
{
    return [self point_at_angle:angle r:self.kedur_r3 geometryFlipped:YES];
}

- (CGPoint)point_r2_at_angle:(CGFloat)angle
{
    return [self point_at_angle:angle r:self.kedur_r2 geometryFlipped:YES];
}

- (CGPoint)point_r1_at_angle:(CGFloat)angle
{
    return [self point_at_angle:angle r:self.kedur_r1 geometryFlipped:YES];
}

- (CGPoint)point_r0_at_angle:(CGFloat)angle
{
    return [self point_at_angle:angle r:self.kedur_r0 geometryFlipped:YES];
}

- (CGPoint)point_at_angle:(CGFloat)angle r:(CGFloat)r geometryFlipped:(BOOL)geometryFlipped
{
    CGFloat sin = sinf(angle);
    CGFloat cos = cosf(angle) * (geometryFlipped ? 1 : -1);
    CGFloat x = self.protractor_center.x + sin * r;
    CGFloat y = self.protractor_center.y + cos * r;
    return CGPointMake(x, y);
}

- (CGPoint)edge_point_at_angle:(CGFloat)angle
{
    CGFloat angle_min = atan((kScreenWidth - self.protractor_nop) / (kScreenHight / 2));
    CGFloat angle_max = M_PI - angle_min;
    CGFloat x = self.protractor_nop, y = 0;
    if (angle <= angle_min)
    {
        x += tan(angle) * (kScreenHight / 2);
    }
    else if (angle <= angle_max)
    {
        CGFloat ang = angle - M_PI / 2;
        x = kScreenWidth;
        y = self.protractor_center.y + tan(ang) * (kScreenWidth - self.protractor_nop);
    }
    else
    {
        y = kScreenHight;
        x += - tan(angle) * (kScreenHight / 2);
    }
    return CGPointMake(x, y);
}

- (CGFloat)point_to_angle:(CGPoint)point
{
    if (point.x <= self.protractor_nop)
    {
        point.x = self.protractor_nop;
    }
    CGFloat w = point.x - self.protractor_center.x;
    CGFloat h = self.protractor_center.y - point.y;
    CGFloat radia = atan(w / h);
    CGFloat angle = radia_to_angle(radia);
    if (angle < 0)
    {
        angle = 180 + angle;
    }
    angle = fabs(angle);
    if (angle == 0 && point.y > (kScreenHight / 2))
    {
        angle = 180;
    }
    return angle;
}

#pragma mark - getters setters
- (CAShapeLayer *)background_layer
{
    if (!_background_layer)
    {
        _background_layer = [self shapeLayerPath:[UIBezierPath bezierPathWithRect:self.bounds] strokeColor:nil fillColor:self.background_color geometryFlipped:YES];
    }
    return _background_layer;
}

- (CAShapeLayer *)graduation_line_layer
{
    if (!_graduation_line_layer)
    {
        _graduation_line_layer = [self shapeLayerPath:[self path_graduation_lines] strokeColor:self.graduation_line_color fillColor:nil geometryFlipped:YES];
    }
    return _graduation_line_layer;
}

- (CAShapeLayer *)graduation_value_layer
{
    if (!_graduation_value_layer)
    {
        _graduation_value_layer = [self shapeLayerPath:[UIBezierPath bezierPathWithRect:self.bounds] strokeColor:nil fillColor:nil geometryFlipped:YES];
        for (NSInteger i = 0; i <= 180; i ++)
        {
            if (i % 10 == 0)
            {
                CGFloat angle = angle_to_radia(i);
                NSString *text = [NSString stringWithFormat:@"%zd", i];
                CGRect rect = CGRectMake(0, 0, 20, 12);
                CGPoint point = [self point_at_angle:angle r:self.kedur_val geometryFlipped:YES];
                CGAffineTransform transform = CGAffineTransformRotate(CGAffineTransformIdentity, -angle);
                CATextLayer *layer = [self textLayerAtPosition:point bounds:rect color:self.graduation_value_color fontSize:11 transform:transform];
                layer.string = text;
                [_graduation_value_layer addSublayer:layer];
            }
        }
    }
    return _graduation_value_layer;
}

- (CAShapeLayer *)center_normal_layer
{
    if (!_center_normal_layer)
    {
        _center_normal_layer = [self shapeLayerPath:[self path_inner_background] strokeColor:nil fillColor:self.center_normal_color geometryFlipped:YES];
    }
    return _center_normal_layer;
}

- (CAShapeLayer *)center_included_angle_layer
{
    if (!_center_included_angle_layer)
    {
        _center_included_angle_layer = [self shapeLayerPath:[self path_included_angle] strokeColor:nil fillColor:self.center_included_angle_color geometryFlipped:NO];
    }
    return _center_included_angle_layer;
}

- (CAShapeLayer *)included_angle_line_layer
{
    if (!_included_angle_line_layer)
    {
        _included_angle_line_layer = [self shapeLayerPath:[self path_included_line] strokeColor:self.included_angle_line_color fillColor:nil geometryFlipped:NO];
    }
    return _included_angle_line_layer;
}

- (CAShapeLayer *)shapeLayerPath:(UIBezierPath *)path strokeColor:(UIColor *)strokeColor fillColor:(UIColor *)fillColor geometryFlipped:(BOOL)geometryFlipped
{
    CAShapeLayer *layer = [CAShapeLayer layer];
    layer.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    layer.bounds = layer.frame;
    layer.geometryFlipped = geometryFlipped;
    layer.path = path.CGPath;
    layer.strokeColor = strokeColor.CGColor;
    layer.fillColor = fillColor.CGColor;
    layer.lineWidth = kSingleLineWidth;
    layer.lineJoin = kCALineJoinBevel;
    return layer;
}

- (CATextLayer *)angle_layer
{
    if (!_angle_layer)
    {
        CGRect rect = CGRectMake(0, 0, 120, 30);
        CGPoint point = CGPointMake(kScreenWidth - 40, kScreenHight / 2);
        CGAffineTransform transform = CGAffineTransformRotate(CGAffineTransformIdentity, M_PI / 2);
        CATextLayer *layer = [self textLayerAtPosition:point bounds:rect color:self.angle_color fontSize:20 transform:transform];
        layer.string = [NSString stringWithFormat:@" %.2f°", radia_to_angle(fabs(self.endAngle - self.startAngle))];
        _angle_layer = layer;
    }
    return _angle_layer;
}

- (CATextLayer *)textLayerAtPosition:(CGPoint)position bounds:(CGRect)rect color:(UIColor *)color fontSize:(CGFloat)size transform:(CGAffineTransform)transform
{
    CATextLayer *layer = [CATextLayer layer];
    layer.position = position;
    layer.bounds = rect;
    layer.backgroundColor = [UIColor clearColor].CGColor;
    layer.foregroundColor = color.CGColor;
    layer.alignmentMode = @"center";
    layer.fontSize = size;
    layer.affineTransform = transform;
    return layer;
}

- (CAShapeLayer *)corner_radius_layer
{
    if (!_corner_radius_layer)
    {
        CGFloat w = self.protractor_nop;
        _corner_radius_layer = [CAShapeLayer layer];
        _corner_radius_layer.backgroundColor = [UIColor clearColor].CGColor;
        _corner_radius_layer.fillColor = self.included_angle_line_color.CGColor;
        _corner_radius_layer.position = self.protractor_center;
        _corner_radius_layer.bounds = CGRectMake(0, 0, w, w);
        _corner_radius_layer.path = [UIBezierPath bezierPathWithRoundedRect:_corner_radius_layer.bounds cornerRadius:w / 2].CGPath;
    }
    return _corner_radius_layer;
}

- (CAShapeLayer *)start_angle_layer
{
    if (!_start_angle_layer)
    {
        _start_angle_layer = [self create_touch_item_layer];
        _start_angle_layer.position = [self point_at_angle:self.startAngle r:self.protractor_inner_radius geometryFlipped:NO];
        _start_angle_layer.affineTransform = CGAffineTransformRotate(CGAffineTransformIdentity, self.startAngle);
    }
    return _start_angle_layer;
}

- (CAShapeLayer *)end_angle_layer
{
    if (!_end_angle_layer)
    {
        _end_angle_layer = [self create_touch_item_layer];
        _end_angle_layer.position = [self point_at_angle:self.endAngle r:self.protractor_inner_radius geometryFlipped:NO];
        _end_angle_layer.affineTransform = CGAffineTransformRotate(CGAffineTransformIdentity, self.endAngle);
    }
    return _end_angle_layer;
}

- (CAShapeLayer *)create_touch_item_layer
{
    CGFloat nop = 2;
    CGFloat nop_l = 3;
    CGFloat w = self.protractor_nop + 2;
    CAShapeLayer *layer = [CAShapeLayer layer];
    layer.bounds = CGRectMake(0, 0, w, w);
    layer.backgroundColor = self.included_angle_line_color.CGColor;
    layer.borderColor = self.included_angle_line_color.CGColor;
    layer.borderWidth = 1;
    layer.cornerRadius = w / 2;
    layer.masksToBounds = YES;
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(w / 2, nop_l)];
    [path addLineToPoint:CGPointMake(w / 2, w - nop_l)];
    [path moveToPoint:CGPointMake(w / 2 - nop, nop_l)];
    [path addLineToPoint:CGPointMake(w / 2 - nop, w - nop_l)];
    [path moveToPoint:CGPointMake(w / 2 + nop, nop_l)];
    [path addLineToPoint:CGPointMake(w / 2 + nop, w - nop_l)];
    
    layer.strokeColor = self.background_color.CGColor;
    layer.path = path.CGPath;
    layer.lineWidth = kSingleLineWidth;
    layer.lineJoin = kCALineJoinBevel;
    return layer;
}

- (CGFloat)protractor_nop
{
    return 12;
}

- (CGPoint)protractor_center
{
    return CGPointMake(self.protractor_nop, kScreenHight / 2);
}

- (CGFloat)protractor_radius
{
    return 10;
}

- (CGFloat)kedur_r0
{
    return self.kedur_r3 - 16;
}

- (CGFloat)kedur_r1
{
    return self.kedur_r3 - 12;
}

- (CGFloat)kedur_r2
{
    return self.kedur_r3 - 8;
}

- (CGFloat)kedur_r3
{
    return (kScreenWidth - self.protractor_nop) * 0.75;
}

- (CGFloat)kedur_val
{
    return self.kedur_r3 - 23;
}

- (CGFloat)protractor_inner_radius
{
    return self.kedur_r3 * 0.55;
}

- (UIColor *)angle_color
{
    if (!_angle_color)
    {
        _angle_color = Color_AC;
    }
    return _angle_color;
}

- (UIColor *)graduation_line_color
{
    if (!_graduation_line_color)
    {
        _graduation_line_color = Color_GL;
    }
    return _graduation_line_color;
}

- (UIColor *)graduation_value_color
{
    if (!_graduation_value_color)
    {
        _graduation_value_color = Color_GV;
    }
    return _graduation_value_color;
}

- (UIColor *)background_color
{
    if (!_background_color)
    {
        _background_color = Color_BK;
    }
    return _background_color;
}

- (UIColor *)center_normal_color
{
    if (!_center_normal_color)
    {
        _center_normal_color = Color_CN;
    }
    return _center_normal_color;
}

- (UIColor *)center_included_angle_color
{
    if (!_center_included_angle_color)
    {
        _center_included_angle_color = Color_CI;
    }
    return _center_included_angle_color;
}

- (UIColor *)included_angle_line_color
{
    if (!_included_angle_line_color)
    {
        _included_angle_line_color = Color_IA;
    }
    return _included_angle_line_color;
}

- (void)setColors:(NSDictionary *)dict
{
    UIColor *gl = dict[Color_GL_Key];
    UIColor *gv = dict[Color_GV_Key];
    UIColor *bk = dict[Color_BK_Key];
    UIColor *cn = dict[Color_CN_Key];
    UIColor *ci = dict[Color_CI_Key];
    UIColor *ia = dict[Color_IA_Key];
    if (gl) self.graduation_line_color = gl;
    if (gv) self.graduation_value_color = gv;
    if (bk) self.background_color = bk;
    if (cn) self.center_normal_color = cn;
    if (ci) self.center_included_angle_color = ci;
    if (ia) self.included_angle_line_color = ia;
}

@end


@interface LYProtractorView : UIView

@property (nonatomic, copy) void (^callback)(CGFloat from, CGFloat to, CGFloat angle);

@property (nonatomic, strong) LYProtractorLayer *protractorLayer;
@property (nonatomic, assign) CGFloat touch_begin_angle;
@property (nonatomic, assign) BOOL touch_min;
@property (nonatomic, assign) BOOL touch_direct_determined;
@property (nonatomic, assign) CGFloat layer_start_angle;
@property (nonatomic, assign) CGFloat layer_end_angle;

@property (nonatomic, strong) CALayer *showImageLayer;

@property (nonatomic, strong) UIButton *touchTypeButton;
@property (nonatomic, assign) BOOL touch_protractor;
@property (nonatomic, assign) CGPoint touch_begin_point;
@property (nonatomic, assign) CGPoint layer_point;

@property (nonatomic, assign) BOOL captureFlashModeOn;
@property (nonatomic, assign) BOOL isFrontCamera;
@property (nonatomic, readonly) BOOL canTakePicture;

@property (nonatomic, strong) UIButton *takePictureButton;
@property (nonatomic, strong) UIButton *flashButton;
@property (nonatomic, strong) UIButton *retakeButton;


@property (nonatomic, strong) AVCaptureDevice *device;
@property (nonatomic, strong) AVCaptureDeviceInput *input;
@property (nonatomic, strong) AVCaptureMetadataOutput *output;
@property (nonatomic, strong) AVCaptureStillImageOutput *imageOutPut;
@property (nonatomic, strong) AVCaptureSession *session;
@property (nonatomic, strong) AVCaptureVideoPreviewLayer *previewLayer;

@property (nonatomic, assign) BOOL isCapturing;

- (LYProtractorView *)initWithFrame:(CGRect)frame frontCamera:(BOOL)isFront;

- (void)changeCamera;

- (void)startCapture;

- (void)takePictureWithHandle:(void (^)(UIImage *image, NSError *err))block;

@end

@implementation LYProtractorView

- (instancetype)initWithFrame:(CGRect)frame frontCamera:(BOOL)isFront
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.backgroundColor = [UIColor blackColor];
        self.isFrontCamera = isFront;
        self.touch_protractor = YES;
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
    [self.layer addSublayer:self.protractorLayer];
    if ([self.device lockForConfiguration:nil]){
        if ([self.device isFlashModeSupported:AVCaptureFlashModeOff]){
            [self.device setFlashMode:AVCaptureFlashModeOff];
        }
        self.captureFlashModeOn = NO;
        
        if ([self.device isWhiteBalanceModeSupported:AVCaptureWhiteBalanceModeAutoWhiteBalance]){
            [self.device setWhiteBalanceMode:AVCaptureWhiteBalanceModeAutoWhiteBalance];
        }
        [self.device unlockForConfiguration];
    }
    
    [self addButtons];
    [self addSubview:self.flashButton];
    
    __weak typeof(self) weakself = self;
    [self.takePictureButton handleControlEvents:UIControlEventTouchUpInside withBlock:^(UIControlEvents events) {
        
        __strong typeof(weakself) strongself = weakself;
        [strongself takePictureWithHandle:^(UIImage *image, NSError *err) {
            
            if (err) return ;
            
            [strongself removeButtons];
            UIImageOrientation imgOrientation;
            imgOrientation = image.imageOrientation;
            
            image = [strongself fixImageOrientation:image];
            NSString *type = self.previewLayer.videoGravity;
            if (type == AVLayerVideoGravityResizeAspectFill)
            {
                CGSize isize = image.size;
                CGSize vsize = strongself.bounds.size;
                CGFloat ibs = isize.width / isize.height;
                CGFloat vbs = vsize.width / vsize.height;
                BOOL clip_y = ibs < vbs;
                CGFloat w = clip_y ? isize.width : (isize.height * vbs);
                CGFloat h = clip_y ? ( isize.width / vbs) : isize.height;
                CGRect rect = CGRectMake((isize.width - w) / 2, (isize.height - h) / 2, w, h);
                
                CGImageRef ref = CGImageCreateWithImageInRect(image.CGImage, rect);
                CGRect bounds = CGRectMake(0, 0, CGImageGetWidth(ref), CGImageGetHeight(ref));
                UIGraphicsBeginImageContext(bounds.size);
                CGContextRef context = UIGraphicsGetCurrentContext();
                CGContextDrawImage(context, bounds, ref);
                image = [UIImage imageWithCGImage:ref];
                CGImageRelease(ref);
                UIGraphicsEndImageContext();
            }
            
            UIImageView *imv = [[UIImageView alloc] initWithFrame:strongself.bounds];
            imv.image = image;
            strongself.showImageLayer = imv.layer;
        }];
    }];
    
    [self.touchTypeButton handleControlEvents:UIControlEventTouchUpInside withBlock:^(UIControlEvents events) {
        
        __strong typeof(weakself) strongself = weakself;
        strongself.touch_protractor = !strongself.touch_protractor;
        
        [strongself.touchTypeButton setTitle:strongself.touch_protractor ? @"移动图片" : @"移动光标" forState:UIControlStateNormal];
    }];
    [self.retakeButton handleControlEvents:UIControlEventTouchUpInside withBlock:^(UIControlEvents events) {
        
        __strong typeof(weakself) strongself = weakself;
        strongself.showImageLayer = nil;
        [strongself addButtons];
        [strongself startCapture];
    }];
}

- (void)addButtons
{
    self.touch_protractor = YES;
    [self addSubview:self.takePictureButton];
    [self.touchTypeButton removeFromSuperview];
    [self.retakeButton removeFromSuperview];
}

- (void)removeButtons
{
    self.touch_protractor = YES;
    [self.takePictureButton removeFromSuperview];
    [self addSubview:self.touchTypeButton];
    [self addSubview:self.retakeButton];
}

- (void)startCapture{
    [self.session startRunning];
    self.isCapturing = YES;
}

- (void)changeCamera{
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

- (void)takePictureWithHandle:(void (^)(UIImage *, NSError *))block
{
    if (self.isCapturing == NO)
    {
        [self startCapture];
        [_takePictureButton setTitle:@"照片锁" forState:(UIControlStateNormal)];
        [_takePictureButton setImage:[UIImage imageNamed:@"suoding"] forState:(UIControlStateNormal)];
        return;
    }
    AVCaptureConnection * videoConnection = [self.imageOutPut connectionWithMediaType:AVMediaTypeVideo];
    if (!videoConnection)
    {
        dispatch_async(dispatch_get_main_queue(), ^{
            
            if (block) block(nil, [NSError errorWithDomain:@"拍照失败!" code:0 userInfo:nil]);
        });
        return;
    }
    
    __weak typeof(self) weakself = self;
    [self.imageOutPut captureStillImageAsynchronouslyFromConnection:videoConnection completionHandler:^(CMSampleBufferRef imageDataSampleBuffer, NSError *error) {
        
        if (imageDataSampleBuffer == NULL) return;
        __strong typeof(weakself) strongself = weakself;
        [strongself.session stopRunning];
        strongself.isCapturing = NO;
        
        NSData *imageData = [AVCaptureStillImageOutput jpegStillImageNSDataRepresentation:imageDataSampleBuffer];
        UIImage *image = [UIImage imageWithData:imageData];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            if (block) block(image, nil);
        });
    }];
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

#pragma mark - touch events
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    CGPoint point = [[touches anyObject] locationInView:self];
    if (self.touch_protractor)
    {
        self.touch_direct_determined = NO;
        CGFloat angle = [self.protractorLayer point_to_angle:point];
        self.touch_begin_angle = angle;
        self.layer_start_angle = radia_to_angle(self.protractorLayer.startAngle);
        self.layer_end_angle = radia_to_angle(self.protractorLayer.endAngle);
        if (fabs(self.layer_start_angle - self.layer_end_angle) > 0.0001)
        {
            self.touch_direct_determined = YES;
            self.touch_min = fabs(self.touch_begin_angle - self.layer_start_angle) < fabs(self.touch_begin_angle - self.layer_end_angle);
        }
    }
    else
    {
        self.touch_begin_point = point;
        self.layer_point = self.showImageLayer.position;
    }
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    CGPoint point = [[touches anyObject] locationInView:self];
    if (self.touch_protractor)
    {
        CGFloat angle = [self.protractorLayer point_to_angle:point];
        CGFloat angle_changed = angle - self.touch_begin_angle;
        if (!self.touch_direct_determined)
        {
            self.touch_direct_determined = YES;
            self.touch_min = angle_changed < 0;
        }
        CGFloat angle_now = angle_changed + (self.touch_min ? self.layer_start_angle : self.layer_end_angle);
        CGFloat radia_now = angle_to_radia(angle_now);
        if (self.touch_min)
        {
            [self.protractorLayer redrawIncludedAngleLineFromAngle:radia_now toAngle:self.protractorLayer.endAngle];
        }
        else
        {
            [self.protractorLayer redrawIncludedAngleLineFromAngle:self.protractorLayer.startAngle toAngle:radia_now];
        }
    }
    else
    {
        CGPoint vector_changed = CGPointMake(point.x - self.touch_begin_point.x, point.y - self.touch_begin_point.y);
        CGPoint now_position = CGPointMake(self.layer_point.x + vector_changed.x, self.layer_point.y + vector_changed.y);
        
        [CATransaction begin];
        [CATransaction setDisableActions:YES];
        self.showImageLayer.position = now_position;
        [CATransaction commit];
    }
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self touchesMoved:touches withEvent:event];
}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self touchesMoved:touches withEvent:event];
}

#pragma mark - getters setters
- (LYProtractorLayer *)protractorLayer
{
    if (!_protractorLayer)
    {
        _protractorLayer = [LYProtractorLayer drawProtractorLayerWithColors:nil];
    }
    return _protractorLayer;
}

- (void)setShowImageLayer:(CALayer *)showImageLayer
{
    [_showImageLayer removeFromSuperlayer];
    _showImageLayer = nil;
    if (!showImageLayer)
    {
        [self.layer insertSublayer:self.previewLayer below:self.protractorLayer];
        return;
    }
    else
    {
        [self.previewLayer removeFromSuperlayer];
    }
    _showImageLayer = showImageLayer;
    [self.layer insertSublayer:_showImageLayer below:self.protractorLayer];
}

- (void)setCallback:(void (^)(CGFloat, CGFloat, CGFloat))callback
{
    self.protractorLayer.callback = callback;
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

- (UIButton *)takePictureButton
{
    if (!_takePictureButton)
    {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setFrame:CGRectMake(0, 0, 150, 60)];
        button.center = CGPointMake(self.bounds.size.width - 50, 110);
        button.backgroundColor = [UIColor clearColor];
        _takePictureButton = button;
        _takePictureButton.transform = CGAffineTransformRotate(_takePictureButton.transform, M_PI_2);
        _takePictureButton.titleLabel.font = [UIFont systemFontOfSize:17];
        [_takePictureButton setTitle:@"打开相机" forState:UIControlStateNormal];
        [_takePictureButton setImage:[UIImage imageNamed:@"paishe"] forState:(UIControlStateNormal)];
    }
    return _takePictureButton;
}

- (UIButton *)flashButton
{
    if (!_flashButton)
    {
        _flashButton = [self buttonAtPoint:CGPointMake( self.bounds.size.width - 100, 60)];
        [_flashButton setImage:[UIImage imageNamed:@"tool_fanhui"] forState:(UIControlStateNormal)];
        _flashButton.tag = 24;
        _flashButton.layer.borderColor = [UIColor lightGrayColor].CGColor;
        [_flashButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    }
    return _flashButton;
}

- (UIButton *)touchTypeButton
{
    if (!_touchTypeButton)
    {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setFrame:CGRectMake(0, 0, 120, 60)];
        button.center = CGPointMake(self.bounds.size.width - 50, self.bounds.size.height - 60);
        button.backgroundColor = [UIColor clearColor];
        _touchTypeButton = button;
        _touchTypeButton.transform = CGAffineTransformRotate(_touchTypeButton.transform, M_PI_2);
        _touchTypeButton.titleLabel.font = [UIFont systemFontOfSize:17];
        [_touchTypeButton setTitle:@"移动图片" forState:UIControlStateNormal];
    }
    return _touchTypeButton;
}

- (UIButton *)retakeButton
{
    if (!_retakeButton)
    {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setFrame:CGRectMake(0, 0, 120, 60)];
        button.center = CGPointMake(self.bounds.size.width - 50, 95);
        button.backgroundColor = [UIColor clearColor];
        _retakeButton = button;
        _retakeButton.transform = CGAffineTransformRotate(_retakeButton.transform, M_PI_2);
        [_retakeButton setImage:[UIImage imageNamed:@"jia0du_quxiao"] forState:(UIControlStateNormal)];
        _retakeButton.titleLabel.font = [UIFont systemFontOfSize:17];
        [_retakeButton setTitle:@"重新" forState:UIControlStateNormal];
    }
    return _retakeButton;
}

- (UIButton *)buttonAtPoint:(CGPoint)point
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setFrame:CGRectMake(0, 0, 60, 60)];
    button.center = point;
    button.backgroundColor = [UIColor clearColor];
    return button;
}

@end


@interface LCProtractorViewController ()

@property (nonatomic, strong) LYProtractorView *LyView;

@end

@implementation LCProtractorViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    }
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    _LyView = [[LYProtractorView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHight) frontCamera:NO];
    [self.view addSubview:_LyView];
    [_LyView.flashButton addTarget:self action:@selector(buttonClick) forControlEvents:(UIControlEventTouchUpInside)];
    _LyView.callback = ^(CGFloat from, CGFloat to, CGFloat angle) {
    };
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
