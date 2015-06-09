//
//  ViewController.h
//  Alcolator
//
//  Created by Mac on 2/6/15.
//  Copyright (c) 2015 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (weak,nonatomic) UITextField *beerPercentTextField;
@property (weak, nonatomic) UILabel *resultLabel;
@property (weak,nonatomic) UISlider *beerCountSlider;
@property (weak, nonatomic) UILabel *beerResultLabel;

-(void) buttonPressed:(UIButton *)sender;


@end

