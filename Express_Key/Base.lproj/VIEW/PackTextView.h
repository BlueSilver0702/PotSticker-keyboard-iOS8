//
//  PackTextView.h
//  Express_Key
//
//  Created by Jan on 10/26/14.
//  Copyright (c) 2014 Jan. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PackViewController;

@interface PackTextView : UITextView

@property(nonatomic, weak)PackViewController *parentView;
@property(nonatomic)bool isCompound;
@property(nonatomic)bool isCurrent;

@end
