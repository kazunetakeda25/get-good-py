//
//  RestClient.h
//  getgood
//
//  Created by Dan on 4/28/18.
//  Copyright © 2018 PH. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppData.h"
#import "Temp.h"

@interface RestClient : NSObject
+ (void) getProfile:(void (^)(bool, NSDictionary*)) callback;

+ (void) checkMail:(NSString*) email name: (NSString*) name callback:(void (^)(bool, NSDictionary*)) callback;

+ (void) signup:(NSString*) email name: (NSString*)name avatar:(NSString*) avatar password:(NSString*) password callback:(void (^)(bool, NSDictionary*)) callback;
+ (void) verify:(NSString*) email callback:(void (^)(bool result, NSDictionary* data)) callback;

+ (void) login:(NSString*) email password:(NSString*) password callback:(void (^)(bool result, NSDictionary* data)) callback;

+ (void) forgotPassword:(NSString*) email callback:(void (^)(bool result, NSDictionary* data)) callback;

+ (void) updatePushToken:(NSString*) token callback:(void (^)(bool result, NSDictionary* data)) callback;

+ (void) checkGameID:(NSString*) gameID callback:(void (^)(bool result, NSDictionary* data)) callback;

+ (void) checkLoLGameID:(NSString*) gameID callback:(void (^)(bool result, NSDictionary* data)) callback;

+ (void) checkName:(NSString*) name callback:(void (^)(bool result, NSDictionary* data)) callback;

+ (void) updateProfile:(void (^)(bool result, NSDictionary* data)) callback;

+ (void) updateLoLProfile:(void (^)(bool result, NSDictionary* data)) callback;

+ (void) getPlayers:(int)nPage
               sort:(NSString*) sort
    playerRatingMax:(float) playerRatingMax
    playerRatingMin:(float) playerRatingMin
      gameRatingMax:(NSString*) gameRatingMax
      gameRatingMin:(NSString*) gameRatingMin
             server:(NSString*) server
           platform:(NSString*) platform
             online:(int) online
           category:(NSString*) category
            keyword:(NSString*) keyword
           callback:(void (^)(bool result, NSDictionary* data)) callback;

+ (void) createGroup:(NSString*) name description:(NSString*) description hero:(NSString*) hero callback:(void (^)(bool result, NSDictionary* data)) callback;

+ (void) getGroups:(int)nPage
              sort:(NSString*) sort
   playerRatingMax:(float) playerRatingMax
   playerRatingMin:(float) playerRatingMin
     gameRatingMax:(NSString*) gameRatingMax
     gameRatingMin:(NSString*) gameRatingMin
            server:(NSString*) server
          platform:(NSString*) platform
            online:(int) online
          category:(NSString*) category
           keyword:(NSString*) keyword
          callback:(void (^)(bool result, NSDictionary* data)) callback;

+ (void) createLesson:(NSString*) name description:(NSString*) description hero:(NSString*) hero videos:(NSString*) videos thumb_url:(NSString*) thumb_url price:(float) price callback:(void (^)(bool result, NSDictionary* data)) callback;


+ (void) getLessons:(int)nPage
               sort:(NSString*) sort
     coachRatingMax:(float) coachRatingMax
     coachRatingMin:(float) coachRatingMin
      gameRatingMax:(NSString*) gameRatingMax
      gameRatingMin:(NSString*) gameRatingMin
           priceMax:(float) priceMax
           priceMin:(float) priceMin
             server:(NSString*) server
           platform:(NSString*) platform
             online:(int) online
           category:(NSString*) category
            keyword:(NSString*) keyword
           callback:(void (^)(bool result, NSDictionary* data)) callback;

+ (void) getMyGroups:(void (^)(bool result, NSDictionary* data)) callback;

+ (void) updateGroup:(NSString*) id title:(NSString*) title description:(NSString*) description hero:(NSString*) hero ready:(NSString*) ready callback:(void (^)(bool result, NSDictionary* data)) callback;

+ (void) getMyLessons:(void (^)(bool result, NSDictionary* data)) callback;

+ (void) updateLesson:(NSString*) id title:(NSString*) title description:(NSString*) description hero:(NSString*) hero price:(float)price thumb_url:(NSString*) thumb_url videos:(NSString*) videos ready:(NSString*) ready callback:(void (^)(bool result, NSDictionary* data)) callback;

+ (void) getLessonsWithUserID:(NSString *)userID callback:(void (^)(bool result, NSDictionary* data)) callback;

+ (void) getGroupsWithUserID:(NSString *)userID callback:(void (^)(bool result, NSDictionary* data)) callback;

+ (void) readyProfile:(void (^)(bool result, NSDictionary* data)) callback;
+ (void) readyGroup:(NSString*) id callback:(void (^)(bool result, NSDictionary* data)) callback;
+ (void) readyLesson:(NSString*) id callback:(void (^)(bool result, NSDictionary* data)) callback;

+ (void) createDialog:(NSString*) type reference:(NSString*) reference_id receiver:(NSString*) rec_id callback:(void (^)(bool result, NSDictionary* data)) callback;
+ (void) readProfile:(NSString*) userID callback:(void (^)(bool result, NSDictionary* data)) callback;
+ (void) getDialogList:(void (^)(bool result, NSDictionary* data)) callback;
+ (void) sendMessage:(NSString*) dialog_id message:(NSString*) message type:(NSString*) type callback:(void (^)(bool result, NSDictionary* data)) callback;

+ (void) getDialog:(NSString*) dialog_id message_id:(int) message_id callback:(void (^)(bool result, NSDictionary* data)) callback;

+ (void) sendNotification:(NSString*) message user_id:(NSString*) user_id;
+ (void) sendSilentNotification:(NSString*) user_id dialogID:(NSString*) dialogID;

+ (void) logout;


+ (void) updateDialog:(NSString*) dialog_id state:(NSString*) state inviter_id:(NSString*) inviter_id block_id:(NSString*) block_id reference_id:(NSString*) reference_id callback:(void (^)(bool result, NSDictionary* data)) callback;

+ (void) joinGroup:(NSString*) group_id callback:(void (^)(bool result, NSDictionary* data)) callback;

+ (void) getLessonWithID:(NSString*) id callback:(void (^)(bool result, NSDictionary* data)) callback;

+ (void) postCoachReview:(NSString*) id comment:(NSString*) comment competency:(int) competency communication:(int)communication flexibility:(int) flexibility attitude:(int) attitude callback:(void (^)(bool result, NSDictionary* data)) callback;

+ (void) postTraineeReview:(NSString*) id comment:(NSString*) comment general:(int) general callback:(void (^)(bool result, NSDictionary* data)) callback;


+ (void) getGroupWithID:(NSString*) id callback:(void (^)(bool result, NSDictionary* data)) callback;

+ (void) getUsersWithIDs:(NSString*) ids callback:(void (^)(bool result, NSDictionary* data)) callback;

+ (void) leaveGroup:(NSString*) id callback:(void (^)(bool result, NSDictionary* data)) callback;

+ (void) applyGroup:(NSString*) id callback:(void (^)(bool result, NSDictionary* data)) callback;

+ (void) joinUserGroup:(NSString*) id user:(NSString*) user_id callback:(void (^)(bool result, NSDictionary* data)) callback;

+ (void) kick:(NSString*) id user:(NSString*) user_id callback:(void (^)(bool result, NSDictionary* data)) callback;

+ (void) getGroupMessages:(NSString*) id callback:(void (^)(bool result, NSDictionary* data)) callback;

+ (void) deleteGroup:(NSString*) id callback:(void (^)(bool result, NSDictionary* data)) callback;
+ (void) deleteLesson:(NSString*) id callback:(void (^)(bool result, NSDictionary* data)) callback;

+ (void) postPlayerReview:(NSString*) to_id
                   leader:(int) leader
              cooperative:(int) cooperative
       good_communication:(int) good_communication
            sportsmanship:(int) sportsmanship
                      mvp:(int) mvp
              flex_player:(int) flex_player
     good_hero_competency:(int) good_hero_competency
                 griefing:(int) griefing
                   spam:(int) spam
                   no_communication:(int) no_communication
                   un_cooperative:(int) un_cooperative
                   trickling_in:(int) trickling_in
                 poor_hero_competency:(int) poor_hero_competency
                 bad_ultimate_usage:(int) bad_ultimate_usage
                 overextending:(int) overextending
                 comment:(NSString*) comment
                 abusive_chat:(int) abusive_chat
                 good_ultimate_usage:(int) good_ultimate_usage
                 callback:(void (^)(bool result, NSDictionary* data)) callback;


+ (void) getAdminPost:(void (^)(bool result, NSDictionary* data)) callback;


+ (void) createThread:(NSString*) title description:(NSString*) description callback:(void (^)(bool result, NSDictionary* data)) callback;

+ (void) getThreadList:(int) page keyword:(NSString*) keyword callback:(void (^)(bool result, NSDictionary* data)) callback;


+ (void) getCommentList:(NSString*) thread reference:(NSString*) reference  callback:(void (^)(bool result, NSDictionary* data)) callback;

+ (void) addComment:(NSString*) comment thread:(NSString*) thread reference:(NSString*) reference  callback:(void (^)(bool result, NSDictionary* data)) callback;

+ (void) getLikes:(NSString*) id callback:(void (^)(bool result, NSDictionary* data)) callback;

+ (void) addLike:(NSString*) id like: (NSString*) like callback:(void (^)(bool result, NSDictionary* data)) callback;

+ (void) getActivities:(void (^)(bool result, NSDictionary* data)) callback;

+ (void) getLastDialogTimestamp:(void (^)(bool result, NSDictionary* data)) callback;

+ (void) getLastGroupTimestamp:(void (^)(bool result, NSDictionary* data)) callback;

+ (void) getParticipatingGroups:(void (^)(bool result, NSDictionary* data)) callback;


+ (void) getCoachReview:(NSString*) id callback: (void (^)(bool result, NSDictionary* data)) callback;

+ (void) getTraineeReview:(NSString*) id callback: (void (^)(bool result, NSDictionary* data)) callback;

+ (void) getPlayerReview:(NSString*) id callback: (void (^)(bool result, NSDictionary* data)) callback;

+ (void) online;

+ (void) sendFeedback:(NSString*) content callback:(void (^)(bool result, NSDictionary* data)) callback;
@end
