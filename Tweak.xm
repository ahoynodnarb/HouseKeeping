@interface BBBulletinRequest
@property (nonatomic,copy) NSString * bulletinID;
@property (nonatomic,copy) NSString * sectionID;
@end

@interface BBServer
-(void)publishBulletin:(id)arg1 destinations:(unsigned long long)arg2;
-(void)_clearBulletinIDs:(id)arg1 forSectionID:(id)arg2 shouldSync:(BOOL)arg3;
@end

@interface BBBulletin : BBBulletinRequest
@end

@interface SBFLockScreenDateViewController: UIViewController
-(void)_updateView;
@end

static BOOL clearNotifications = NO;
static BOOL placeHolder = YES;
static NSDate *firstTime;

NSDictionary *bundleDefaults = [[NSUserDefaults standardUserDefaults]persistentDomainForName:@"com.popsicletreehouse.housekeepingprefs"];
int timeBetweenClears = [[bundleDefaults objectForKey:@"timeBetweenCleats"]intValue];
bool isEnabled = [[bundleDefaults objectForKey:@"isEnabled"]boolValue];

%hook SBFLockscreenDateViewController
-(void)_updateView {
	if(isEnabled == true){
		%orig;
		NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
		[formatter setDateFormat:@"HH:mm"];
		NSDate *currentTime = [NSDate date];
		if(placeHolder) {
			firstTime = [NSDate date];
			placeHolder = NO;
		}
		if([firstTime compare:currentTime] == NSOrderedSame) placeHolder = YES;
		NSString *time1 = [formatter stringFromDate:firstTime];
		NSString *time2 = [formatter stringFromDate:currentTime];
		if([time1 rangeOfString:@":"].location != NSNotFound){
			[time1 stringByReplacingOccurrencesOfString:@":" withString:@""];
		}
		if([time2 rangeOfString:@":"].location != NSNotFound){
			[time2 stringByReplacingOccurrencesOfString:@":" withString:@""];
		}
		int currentTimeInt = [time1 intValue];
		int firstTimeInt = [time2 intValue];
		//compared as minutes
		if(currentTimeInt - firstTimeInt >= timeBetweenClears) {
			NSLog(@"Logged");
			clearNotifications = YES;
		}
	} else {
		%orig;
	}
}
%end

%hook BBServer
-(void)publishBulletin:(id)arg1 destinations:(unsigned long long)arg2 {
	%orig;
	BBBulletin *bulletin = ((BBBulletin *)arg1);
	if(clearNotifications){
		[self _clearBulletinIDs:@[bulletin.bulletinID] forSectionID:bulletin.sectionID shouldSync:YES];
	} else {
		%orig;
	}
	
}
%end