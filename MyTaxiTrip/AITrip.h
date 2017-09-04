//
//  AITrip.h
//  MyTaxiTrip
//
//  Created by Asyl Isakov on 9/3/17.
//  Copyright © 2017 asyl. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

NS_ASSUME_NONNULL_BEGIN

@interface AITrip : NSManagedObject

@property (nullable, nonatomic, copy) NSString *address;
@property (nullable, nonatomic, copy) NSString *addressTo;
@property (nullable, nonatomic, copy) NSDate *date;
@property (nullable, nonatomic, copy) NSString *planName;
@property (nonatomic) int32_t rate;
@property (nonatomic) int64_t totalCost;
@property (nonatomic) int64_t totalDist;
@property (nonatomic) int64_t tripId;

- (BOOL) isRated;

@end

NS_ASSUME_NONNULL_END
