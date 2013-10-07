//
//  RottenGuavaTrailerViewController.m
//  RottenGuavas
//
//  Created by Gilad Goldberg on 10/7/13.
//  Copyright (c) 2013 Gilad Goldberg. All rights reserved.
//

#import "RottenGuavaTrailerViewController.h"
#import <MBProgressHUD/MBProgressHUD.h>
#import <Google-API-Client/GTLYouTube.h>

@interface RottenGuavaTrailerViewController ()
@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation RottenGuavaTrailerViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
	
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    GTLServiceYouTube *service = [[GTLServiceYouTube alloc] init];
    service.APIKey = @"AIzaSyDxQnQCQYKEmeZ48P0oRM4PQzLRZYIFR7s";
    
    GTLQueryYouTube *query = [GTLQueryYouTube queryForSearchListWithPart:@"id"];
    query.q = [NSString stringWithFormat:@"%@ trailer", self.movie.title];
    
    [service executeQuery:query completionHandler:^(GTLServiceTicket *ticket, id object, NSError *error) {
        if (!error) {
            GTLYouTubeSearchListResponse *response = (GTLYouTubeSearchListResponse*)object;
            
            // I'm feeling lucky
            NSString *firstVideoId = nil;
            for (GTLYouTubeSearchResult *result in response.items) {
                if ([result.identifier.kind isEqualToString:@"youtube#video"]) {
                    // Blech, bugs in YouTube ObjC API
                    firstVideoId = [[result.identifier JSON] objectForKey:@"videoId"];
                    break;
                }
            }
            
            if (firstVideoId) {
                NSLog(@"Got ID: %@", firstVideoId);
                NSString *embedURL = [NSString stringWithFormat:@"http://www.youtube.com/embed/%@", firstVideoId];
                
               
                NSString *html = @"\
                 <object>\
                 <param name=\"movie\" value=\"http://www.youtube.com/v/%@\"></param>\
                 <embed src=\"http://www.youtube.com/v/%@\" type=\"application/x-shockwave-flash\"></embed>\
                 </object>\
                ";
                
                html = [NSString stringWithFormat:html, firstVideoId, firstVideoId];
                [self.webView loadHTMLString:html baseURL:[NSURL URLWithString:embedURL]];
            }
            
            [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
            
        }
        else {
            NSLog(@"Error loading: %@", error.localizedDescription);
        }
    }];
}


@end
