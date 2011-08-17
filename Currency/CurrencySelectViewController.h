//
//  CurrencySelectViewController.h
//  Currency
//
//  Created by Tommy Jensen on 17/08/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface CurrencySelectViewController : UIViewController<UIPickerViewDataSource, UIPickerViewDelegate> {
    
    NSArray * currencies;
    IBOutlet UIPickerView *currencyPicker;
    IBOutlet UIActivityIndicatorView *active;
    IBOutlet UILabel *activeLabel;
}

@property NSString * selected;
@end
