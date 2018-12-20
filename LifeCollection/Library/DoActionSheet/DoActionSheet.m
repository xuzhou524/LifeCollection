//
//  DoActionSheet.m
//  TestActionSheet
//
//  Created by Donobono on 2014. 01. 01..
//

#import "DoActionSheet.h"

#pragma mark - DoAlertViewController

@interface DoActionSheetController : UIViewController

@property (nonatomic, strong) DoActionSheet *actionSheet;

@end

@implementation DoActionSheetController

#pragma mark - View life cycle

- (void)viewDidLoad{
    [super viewDidLoad];
    self.view = _actionSheet;
}
@end

@implementation DoActionSheet

// with cancel button and other buttons
- (void)showC:(NSString *)strTitle
       cancel:(NSString *)strCancel
      buttons:(NSArray *)aButtons
       result:(DoActionSheetHandler)result{
    _strTitle   = strTitle;
    _strCancel  = strCancel;
    _aButtons   = aButtons;
    _result     = result;
    
    [self showActionSheet];
}

- (double)getTextHeight:(UILabel *)lbText{
    double dHeight = 0.0;
    NSDictionary *attributes = @{NSFontAttributeName:lbText.font};
    CGRect rect = [lbText.text boundingRectWithSize:CGSizeMake(lbText.frame.size.width, MAXFLOAT)
                                         options:NSStringDrawingUsesLineFragmentOrigin
                                      attributes:attributes
                                         context:nil];
    dHeight = ceil(rect.size.height);
    return dHeight;
}

- (void)setLabelAttributes:(UILabel *)lb{
    lb.backgroundColor = [UIColor clearColor];
    lb.textAlignment = NSTextAlignmentCenter;
    lb.numberOfLines = 0;
    
    lb.font = DO_AS_TITLE_FONT;
    lb.textColor = DO_AS_TITLE_TEXT_COLOR;
}

- (void)setButtonAttributes:(UIButton *)bt cancel:(BOOL)bCancel{
    bt.autoresizingMask = UIViewAutoresizingFlexibleWidth;

    if (bCancel){
        bt.backgroundColor = DO_AS_CANCEL_COLOR;
        bt.titleLabel.font = DO_AS_TITLE_FONT;
        [bt setTitleColor:DO_AS_CANCEL_TEXT_COLOR forState:UIControlStateNormal];
    }else{
        bt.backgroundColor = DO_AS_BUTTON_COLOR;
        bt.titleLabel.font = DO_AS_BUTTON_FONT;
        [bt setTitleColor:DO_AS_BUTTON_TEXT_COLOR forState:UIControlStateNormal];
    }
    CALayer *layer = [bt layer];
    [layer setMasksToBounds:YES];
    [layer setCornerRadius:3];
    [bt addTarget:self action:@selector(buttonTarget:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)showActionSheet{
    double dHeight = 0;
    self.backgroundColor = DO_AS_DIMMED_COLOR;

    // make back view -----------------------------------------------------------------------------------------------
    _vActionSheet = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 0)];
    _vActionSheet.backgroundColor = DO_AS_BACK_COLOR;
    [self addSubview:_vActionSheet];
    
    // Title --------------------------------------------------------------------------------------------------------
    if (_strTitle != nil && _strTitle.length > 0){
        if (self.doTitleInset.top == 0 && self.doTitleInset.left == 0 && self.doTitleInset.bottom == 0 && self.doTitleInset.right == 0) {
            self.doTitleInset = DO_AS_TITLE_INSET;
        }
        
        UILabel *lbTitle = [[UILabel alloc] initWithFrame:CGRectMake(self.doTitleInset.left, self.doTitleInset.top,
                                                                     _vActionSheet.frame.size.width - (self.doTitleInset.left + self.doTitleInset.right) , 0)];
        lbTitle.text = _strTitle;
        [self setLabelAttributes:lbTitle];
        lbTitle.frame = CGRectMake(self.doTitleInset.left, self.doTitleInset.top, lbTitle.frame.size.width, [self getTextHeight:lbTitle]);
        lbTitle.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        [_vActionSheet addSubview:lbTitle];
        
        dHeight = lbTitle.frame.size.height + self.doTitleInset.bottom;
    
    }else
        dHeight += self.doTitleInset.bottom;

    if (self.doButtonInset.top == 0 && self.doButtonInset.left == 0 && self.doButtonInset.bottom == 0 && self.doButtonInset.right == 0) {
        self.doButtonInset = DO_AS_BUTTON_INSET;
    }
    // add scrollview for many buttons and content
    UIScrollView *sc = [[UIScrollView alloc] initWithFrame:CGRectMake(0, dHeight + self.doButtonInset.top, 320, 370)];
    sc.backgroundColor = [UIColor clearColor];
    [_vActionSheet addSubview:sc];
    sc.autoresizingMask = UIViewAutoresizingFlexibleWidth;

    double dYContent = 0;

    dYContent += [self addContent:sc];
    if (dYContent > 0)
        dYContent += self.doButtonInset.bottom + self.doButtonInset.top;

    // add buttons
    int nTagIndex = 0;
    for (NSString *str in _aButtons){
        UIButton *bt = [UIButton buttonWithType:UIButtonTypeCustom];
        bt.tag = nTagIndex;
        [bt setTitle:str forState:UIControlStateNormal];
        
        [self setButtonAttributes:bt cancel:NO];
        bt.frame = CGRectMake(self.doButtonInset.left, dYContent,
                              _vActionSheet.frame.size.width - (self.doButtonInset.left + self.doButtonInset.right), DO_AS_BUTTON_HEIGHT);
        
        dYContent += DO_AS_BUTTON_HEIGHT + self.doButtonInset.bottom;
        
        [sc addSubview:bt];

        nTagIndex += 1;
   }
    
    sc.contentSize = CGSizeMake(sc.frame.size.width, dYContent);
    dHeight += self.doButtonInset.bottom + MIN(dYContent, sc.frame.size.height);
    
    // add Cancel button
    if (_strCancel != nil && _strCancel.length > 0){
        UIButton *bt = [UIButton buttonWithType:UIButtonTypeCustom];
        bt.tag = DO_AS_CANCEL_TAG;
        [bt setTitle:_strCancel forState:UIControlStateNormal];
        
        [self setButtonAttributes:bt cancel:YES];
        bt.frame = CGRectMake(self.doButtonInset.left, dHeight + self.doButtonInset.top + self.doButtonInset.bottom,
                              _vActionSheet.frame.size.width - (self.doButtonInset.left + self.doButtonInset.right),DO_AS_BUTTON_HEIGHT);
        
        dHeight += DO_AS_BUTTON_HEIGHT + (self.doButtonInset.top + self.doButtonInset.bottom) * 2;
        
        [_vActionSheet addSubview:bt];
    }else
        dHeight += self.doButtonInset.bottom;
    
    _vActionSheet.frame = CGRectMake(0, 0, _vActionSheet.frame.size.width, dHeight + 10);

    DoActionSheetController *viewController = [[DoActionSheetController alloc] initWithNibName:nil bundle:nil];
    viewController.actionSheet = self;
    
    if (!_actionWindow){
        UIWindow *window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
        window.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        window.opaque = NO;
        window.windowLevel = UIWindowLevelAlert;
        window.rootViewController = viewController;
        _actionWindow = window;
        
        self.frame = window.frame;
        _vActionSheet.center = window.center;
    }
    [_actionWindow makeKeyAndVisible];
    CALayer *layer = [_vActionSheet layer];
    [layer setMasksToBounds:YES];
    [layer setCornerRadius:3];
    [self showAnimation];
}

- (void)buttonTarget:(id)sender{
    _result([sender tag]);
    [self hideAnimation];
}

- (double)addContent:(UIScrollView *)sc{
    double dContentOffset = 0;
    if (self.doButtonInset.top == 0 && self.doButtonInset.left == 0 && self.doButtonInset.bottom == 0 && self.doButtonInset.right == 0) {
        self.doButtonInset = DO_AS_BUTTON_INSET;
    }
    return dContentOffset;
}

- (void)hideActionSheet{
    [self removeFromSuperview];
    [_actionWindow removeFromSuperview];
    _actionWindow = nil;
}

- (void)showAnimation{
    self.alpha = 0.0;
    _vActionSheet.frame = CGRectMake(0, self.bounds.size.height,
                                             self.bounds.size.width, _vActionSheet.frame.size.height + 3 + 5);
    [UIView animateWithDuration:0.2 animations:^(void) {
        self.alpha = 1.0;
        [UIView setAnimationDelay:0.1];
        _vActionSheet.frame = CGRectMake(0, self.bounds.size.height - _vActionSheet.frame.size.height + 15,
                                                 self.bounds.size.width, _vActionSheet.frame.size.height);
    } completion:nil];
}

- (void)hideAnimation{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIDeviceOrientationDidChangeNotification object:nil];

    [UIView animateWithDuration:0.2 animations:^(void) {

        _vActionSheet.frame = CGRectMake(0, self.bounds.size.height,
                                                 self.bounds.size.width, _vActionSheet.frame.size.height);
        [UIView setAnimationDelay:0.1];
        _vActionSheet.alpha = 0.0;
        self.alpha = 0.0;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.1 animations:^(void) {
            [UIView setAnimationDelay:0.1];
            _vActionSheet.frame = CGRectMake(0, self.bounds.size.height,
                                             self.bounds.size.width, _vActionSheet.frame.size.height);
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.1 animations:^(void) {
                [UIView setAnimationDelay:0.1];
                self.alpha = 0.0;
            } completion:^(BOOL finished) {
                [self hideActionSheet];
            }];
        }];
    }];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    CGPoint pt = [[touches anyObject] locationInView:self];
    if (CGRectContainsPoint(_vActionSheet.frame, pt))
        return;
    _result(DO_AS_CANCEL_TAG);
    [self hideAnimation];
}

@end
