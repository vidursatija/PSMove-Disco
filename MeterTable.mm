//
//  MeterTable.m
//  MoveMeterStudio
//
//  Created by Vidur Satija on 19/03/16.
//  Copyright © 2016 Aromatic Studios. All rights reserved.
//

#import "MeterTable.h"
#import <math.h>


@implementation MeterTable

double DbToAmp(double inDb)
{
    return pow(10., 0.05 * inDb);
}

float inMinDecibels = -80.0;
int inTableSize = 255;
float inRoot = 1.5;

float mMinDecibels = inMinDecibels;
float mDecibelResolution = mMinDecibels/ (inTableSize - 1);
float mScaleFactor = 1.0/mDecibelResolution;

float *mTable = (float*)malloc(inTableSize*sizeof(float));

double minAmp = DbToAmp(inMinDecibels);
double ampRange = 1.0 - minAmp;
double invAmpRange = 1.0 / ampRange;

double rroot = 1.0/inRoot;

int init()
{
    for (int i = 0; i < inTableSize; ++i) {
        double decibels = i * mDecibelResolution;
        double amp = DbToAmp(decibels);
        double adjAmp = (amp - minAmp) * invAmpRange;
        mTable[i] = pow(adjAmp, rroot);
    }
    return 0;
}

int a = init();

PSMove *move = psmove_connect_by_id(0);
//PSMove *move2 = psmove_connect_by_id(1);

+ (void) updateTracker:(float)level
{
    psmove_set_leds(move, level, 0, 255-level);
    psmove_update_leds(move);
    //psmove_set_leds(move2, 255-level, 0, level);
    //psmove_update_leds(move2);
    
}

+ (float) ValueAt: (float) inDecibels
{
    if (inDecibels < mMinDecibels) return  0.;
    if (inDecibels >= 0.) return 1.;
    int index = (int)(inDecibels * mScaleFactor);
    return mTable[index];
}



@end