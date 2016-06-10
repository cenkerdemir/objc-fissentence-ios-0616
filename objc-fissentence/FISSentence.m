//
//  FISSentence.m
//  objc-fissentence
//
//  Created by Cenker Demir on 6/9/16.
//  Copyright © 2016 The Flatiron School. All rights reserved.
//

#import "FISSentence.h"

@interface FISSentence ()

@property (strong,readwrite, nonatomic) NSString *sentence;

-(void)assembleSentence;
-(BOOL)validWord:(NSString *)word;
-(BOOL)validPunctuation:(NSString *)punctuation;
-(BOOL)validIndex:(NSUInteger)index;

@end


@implementation FISSentence

-(void)addWord:(NSString *)word{
    if ([self validWord:word]) {
        [self.words addObject:word];
    }
    [self assembleSentence];
}

-(void)assembleSentence {
    self.sentence = [[self.words componentsJoinedByString:@" "] stringByAppendingString:self.punctuation];
}

-(void)addWords:(NSArray *)words withPunctuation:(NSString *)punctuation{
    if ((nil != words) && [words count]) {
        if ([self validPunctuation:punctuation]) {
            for (NSString *word in words) {
                if ([self validWord:word]) {
                    [self addWord:word];
                }
            }
            self.punctuation = punctuation;
            [self assembleSentence];
        }
    }
}

-(void)removeWordAtIndex:(NSUInteger)index{
    if ([self validIndex:index]) {
        [self.words removeObjectAtIndex:index];
        [self assembleSentence];
    }
}

-(void)insertWord:(NSString *)word atIndex:(NSUInteger)index{
    if ([self validWord:word] && [self validIndex:index]) {
        [self.words insertObject:word atIndex:index];
    }
    [self assembleSentence];
}

-(void)replacePunctuationWithPunctuation:(NSString *)punctuation{
    if ([self validPunctuation:punctuation]) {
        self.punctuation = punctuation;
    }
    [self assembleSentence];
}

-(void)replaceWordAtIndex:(NSUInteger)index withWord:(NSString *)word{
    if ([self validWord:word] && [self validIndex:index]) {
        [self.words replaceObjectAtIndex:index withObject:word];
    }
    [self assembleSentence];
}

-(BOOL)validWord:(NSString *)word {
    if ([word length] && ![word isEqualToString:@" "]) {
        return YES;
    }
    else {
        return NO;
    }
}

-(BOOL)validPunctuation:(NSString *)punctuation {
    if ((nil != punctuation) && [@".?!,;:-" containsString:punctuation]) {
        return YES;
    }
    else {
        return NO;
    }
}

-(BOOL)validIndex:(NSUInteger)index {
    if (index < [self.words count]) {
        return YES;
    }
    else {
        return NO;
    }
}

@end
