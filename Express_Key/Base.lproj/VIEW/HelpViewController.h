//
//  HelpViewController.h
//  Express_Key
//
//  Created by Jan on 10/23/14.
//  Copyright (c) 2014 Jan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>

@interface HelpViewController : UIViewController <MFMailComposeViewControllerDelegate>

- (IBAction)viewListPage:(id)sender;
- (IBAction)openCQ:(id)sender;
- (IBAction)openLW:(id)sender;
- (IBAction)openB:(id)sender;
- (IBAction)openTekiki:(id)sender;
- (IBAction)openMailBox:(id)sender;

@end
