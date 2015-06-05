//
//  PackViewController.m
//  Express_Key
//
//  Created by Jan on 10/23/14.
//  Copyright (c) 2014 Jan. All rights reserved.
//

#import "PackViewController.h"
#import "CreateViewController.h"

#import <Social/Social.h>
#import <Accounts/Accounts.h>

@interface PackViewController ()

@end

@implementation PackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    NSLog(@"%@", self.model);
}

- (void)viewWillAppear:(BOOL)animated {
//    self.textView.text = self.model.packText;
    [self renderPage];
    
//    [self showFacebookView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)viewListPage:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}
- (IBAction)editExpress:(id)sender {
    [self  performSegueWithIdentifier:@"EditPack" sender:self.model];
}
- (IBAction)shareExpress:(id)sender {
    self.actView.hidden = NO;
    [self.actView startAnimating];
    [self showFacebookView];
//    [self.navigationController popToRootViewControllerAnimated:YES];
}

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"EditPack"])
    {
        CreateViewController * vc = [segue destinationViewController];
        vc.currentPack = (PackModel *)sender;
    }
    
}

- (void)renderPage {
    NSString *str = self.model.packText;
    self.txtViewList = [[NSMutableArray alloc] init];
    NSUInteger length = [str length];
    NSUInteger sublength = 0;
    NSRange range = NSMakeRange(0, length);
    NSString *tmpStr = @"";
    CGRect rect = self.containView.frame;
    rect.size.height = 40.0;
    rect.origin.x = 0;
    
    int i = 0;
    while(range.location != NSNotFound)
    {
        range = [str rangeOfString: @"<!--" options:0 range:range];
        if(range.location != NSNotFound)
        {
            i++;
            PackTextView *tmpView = [[PackTextView alloc] initWithFrame:rect];
            tmpView.text = [str substringToIndex:range.location];
            tmpView.parentView = self;
//            NSLog(@"1--------%@", tmpView.text);
            sublength = tmpView.text.length+4;
            [self.txtViewList addObject:tmpView];
            range = NSMakeRange(range.location + range.length, length - (range.location + range.length));
            
            range = [str rangeOfString: @"-->" options:0 range:range];
            if(range.location != NSNotFound)
            {
                PackTextView *tmpView1 = [[PackTextView alloc] initWithFrame:rect];
                tmpView1.parentView = self;
                tmpView1.text = [str substringToIndex:range.location];
                tmpView1.text = [tmpView1.text substringFromIndex:sublength];
                NSLog(@"2------%@:%@", tmpView1.text, str);
                tmpView1.isCompound = YES;
                [self.txtViewList addObject:tmpView1];
                range = NSMakeRange(range.location + range.length, length - (range.location + range.length));
                tmpStr = [str substringFromIndex:range.location];
            }
        } else {
            PackTextView *tmpView = [[PackTextView alloc] initWithFrame:rect];
            tmpView.parentView = self;
            NSLog(@"%@---%@------.......",str, tmpView.text);
            if (i) {
                tmpView.text = tmpStr;
            } else {
                tmpView.text = str;
            }
            
            [self.txtViewList addObject:tmpView];
        }
    }
    
    for (PackTextView *jTextView in self.txtViewList) {
        if (jTextView.isCompound) {
            jTextView.backgroundColor = [UIColor colorWithRed:209/255.0 green:238/255.0 blue:252/255.0 alpha:1.0];
            //            jTextView.backgroundColor = [UIColor blueColor];
            //            [jTextView.layer setBorderColor:[[[UIColor grayColor] colorWithAlphaComponent:0.5] CGColor]];
            //            [jTextView.layer setBorderWidth:2.0];
            
            //The rounded corner part, where you specify your view's corner radius:
            jTextView.layer.cornerRadius = 5;
            jTextView.clipsToBounds = YES;
//            jTextView.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
            jTextView.textAlignment = NSTextAlignmentCenter;
        } else {
            jTextView.backgroundColor = [UIColor clearColor];
        }
        
        jTextView.font = [UIFont fontWithName:@"HelveticaNeue" size:17.0];
        jTextView.editable = NO;
        jTextView.scrollEnabled = NO;
        [self.containView addSubview:jTextView];
    }
    
    int top = 10;
    for (PackTextView *xtxtView in self.txtViewList) {
        CGRect frame = xtxtView.frame;
        frame.size.height = xtxtView.contentSize.height+5;
        frame.origin.y = top;
        xtxtView.frame = frame;
        top += frame.size.height;
        
        CGFloat topoffset = ([xtxtView bounds].size.height - [xtxtView contentSize].height * [xtxtView zoomScale])/2.0;
        topoffset = ( topoffset < 0.0 ? 0.0 : topoffset );
        xtxtView.contentOffset = (CGPoint){.x = 0, .y = topoffset};
        //        xtxtView.backgroundColor = [UIColor redColor];
    }
}

- (void)touchPack {
    UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"Inform!" message:@"Use this within your favorite apps by installing the keyboard extension." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alertView show];
}


- (void)showFacebookView
{
//    if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook])
    {
        [self.actView stopAnimating];
        
        SLComposeViewController *mySLComposerSheet = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
        
        if (!mySLComposerSheet)
            return;
        
//        [mySLComposerSheet setInitialText:@"I want to share Potsticker expressions with you.\n 1.  Open Potsticker (Download URL:\n  https://itunes.apple.com/us/app/potsticker/id495268369)\n\n 2.  Copy everything below the dotted line. Paste into Potsticker.\n \"expression1\", \"expression2\", \"expression3\""];
        //        [mySLComposerSheet addURL:[NSURL URLWithString:Share_URL]];

        [mySLComposerSheet setInitialText:@"I want to share Potsticker expressions with you.\n 1.  Open Potsticker (Download URL:\n  https://itunes.apple.com/us/app/potsticker/id495268369)\n\n 2.  Copy everything below the dotted line. Paste into Potsticker.\n \"expression1\", \"expression2\", \"expression3\""];
//        [mySLComposerSheet addURL:[NSURL URLWithString:Share_URL]];

        [mySLComposerSheet setCompletionHandler:^(SLComposeViewControllerResult result) {
            
            switch (result) {
                case SLComposeViewControllerResultCancelled:
                    NSLog(@"Post Canceled");
                    break;
                case SLComposeViewControllerResultDone:
                    NSLog(@"Post Sucessful");
                    break;
                    
                default:
                    break;
            }
        }];
        
        [self presentViewController:mySLComposerSheet animated:YES completion:nil];
    }
}

@end
