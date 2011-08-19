//
//  CurrencySelectViewController.h
//  Currency
//
//  Created by Tommy Jensen on 17/08/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface CurrencySelectViewController : UIViewController<UIPickerViewDataSource, UIPickerViewDelegate, NSXMLParserDelegate> {
    
    NSMutableArray * currencies;
    IBOutlet UIPickerView *currencyPicker;
    IBOutlet UIActivityIndicatorView *active;
    IBOutlet UILabel *activeLabel;
    NSMutableData *data;
    IBOutlet UIPickerView *picker;
}

@property NSString * selected;

//private
-(void) parseXML;
@end
