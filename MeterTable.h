//
//  MeterTable.h
//  MoveMeterStudio
//
//  Created by Vidur Satija on 19/03/16.
//  Copyright © 2016 Aromatic Studios. All rights reserved.
//

#import <Foundation/Foundation.h>
#include "psmove.h"

@interface MeterTable : NSObject

+ (float) ValueAt: (float) inDecibels;
+ (void) updateTracker: (float) level;


@end
