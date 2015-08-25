//
//  myModel.h
//  test_assignment
//
//  Created by mac on 8/24/15.
//  Copyright (c) 2015 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface myModel : NSObject
@property(nonatomic,strong)NSString *uid;
@property(nonatomic,strong)NSString *name;
@property(nonatomic,strong)NSString *userName;
@property(nonatomic,strong)NSString *email;
@property(nonatomic,strong)NSDictionary *dictforAddress;
//@property(nonatomic,strong)NSDictionary *dictforGeo;
@property(nonatomic,strong)NSDictionary *dictforcompany;

@property(nonatomic,strong)NSString *phoneno;
@property(nonatomic,strong)NSString *website;

@end
