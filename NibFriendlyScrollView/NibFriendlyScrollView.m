//
//  NibFriendlyScrollView.m
//  NibFriendlyScrollView
//
//  Created by PJ on 06/05/2013.
//  Copyright (c) 2013 Software101. All rights reserved.
//
//  Distributed under the permissive zlib License
//  Get the latest version from here:
//
//  https://github.com/pjcook/NibFriendlyScrollView
//
//  This software is provided 'as-is', without any express or implied
//  warranty.  In no event will the authors be held liable for any damages
//  arising from the use of this software.
//
//  Permission is granted to anyone to use this software for any purpose,
//  including commercial applications, and to alter it and redistribute it
//  freely, subject to the following restrictions:
//
//  1. The origin of this software must not be misrepresented; you must not
//  claim that you wrote the original software. If you use this software
//  in a product, an acknowledgment in the product documentation would be
//  appreciated but is not required.
//
//  2. Altered source versions must be plainly marked as such, and must not be
//  misrepresented as being the original software.
//
//  3. This notice may not be removed or altered from any source distribution.
//

#import "NibFriendlyScrollView.h"

@interface NibFriendlyScrollView()
    <UIGestureRecognizerDelegate>

@property (nonatomic, weak) IBOutlet UIView *scrollViewContent;
@property (nonatomic, strong) UITapGestureRecognizer *tapGesture;

@end

@implementation NibFriendlyScrollView

- (void)dealloc
{
    [self removeTapGesture];
    NSNotificationCenter *notificationCenter = [NSNotificationCenter defaultCenter];
    [notificationCenter removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [notificationCenter removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}

- (void)awakeFromNib
{
    if (self.scrollViewContent)
    {
        self.contentSize = self.scrollViewContent.frame.size;
        self.scrollViewContent.frame = self.scrollViewContent.bounds;
        [self addSubview:self.scrollViewContent];

        // Listen for keyboard and update scrollview insets accordingly
        NSNotificationCenter *notificationCenter = [NSNotificationCenter defaultCenter];
        [notificationCenter addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
        [notificationCenter addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    }
}

#pragma mark -
#pragma mark Keyboad Handling

- (void)removeTapGesture
{
    if (self.tapGesture)
    {
        self.tapGesture.delegate = nil;
        [self removeGestureRecognizer:self.tapGesture];
        self.tapGesture = nil;
    }
}

- (void)addTapGesture
{
    [self removeTapGesture];
    
    self.tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tappedOnContentView)];
    [self addGestureRecognizer:self.tapGesture];
    self.tapGesture.delegate = self;
}

- (void)tappedOnContentView
{
    [self endEditing:YES];
}

- (void)keyboardWillShow:(NSNotification *)notification
{
    CGSize keybSize = [[[notification userInfo] objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    UIEdgeInsets contentInset = UIEdgeInsetsMake(0, 0, keybSize.height - 0, 0);
    [UIView animateWithDuration:0.25f animations:^
     {
         self.contentInset = contentInset;
         self.scrollIndicatorInsets = contentInset;
     }];
    [self flashScrollIndicators];
    
    [self addTapGesture];
}

- (void)keyboardWillHide:(NSNotification *)notification
{
    [self removeTapGesture];
    
    [UIView animateWithDuration:0.25f animations:^
     {
         self.contentInset = UIEdgeInsetsZero;
         self.scrollIndicatorInsets = UIEdgeInsetsZero;
     }];
}

@end
