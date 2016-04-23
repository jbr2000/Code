//
//  PolygonsViewController.m
//  Polygons
//
//  Created by Spencer McWilliams on 2/21/13.
//  Copyright (c) 2013 Spencer McWilliams. All rights reserved.
//

#import "PolygonsViewController.h"
#import "PolygonView.h"

@interface PolygonsViewController ()

@property (weak, nonatomic) IBOutlet PolygonView *polygon;
@property (weak, nonatomic) IBOutlet UISlider *slider;
@property (weak, nonatomic) IBOutlet PolygonView *polygon2;

@end

@implementation PolygonsViewController

- (void)viewDidLoad
{
    
//    [NSTimer scheduledTimerWithTimeInterval:0.5
//                            target:self
//                          selector:@selector(changeSides)
//                          userInfo:nil
//                           repeats:YES];
    

}

- (void)changeSides
{
    self.polygon.numberOfSides++;
    
    self.slider.value = self.polygon.numberOfSides;
    
    

}
- (IBAction)swipeRight:(id)sender {
    self.polygon.numberOfSides++;
    self.slider.value = self.polygon.numberOfSides;
}

- (void)setPolygon:(PolygonView *)polygon
{
    _polygon = polygon;
    
    _polygon.numberOfSides = 5;
}

- (IBAction)sliderChanged:(UISlider *)sender
{
    self.polygon.numberOfSides = sender.value;
    self.polygon2.numberOfSides = sender.value;
}


@end
