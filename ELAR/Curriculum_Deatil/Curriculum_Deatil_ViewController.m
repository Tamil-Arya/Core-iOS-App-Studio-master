//
//  Curriculum_Deatil_ViewController.m
//  ELAR
//
//  Created by Bhushan Bawa on 04/12/15.
//  Copyright © 2015 PICNFRAMES TECHNOLOGIES. All rights reserved.
//

#import "Curriculum_Deatil_ViewController.h"
#import "Text_color_.h"
#import "NSString+FontAwesome.h"
#import "UIImage+FontAwesome.h"
#import "Font_Face_Controller.h"

@interface Curriculum_Deatil_ViewController ()

@end

@implementation Curriculum_Deatil_ViewController
@synthesize title;
@synthesize Detail;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBarHidden=YES;
    
    
    self.view.backgroundColor=[Text_color_ EDU_Blog_Color_code];
    
    
    
    //////////////////// Save_Draft No Button\\\\\\\\\\\\\\
    
    close_BTN = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [close_BTN addTarget:self
                   action:@selector(aMethod_delete)
         forControlEvents:UIControlEventTouchUpInside];
    //BTN_Save_Draft.backgroundColor=[UIColor colorWithRed:242.0f/255.0f green:158.0f/255.0f blue:195.0f/255.0f alpha:1.0];
    [close_BTN setTitle:[NSString fontAwesomeIconStringForIconIdentifier:@"fa-times"] forState:UIControlStateNormal];
    [close_BTN.titleLabel setFont:[UIFont fontWithName:@"FontAwesome" size:25]];
    [close_BTN setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    close_BTN.frame = CGRectMake(self.view.frame.size.width-40,20,40, 40);
    [self.view addSubview:close_BTN];
    

    
    
    
    ////////////////////  Left_Publish  Lable\\\\\\\\\\\\\\
    
    
    mtitle_LB=[[UILabel alloc]init];
    mtitle_LB.lineBreakMode = UILineBreakModeWordWrap;
    mtitle_LB.numberOfLines = 0;
    mtitle_LB.backgroundColor=[UIColor clearColor];
    mtitle_LB.text=[NSString stringWithFormat:@"%@- %@",[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Knowledge Area" value:@"" table:nil],title];
    
    [mtitle_LB sizeToFit];
    mtitle_LB.frame=CGRectMake(10,60,self.view.frame.size.width-20,100);
    mtitle_LB.textColor=[UIColor whiteColor];
       mtitle_LB.font=[Font_Face_Controller opensanssemibold:16];
    mtitle_LB.textAlignment=NSTextAlignmentCenter;
    [self.view addSubview:mtitle_LB];
    
    
    
    ////////////////////  Left_Publish  Lable\\\\\\\\\\\\\\
    
    
    mtext_View=[[UITextView alloc]init];
  
    mtext_View.editable=NO;
    
    mtext_View.backgroundColor=[UIColor clearColor];
    mtext_View.text=Detail;
    
    [mtext_View sizeToFit];
    mtext_View.frame=CGRectMake(10,mtitle_LB.frame.origin.y+mtitle_LB.frame.size.height,self.view.frame.size.width-20, 300);
    mtext_View.textColor=[UIColor whiteColor];
    mtext_View.font=[Font_Face_Controller opensansregular:16];
    mtext_View.textAlignment=NSTextAlignmentCenter;
    [self.view addSubview:mtext_View];


    
    
    
}

-(void)aMethod_delete

{
      [self dismissViewControllerAnimated:YES completion:nil];
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
