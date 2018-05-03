//
//  TermOfUseViewController.m
//  Smart Classroom Manager
//
//  Created by Muthukumar on 21/04/18.
//  Copyright © 2018 PICNFRAMES TECHNOLOGIES. All rights reserved.
//

#import "TermOfUseViewController.h"
#import "API.h"
#import "Utilities.h"
#import "TermModel.h"
#import "TermCell.h"
#import "Remember_Me_ViewController.h"
#import "ELR_loaders_.h"
#import "ReachabilityManager.h"

#define TERM_OF_CONDITION_URL @"https://dev.elar.se/mobile_api/get_userterms_formobile"


@interface TermOfUseViewController ()<NSURLSessionDelegate,NSXMLParserDelegate>
@property(nonatomic, strong) NSString *customer_name;
@property(nonatomic) BOOL isDecline;
@property (nonatomic) NSMutableArray * array;
@property (nonatomic) NSMutableArray *selected_array;
@property (nonatomic) NSMutableArray *arrary_id;
@property (nonatomic) NSMutableArray *descriptionArray;
@property (nonatomic) UIImageView *loader_image;

@property (retain, nonatomic) NSString *string_url;
@end

@implementation TermOfUseViewController
@synthesize tableView;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.loader_image=[ELR_loaders_ Start_loader:CGRectMake(([[UIScreen mainScreen]bounds].size.width-85)/2,[[UIScreen mainScreen]bounds].size.height/2,85,85)];
    [self.view addSubview:self.loader_image];

    
    NSMutableDictionary *dic=[[NSMutableDictionary alloc]init];
    self.arrary_id = [[NSMutableArray alloc] init];
    self.descriptionArray = [[NSMutableArray alloc] init];

    _selected_array = [[NSMutableArray alloc] init];
    [dic setValue:@"H67jdS7wwfh" forKey:@"securityKey"];
    [dic setValue:[[NSUserDefaults standardUserDefaults]valueForKey:@"user_id"] forKey:@"loginUserID"];
    [dic setValue:@"ios" forKey:@"platform"];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    self.tableView.estimatedRowHeight = 100.0;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    [_accept_Button setEnabled:NO];
    [_decline_button setEnabled:NO];


    NSMutableDictionary *dicdddd=[[NSMutableDictionary alloc]init];
    [dicdddd setValue:@"H67jdS7wwfh" forKey:@"securityKey"];
    [dicdddd setValue:[[NSUserDefaults standardUserDefaults]valueForKey:@"user_id"] forKey:@"loginUserID"];
    [dicdddd setValue:@"ios" forKey:@"platform"];
    
    self.string_url = @"https://dev.elar.se/mobile_api/get_userterms_formobile";
    
    if ([[ReachabilityManager sharedManager]isReachable]) {
        [self webserviceFordate:dicdddd withURL:self.string_url];

    }else{
        [[ReachabilityManager sharedManager]showAlertForNoInternetNotification];
    }
    
    [self.tableView reloadData];
    
    [_accept_Button setTitle:[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Accept" value:@"" table:nil] forState:UIControlStateNormal];
    
     [_decline_button setTitle:[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Decline" value:@"" table:nil] forState:UIControlStateNormal];
     [_logOut_button setTitle:[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Log out" value:@"" table:nil] forState:UIControlStateNormal];
    
    
    [_termsOfUseLabel setText:[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Terms of use" value:@"" table:nil]];
    [_termsOfUseSubLabel setText:[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"To proceed to the platform you need to accept our new terms of service." value:@"" table:nil]];
    
    // Do any additional setup after loading the view from its nib.
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    self.navigationController.navigationBar.hidden = true;
}
-(void) webserviceFordate : (NSDictionary *)dicdddd withURL:(NSString *)str_url  {
    
    NSError * error;
    
    
    //    NSDictionary *body = @{@"snippet": @{@"topLevelComment":@{@"snippet":@{@"textOriginal":self.commentToPost.text}},@"videoId":self.videoIdPostingOn}};
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration delegate:self delegateQueue:nil];
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@",str_url]];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                       timeoutInterval:60.0];
    
    [request addValue:@"application/json" forHTTPHeaderField:@ "Content-Type"];
    [request addValue:@"application/json" forHTTPHeaderField:@"Accept"];
    
    [request setHTTPMethod:@"POST"];
    
    NSData *postData = [NSJSONSerialization dataWithJSONObject:dicdddd options:0 error:&error];
    [request setHTTPBody:postData];
    
    
    NSURLSessionDataTask *postDataTask = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (data != nil || data == NULL) {
            NSMutableDictionary* dictionaryreceived = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                if(dictionaryreceived != nil){
                    if([self.string_url isEqualToString:@"https://dev.elar.se/mobile_api/get_userterms_formobile"]) {
                        
                        NSInteger isTrue = [[dictionaryreceived objectForKey:@"status"] integerValue];
                        if (isTrue) {
                           self.customer_name = [NSString stringWithFormat:@"%@",[dictionaryreceived objectForKey:@"customer_name"]];
                            [self parseResponse:[dictionaryreceived objectForKey:@"term_list"]];

                        }else {
                            Remember_Me_ViewController *objRemember_Me_ViewController=[[Remember_Me_ViewController alloc]init];
                            [self.navigationController pushViewController:objRemember_Me_ViewController animated:YES];
                        }
                    }else if ([self.string_url isEqualToString:@"https://dev.elar.se/mobile_api/save_term_details"]) {
                            if(!_isDecline) {
                                [self mStopIndicater];

                                appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
                                [appDelegate LOg_in];
                                 
                            }else{
                                [self mStopIndicater];

                                appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
                                [appDelegate LOg_Out];
                            }
                        }
                }
                
            });
        }
    }];
    
    [postDataTask resume];
    
}

- (void)parseResponse: (NSMutableArray *)arrar_termofuse {
    
    self.array = [[NSMutableArray alloc] init];
    
    for (int i =0; i<arrar_termofuse.count; i++) {
        NSMutableDictionary *dic = [[arrar_termofuse objectAtIndex:i] objectForKey:@"UserTerm"];

        [self.descriptionArray addObject:[self replaceCustomNameByValidString:[dic objectForKey:@"term_description"] withValidString:self.customer_name]];
        [self.arrary_id addObject:[dic objectForKey:@"id"]];
        [self.array addObject:[[dic objectForKey:@"term_title"]capitalizedString]];
    }
    [self.tableView reloadData];
    [self mStopIndicater];

}

-(NSString *)replaceCustomNameByValidString:(NSString *)str withValidString:(NSString *)validStr{
    
    NSString *validatedStr;
    NSRange tldr = [str rangeOfString:@"_CUSTOMER_NAME_"];
    if (tldr.location != NSNotFound) {

        NSString *removeOpenBracket=[str stringByReplacingOccurrencesOfString:@"{" withString:@""];
        NSString *removeCloseBracket=[removeOpenBracket stringByReplacingOccurrencesOfString:@"}" withString:@""];
        validatedStr=[removeCloseBracket stringByReplacingOccurrencesOfString:@"_CUSTOMER_NAME_" withString:validStr];

    }else{
        return str;
    }
    return validatedStr;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)theTableView
{
    NSInteger noFSection = self.array.count ?   self.array.count+1 : 0;
    return noFSection;
}

- (NSInteger)tableView:(UITableView *)theTableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger noFSection = self.array.count ?   self.array.count : 0;
    if (section == noFSection) {
        return self.array.count;
    }
    
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    NSInteger noFSection = self.array.count ?   self.array.count : 0;
    if (indexPath.section == noFSection) {
       return 40.0;
    }
    return UITableViewAutomaticDimension;
}


// the cell will be returned to the tableView
- (UITableViewCell *)tableView:(UITableView *)theTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TermCell *termCell;
    NSInteger noFSection = self.array.count ?   self.array.count : 0;

    if (indexPath.section == noFSection) {
        
        termCell= (TermCell *)[theTableView dequeueReusableCellWithIdentifier: @"Cell1"];
        
        termCell.titleForCheckBox.text = [self convertEntiesInString:[self.array objectAtIndex:indexPath.row]];;
        
        
        if ([_selected_array containsObject:@(indexPath.row)]){
             [termCell.checkButton setBackgroundImage:[UIImage imageNamed:@"click.png"] forState:UIControlStateNormal];
            [termCell.checkButton setSelected:YES];
            
        }
        else{
           [termCell.checkButton setBackgroundImage:[UIImage imageNamed:@"nonclick20*20.png"] forState:UIControlStateNormal];
            [termCell.checkButton setSelected:NO];

        }
    }
    else{
        
        termCell= (TermCell *)[theTableView dequeueReusableCellWithIdentifier: @"Cell"];
        termCell.textLabel.text = [self convertEntiesInString:[self.array objectAtIndex:indexPath.section]];
        termCell.detailTextLabel.text = [self convertEntiesInString:[self.descriptionArray objectAtIndex:indexPath.section]];
        
        termCell.layer.cornerRadius = 10.0f;
        termCell.layer.borderWidth  = 0.4f;
        termCell.layer.masksToBounds = YES;
        termCell.backgroundColor = [UIColor whiteColor];
        termCell.layer.borderColor  = [UIColor grayColor].CGColor;
        termCell.layer.shadowRadius = 10.0;
    }
 
    return termCell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    //this is the space
    return 5.0;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    NSInteger noFSection = self.array.count ?   self.array.count : 0;

    
    if (section == noFSection) {
        return 40.0;
    }
    return 0.0;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    TermCell *cellAtindexPath = [tableView cellForRowAtIndexPath:indexPath];
    if ([[cellAtindexPath.checkButton backgroundImageForState:UIControlStateNormal] isEqual:[UIImage imageNamed:@"click.png"]]){
        [cellAtindexPath.checkButton setBackgroundImage:[UIImage imageNamed:@"nonclick20*20.png"] forState:UIControlStateNormal];
        [_selected_array removeObject:@(indexPath.row)];

    }else {
        [cellAtindexPath.checkButton setBackgroundImage:[UIImage imageNamed:@"click.png"] forState:UIControlStateNormal];

        [_selected_array addObject:@(indexPath.row)];
    }
    
    
    if (_selected_array.count == _array.count) {
        [_accept_Button setEnabled:YES];
        [_decline_button setEnabled:YES];
        
        [_decline_button setBackgroundColor:[UIColor colorWithRed:241.0/255.0 green:90.0/255.0 blue:107.0/255.0 alpha:1.0]];
        [_accept_Button setBackgroundColor:[UIColor colorWithRed:90.0/255.0 green:187.0/255.0 blue:84.0/255.0 alpha:1.0]];
    }else{
        [_accept_Button setEnabled:NO];
        [_decline_button setEnabled:NO];
        
        [_decline_button setBackgroundColor:[UIColor grayColor]];
        [_accept_Button setBackgroundColor:[UIColor grayColor]];
    }
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *sectionHeaderView;
    NSInteger noFSection = self.array.count ?   self.array.count : 0;
    sectionHeaderView = [[UIView alloc] initWithFrame:
                         CGRectMake(12, 0, tableView.frame.size.width-44, 120.0)];
    
    
    
    UILabel *headerLabel = [[UILabel alloc] initWithFrame:
                            CGRectMake(sectionHeaderView.frame.origin.x,sectionHeaderView.frame.origin.y - 44, sectionHeaderView.frame.size.width, sectionHeaderView.frame.size.height)];
    
    if (section == noFSection) {
        [headerLabel setText:[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"I have read and accepting the following terms of service:" value:@"" table:nil]];
        [headerLabel setFont:[UIFont systemFontOfSize:12.0]];
        [headerLabel setNumberOfLines:0];
        [headerLabel setTextAlignment:NSTextAlignmentRight];
        [sectionHeaderView addSubview:headerLabel];
        return sectionHeaderView;
    }
    
    return nil;
}

- (IBAction)accept:(UIButton *)sender {
    
    [self mStartIndicater];

    self.isDecline = NO;
    NSMutableString *selected_string = [[NSMutableString alloc] init];
    for (int i= 0; i<_selected_array.count; i++) {
        
        NSInteger path = [[_selected_array objectAtIndex:i] integerValue] ;
        [selected_string appendString:[NSString stringWithFormat:@"%@", [_arrary_id objectAtIndex:path]]];

        if (_selected_array.count-1 == i) {
        }else{
            [selected_string appendString:@","];
        }
    }
    
    
    NSMutableDictionary *dicdddd=[[NSMutableDictionary alloc]init];
    [dicdddd setValue:@"H67jdS7wwfh" forKey:@"securityKey"];
    [dicdddd setValue:[[NSUserDefaults standardUserDefaults]valueForKey:@"user_id"] forKey:@"loginUserID"];
    [dicdddd setValue:@"ios" forKey:@"platform"];
    [dicdddd setValue:selected_string forKey:@"accepted_term"];
    [dicdddd setValue:@"yes" forKey:@"accept_status"];
    self.string_url = @"https://dev.elar.se/mobile_api/save_term_details";
    [self webserviceFordate:dicdddd withURL:self.string_url];
    
    
}
- (IBAction)decline:(id)sender {
    
    [self mStartIndicater];

    self.isDecline = YES;

    NSMutableString *selected_string = [[NSMutableString alloc] init];
    for (int i= 0; i<_selected_array.count; i++) {
        
        NSInteger path = [[_selected_array objectAtIndex:i] integerValue] ;
        
        [selected_string appendString:[NSString stringWithFormat:@"%@", [_arrary_id objectAtIndex:path]]];
        if (_selected_array.count-1 == i) {
        }else{
            [selected_string appendString:@","];
        }
    }
    
    NSMutableDictionary *dicdddd=[[NSMutableDictionary alloc]init];
    [dicdddd setValue:@"H67jdS7wwfh" forKey:@"securityKey"];
    [dicdddd setValue:[[NSUserDefaults standardUserDefaults]valueForKey:@"user_id"] forKey:@"loginUserID"];
    [dicdddd setValue:@"ios" forKey:@"platform"];
    [dicdddd setValue:selected_string forKey:@"accepted_term"];
    [dicdddd setValue:@"no" forKey:@"accept_status"];
    self.string_url = @"https://dev.elar.se/mobile_api/save_term_details";
    [self webserviceFordate:dicdddd withURL:@"https://dev.elar.se/mobile_api/save_term_details"];
   
    
    
}


- (IBAction)logout:(UIButton *)sender {
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [appDelegate LOg_Out];
    
}


- (NSString*)convertEntiesInString:(NSString*)htmlString {
 
    NSData *stringData = [htmlString dataUsingEncoding:NSUTF8StringEncoding];
    
    NSDictionary *options = @{NSDocumentTypeDocumentAttribute:NSHTMLTextDocumentType};
    NSAttributedString *decodedString;
    decodedString = [[NSAttributedString alloc] initWithData:stringData
                                                     options:options
                                          documentAttributes:NULL
                                                       error:NULL];
    return decodedString.string;
}



#pragma mark - -*********************
#pragma mark Activity Indicater
#pragma mark - -*********************

-(void)mStartIndicater
{
    
    [self.loader_image setHidden:NO];
    
    
}

#pragma mark - -*********************
#pragma mark Stop Indicater
#pragma mark - -*********************

-(void)mStopIndicater
{
    [self.loader_image setHidden:YES];
    //    [loader_image removeFromSuperview];
    
    
    
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
