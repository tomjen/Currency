//
//  CurrencySelectViewController.m
//  Currency
//
//  Created by Tommy Jensen on 17/08/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "CurrencySelectViewController.h"
#import "XMLReader.h"


@implementation CurrencySelectViewController

@synthesize selected;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    data = nil;
    currencies;
    return self;
}

- (void)dealloc
{
    [currencyPicker release];
    [active release];
    [activeLabel release];
    [data release];
    [currencies release];
    [picker release];
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSURLRequest *reg = [[NSURLRequest alloc] initWithURL:[[[NSURL alloc] initWithString:@"http://www.nationalbanken.dk/dndk/valuta.nsf/valuta.xml"] autorelease]];
    [[[NSURLConnection alloc] initWithRequest:reg delegate:self] release];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [currencyPicker release];
    currencyPicker = nil;
    [active release];
    active = nil;
    [activeLabel release];
    activeLabel = nil;
    [picker release];
    picker = nil;
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark components in picker

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if(!currencies ){
        return 200;
    }
    return [currencies count];
}
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    if(!data){
        return [NSString stringWithFormat:@"%d", row +1900];
    }
    if(row < [currencies count]){
        return [currencies objectAtIndex: row];
    }
    return @"";
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    
}

#pragma mark ns url connection

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    NSLog((NSString *) [[error userInfo] objectForKey:NSLocalizedDescriptionKey]);
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    [active stopAnimating];
    [activeLabel setText: @"Download complete"];
    NSLog(@"%s", [[[[NSString alloc] initWithData:data encoding: NSUTF8StringEncoding] autorelease] cStringUsingEncoding:NSUTF8StringEncoding]);
    [self parseXML];
}
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{
    [data release];
    data = [[NSMutableData alloc] initWithCapacity: 5];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data2 {
    [data appendData:data2];
}

#pragma mark xml

- (void) parseXML {
    [currencies release];
    currencies = [NSMutableArray arrayWithCapacity:5];
    NSXMLParser * parser = [[[NSXMLParser alloc] initWithData:data] autorelease];
    parser.delegate = self;
    if([parser parse]){
        [picker reloadAllComponents];
    }
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict{
    id obj =  [attributeDict objectForKey:@"disc"];
    if(obj)
        [currencies addObject:obj];
}
@end
