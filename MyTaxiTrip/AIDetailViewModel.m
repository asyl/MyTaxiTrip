//
//  AIDetailViewModel.m
//  MyTaxiTrip
//
//  Created by Asyl Isakov on 9/4/17.
//  Copyright © 2017 asyl. All rights reserved.
//

#import "AIDetailViewModel.h"
#import "AITrip.h"

@interface AIDetailViewModel ()

@end


@implementation AIDetailViewModel

- (instancetype)initWithModel:(id)model {
  self = [super init];
  if (self) {
    _model = model;
  }
  return self;
}

- (NSString *)tripDate {
  NSDate *date = self.model.date;
  NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
  [formatter setDateFormat:@"h:mm a, MMM d yyy"];
  return [formatter stringFromDate:date];
}

- (NSString *)tripPlanName {
  return self.model.planName;
}

- (NSString *)tripCost {
  return [NSString stringWithFormat:@"%lld sum", self.model.totalCost];
}

- (NSString *)tripAddress {
  return self.model.address;
}

- (NSString *)tripAddressTo {
  return self.model.addressTo;
}

- (NSString *)tripDist {
  return [NSString stringWithFormat:@"%lld meters", self.model.totalDist];
}

- (NSString *)tripRate {
  if (self.model.rate > 0) {
    if (self.model.rate > 1) {
      return [NSString stringWithFormat:@"%d stars", self.model.rate];
    } else {
      return [NSString stringWithFormat:@"%d star", self.model.rate];
    }
  } else {
    return @"Not Rated";
  }
}

- (void)rateWith:(int32_t)rate {
  self.model.rate = rate;
  [self.model.managedObjectContext save:nil];
}

@end
