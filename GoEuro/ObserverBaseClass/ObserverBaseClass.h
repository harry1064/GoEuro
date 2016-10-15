//
//  ObserverBaseClass.h
//  JSQMessages
//
//  Created by Quinto Technologies Pvt. Ltd. on 29/03/16.
//  Copyright © 2016 Harpreet Singh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "AFNetworkReachabilityManager.h"
@interface ObserverBaseClass : UIViewController
- (void) reachabilityDidChange:(NSNotification *)notification;
@end
