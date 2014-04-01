//
//  GameOf2048ViewController.m
//  GameOf2048
//
//  Created by RuiKQ on 14-3-28.
//  Copyright (c) 2014年 RuiKQ. All rights reserved.
//

#import "GameOf2048ViewController.h"

@interface GameOf2048ViewController ()
{
    int numberArray[16];
}

@property (weak, nonatomic) IBOutlet UIView *mainView;
@property (strong , nonatomic) NSArray * viewArray;
@property (nonatomic) BOOL isLost;
@property (nonatomic) BOOL isMove;
@property (strong , nonatomic) NSDictionary *colorDictionary;
@property (nonatomic) int score;
@end

@implementation GameOf2048ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    _viewArray=[_mainView subviews];
    UIColor *_0Color=[UIColor colorWithRed:204/255.0 green:192/255.0 blue:179/255.0 alpha:1.0];
    UIColor *_2Color=[UIColor colorWithRed:238/255.0 green:228/255.0 blue:219/255.0 alpha:1.0];
    UIColor *_4Color=[UIColor colorWithRed:237/255.0 green:224/255.0 blue:201/255.0 alpha:1.0];
    UIColor *_8Color=[UIColor colorWithRed:241/255.0 green:177/255.0 blue:125/255.0 alpha:1.0];
    UIColor *_16Color=[UIColor colorWithRed:245/255.0 green:149/255.0 blue:99/255.0 alpha:1.0];
    UIColor *_32Color=[UIColor colorWithRed:244/255.0 green:124/255.0 blue:99/255.0 alpha:1.0];
    UIColor *_64Color=[UIColor colorWithRed:244/255.0 green:95/255.0 blue:67/255.0 alpha:1.0];
    UIColor *_128Color=[UIColor colorWithRed:237/255.0 green:204/255.0 blue:97/255.0 alpha:1.0];
    
    _colorDictionary=@{@0: _0Color,@2: _2Color,@4: _4Color,@8: _8Color,
                       @16: _16Color,@32: _32Color,@64: _64Color,@128: _128Color};
    [self newGame];
}

#pragma Gesture Recoginzer
- (IBAction)handleSwipeRight:(UISwipeGestureRecognizer *)sender
{
    
    int number,nextNumber;
    int i;
    for (i=0; i<4; i++) {
        int temp[4]={0,0,0,0};
        int n=0;
        for (int j=0; j<4; j++) {
            number=numberArray[4*i+3-j];
            if (number!=0) {
                temp[n]=number;
                n++;
            }
        }
        
        for (int k=0; k<3; k++) {
            number=temp[k];
            nextNumber=temp[k+1];
            if (number==nextNumber && number!=0 && nextNumber!=0) {
                temp[k]=number+nextNumber;
                _score+=temp[k];
                temp[k+1]=0;
                for (int h=k+1; h<3; h++) {
                    temp[h]=temp[h+1];
                    temp[h+1]=0;
                }
            }
        }
        
        for (int k=0; k<4; k++) {
            numberArray[4*i+3-k]=temp[k];//向右索引
        }
        [self changeView];
    }
    [self newNumber];
}

- (IBAction)handleSwipeLeft:(UISwipeGestureRecognizer *)sender
{
    int number,nextNumber;
    int i;
    for (i=0; i<4; i++) {
        int temp[4]={0,0,0,0};
        int n=0;
        for (int j=0; j<4; j++) {
            number=numberArray[4*i+j];
            if (number!=0) {
                temp[n]=number;
                n++;
            }
        }
        
        for (int k=0; k<3; k++) {
            number=temp[k];
            nextNumber=temp[k+1];
            if (number==nextNumber && number!=0 && nextNumber!=0) {
                temp[k]=number+nextNumber;
                _score+=temp[k];
                temp[k+1]=0;
                for (int h=k+1; h<3; h++) {
                    temp[h]=temp[h+1];
                    temp[h+1]=0;
                }
            }
        }
        
        for (int k=0; k<4; k++) {
            numberArray[4*i+k]=temp[k];//向右索引
        }
        [self changeView];
    }

    [self newNumber];
}

- (IBAction)handleSwipeUp:(UISwipeGestureRecognizer *)sender
{
    int number,nextNumber;
    int i;
    for (i=0; i<4; i++) {
        int temp[4]={0,0,0,0};
        int n=0;
        for (int j=0; j<4; j++) {
            number=numberArray[4*j+i];
            if (number!=0) {
                temp[n]=number;
                n++;
            }
        }
        
        for (int k=0; k<3; k++) {
            number=temp[k];
            nextNumber=temp[k+1];
            if (number==nextNumber && number!=0 && nextNumber!=0) {
                temp[k]=number+nextNumber;
                _score+=temp[k];
                temp[k+1]=0;
                for (int h=k+1; h<3; h++) {
                    temp[h]=temp[h+1];
                    temp[h+1]=0;
                }
            }else{
                
            }
        }
        
        for (int k=0; k<4; k++) {
            numberArray[4*k+i]=temp[k];//向右索引
        }
        [self changeView];
    }

   [self newNumber];
}

- (IBAction)handleSwipeDown:(UISwipeGestureRecognizer *)sender
{
    int number,nextNumber;
    int i;
    for (i=0; i<4; i++) {
        int temp[4]={0,0,0,0};
        int n=0;
        for (int j=3; j<4 && j>=0; j--) {
            number=numberArray[4*j+i];
            if (number!=0) {
                temp[n]=number;
                n++;
            }
        }
        
        for (int k=0; k<3; k++) {
            number=temp[k];
            nextNumber=temp[k+1];
            if (number==nextNumber && number!=0 && nextNumber!=0) {
                temp[k]=number+nextNumber;
                _score+=temp[k];
                temp[k+1]=0;
                for (int h=k+1; h<3; h++) {
                    temp[h]=temp[h+1];
                    temp[h+1]=0;
                }
            }
        }
        
        for (int k=3; k<4 && k>=0; k--) {
            numberArray[4*k+i]=temp[3-k];//向右索引
        }
        [self changeView];
    }

    [self newNumber];
}


- (IBAction)playNewGame:(UIButton *)sender
{
    [self newGame];
}

-(void)changeView
{
    //根据numberArray中的数据改变视图
    for (int i=0; i<16; i++) {
        UILabel *view=_viewArray[i];
        
        if (numberArray[i]>=1024) {
            view.backgroundColor=_colorDictionary[@128];
            [view setFont:[UIFont fontWithName:@"Helvetica-Bold" size:25]];
        }else if(numberArray[i]>=128){
            view.backgroundColor=_colorDictionary[@128];
            [view setFont:[UIFont fontWithName:@"Helvetica-Bold" size:35]];
        }else if(numberArray[i]>=32){
            view.backgroundColor=_colorDictionary[[NSNumber numberWithInt:numberArray[i]]];
            [view setFont:[UIFont fontWithName:@"Helvetica-Bold" size:40]];
        }else{
            view.backgroundColor=_colorDictionary[[NSNumber numberWithInt:numberArray[i]]];
        }
        
        if (numberArray[i]==0) {
            view.text=@"";
        }else{
            view.text=[NSString stringWithFormat:@"%d",numberArray[i]];
        }
    }
    _scoreLable.text=[NSString stringWithFormat:@"%d",_score];
}

-(void)newGame
{
    for (UILabel * view in _viewArray) {
        view.backgroundColor=_colorDictionary[@0];
        view.text=@"";
    }
    
    for (int i=0; i<16; i++) {
        numberArray[i]=0;
    }
    
    _scoreLable.text=@"0";
    _isLost=NO;
    _isMove=YES;
    _score=0;
    int x=arc4random()%16;
    numberArray[x]=2;
    int y=x;
    while (y==x) {
        y=arc4random()%16;
    }
    numberArray[y]=2;
    
    UILabel *viewX=_viewArray[x];
    UILabel *viewY=_viewArray[y];
    viewX.text=@"2";
    viewX.backgroundColor=_colorDictionary[@2];
    viewY.text=@"2";
    viewY.backgroundColor=_colorDictionary[@2];
}

//新数字随机出现的地方
-(int)getRandomIndex{
    int loopCounter=0;
    int randomIndex=arc4random()%16;
    int index=numberArray[randomIndex];
    while (index!=0 && _isMove) {
        randomIndex=arc4random()%16;
        index=numberArray[randomIndex];
        loopCounter++;
        if (loopCounter==16) {
            _isLost=YES;
            NSLog(@"Game Over");
        }
    }
    return randomIndex;
}

//新数字随机出现2或者4
-(int)getRandomNumber
{
    int num=arc4random()%2+1;
    return 2*num;
}

-(void)newNumber
{
    int index=[self getRandomIndex];
    int number=[self getRandomNumber];
    //
    numberArray[index]=number;
    UILabel *newView=_viewArray[index];
    newView.text=[NSString stringWithFormat:@"%d",number];
    newView.backgroundColor=_colorDictionary[[NSNumber numberWithInt:number]];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
