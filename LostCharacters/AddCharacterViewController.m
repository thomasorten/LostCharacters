//
//  AddCharacterViewController.m
//  LostCharacters
//
//  Created by Thomas Orten on 6/3/14.
//  Copyright (c) 2014 Orten, Thomas. All rights reserved.
//

#import "AddCharacterViewController.h"

@interface AddCharacterViewController ()
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passengerTextField;
@property (weak, nonatomic) IBOutlet UITextField *genderTextField;
@property (weak, nonatomic) IBOutlet UITextField *ageTextField;
@property (weak, nonatomic) IBOutlet UITextField *hairColorTextField;

@end

@implementation AddCharacterViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (IBAction)onAddCharacter:(UIButton *)sender
{
    NSManagedObject *character = [NSEntityDescription insertNewObjectForEntityForName:@"Character" inManagedObjectContext:self.managedObjectContext];
    
    NSNumber *age = @([self.ageTextField.text intValue]);
    
    [character setValue:self.nameTextField.text forKeyPath:@"actor"];
    [character setValue:self.passengerTextField.text forKeyPath:@"passenger"];
    [character setValue:self.hairColorTextField.text forKeyPath:@"hairColor"];
    [character setValue:self.genderTextField.text forKeyPath:@"gender"];
    [character setValue:age forKeyPath:@"age"];
    
    for (UIView *view in self.view.subviews) {
        if ([view isKindOfClass:[UITextField class]]) {
            UITextField *field = (UITextField *) view;
            field.text = @"";
        }
    }
    
    [self.managedObjectContext save:nil];
}

- (void)viewDidAppear:(BOOL)animated
{
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(dismissKeyboard)];
    [self.view addGestureRecognizer:tap];
}

-(void)dismissKeyboard {
    [self.view endEditing:YES];
}

@end
