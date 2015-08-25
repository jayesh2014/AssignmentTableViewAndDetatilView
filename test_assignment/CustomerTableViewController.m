//
//  CustomerTableViewController.m
//  test_assignment
//
//  Created by mac on 8/24/15.
//  Copyright (c) 2015 mac. All rights reserved.
//

#import "CustomerTableViewController.h"
#import "ShowDetailViewController.h"
#import "customCell.h"
#import "myModel.h"
@interface CustomerTableViewController ()
{
    NSMutableArray *Users;
}
@end

@implementation CustomerTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title=@"All Users";
    [self getLatestusers];
    
    self.refreshControl = [[UIRefreshControl alloc] init];
    self.refreshControl.backgroundColor = [UIColor purpleColor];
    self.refreshControl.tintColor = [UIColor whiteColor];
    [self.refreshControl addTarget:self
                            action:@selector(getLatestusers)
                  forControlEvents:UIControlEventValueChanged];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)getLatestusers
{
    NSURL *url=[NSURL URLWithString:@"http://jsonplaceholder.typicode.com/users"];
    [NSURLConnection sendAsynchronousRequest:[[NSURLRequest alloc] initWithURL:url] queue:[[NSOperationQueue alloc] init] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
        
        if (!error) {
            NSArray *latestuser = [self fetchData:data];
            Users = [NSMutableArray arrayWithCapacity:10];
            
            if (latestuser) {
                for (NSDictionary *loanDic in latestuser) {
                    myModel *userInfo = [[myModel alloc] init];
                    userInfo.uid = [[loanDic objectForKey:@"id"] stringValue];
                    userInfo.name = [loanDic objectForKey:@"name"];
                    userInfo.userName = [loanDic objectForKey:@"username"];
                    userInfo.email = [loanDic objectForKey:@"email"];
                    userInfo.dictforAddress=[loanDic objectForKey:@"address"];
                    userInfo.dictforcompany=[loanDic objectForKey:@"company"];
                    userInfo.phoneno=[loanDic objectForKey:@"phone"];
                    userInfo.website=[loanDic objectForKey:@"website"];
                    [Users addObject:userInfo];
                }
            }
            
            // As this block of code is run in a background thread, we need to ensure the GUI
            // update is executed in the main thread
            [self performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:NO];
            
        }
    }];
}


- (NSArray *)fetchData:(NSData *)response
{
    NSError *error = nil;
    NSMutableArray *parsedData = [NSJSONSerialization JSONObjectWithData:response options:0 error:&error];
    
    if (error != nil) {
        NSLog(@"Error: %@", error.description);
        return nil;
    }
    
    NSArray* latestuser = [parsedData copy];//[parsedData objectForKey:@"address"];
    
    return latestuser;
}

//- (void)reloadData
//{
//    // Reload table data
//    [self.tableView reloadData];
//    
//}

- (void)reloadData
{
    // Reload table data
    [self.tableView reloadData];
    
    // End the refreshing
    if (self.refreshControl) {
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"MMM d, h:mm a"];
        NSString *title = [NSString stringWithFormat:@"Last update: %@", [formatter stringFromDate:[NSDate date]]];
        NSDictionary *attrsDictionary = [NSDictionary dictionaryWithObject:[UIColor whiteColor]
                                                                    forKey:NSForegroundColorAttributeName];
        NSAttributedString *attributedTitle = [[NSAttributedString alloc] initWithString:title attributes:attrsDictionary];
        self.refreshControl.attributedTitle = attributedTitle;
        
        [self.refreshControl endRefreshing];
    }
}
//



// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}



// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        NSMutableArray *userarray=[Users mutableCopy];
        [userarray removeObjectAtIndex:indexPath.row];
        Users=[userarray mutableCopy];
        
        
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}


/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    
    // Make sure your segue name in storyboard is the same as this line
    if ([[segue identifier] isEqualToString:@"ShowDetail"])
    {
        
          NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        NSLog(@"indexpath=%d",indexPath.row);
        myModel *ur = [Users objectAtIndex:indexPath.row];
       
        // Get reference to the destination view controller
        ShowDetailViewController *vc = [segue destinationViewController];
        
        // Pass any objects to the view controller here, like...
        vc.userName=ur.userName;
        vc.Uid=ur.uid;
        vc.name=ur.name;
        vc.email=ur.email;
        vc.dictforcompany=ur.dictforcompany;
        vc.dictforAddress=ur.dictforAddress;
        vc.phoneno=ur.phoneno;
        vc.website=ur.website;
        //[vc setMyObjectHere:object];
    }
    // Pass the selected object to the new view controller.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    if (Users) {
        return [Users count];
    }
    
    return 0;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    customCell *cell = (customCell*)[tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    // Configure the cell...
    myModel *ur = [Users objectAtIndex:indexPath.row];
    cell.lblcid.text = (NSString*)ur.uid;
    cell.lblName.text = ur.name;
    cell.userName.text = ur.userName;
    cell.lblEmail.text = ur.email;
    
    return cell;
}

@end
