//
//  Select_Week.m
//  ELAR
//
//  Created by Bhushan Bawa on 05/03/16.
//  Copyright © 2016 PICNFRAMES TECHNOLOGIES. All rights reserved.
//

#import "Select_Week.h"
#import "NSString+HTML.h"

#import "NSString+HTML.h"
#import "NSString+FontAwesome.h"
#import "UIImage+FontAwesome.h"
@interface Select_Week ()

@end

@implementation Select_Week

@synthesize values;
@synthesize Main_values;
@synthesize Sub_values;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    check_values_tableview=false;
    
    get_id_Group=[[NSMutableArray alloc]init];
    
    
    self.navigationController.navigationBarHidden=NO;
    
    mtable_view=[[UITableView alloc]init];
    mtable_view.frame=CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    mtable_view.delegate=self;
    mtable_view.dataSource=self;
    [self.view addSubview:mtable_view];
//    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone
//                                                                                target:self
//                                                                                action:@selector(doneEditing)];

    
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithTitle:[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Done" value:@"" table:nil] style:UIBarButtonItemStylePlain target:self
                                                                  action:@selector(doneEditing)];

    [[self navigationItem] setRightBarButtonItem:doneButton];
    
    
    
}

- (void)doneEditing {
    
    
    [[NSNotificationCenter defaultCenter]
     postNotificationName:_notification
     object:select_value];

    
    [self.navigationController popViewControllerAnimated:YES];
    
    
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return  44;
}


-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
   
    
    select_value=[NSString stringWithFormat:@"%ld",(long)indexPath.row+1];
    
    
        [tableView cellForRowAtIndexPath:indexPath].accessoryType = UITableViewCellAccessoryNone;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
     select_value=[NSString stringWithFormat:@"%ld",(long)indexPath.row+1];
    
    [mtable_view reloadData];
                
    UITableViewCell *cell = [mtable_view cellForRowAtIndexPath:indexPath];
    cell.accessoryType = UITableViewCellAccessoryCheckmark;
                
                
         }

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [Main_values integerValue];
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"newFriendCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    NSArray *views=[cell.contentView subviews];
    for(int i=0;i<[views count];i++)
    {
        UIView *tempView=[views objectAtIndex:i];
        [tempView removeFromSuperview];
        tempView = nil;
    }
    
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
        
        
cell.accessoryType = UITableViewCellAccessoryNone;
                

cell.textLabel.text=[NSString stringWithFormat:@"%ld",indexPath.row+1];
    
    
    return cell;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end
