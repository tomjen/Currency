//
//  CurrencyAppDelegate.h
//  Currency
//
//  Created by Tommy Jensen on 17/08/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CurrencyViewController;

@interface CurrencyAppDelegate : NSObject <UIApplicationDelegate> {

}

@property (nonatomic, retain) IBOutlet UIWindow *window;

@property (nonatomic, retain) IBOutlet CurrencyViewController *viewController;

@end
