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

@interface WFTrigger
+ (BOOL)isAllowedToRunAutomatically;
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

BOOL isRateLimitingDisabled(WFAction* action) {
	return [[action identifier] isEqualToString:@"is.workflow.actions.sendmessage"];
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

%hook VCUserNotificationManager
-(BOOL)postNotificationOfType:(unsigned long long)arg2 forTrigger:(id)arg3 workflowReference:(id)arg4 removeDeliveredNotifications:(BOOL)arg5 pendingTriggerEventIDs:(id)arg6 actionIcons:(id)arg7 error:(id*)arg8 {
	[self _postNotificationOfType:arg2 forTrigger:arg3 workflowReference:arg4 removeDeliveredNotifications:arg5 pendingTriggerEventIDs:arg6 actionIcons:arg7 error:nil];
	return YES;
}
%end