//
//  AIDetailViewModel.h
//  MyTaxiTrip
//
//  Created by Asyl Isakov on 9/4/17.
//  Copyright © 2017 asyl. All rights reserved.
//

#import <Foundation/Foundation.h>

@class AITrip;

@interface AIDetailViewModel : NSObject

@property (nonatomic, readonly) AITrip *model;

@property (nonatomic, readonly) NSString *tripDate;
@property (nonatomic, readonly) NSString *tripPlanName;
@property (nonatomic, readonly) NSString *tripCost;
@property (nonatomic, readonly) NSString *tripAddress;
@property (nonatomic, readonly) NSString *tripAddressTo;
@property (nonatomic, readonly) NSString *tripDist;
@property (nonatomic, readonly) NSString *tripRate;

- (instancetype)initWithModel:(id)model;

- (void)rateWith:(int32_t)rate;

@end
