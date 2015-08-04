//
//  LTView.m
//  lesson3
//
//  Created by lanou3g on 15-4-17.
//  Copyright (c) 2015年 桐花. All rights reserved.
//

#import "LTView.h"

#define LTHeight frame.size.height
#define LTWidth frame.size.width

//添加延展.只能在本类的.m中被访问,访问textField的第一种方式
//@interface LTView (){
//    UITextField *_textField;
//}
//
//@end
@implementation LTView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
//- (void)dealloc
//{
//    self.label = nil;
//    self.textField = nil;
//    
//}

-(id)initWithFrame:(CGRect)frame  {
    
    self = [super initWithFrame:frame];
    if (self) {
        self.label = [[UILabel alloc]initWithFrame:CGRectMake(LTWidth/10.0, 0, LTWidth/3.0, LTHeight)];
        _label.textAlignment = NSTextAlignmentLeft;
        [self addSubview:_label];
        
        
        self.textField = [[UITextField alloc]initWithFrame:CGRectMake(LTWidth/2.0, 0, LTWidth/3.0, LTHeight)];
        [self addSubview:_textField];
        _textField.borderStyle = UITextBorderStyleRoundedRect ;
        
//        self.switchs = [[UISwitch alloc] initWithFrame:CGRectMake(LTWidth*2/3.0+10, 0, 40, LTHeight)];
//        [self addSubview:_switchs];
        
    }
    return self;
    
}







@end
