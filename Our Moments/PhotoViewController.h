//
//  PhotoViewController.h
//  Our Moments
//
//  Created by Vu Le on 6/5/15.
//  Copyright (c) 2015 Vu Le. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PhotoViewController : UIViewController
- (IBAction)pickPhoto:(id)sender;

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end
