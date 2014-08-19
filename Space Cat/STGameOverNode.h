//
//  STGameOverNode.h
//  Space Cat
//
//  Created by Benjamin Shyong on 8/19/14.
//  Copyright (c) 2014 ShyongTech. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface STGameOverNode : SKSpriteNode
+ (instancetype) gameOverAtPosition:(CGPoint)position;
- (void)performAnimation;
@end
