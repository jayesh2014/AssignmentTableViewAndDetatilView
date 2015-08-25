//
//  ShowDetailViewController.m
//  test_assignment
//
//  Created by mac on 8/24/15.
//  Copyright (c) 2015 mac. All rights reserved.
//

#import "ShowDetailViewController.h"
#import "MapPoint.h"
@interface ShowDetailViewController ()
{
    MKPinAnnotationView*  annotationView;
    NSString *strForaddress;

}
@end

@implementation ShowDetailViewController
@synthesize lblForName,lblforbs,lblforcatchphrase,lblforcity,lblForcompany,lblforEmail,lblforNm,lblForphNumber,lblforstreet,lblforsuite,lblforwebsite,lblforzip,lblforId,mapView;
- (void)viewDidLoad {
    [super viewDidLoad];
    lblForName.text=self.userName;
    lblforNm.text=self.name;
    lblforId.text=self.Uid;
    lblforEmail.text=self.email;
    lblForcompany.text=[self.dictforcompany objectForKey:@"name"];
    lblforcatchphrase.text=[self.dictforcompany objectForKey:@"catchPhrase"];
    lblforbs.text=[self.dictforcompany objectForKey:@"bs"];
    lblforstreet.text=[self.dictforAddress objectForKey:@"street"];
    lblforsuite.text=[self.dictforAddress objectForKey:@"suite"];
    lblforcity.text=[self.dictforAddress objectForKey:@"city"];
    lblforzip.text=[self.dictforAddress objectForKey:@"zipcode"];
    [lblForphNumber setTitle:self.phoneno forState:UIControlStateNormal];
    [lblforwebsite setTitle:self.website forState:UIControlStateNormal];
    
    
    strForaddress=nil;
    NSString *lat=[[self.dictforAddress objectForKey:@"geo"]objectForKey:@"lat"];
      NSString *log=[[self.dictforAddress objectForKey:@"geo"]objectForKey:@"lng"];
    // Do any additional setup after loading the view from its nib.
    
    strForaddress=[NSString stringWithFormat:@"%@ %@ %@ %@",lblforstreet.text,lblforsuite.text,lblforcity.text,lblforzip.text];
           [self updateMaps:lat longititude:log];
        
  

    // Do any additional setup after loading the view.
}



#pragma mark - adding pin on map in this method

- (void)updateMaps:(NSString*)lat longititude:(NSString*)lon {
    //6
    for (id<MKAnnotation> annotation in mapView.annotations)
    {
        NSLog(@" in for annotation ");
        if ([annotation isKindOfClass:[MapPoint class]])
        {
            NSLog(@"in if annotation");
            [mapView removeAnnotation:annotation];
        }
    }
    CLLocationCoordinate2D placeCoord;
    placeCoord.latitude=[lat doubleValue];
    placeCoord.longitude=[lon doubleValue];
    
    MapPoint *placeObject = [[MapPoint alloc] initWithName:strForaddress address:nil coordinate:placeCoord];
    
    [mapView addAnnotation:placeObject];
    MKCoordinateSpan span = {.latitudeDelta =  0.1009, .longitudeDelta =  0.1009};
    MKCoordinateRegion region = {placeCoord, span};
    [mapView setRegion:region];
    // [ListMap setCenterCoordinate:placeCoord animated:YES];
    
}
#pragma mark - MKMapView delegates

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation {
    
    
    static NSString *identifier = @"MapPoint";
    
    if ([annotation isKindOfClass:[MapPoint class]]) {
        
        annotationView = (MKPinAnnotationView *) [self.mapView dequeueReusableAnnotationViewWithIdentifier:identifier];
        if (annotationView == nil) {
            annotationView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:identifier];
        } else {
            annotationView.annotation = annotation;
        }
        
        annotationView.canShowCallout = YES;
        
        
        annotationView.image = [UIImage imageNamed:@"map2.png"];
        
        return annotationView;
    }
    
    return nil;
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

- (IBAction)actiononwebsite:(id)sender {
    NSString *url=[NSString stringWithFormat:@"https://www.%@",self.website];
           //[[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"www.google.com"]];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
}

- (IBAction)actiononPhno:(id)sender {
    NSString *phNo = self.phoneno;
    NSURL *phoneUrl = [NSURL URLWithString:[NSString  stringWithFormat:@"telprompt:%@",phNo]];
    
    if ([[UIApplication sharedApplication] canOpenURL:phoneUrl]) {
        [[UIApplication sharedApplication] openURL:phoneUrl];
    } else
    {
      UIAlertView  *calert = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"Call facility is not available!!!" delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
        [calert show];
    }
}
@end
