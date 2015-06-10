//
//  ViewController.m
//  Alcolator
//
//  Created by Mac on 2/6/15.
//  Copyright (c) 2015 Mac. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UITextFieldDelegate>



@property (weak, nonatomic) UIButton *calculateButton;
@property (weak, nonatomic) UITapGestureRecognizer *hideKeyboardTapGestureRecognizer;


@end

@implementation ViewController

-(void) loadView{
    //alloc and initialization the all encompassing view
    self.view=[[UIView alloc]init];
    
    //alloc and initialization of each view and the gesture recognizer
    UITextField *textField=[[UITextField alloc]init];
    UISlider *slider=[[UISlider alloc]init];
    UILabel *label = [[UILabel alloc] init];
    UIButton *button=[[UIButton alloc]init];
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]init];
    UILabel *beerLabel =[[UILabel alloc]init];
    
    //add views and gesture recognizer as a subview
    [self.view addSubview:textField];
    [self.view addSubview:slider];
    [self.view addSubview:label];
    [self.view addSubview:button];
    [self.view addGestureRecognizer:tap];
    [self.view addSubview:beerLabel];
    
    //assign views and gesture recognizer to properties
    self.beerPercentTextField=textField;
    self.beerCountSlider=slider;
    self.resultLabel = label;
    self.calculateButton=button;
    self.hideKeyboardTapGestureRecognizer=tap;
    self.beerResultLabel = beerLabel;
    
}

- (void)viewDidLoad {
    //superclass implementation
    [super viewDidLoad];
    
    self.view.backgroundColor=[UIColor lightGrayColor];
    
    
    self.beerPercentTextField.delegate=self;
    
    self.beerPercentTextField.placeholder = NSLocalizedString(@"% Alcohol Content Per Beer", @"Beer percent placeholder text");
    
    [self.beerCountSlider addTarget:self action:@selector(sliderValueDidChange:) forControlEvents:UIControlEventValueChanged];
    self.beerCountSlider.minimumValue=1;
    self.beerCountSlider.maximumValue=10;
    
    //Tells sell.button when a finger is lifted from the button
    [self.calculateButton addTarget:self action:@selector(buttonPressed:) forControlEvents:(UIControlEventTouchUpInside)];
    
    //title of the button
    [self.calculateButton setTitle:NSLocalizedString(@"Calculate!", @"Calculate Command") forState:(UIControlStateNormal)];
    
    //gesture recognizer  calls [self -tapgesturedidfire] when it detects a tap
    [self.hideKeyboardTapGestureRecognizer addTarget:self action:@selector(tapGestureDidFire:)];
    
    //gets rid of the maximum number of lines on the label
    self.resultLabel.numberOfLines =0;
    
    //self.beerResultLabel.backgroundColor = [UIColor whiteColor];
    
    self.resultLabel.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1.0];
    self.beerCountSlider.tintColor = [UIColor whiteColor];
    self.beerPercentTextField.font = [UIFont fontWithName:@"AvenirNext-Bold" size:20];
    self.beerResultLabel.font=[UIFont fontWithName:@"AvenirNext-Bold" size:20];
    self.beerResultLabel.textAlignment=NSTextAlignmentCenter;
    self.resultLabel.font = [UIFont fontWithName:@"Avenir-Book" size:12];
    self.resultLabel.textAlignment=NSTextAlignmentCenter;
    
    self.resultLabel.layer.borderColor = [UIColor grayColor].CGColor;
    self.resultLabel.layer.borderWidth = 2.0;
    //self.resultLabel.shadowColor = [UIColor redColor];
    //self.resultLabel.shadowOffset = CGSizeMake(2, 1);
    //self.resultLabel.layer.cornerRadius = 20;
    self.calculateButton.titleLabel.font = [UIFont fontWithName:@"AvenirNext-Bold" size:20];
    
    self.title = NSLocalizedString(@"Wine", @"wine");
    
}
-(void) viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    CGRect screenRect = [[UIScreen mainScreen] bounds];

    CGFloat viewWidth = screenRect.size.width;
    CGFloat padding =20;
    CGFloat itemWidth = viewWidth - padding - padding;
    CGFloat itemHeight =44;
    
    self.beerPercentTextField.frame=CGRectMake(padding, padding+itemHeight, itemWidth, itemHeight);
    
    CGFloat bottomOfTextField = CGRectGetMaxY(self.beerPercentTextField.frame);
    self.beerCountSlider.frame = CGRectMake(padding, bottomOfTextField + padding+itemHeight, itemWidth, itemHeight);
    
    CGFloat bottomOfSlider = CGRectGetMaxY(self.beerCountSlider.frame);
    self.beerResultLabel.frame=CGRectMake(padding, bottomOfSlider+padding, itemWidth, itemHeight);
    
    CGFloat bottomOfBeerLabel = CGRectGetMaxY(self.beerResultLabel.frame);
    self.resultLabel.frame = CGRectMake(padding,bottomOfBeerLabel+padding, itemWidth, itemHeight*4);
    
    CGFloat bottomOfLabel = CGRectGetMaxY(self.resultLabel.frame);
    self.calculateButton.frame =CGRectMake(padding, bottomOfLabel+padding, itemWidth, itemHeight);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)textFieldDidChange:(UITextField *)sender {
    
    NSString *enteredText = sender.text;
    float enteredNumber =[enteredText floatValue];
    
    if (enteredNumber ==0) {
        sender.text=nil;
        
    }
}


- (void)sliderValueDidChange:(UISlider *)sender {
    NSLog(@"Slider value changed to %f",sender.value);
    [self.beerPercentTextField resignFirstResponder];
    int beerCount=self.beerCountSlider.value;
    
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
    
    
    float ouncesInOneWineGlass = 5;
    float alcoholPercentageOfWine = 0.13;
    
    float ouncesOfAlcoholPerWineGlass = ouncesInOneWineGlass*alcoholPercentageOfWine;
    float numberOfWineGlassesForEquivalentAlcoholAmount = ouncesOfAlcoholTotal/ ouncesOfAlcoholPerWineGlass;
    
    NSString * beerText;
    
    if(beerCount==1){
        beerText= NSLocalizedString(@"beer", "singular beer");
    }else{
        beerText=NSLocalizedString(@"beers", "plural of beer");
        
    }
    
    NSString * wineText;
    if(numberOfWineGlassesForEquivalentAlcoholAmount==1){
        wineText=NSLocalizedString(@"glass", "singular glass");
    }else{
        wineText=NSLocalizedString(@"glasses", "plural of glass");
    }
    
    NSString *resultText =[NSString stringWithFormat:NSLocalizedString(@"%d %@ contains as much alcohol as %.1f %@ of wine.", nil), beerCount,beerText, numberOfWineGlassesForEquivalentAlcoholAmount,wineText];
    self.resultLabel.text=resultText;
    
    
    
}



- (void)buttonPressed:(UIButton *)sender {
    
    [self.beerPercentTextField resignFirstResponder];
    int numberOfBeers = self.beerCountSlider.value;
    int ouncesInOneBeerGlass=12;
    
    float alcoholPercentageOfBeer = [self.beerPercentTextField.text floatValue]/100;
    float ouncesOfAlcoholPerBeer = ouncesInOneBeerGlass * alcoholPercentageOfBeer;
    float ouncesOfAlcoholTotal = ouncesOfAlcoholPerBeer*numberOfBeers;
    
    
    float ouncesInOneWineGlass = 5;
    float alcoholPercentageOfWine = 0.13;
    
    float ouncesOfAlcoholPerWineGlass = ouncesInOneWineGlass*alcoholPercentageOfWine;
    float numberOfWineGlassesForEquivalentAlcoholAmount = ouncesOfAlcoholTotal/ ouncesOfAlcoholPerWineGlass;
    
    NSString * beerText;
    
    if(numberOfBeers==1){
        beerText= NSLocalizedString(@"beer", "singular beer");
    }else{
        beerText=NSLocalizedString(@"beers", "plural of beer");
        
    }
    
    NSString * wineText;
    if(numberOfWineGlassesForEquivalentAlcoholAmount==1){
        wineText=NSLocalizedString(@"glass", "singular glass");
    }else{
        wineText=NSLocalizedString(@"glasses", "plural of glass");
    }
    
    
    NSString *resultText =[NSString stringWithFormat:NSLocalizedString(@"%d %@ contains as much alcohol as %.1f %@ of wine.", nil), numberOfBeers,beerText, numberOfWineGlassesForEquivalentAlcoholAmount,wineText];
    self.resultLabel.text=resultText;
    
}

- (void)tapGestureDidFire:(UITapGestureRecognizer *)sender {
    
    [self.beerPercentTextField resignFirstResponder];
}



@end
