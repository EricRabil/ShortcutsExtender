#import <UIKit/UIViewController.h>

@protocol WFTriggerConfigurationViewControllerDelegate <NSObject>
@required
-(void)triggerConfigurationViewController:(id)arg1 didFinishWithTrigger:(id)arg2;
@end;

@interface WFDatabase : NSObject
@end;

@interface WFTrigger: NSObject
+ (BOOL)isAllowedToRunAutomatically;
+ (NSString*)localizedDisplayName;
+ (NSString*)localizedDisplayExplanation;
+ (id)triggerTypeIcon;
@end;

@interface WFTriggerManager : NSObject {
	WFDatabase* _database;
}

@property (nonatomic,readonly) WFDatabase * database;              //@synthesize database=_database - In the implementation block
-(WFDatabase *)database;
-(id)initWithDatabase:(id)arg1 ;
-(id)allConfiguredTriggers;
-(void)saveNewConfiguredTrigger:(id)arg1 workflow:(id)arg2 notifyDaemon:(BOOL)arg3 completion:(/*^block*/id)arg4 ;
-(void)saveNewConfiguredTrigger:(id)arg1 workflowReference:(id)arg2 notifyDaemon:(BOOL)arg3 completion:(/*^block*/id)arg4 ;
-(void)updateConfiguredTrigger:(id)arg1 triggerID:(id)arg2 notifyDaemon:(BOOL)arg3 completion:(/*^block*/id)arg4 ;
-(void)deleteTriggerWithIdentifier:(id)arg1 notifyDaemon:(BOOL)arg2 completion:(/*^block*/id)arg3 ;
-(id)configuredTriggerWithID:(id)arg1 ;
@end;


@interface WFTriggerConfigurationViewController : UIViewController {

	WFTrigger* _trigger;
	id<WFTriggerConfigurationViewControllerDelegate> _delegate;
	WFTriggerManager* _triggerManager;
	unsigned long long _mode;

}

@property (nonatomic,readonly) WFTriggerManager * triggerManager;                                           //@synthesize triggerManager=_triggerManager - In the implementation block
@property (nonatomic,readonly) unsigned long long mode;                                                     //@synthesize mode=_mode - In the implementation block
@property (nonatomic,retain) WFTrigger * trigger;                                                           //@synthesize trigger=_trigger - In the implementation block
@property (assign,nonatomic) id<WFTriggerConfigurationViewControllerDelegate> delegate;              //@synthesize delegate=_delegate - In the implementation block
-(unsigned long long)mode;
-(WFTrigger *)trigger;
-(void)finish;
-(void)viewDidLoad;
-(void)dismiss:(id)arg1 ;
-(void)setDelegate:(id<WFTriggerConfigurationViewControllerDelegate>)arg1 ;
-(id<WFTriggerConfigurationViewControllerDelegate>)delegate;
-(void)setTrigger:(WFTrigger *)arg1 ;
-(WFTriggerManager *)triggerManager;
-(BOOL)isModalInPresentation;
-(id)initWithTrigger:(id)arg1 triggerManager:(id)arg2 mode:(unsigned long long)arg3 ;
-(void)updateNextButtonEnabledState;
@end;

@interface WFAction
- (NSInteger)rateLimitTimeout;
- (NSInteger)rateLimitThreshold;
- (NSInteger)rateLimitDelay;
- (NSString*)identifier;
@end;

@interface VCUserNotificationManager
-(BOOL)postNotificationOfType:(unsigned long long)arg1 forTrigger:(id)arg2 workflowReference:(id)arg3 removeDeliveredNotifications:(BOOL)arg4 pendingTriggerEventIDs:(id)arg5 actionIcons:(id)arg6 error:(id*)arg7 ;
-(BOOL)_postNotificationOfType:(unsigned long long)arg1 forTrigger:(id)arg2 workflowReference:(id)arg3 removeDeliveredNotifications:(BOOL)arg4 pendingTriggerEventIDs:(id)arg5 actionIcons:(id)arg6 error:(id*)arg7 ;
@end;

@interface WFSleepTrigger: WFTrigger
@end;

@interface WFAppInFocusTrigger: WFTrigger
@end;

@interface WFEmailTrigger: WFTrigger
@end;

@interface WFMessageTrigger: WFTrigger
- (BOOL)requiresEventInfoAsInput;
@end;

@interface WFPlugInTrigger: WFTrigger
@end;

@interface WFBatteryLevelTrigger: WFTrigger
@end;

@interface WFAlarmTrigger: WFTrigger
@end;

@interface WFWorkoutTrigger: WFTrigger
@end;

@interface WFAppInBackgroundTrigger: WFTrigger
@end;

@interface WFDNDTrigger: WFTrigger
@end;

@interface WFLowPowerModeTrigger: WFTrigger
@end;

@interface WFCarPlayConnectionTrigger: WFTrigger
@end;

@interface WFAirplaneModeTrigger: WFTrigger
@end;

@interface WFTimeOfDayTrigger: WFTrigger
@end;

@interface WFWifiTrigger: WFTrigger
@end;

@interface WFAutomationSelectTypeViewController
+(NSArray<NSArray*>*)allTriggerTypeGroups;
@end;

BOOL isRateLimitingDisabled(WFAction* action) {
	// return [[action identifier] isEqualToString:@"is.workflow.actions.sendmessage"];
	return YES;
}

BOOL shouldAllAutomationsAllowBackgroundRun() {
	return YES;
}

%hook WFAction
- (NSInteger)rateLimitTimeout {
	if (isRateLimitingDisabled(self) == NO) {
		return %orig;
	} else {
		return 0;
	}
}
- (NSInteger)rateLimitThreshold {
	if (isRateLimitingDisabled(self) == NO) {
		return %orig;
	} else {
		return 0;
	}
}
- (NSInteger)rateLimitDelay {
	if (isRateLimitingDisabled(self) == NO) {
		return %orig;
	} else {
		return 0;
	}
}
%end

%hook WFTrigger
+ (BOOL)isAllowedToRunAutomatically {
	return shouldAllAutomationsAllowBackgroundRun() ? YES : %orig;
}
%end

%hook WFSleepTrigger
+ (BOOL)isAllowedToRunAutomatically {
	return shouldAllAutomationsAllowBackgroundRun() ? YES : %orig;
}
%end
%hook WFAppInFocusTrigger
+ (BOOL)isAllowedToRunAutomatically {
	return shouldAllAutomationsAllowBackgroundRun() ? YES : %orig;
}
%end
%hook WFEmailTrigger
+ (BOOL)isAllowedToRunAutomatically {
	return shouldAllAutomationsAllowBackgroundRun() ? YES : %orig;
}
%end
%hook WFMessageTrigger
+ (BOOL)isAllowedToRunAutomatically {
	return shouldAllAutomationsAllowBackgroundRun() ? YES : %orig;
}
%end
%hook WFPlugInTrigger
+ (BOOL)isAllowedToRunAutomatically {
	return shouldAllAutomationsAllowBackgroundRun() ? YES : %orig;
}
%end
%hook WFBatteryLevelTrigger
+ (BOOL)isAllowedToRunAutomatically {
	return shouldAllAutomationsAllowBackgroundRun() ? YES : %orig;
}
%end
%hook WFAlarmTrigger
+ (BOOL)isAllowedToRunAutomatically {
	return shouldAllAutomationsAllowBackgroundRun() ? YES : %orig;
}
%end
%hook WFWorkoutTrigger
+ (BOOL)isAllowedToRunAutomatically {
	return shouldAllAutomationsAllowBackgroundRun() ? YES : %orig;
}
%end
%hook WFAppInBackgroundTrigger
+ (BOOL)isAllowedToRunAutomatically {
	return shouldAllAutomationsAllowBackgroundRun() ? YES : %orig;
}
%end
%hook WFDNDTrigger
+ (BOOL)isAllowedToRunAutomatically {
	return shouldAllAutomationsAllowBackgroundRun() ? YES : %orig;
}
%end
%hook WFLowPowerModeTrigger
+ (BOOL)isAllowedToRunAutomatically {
	return shouldAllAutomationsAllowBackgroundRun() ? YES : %orig;
}
%end
%hook WFCarPlayConnectionTrigger
+ (BOOL)isAllowedToRunAutomatically {
	return shouldAllAutomationsAllowBackgroundRun() ? YES : %orig;
}
%end
%hook WFAirplaneModeTrigger
+ (BOOL)isAllowedToRunAutomatically {
	return shouldAllAutomationsAllowBackgroundRun() ? YES : %orig;
}
%end
%hook WFTimeOfDayTrigger
+ (BOOL)isAllowedToRunAutomatically {
	return shouldAllAutomationsAllowBackgroundRun() ? YES : %orig;
}
%end
%hook WFWifiTrigger
+ (BOOL)isAllowedToRunAutomatically {
	return shouldAllAutomationsAllowBackgroundRun() ? YES : %orig;
}
%end

%hook VCUserNotificationManager
-(BOOL)postNotificationOfType:(unsigned long long)arg2 forTrigger:(id)arg3 workflowReference:(id)arg4 removeDeliveredNotifications:(BOOL)arg5 pendingTriggerEventIDs:(id)arg6 actionIcons:(id)arg7 error:(id*)arg8 {
	[self _postNotificationOfType:arg2 forTrigger:arg3 workflowReference:arg4 removeDeliveredNotifications:arg5 pendingTriggerEventIDs:arg6 actionIcons:arg7 error:nil];
	return YES;
}
%end

@interface WFCustomTrigger: WFTrigger
@end

%subclass WFCustomTrigger: WFTrigger
%new
+ (NSString*)localizedDisplayName {
	return @"ShortcutsExtender Trigger";
}
%new
+ (NSString*)localizedDisplayExplanation {
	return @"Integrate with a custom Shortcuts trigger";
}
%new
+ (BOOL)isAllowedToRunAutomatically {
	return YES;
}
%new
+ (id)triggerTypeIcon {
	return [%c(WFAppInFocusTrigger) triggerTypeIcon];
}
%end

%subclass WFCustomTriggerConfigurationViewController: WFTriggerConfigurationViewController
%end

%hook WFAutomationSelectTypeViewController
+(NSArray<NSArray*>*)allTriggerTypeGroups {
	NSMutableArray<NSArray*>* coreGroups = [%orig mutableCopy];

	[coreGroups addObject:@[
		%c(WFCustomTrigger)
	]];

	return coreGroups;
}
%end