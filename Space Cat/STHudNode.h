//
//  STHudNode.h
//  Space Cat
//
//  Created by Benjamin Shyong on 8/19/14.
//  Copyright (c) 2014 ShyongTech. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface STHudNode : SKSpriteNode
@property (nonatomic) NSInteger lives;
@property (nonatomic) NSInteger score;

+ (instancetype)hudAtPosition:(CGPoint)position inFrame:(CGRect)frame;
@end
