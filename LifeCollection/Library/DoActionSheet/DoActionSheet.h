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
#define DO_AS_BACK_COLOR               DO_RGB(244, 244, 247)

// button background color
#define DO_AS_BUTTON_COLOR             DO_RGB(52, 152, 219)
#define DO_AS_CANCEL_COLOR             DO_RGB(231, 76, 60)

// button text color
#define DO_AS_TITLE_TEXT_COLOR         DO_RGB(113, 120, 150)
#define DO_AS_BUTTON_TEXT_COLOR        DO_RGB(255, 255, 255)
#define DO_AS_CANCEL_TEXT_COLOR        DO_RGB(255, 255, 255)

#define DO_AS_DIMMED_COLOR         DO_RGBA(0, 0, 0, 0.6)

#define DO_AS_TITLE_FONT           LCFont(16)
#define DO_AS_BUTTON_FONT          LCFont(16)

#define DO_AS_TITLE_INSET          UIEdgeInsetsMake(15, 20, 15, 20)
#define DO_AS_BUTTON_INSET         UIEdgeInsetsMake(10, 20, 10, 20)

#define DO_AS_BUTTON_HEIGHT        50

#define DO_AS_CANCEL_TAG           -100

@class DoActionSheet;
typedef void(^DoActionSheetHandler)(int nResult);

@interface DoActionSheet : UIView <MKMapViewDelegate>{
@private
    NSString                *_strTitle;
    NSString                *_strCancel;
    UIWindow                *_actionWindow;
    UIView                  *_vActionSheet;
    DoActionSheetHandler    _result;
}

@property (strong, nonatomic)   NSArray         *aButtons;

// insets
@property (readwrite)   UIEdgeInsets    doTitleInset;
@property (readwrite)   UIEdgeInsets    doButtonInset;


// with cancel button and other buttons
- (void)showC:(NSString *)strTitle
       cancel:(NSString *)strCancel
      buttons:(NSArray *)aButtons
       result:(DoActionSheetHandler)result;

@end
