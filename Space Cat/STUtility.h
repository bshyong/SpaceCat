//
//  STUtility.h
//  Space Cat
//
//  Created by Benjamin Shyong on 8/15/14.
//  Copyright (c) 2014 ShyongTech. All rights reserved.
//

#import <Foundation/Foundation.h>

static const int STProjectileSpeed = 400;
static const int STSpaceDogMinSpeed = -100;
static const int STSpaceDogMaxSpeed = -50;

typedef NS_OPTIONS(uint32_t, STCollisionCategory){
  STCollisionCategoryEnemy = 1 << 0,
  STCollisionCategoryProjectile = 1 << 1,
  STCollisionCategoryDebris = 1 << 2,
  STCollisionCategoryGround = 1 << 3
};

@interface STUtility : NSObject
+ (NSInteger)randWithMin:(NSInteger)min max:(NSInteger)max;
@end
