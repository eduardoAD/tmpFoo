//
//  DetailViewController.m
//  tmpFoo
//
//  Created by Eduardo Alvarado Díaz on 10/23/14.
//  Copyright (c) 2014 Organization. All rights reserved.
//

#import "DetailViewController.h"
#import "TextFieldValidator.h"
#import "ActionSheetStringPicker.h"
#import "ActionSheetDatePicker.h"

@interface DetailViewController ()
@property (strong, nonatomic) IBOutlet TextFieldValidator *nameText;
@property (strong, nonatomic) IBOutlet TextFieldValidator *emailText;
@property (strong, nonatomic) IBOutlet TextFieldValidator *numberText;
@property (strong, nonatomic) IBOutlet TextFieldValidator *dateText;
@property (strong, nonatomic) IBOutlet TextFieldValidator *titleText;

@property (strong, nonatomic) UIButton *uno;
@property (strong, nonatomic) NSArray *quotes;
@property (strong, nonatomic) IBOutlet UIImageView *image;

@end

@implementation DetailViewController

#pragma mark - Managing the detail item

- (void)setDetailItem:(id)newDetailItem {
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
            
        // Update the view.
        [self configureView];
    }
}

- (void)configureView {
    // Update the user interface for the detail item.
    if (self.detailItem) {
        self.detailDescriptionLabel.text = [[self.detailItem valueForKey:@"timeStamp"] description];
    }

    [self.nameText addRegx:@"^.{3,10}$" withMsg:@"User name should be come between 3-10"];
    [self.nameText addRegx:@"[A-Za-z0-9]{3,10}" withMsg:@"Only alpha numeric characters are allowed"];

    [self.emailText addRegx:@"[A-Z0-9a-z._%+-]{3,}+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}" withMsg:@"Enter valid email"];

    [self.numberText addRegx:@"^.{10,}$" withMsg:@"Phone number should be 10"];
    [self.numberText addRegx:@"[0-9]{1,}" withMsg:@"Phone number must be only numbers"];

    self.dateText.isMandatory = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self configureView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)textFieldDidBeginEditing:(UITextField *)myTextField{
    if (myTextField == self.titleText) {
        [myTextField resignFirstResponder];
        // Create an array of strings you want to show in the picker:
        NSArray *data = [NSArray arrayWithObjects:@"Sr.", @"Sra.", @"Dr.", @"Dra.", nil];

        [ActionSheetStringPicker showPickerWithTitle:@"Please select a Title:"
                                                rows:data
                                    initialSelection:0
                                           doneBlock:^(ActionSheetStringPicker *picker, NSInteger selectedIndex, id selectedValue) {
                                               NSLog(@"Selected Index: %ld", (long)selectedIndex);
                                               NSLog(@"Selected Value: %@", selectedValue);
                                               self.titleText.text = selectedValue;
                                               [self.titleText validate];
                                           }
                                         cancelBlock:^(ActionSheetStringPicker *picker) {
                                             NSLog(@"Block String Picker Canceled");
                                         }
                                              origin:self.view];
    }else if (myTextField == self.dateText){
        [myTextField resignFirstResponder];
        [ActionSheetDatePicker showPickerWithTitle:@"Please select:"
                                    datePickerMode:UIDatePickerModeDate
                                      selectedDate:[NSDate date]
                                         doneBlock:^(ActionSheetDatePicker *picker, id selectedDate, id origin) {
                                             NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
                                             [dateFormatter setDateFormat:@"dd-MM-yyyy"];
                                             NSString *strDate = [dateFormatter stringFromDate:selectedDate];

                                             self.dateText.text = strDate;
                                             [self.dateText validate];
                                         }
                                       cancelBlock:^(ActionSheetDatePicker *picker) {
                                           NSLog(@"Block Date Picker Canceled");
                                       }
                                            origin:self.view];
    }
    
}

- (IBAction)validation:(UIButton *)sender {

    if ([self.nameText validate] & [self.emailText validate] & [self.numberText validate] & [self.titleText validate] & [self.dateText validate] ) {
        [[[UIAlertView alloc] initWithTitle:nil message:@"Form validate!!" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"Ok", nil] show];
        return;
    }

}

- (IBAction)selectDate:(UIButton *)sender {
    ActionSheetDatePicker *picker = [[ActionSheetDatePicker alloc] initWithTitle:@"Select date:" datePickerMode:UIDatePickerModeDateAndTime selectedDate:[NSDate date] doneBlock:^(ActionSheetDatePicker *picker, id selectedDate, id origin) {

        NSLog(@"original date: %@",selectedDate);


        NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
        NSDateComponents *components = [gregorian components:(NSCalendarUnitYear | NSCalendarUnitMonth |NSCalendarUnitDay |  NSCalendarUnitHour | NSCalendarUnitMinute) fromDate:selectedDate];
        [components setMinute:0];

        NSDate *roundDate = [gregorian dateFromComponents:components];
        NSLog(@"transform date: %@",roundDate);

    } cancelBlock:^(ActionSheetDatePicker *picker) {
        NSLog(@"cancel");
    } origin:self.view];
    

    [picker setMinuteInterval:60];
    [picker showActionSheetPicker];

}

- (void)actionSheetPicker:(AbstractActionSheetPicker *)actionSheetPicker configurePickerView:(UIPickerView *)pickerView{
    NSLog(@"---");
}

-(void)foo{
    NSString *color = @"Purple";
    NSString *preference = @"My favorite color is ";
    NSString *favorite = [preference stringByAppendingString:color];
    NSLog(@"%@",favorite);
    NSArray *drinks = @[@"juice", @"water", @"coffee"];
    for (NSString *item in drinks) {
        NSLog(@"%@",item);
    }

    id thing = nil;
    thing = @4;
    NSLog(@"thing = %@",thing);
    self.uno = [[UIButton alloc] initWithFrame:CGRectMake(100, 250, 280, 44)];
    self.uno.frame = CGRectMake(100, 250, 280, 44);

    self.quotes = [[NSArray alloc]initWithObjects:@"", nil];
    [self.quotes objectAtIndex:arc4random_uniform(5)];

    UIImage *image1 = [UIImage imageNamed:@""];
    self.image.animationImages = [[NSArray alloc] initWithObjects:image1, nil];
    self.image.animationDuration = 5;
    [self.image startAnimating];
    [UIView animateWithDuration:5 animations:^{

    }];

}

-(IBAction)buttonPressed:(id)sender{

}

@end
