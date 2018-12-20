//
//  DoActionSheet.h
//  TestActionSheet
//
//  Created by Donobono on 2014. 01. 01..
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

#define DO_RGB(r, g, b)     [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1]
#define DO_RGBA(r, g, b, a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]

// color set 3 -----------------------------------------------------------------------------
#define DO_AS_BACK_COLOR               DO_RGB(232, 229, 222)

// button background color
#define DO_AS_BUTTON_COLOR             DO_RGB(158, 132, 103)
#define DO_AS_CANCEL_COLOR             DO_RGB(240, 185, 103)
#define DO_AS_DESTRUCTIVE_COLOR        DO_RGB(124, 192, 134)

// button text color
#define DO_AS_TITLE_TEXT_COLOR         DO_RGB(95, 74, 50)
#define DO_AS_BUTTON_TEXT_COLOR        DO_RGB(255, 255, 255)
#define DO_AS_CANCEL_TEXT_COLOR        DO_RGB(255, 255, 255)
#define DO_AS_DESTRUCTIVE_TEXT_COLOR   DO_RGB(255, 255, 255)



#define DO_AS_DIMMED_COLOR         DO_RGBA(0, 0, 0, 0.7)

#define DO_AS_TITLE_FONT           [UIFont fontWithName:@"Avenir-Heavy" size:14]
#define DO_AS_BUTTON_FONT          [UIFont fontWithName:@"Avenir-Medium" size:14]

#define DO_AS_TITLE_INSET          UIEdgeInsetsMake(10, 20, 10, 20)
#define DO_AS_BUTTON_INSET         UIEdgeInsetsMake(5, 20, 5, 20)

#define DO_AS_BUTTON_HEIGHT        40
#define DO_AS_SCROLL_HEIGHT        300

#define DO_AS_CANCEL_TAG           -100

typedef NS_ENUM(int, DoAlertViewTransitionStyle) {
    DoASTransitionStyleNormal = 0,
    DoASTransitionStyleFade,
    DoASTransitionStylePop,
};

@class DoActionSheet;
typedef void(^DoActionSheetHandler)(int nResult);

@interface DoActionSheet : UIView <MKMapViewDelegate>
{
@private
    NSString                *_strTitle;
    NSString                *_strCancel;
    
    UIWindow                *_actionWindow;
    UIView                  *_vActionSheet;

    DoActionSheetHandler    _result;
    
    CGRect                  _rectActionSheet;
}

@property (readwrite)   int         nAnimationType;
@property (readwrite)   int         nContentMode;
@property (readwrite)   int         nDestructiveIndex;

@property (readwrite)   double      dRound;
@property (readwrite)   double      dButtonRound;

@property (readwrite)   BOOL        bDestructive;
@property (readonly)    int         nTag;

@property (strong, nonatomic)   NSArray         *aButtons;

// add content

// button background color
@property (strong, nonatomic)   UIColor         *doBackColor;
@property (strong, nonatomic)   UIColor         *doButtonColor;
@property (strong, nonatomic)   UIColor         *doCancelColor;
@property (strong, nonatomic)   UIColor         *doDestructiveColor;

// button text color
@property (strong, nonatomic)   UIColor         *doTitleTextColor;
@property (strong, nonatomic)   UIColor         *doButtonTextColor;
@property (strong, nonatomic)   UIColor         *doCancelTextColor;
@property (strong, nonatomic)   UIColor         *doDestructiveTextColor;

// dimmed color
@property (strong, nonatomic)   UIColor         *doDimmedColor;

// button font
@property (strong, nonatomic)   UIFont          *doTitleFont;
@property (strong, nonatomic)   UIFont          *doButtonFont;
@property (strong, nonatomic)   UIFont          *doCancelFont;

// insets
@property (readwrite)   UIEdgeInsets    doTitleInset;
@property (readwrite)   UIEdgeInsets    doButtonInset;

// button height
@property (readwrite)   CGFloat         doButtonHeight;


// with cancel button and other buttons
- (void)showC:(NSString *)strTitle
       cancel:(NSString *)strCancel
      buttons:(NSArray *)aButtons
       result:(DoActionSheetHandler)result;

@end
