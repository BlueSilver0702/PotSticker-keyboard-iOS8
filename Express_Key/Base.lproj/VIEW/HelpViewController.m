//
//  HelpViewController.m
//  Express_Key
//
//  Created by Jan on 10/23/14.
//  Copyright (c) 2014 Jan. All rights reserved.
//

#import "HelpViewController.h"

@interface HelpViewController ()

@end

@implementation HelpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (IBAction)viewListPage:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (IBAction)openCQ:(id)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString: @"http://tekiki.com/potsticker/faq"]];
}

- (IBAction)openLW:(id)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString: @"http://tekiki.com/potsticker/faq_artists"]];
}

- (IBAction)openB:(id)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString: @"http://twitter.com/search?q=%23potstickerapp"]];
}

- (IBAction)openTekiki:(id)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString: @"http://tekiki.com?s=potsticker"]];
}

- (IBAction)openMailBox:(id)sender {
    // Email Subject
    NSString *emailTitle = @"Potsticker feedback";
    // Email Content
    NSString *messageBody = @"";
    // To address
    NSArray *toRecipents = [NSArray arrayWithObject:@"info@panabee.com"];
    
    MFMailComposeViewController *mc = [[MFMailComposeViewController alloc] init];
    mc.mailComposeDelegate = self;
    [mc setSubject:emailTitle];
    [mc setMessageBody:messageBody isHTML:NO];
    [mc setToRecipients:toRecipents];
    
    // Present mail view controller on screen
    [self presentViewController:mc animated:YES completion:NULL];
    
}

- (void) mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    switch (result)
    {
        case MFMailComposeResultCancelled:
            NSLog(@"Mail cancelled");
            break;
        case MFMailComposeResultSaved:
            NSLog(@"Mail saved");
            break;
        case MFMailComposeResultSent:
            NSLog(@"Mail sent");
            break;
        case MFMailComposeResultFailed:
            NSLog(@"Mail sent failure: %@", [error localizedDescription]);
            break;
        default:
            break;
    }
    
    // Close the Mail Interface
    [self dismissViewControllerAnimated:YES completion:NULL];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
