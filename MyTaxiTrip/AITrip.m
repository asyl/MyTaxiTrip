//
//  AITrip.m
//  MyTaxiTrip
//
//  Created by Asyl Isakov on 9/3/17.
//  Copyright © 2017 asyl. All rights reserved.
//

#import "AITrip.h"

@implementation AITrip

@dynamic tripId;
@dynamic date;
@dynamic address;
@dynamic rate;

// Detail
@dynamic addressTo;
@dynamic totalCost;
@dynamic totalDist;
@dynamic planName;

- (BOOL)isRated {
  return self.rate > 0;
}

@end
