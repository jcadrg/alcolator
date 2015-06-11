//
//  WhiskeyViewController.m
//  Alcolator
//
//  Created by Mac on 6/5/15.
//  Copyright (c) 2015 Mac. All rights reserved.
//

#import "WhiskeyViewController.h"

@interface WhiskeyViewController ()

@end

@implementation WhiskeyViewController

- (instancetype) init {
    self = [super init];
    if (self) {
        self.title = NSLocalizedString(@"Whiskey", nil);
        [self.tabBarItem setTitlePositionAdjustment:UIOffsetMake(0, -18)];
    }
    return self;
}


- (void) viewDidLoad {
    [super viewDidLoad];
    //self.title = NSLocalizedString(@"Whiskey", @"whiskey");
    self.view.backgroundColor = [UIColor colorWithRed:0.992 green:0.992 blue:0.588 alpha:1];
}


- (void)sliderValueDidChange:(UISlider *)sender {
    NSLog(@"Slider value changed to %f",sender.value);
    [self.beerPercentTextField resignFirstResponder];
    int beerCount=self.beerCountSlider.value;
    [self.tabBarItem setBadgeValue:[NSString stringWithFormat:@"%d",(int) sender.value]];
    
    NSString * beerCounterText;
    
    if(beerCount==1){
        beerCounterText= NSLocalizedString(@"beer", "singular beer");
    }else{
        beerCounterText=NSLocalizedString(@"beers", "plural of beer");
        
    }
    
    NSString *beerResultText =[NSString stringWithFormat:NSLocalizedString(@"%d %@", nil), beerCount,beerCounterText];
    self.beerResultLabel.text=beerResultText;
    
    int ouncesInOneBeerGlass=12;
    
    float alcoholPercentageOfBeer = [self.beerPercentTextField.text floatValue]/100;
    float ouncesOfAlcoholPerBeer = ouncesInOneBeerGlass * alcoholPercentageOfBeer;
    float ouncesOfAlcoholTotal = ouncesOfAlcoholPerBeer*beerCount;
    
    
    float ouncesInOneWhiskeyGlass = 1;
    float alcoholPercentageOfWhiskey = 0.4;
    
    float ouncesOfAlcoholPerWhiskeyGlass = ouncesInOneWhiskeyGlass*alcoholPercentageOfWhiskey;
    float numberOfWineGlassesForEquivalentAlcoholAmount = ouncesOfAlcoholTotal/ ouncesOfAlcoholPerWhiskeyGlass;
    
    NSString * beerText;
    
    if(beerCount==1){
        beerText= NSLocalizedString(@"beer", "singular beer");
    }else{
        beerText=NSLocalizedString(@"beers", "plural of beer");
        
    }
    
    NSString * whiskeyText;
    if(numberOfWineGlassesForEquivalentAlcoholAmount==1){
        whiskeyText=NSLocalizedString(@"shot", "singular shot");
    }else{
        whiskeyText=NSLocalizedString(@"shots", "plural of shot");
    }
    
    NSString *resultText =[NSString stringWithFormat:NSLocalizedString(@"%d %@ contains as much alcohol as %.1f %@ of whiskey.", nil), beerCount,beerText, numberOfWineGlassesForEquivalentAlcoholAmount,whiskeyText];
    self.resultLabel.text=resultText;
    
    
    
}




- (void)buttonPressed:(UIButton *)sender;
{
    [self.beerPercentTextField resignFirstResponder];
    
    int numberOfBeers = self.beerCountSlider.value;
    int ouncesInOneBeerGlass = 12;
    
    float alcoholPercentageOfBeer = [self.beerPercentTextField.text floatValue] / 100;
    float ouncesOfAlcoholPerBeer = ouncesInOneBeerGlass * alcoholPercentageOfBeer;
    float ouncesOfAlcoholTotal = ouncesOfAlcoholPerBeer * numberOfBeers;
    
    float ouncesInOneWhiskeyGlass = 1;
    float alcoholPercentageOfWhiskey = 0.4;
    
    float ouncesOfAlcoholPerWhiskeyGlass = ouncesInOneWhiskeyGlass * alcoholPercentageOfWhiskey;
    float numberOfWhiskeyGlassesForEquivalentAlcoholAmount = ouncesOfAlcoholTotal / ouncesOfAlcoholPerWhiskeyGlass;
    
    NSString *beerText;
    
    if (numberOfBeers == 1) {
        beerText = NSLocalizedString(@"beer", @"singular beer");
    } else {
        beerText = NSLocalizedString(@"beers", @"plural of beer");
    }
    
    NSString *whiskeyText;
    
    if (numberOfWhiskeyGlassesForEquivalentAlcoholAmount == 1) {
        whiskeyText = NSLocalizedString(@"shot", @"singular shot");
    } else {
        whiskeyText = NSLocalizedString(@"shots", @"plural of shot");
    }
    
    NSString *resultText = [NSString stringWithFormat:NSLocalizedString(@"%d %@ contains as much alcohol as %.1f %@ of whiskey.", nil), numberOfBeers, beerText, numberOfWhiskeyGlassesForEquivalentAlcoholAmount, whiskeyText];
    self.resultLabel.text = resultText;


}
@end
