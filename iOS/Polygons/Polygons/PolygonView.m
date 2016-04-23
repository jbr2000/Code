//
//  PolygonView.m
//  Polygons
//
//  Created by Spencer McWilliams on 2/21/13.
//  Copyright (c) 2013 Spencer McWilliams. All rights reserved.
//

#import "PolygonView.h"

@implementation PolygonView

- (void)setNumberOfSides:(NSUInteger)numberOfSides
{
    if (numberOfSides == 0)
        return;
    
    _numberOfSides = numberOfSides;
    
    [self setNeedsDisplay];
}

- (CGFloat)radius
{
    return MIN(self.bounds.size.width, self.bounds.size.height) / 2;
}

- (void)drawRect:(CGRect)rect
{
    UIBezierPath *roundedRect = [UIBezierPath bezierPathWithRoundedRect:self.bounds
                                                           cornerRadius:12];
    [roundedRect addClip];
    
    [[UIColor whiteColor] setFill];
    UIRectFill(self.bounds);
    
    [[UIColor blackColor] setStroke];
    [roundedRect stroke];
    
    
    
    
    
    
    [[UIColor redColor] setFill];
    
    UIBezierPath *polygonPath = [[UIBezierPath alloc] init];
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSaveGState(context);
    CGContextTranslateCTM(context, self.bounds.size.width/2, self.bounds.size.height/2);
    CGContextRotateCTM(context, -M_PI/2);
    
    [polygonPath moveToPoint:CGPointMake([self radius], 0)];
    
    for (int i = 1; i < self.numberOfSides; i++) {
        CGFloat x = [self radius] * cos(2 * M_PI * i / self.numberOfSides);
        CGFloat y = [self radius] * sin(2 * M_PI * i / self.numberOfSides);
        
        [polygonPath addLineToPoint:CGPointMake(x, y)];
    }
    
    [polygonPath closePath];
    [polygonPath fill];
    [polygonPath stroke];
    
    
    
    
    
    CGContextRestoreGState(context);
    
    
}


@end
