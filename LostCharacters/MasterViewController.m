#import "MasterViewController.h"
#import "AddCharacterViewController.h"
#import "CharacterTableViewCell.h"

@interface MasterViewController () <UITableViewDataSource, UITableViewDelegate>
@property NSArray *characters;
@end

@implementation MasterViewController

- (void)viewDidLoad
{
    [self load];
    self.tableView.allowsMultipleSelectionDuringEditing = NO;
}

- (void)loadPlist
{
    NSURL *pList = [NSURL URLWithString:@"http://s3.amazonaws.com/mobile-makers-assets/app/public/ckeditor_assets/attachments/2/lost.plist"];
    NSArray *pListArray = [NSMutableArray arrayWithContentsOfURL:pList];
    for (NSDictionary *characterDict in pListArray) {
        NSManagedObject *character = [NSEntityDescription insertNewObjectForEntityForName:@"Character" inManagedObjectContext:self.managedObjectContext];
        
        [character setValue:[characterDict valueForKey:@"actor"] forKeyPath:@"actor"];
        [character setValue:[characterDict valueForKey:@"passenger"] forKeyPath:@"passenger"];
        
        [self.managedObjectContext save:nil];
    }
}

- (void)load
{
    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:@"Character"];
    
    self.characters = [self.managedObjectContext executeFetchRequest:request error:nil];
    
    if (self.characters.count == 0) {
        [self loadPlist];
    }
    
    [self.tableView reloadData];
}

- (void)viewDidAppear:(BOOL)animated
{
    [self load];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.characters.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSManagedObject *character = [self.characters objectAtIndex:indexPath.row];
    
    CharacterTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
   
    NSString *gender = [character valueForKey:@"gender"];
    NSString *age = [NSString stringWithFormat:@"%@", [character valueForKey:@"age"]];
    NSString *hairColor = [character valueForKey:@"hairColor"];
    
    [cell setLabels:[NSArray arrayWithObjects:gender, age, hairColor, nil]];
    
    cell.textLabel.text = [character valueForKey:@"actor"];
    cell.detailTextLabel.text = [character valueForKey:@"passenger"];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        NSManagedObject *object = [self.characters objectAtIndex:indexPath.row];
        [self.managedObjectContext deleteObject:object];
        [self.managedObjectContext save:nil];
        [self load];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 90;
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"SMOKE MONSTER";
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    AddCharacterViewController *destinationController = segue.destinationViewController;
    destinationController.managedObjectContext = self.managedObjectContext;
}

@end