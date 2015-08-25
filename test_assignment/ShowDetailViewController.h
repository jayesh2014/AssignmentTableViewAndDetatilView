//
//  ShowDetailViewController.h
//  test_assignment
//
//  Created by mac on 8/24/15.
//  Copyright (c) 2015 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
@interface ShowDetailViewController : UIViewController
@property (strong, nonatomic) IBOutlet UILabel *lblForName;
@property (weak, nonatomic) IBOutlet UILabel *lblforNm;
@property (weak, nonatomic) IBOutlet UILabel *lblforEmail;
@property (weak, nonatomic) IBOutlet UILabel *lblForcompany;
@property (weak, nonatomic) IBOutlet UILabel *lblforcatchphrase;
@property (weak, nonatomic) IBOutlet UILabel *lblforbs;
@property (weak, nonatomic) IBOutlet UILabel *lblforId;

@property (weak, nonatomic) IBOutlet UILabel *lblforstreet;
@property (weak, nonatomic) IBOutlet UILabel *lblforsuite;

@property (weak, nonatomic) IBOutlet UILabel *lblforcity;
@property (weak, nonatomic) IBOutlet UILabel *lblforzip;
@property (weak, nonatomic) IBOutlet UIButton *lblForphNumber;
@property (weak, nonatomic) IBOutlet UIButton *lblforwebsite;

@property (strong, nonatomic) IBOutlet MKMapView *mapView;



- (IBAction)actiononwebsite:(id)sender;

- (IBAction)actiononPhno:(id)sender;
@property(nonatomic,strong)NSDictionary *dictforAddress;
//@property(nonatomic,strong)NSDictionary *dictforGeo;
@property(nonatomic,strong)NSDictionary *dictforcompany;
@property(nonatomic,strong)NSString *Uid;
@property(nonatomic,strong)NSString *name;
@property(nonatomic,strong)NSString *userName;
@property(nonatomic,strong)NSString *email;
@property(nonatomic,strong)NSString *phoneno;
@property(nonatomic,strong)NSString *website;
@end
