//
//  EmojiView.m
//  BmobIMDemo
//
//  Created by Bmob on 14-6-30.
//  Copyright (c) 2014年 bmob. All rights reserved.
//

#import "EmojiView.h"
#import "CommonUtil.h"

@implementation EmojiView{

    UIScrollView    *_scrollView; //存放表情

}

@synthesize delegate = _delegate;


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}



-(void)createEmojiView{

    _scrollView                      = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 100)];
    _scrollView.backgroundColor      = [UIColor whiteColor];
    _scrollView.contentSize          = CGSizeMake(ScreenWidth*2, 100);
    _scrollView.pagingEnabled        = YES;
    [self addSubview:_scrollView];

    [self addEmojiButton:_scrollView];
}



-(void)addEmojiButton:(UIScrollView *)scrollView{
    NSMutableArray  *emojiBtnArray = [NSMutableArray array];
    for (int i = 0; i < 2; i++) {
        for (int j = 0; j < 6; j++) {
            UIButton *eBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            [eBtn setFrame:CGRectMake(ScreenWidth/6*j, 50*i, ScreenWidth/6, 50)];
            [emojiBtnArray addObject:eBtn];
            [scrollView addSubview:eBtn];
        }
    }
    
    for (int i = 0; i < 2; i++) {
        for (int j = 0; j < 6; j++) {
            UIButton *eBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            [eBtn setFrame:CGRectMake(ScreenWidth+ScreenWidth/6*j, 50*i, ScreenWidth/6, 50)];
            [emojiBtnArray addObject:eBtn];
            [scrollView addSubview:eBtn];
        }
    }
    
    NSArray  *emojiArray = [EmojiEmoticons allEmoticons];
    
    
//    NSArray  *emojiArray = @[@"\U0001F609",@"\1f60",@"\ue415",@"\ue056",@"\ue057",@"\ue414",@"\ue405",@"\ue106",@"\ue418",
//                                   @"\ue417",@"\ue40d",@"\ue40a",@"\ue404",@"\ue105",@"\ue409",@"\ue40e",
//                                   @"\ue402",@"\ue108",@"\ue403",@"\ue058",@"\ue407",@"\ue401",@"\ue40f",
//                                   @"\ue40b",@"\ue406",@"\ue413",@"\ue411",@"\ue412",
//                                   @"\ue410",@"\ue107",
//                                   @"\ue059",@"\ue416",@"\ue408",@"\ue40c",@"\ue00e",@"\ue421",@"\ue41f"];
    
//   NSMutableArray  *emojiArray = [NSMutableArray arrayWithObjects:  @"\uE415",@"\uE056",@"\uE057",@"\uE414",@"\uE405",@"\uE106",@"\uE418",@"\uE417",
//    @"\uE40d",@"\uE40a",@"\uE404",@"\uE105",@"\uE409",@"\uE40e",@"\uE402",@"\uE108",
//    @"\uE403",@"\uE058",@"\uE407",@"\uE401",@"\uE40f",@"\uE40b",@"\uE406",@"\uE413",
//    @"\uE411",@"\uE412",@"\uE410",@"\uE107",@"\uE059",@"\uE416",@"\uE408",@"\uE40c",
//    @"\uE11a",@"\uE10c",@"\uE32c",@"\uE32a",@"\uE32d",@"\uE328",@"\uE32b",@"\uE022",
//    @"\uE023",@"\uE327",@"\uE329",@"\uE32e",@"\uE32f",@"\uE335",@"\uE334",@"\uE021",
//    @"\uE336",@"\uE13c",@"\uE337",@"\uE020",@"\uE330",@"\uE331",@"\uE326",@"\uE03e",
//    @"\uE11d",@"\uE05a",@"\uE00e",@"\uE421",@"\uE420",@"\uE00d",@"\uE010",@"\uE011",
//    @"\uE41e",@"\uE012",@"\uE422",@"\uE22e",@"\uE22f",@"\uE231",@"\uE230",@"\uE427",
//    @"\uE41d",@"\uE00f",@"\uE41f",@"\uE14c",@"\uE201",@"\uE115",@"\uE428",@"\uE51f",
//    @"\uE429",@"\uE424",@"\uE423",@"\uE253",@"\uE426",@"\uE111",@"\uE425",@"\uE31e",
//    @"\uE31f",@"\uE31d",@"\uE001",@"\uE002",@"\uE005",@"\uE004",@"\uE51a",@"\uE519",
//    @"\uE518",@"\uE515",@"\uE516",@"\uE517",@"\uE51b",@"\uE152",@"\uE04e",@"\uE51c",
////                                  @"\uE51e",@"\uE11c",@"\uE536",@"\uE003",@"\uE41c",@"\uE41b",@"\uE419",@"\uE41a",@"uE000",nil];
    
    
    for (int i = 0; i < [emojiBtnArray count]; i++) {
        UIButton *eBtn      = [emojiBtnArray objectAtIndex:i];
        
//        NSString    *emojbS = [CommonUtil escapeUnicodeString:[emojiArray objectAtIndex:i]];
    
        
        NSString * emojbS = [emojiArray objectAtIndex:i];
        
//        NSData *stringData = [emojbS dataUsingEncoding:NSNonLossyASCIIStringEncoding];
        
        
        [eBtn setTitle:emojbS forState:UIControlStateNormal];
//         [[eBtn titleLabel] setFont:[UIFont systemFontOfSize:18]];
        eBtn.tag            = i;
        [eBtn addTarget:self action:@selector(addEmoji:) forControlEvents:UIControlEventTouchUpInside];
    }
}


-(void)addEmoji:(UIButton*)sender{
    
    
     NSArray  *emojiArray = [EmojiEmoticons allEmoticons];
    
//    NSArray  *emojiArray = @[@"\U0001F609",@"\ue415",@"\ue056",@"\ue057",@"\ue414",@"\ue405",@"\ue106",@"\ue418",
//                             @"\ue417",@"\ue40d",@"\ue40a",@"\ue404",@"\ue105",@"\ue409",@"\ue40e",
//                             @"\ue402",@"\ue108",@"\ue403",@"\ue058",@"\ue407",@"\ue401",@"\ue40f",
//                             @"\ue40b",@"\ue406",@"\ue413",@"\ue411",@"\ue412",
//                             @"\ue410",@"\ue107",
//                             @"\ue059",@"\ue416",@"\ue408",@"\ue40c",@"\ue00e",@"\ue421",@"\ue41f"];
 
    
//    NSMutableArray  *emojiArray = [NSMutableArray arrayWithObjects:  @"\uE415",@"\uE056",@"\uE057",@"\uE414",@"\uE405",@"\uE106",@"\uE418",@"\uE417",
//                                   @"\uE40d",@"\uE40a",@"\uE404",@"\uE105",@"\uE409",@"\uE40e",@"\uE402",@"\uE108",
//                                   @"\uE403",@"\uE058",@"\uE407",@"\uE401",@"\uE40f",@"\uE40b",@"\uE406",@"\uE413",
//                                   @"\uE411",@"\uE412",@"\uE410",@"\uE107",@"\uE059",@"\uE416",@"\uE408",@"\uE40c",
//                                   @"\uE11a",@"\uE10c",@"\uE32c",@"\uE32a",@"\uE32d",@"\uE328",@"\uE32b",@"\uE022",
//                                   @"\uE023",@"\uE327",@"\uE329",@"\uE32e",@"\uE32f",@"\uE335",@"\uE334",@"\uE021",
//                                   @"\uE336",@"\uE13c",@"\uE337",@"\uE020",@"\uE330",@"\uE331",@"\uE326",@"\uE03e",
//                                   @"\uE11d",@"\uE05a",@"\uE00e",@"\uE421",@"\uE420",@"\uE00d",@"\uE010",@"\uE011",
//                                   @"\uE41e",@"\uE012",@"\uE422",@"\uE22e",@"\uE22f",@"\uE231",@"\uE230",@"\uE427",
//                                   @"\uE41d",@"\uE00f",@"\uE41f",@"\uE14c",@"\uE201",@"\uE115",@"\uE428",@"\uE51f",
//                                   @"\uE429",@"\uE424",@"\uE423",@"\uE253",@"\uE426",@"\uE111",@"\uE425",@"\uE31e",
//                                   @"\uE31f",@"\uE31d",@"\uE001",@"\uE002",@"\uE005",@"\uE004",@"\uE51a",@"\uE519",
//                                   @"\uE518",@"\uE515",@"\uE516",@"\uE517",@"\uE51b",@"\uE152",@"\uE04e",@"\uE51c",
//                                   @"\uE51e",@"\uE11c",@"\uE536",@"\uE003",@"\uE41c",@"\uE41b",@"\uE419",@"\uE41a",@"uE000",nil];

//    NSArray *newEmojiArray = @[@"\U0001F604",@"\U0001F60A",@"\U0001F603",@""];
    
    NSString    *string = [emojiArray objectAtIndex:sender.tag];
    if (_delegate && [_delegate respondsToSelector:@selector(didSelectEmojiView:emojiText:)]) {
//        NSData *data        = [string dataUsingEncoding:NSNonLossyASCIIStringEncoding];
//        NSString *goodValue = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
//        [_delegate didSelectEmojiView:self emojiText:[CommonUtil escapeUnicodeString:string]];
        
          [_delegate didSelectEmojiView:self emojiText:string];
    }

}

@end
