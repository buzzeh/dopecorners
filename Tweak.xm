static bool enabled = true;
static CGFloat radius = 4;


%hook UIAlertController
- (void)viewWillAppear:(BOOL)arg1{
	%orig; //lets run the original method
	
	if(enabled){ //lets check if the tweak is enabled
		CGFloat conRadius = radius; //lets change the conRadius to the custom value the user has inputed via PSSliderCell
		for (UIView *subview in [self.view subviews]) //lets go into the rabbit hole
		{
				for (UIView *subview2 in [subview subviews]) //hmmm, seems like we must go deeper
				{
					[subview2.layer setCornerRadius:conRadius];
						for (UIView *subview3 in [subview2 subviews]) //ok....even deeper now...
						{	
							[subview3.layer setCornerRadius:conRadius];
							for (UIView *subview4 in [subview3 subviews]) // wtf Apple, how deep is this??
							{
								[subview4.layer setCornerRadius:conRadius]; //found it, value from PSSliderCell will be used instead
							}					
						}
				}
		}
	}
}
%end

static void loadPrefs() //preference loading
{
    NSMutableDictionary *prefs = [[NSMutableDictionary alloc] initWithContentsOfFile:@"/var/mobile/Library/Preferences/com.dopeteam.dopecorners.plist"];
    if (prefs)  {
        enabled =  ( [prefs objectForKey:@"enabled"] ? [[prefs objectForKey:@"enabled"] boolValue] : enabled );
        radius = [prefs objectForKey:@"radius"] ? [[prefs objectForKey:@"radius"] floatValue] : radius;

    }
    [prefs release];
}

%ctor 
{
    CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(), NULL, (CFNotificationCallback)loadPrefs, CFSTR("com.dopeteam.dopecorners/settingschanged"), NULL, CFNotificationSuspensionBehaviorCoalesce);
    loadPrefs();
    
}