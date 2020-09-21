//
//  DataArrays.m
//  getgood
//
//  Created by Md Aminuzzaman on 2/12/17.
//  Copyright © 2017 PH. All rights reserved.
//

#import "DataArrays.h"

@implementation DataArrays

+ (NSArray *) profileServer
{
    static NSArray *profileServer;
    
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken,
    ^{
        profileServer = @[@"Americas",
                          @"Europe",
                          @"Asia"];
        
    });
    
    return profileServer;
}
+ (NSString*) getRegionCode:(NSString*) strSerer
{
    if([strSerer isEqualToString:@"Americas"])
        return @"us";
    
    if([strSerer isEqualToString:@"Europe"])
        return @"eu";
    
    if([strSerer isEqualToString:@"Asia"])
        return @"kr";
    
    return @"";
    
}

+ (NSString*) getRegionName:(NSString*) strCode
{
    if([strCode isEqualToString:@"us"])
        return @"Americas";
    
    if([strCode isEqualToString:@"eu"])
        return @"Europe";
    
    if([strCode isEqualToString:@"kr"])
        return @"Asia";
    
    return @"";
}
+ (NSArray *) profileServerValue
{
    static NSArray *profileServerValue;
    
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken,
                  ^{
                      profileServerValue = @[@"us",
                                             @"eu",
                                             @"kr"];
                      
                  });
    
    return profileServerValue;
}

+ (NSArray *) server
{
    static NSArray *server;
    
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken,
                  ^{
                      server = @[@"All",
                                 @"Americas",
                                 @"Europe",
                                 @"Asia"];
                      
                  });
    
    return server;
}


+ (NSArray *) serverValue
{
    static NSArray *serverValue;
    
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken,
                  ^{
                      serverValue = @[@"all",
                                      @"us",
                                      @"eu",
                                      @"kr"];
                  });
    
    return serverValue;
}


+ (NSArray *) platformValue
{
    static NSArray *serverValue;
    
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken,
                  ^{
                      serverValue = @[@"all",
                                      @"pc",
                                      @"xbox",
                                      @"ps4"];
                  });
    
    return serverValue;
}


+ (NSArray *) lol_heroes
{
    static NSArray *category;
    
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken,
                  ^{
                      category = @[
                                   @"Aatrox",
                                   @"Ahri",
                                   @"Akali",
                                   @"Alistar",
                                   @"Amumu",
                                   @"Anivia",
                                   @"Annie",
                                   @"Ashe",
                                   @"AurelionSol",
                                   @"Azir",
                                   @"Bard",
                                   @"Blitzcrank",
                                   @"Brand",
                                   @"Braum",
                                   @"Caitlyn",
                                   @"Camille",
                                   @"Cassiopeia",
                                   @"Chogath",
                                   @"Corki",
                                   @"Darius",
                                   @"Diana",
                                   @"Draven",
                                   @"DrMundo",
                                   @"dugx85",
                                   @"Ekko",
                                   @"Elise",
                                   @"Evelynn",
                                   @"Ezreal",
                                   @"Fiddlesticks",
                                   @"Fiora",
                                   @"Fizz",
                                   @"Galio",
                                   @"Gangplank",
                                   @"Garen",
                                   @"Gnar",
                                   @"Gragas",
                                   @"Graves",
                                   @"Hecarim",
                                   @"Heimerdinger",
                                   @"Illaoi",
                                   @"Irelia",
                                   @"Ivern",
                                   @"Janna",
                                   @"JarvanIV",
                                   @"Jax",
                                   @"Jayce",
                                   @"Jhin",
                                   @"Jinx",
                                   @"Kaisa",
                                   @"Kalista",
                                   @"Karma",
                                   @"Karthus",
                                   @"Kassadin",
                                   @"Katarina",
                                   @"Kayle",
                                   @"Kayn",
                                   @"Kennen",
                                   @"Khazix",
                                   @"Kindred",
                                   @"Kled",
                                   @"KogMaw",
                                   @"Leblanc",
                                   @"LeeSin",
                                   @"Leona",
                                   @"Lissandra",
                                   @"Lucian",
                                   @"Lulu",
                                   @"Lux",
                                   @"Malphite",
                                   @"Malzahar",
                                   @"Maokai",
                                   @"MasterYi",
                                   @"MissFortune",
                                   @"MonkeyKing",
                                   @"Mordekaiser",
                                   @"Morgana",
                                   @"Nami",
                                   @"Nasus",
                                   @"Nautilus",
                                   @"Nidalee",
                                   @"Nocturne",
                                   @"Nunu",
                                   @"Olaf",
                                   @"Orianna",
                                   @"Ornn",
                                   @"Pantheon",
                                   @"Poppy",
                                   @"Pyke",
                                   @"Quinn",
                                   @"Rakan",
                                   @"Rammus",
                                   @"RekSai",
                                   @"Renekton",
                                   @"Rengar",
                                   @"Riven",
                                   @"Rumble",
                                   @"Ryze",
                                   @"Sejuani",
                                   @"Shaco",
                                   @"Shen",
                                   @"Shyvana",
                                   @"Singed",
                                   @"Sion",
                                   @"Sivir",
                                   @"Skarner",
                                   @"Sona",
                                   @"Soraka",
                                   @"Swain",
                                   @"Syndra",
                                   @"TahmKench",
                                   @"Taliyah",
                                   @"Talon",
                                   @"Taric",
                                   @"Teemo",
                                   @"Thresh",
                                   @"Tristana",
                                   @"Trundle",
                                   @"Tryndamere",
                                   @"TwistedFate",
                                   @"Twitch",
                                   @"Udyr",
                                   @"Urgot",
                                   @"Varus",
                                   @"Vayne",
                                   @"Veigar",
                                   @"Velkoz",
                                   @"Vi",
                                   @"Viktor",
                                   @"Vladimir",
                                   @"Volibear",
                                   @"Warwick",
                                   @"Xayah",
                                   @"Xerath",
                                   @"XinZhao",
                                   @"Yasuo",
                                   @"Yorick",
                                   @"Zac",
                                   @"Zed",
                                   @"Ziggs",
                                   @"Zilean",
                                   @"Zoe",
                                   @"Zyra"
                                   ];
                      
                  });
    
    return category;
}


+ (NSArray *) lol_categories
{
    static NSArray *category;
    
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken,
                  ^{
                      category = @[
                                   @"Top Lane",
                                   @"ADC",
                                   @"Mid Lane",
                                   @"Jungler",
                                   @"Support"
                                   ];
                      
                  });
    
    return category;
}


+ (NSArray *) lol_categories_values
{
    static NSArray *category;
    
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken,
                  ^{
                      category = @[
                                   @"Top_Lane",
                                   @"ADC",
                                   @"Mid_Lane",
                                   @"Jungler",
                                   @"Lol_Support"
                                   ];
                      
                  });
    
    return category;
}


+ (NSArray *) category
{
    static NSArray *category;
    
    static dispatch_once_t onceToken;

    dispatch_once(&onceToken,
                  ^{
                      category = @[@"Ana",
                                   @"Bastion",
                                   @"Brigitte",
                                   @"Dva",
                                   @"Doomfist",
                                   @"Genji",
                                   @"Hanzo",
                                   @"Junkrat",
                                   @"Lucio",
                                   @"Mcree",
                                   @"Mei",
                                   @"Mercy",
                                   @"Orisa",
                                   @"Pharah",
                                   @"Reaper",
                                   @"Reinhardt",
                                   @"Roadhog",
                                   @"Soldier:76",
                                   @"Sombra",
                                   @"Symmetra",
                                   @"Torbjorn",
                                   @"Tracer",
                                   @"Widowmaker",
                                   @"Winston",
                                   @"Wrecking_Ball",
                                   @"Zarya",
                                   @"Zenyatta"];
                      
                  });
    
    return category;
}

+(NSArray *)TankHeroes{
    
    static NSArray *tankhero;
    
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken,
                  ^{
                      tankhero = @[@"Reinhardt",
                                   @"Winston",
                                   @"Dva",
                                   @"Zarya",
                                   @"Orisa",
                                   @"Roadhog"
                                   ];
                      
                  });
    
    return tankhero;
}

+(NSArray *)CategoryGroups{
    
    static NSArray *tankhero;
    
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken,
                  ^{
                      tankhero = @[@"Tank",
                                   @"Dps",
                                   @"Support",
                                   @"Flex"
                                   ];
                      
                  });
    
    return tankhero;
}


+(NSArray *)DpsHeroes{
    
    static NSArray *dpshero;
    
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken,
                  ^{
                      dpshero = @[@"Reaper",
                                  @"Soldier:76",
                                  @"Pharah",
                                  @"Tracer",
                                  @"Doomfist",
                                  @"Junkrat",
                                  @"Genji",
                                  @"Bastion",
                                  @"Torbjorn",
                                  @"Widowmaker",
                                  @"Hanzo",
                                  @"Mcree",
                                  @"Sombra",
                                  @"Mei"
                                 ];
                      
                    });
    
    return dpshero;
    
}

+(NSArray *)SupportHeroes{
    
    static NSArray *Supporthero;
    
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken,
                  ^{
                      Supporthero = @[
                                  @"Mercy",
                                  @"Zenyatta",
                                  @"Moira",
                                  @"Ana",
                                  @"Symmetra",
                                  @"Lucio"
                                  ];
                      
                  });
    
    return Supporthero;
    
}

+ (NSArray *) sort
{
    static NSArray *sort;
    
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken,
                  ^{
                      sort = @[@"Popular",
                               @"Recent",
                               @"Coach Rating",
                               @"Player Rating",
                               @"In-game Rating",
                               @"List down all player attributes",
                               @"Most improved player rating",
                               @"Online",
                               @"Offline",
                               @"In-session"];
                      
                  });
    
    return sort;
}

+ (NSArray *) hero
{
    static NSArray *hero;
    
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken,
                  ^{
                      hero = @[@"Winstone",
                               @"Dune",
                               @"Ronaldo"];
                      
                  });
    
    return hero;
}

+ (NSArray *) coachMode
{
    static NSArray *coachMode;
    
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken,
                  ^{
                      coachMode = @[@"VOD",
                                    @"Live Stream"];
                      
                  });
    
    return coachMode;
}

+ (NSArray *) gameRegions
{
    static NSArray *gameRegions;
    
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken,
                  ^{
                      gameRegions = @[@"Americas",
                                      @"Europe",
                                      @"Asia"];
                      
                  });
    
    return gameRegions;
}



+ (NSArray *) gameRegionCodes
{
    static NSArray *gameRegionCodes;
    
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken,
                  ^{
                      gameRegionCodes = @[@"us",
                                          @"eu",
                                          @"kr"];
                    });
    
    return gameRegionCodes;
}



+ (NSArray *) lolFilterServerNames
{
    static NSArray *gameRegions;
    
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken,
                  ^{
                      gameRegions = @[
                                      @"All",
                                      @"Brazil",
                                      @"Europe Nordic & East",
                                      @"Europe West",
                                      @"Latin America North",
                                      @"Latin America South",
                                      @"North America",
                                      @"Oceania",
                                      @"Russia",
                                      @"Turkey",
                                      @"Japan"
                                      ];
                      
                  });
    
    return gameRegions;
}

+ (NSArray *) lolFilterServerValues
{
    static NSArray *gameRegions;
    
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken,
                  ^{
                      gameRegions = @[
                                      @"all",
                                      @"br",
                                      @"eune",
                                      @"euw",
                                      @"lan",
                                      @"las",
                                      @"na",
                                      @"oce",
                                      @"ru",
                                      @"tr",
                                      @"jp"
                                      ];
                      
                  });
    
    return gameRegions;
}

+ (NSArray *) lolServerNames
{
    static NSArray *gameRegions;
    
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken,
                  ^{
                      gameRegions = @[
                                      @"Brazil",
                                      @"Europe Nordic & East",
                                      @"Europe West",
                                      @"Latin America North",
                                      @"Latin America South",
                                      @"North America",
                                      @"Oceania",
                                      @"Russia",
                                      @"Turkey",
                                      @"Japan"
                                      ];
                      
                  });
    
    return gameRegions;
}

+ (NSArray *) lolServerValues
{
    static NSArray *gameRegions;
    
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken,
                  ^{
                      gameRegions = @[
                                      @"br",
                                      @"eune",
                                      @"euw",
                                      @"lan",
                                      @"las",
                                      @"na",
                                      @"oce",
                                      @"ru",
                                      @"tr",
                                      @"jp"
                                      ];
                      
                  });
    
    return gameRegions;
}

+ (NSArray *) lolServerEndPoints
{
    static NSArray *gameRegions;
    
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken,
                  ^{
                      gameRegions = @[
                                      @"br1",
                                      @"eun1",
                                      @"euw1",
                                      @"la1",
                                      @"la2",
                                      @"na1",
                                      @"oc1",
                                      @"ru",
                                      @"tr1",
                                      @"jp1"
                                      ];
                      
                  });
    
    return gameRegions;
}

+ (NSArray *) lolRanks
{
    static NSArray *gameRegions;
    
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken,
                  ^{
                      gameRegions = @[
                                      @"",
                                      @"BRONZE I",
                                      @"BRONZE II",
                                      @"BRONZE III",
                                      @"BRONZE IV",
                                      @"BRONZE V",
                                      @"SILVER I",
                                      @"SILVER II",
                                      @"SILVER III",
                                      @"SILVER IV",
                                      @"SILVER V",
                                      @"GOLD I",
                                      @"GOLD II",
                                      @"GOLD III",
                                      @"GOLD IV",
                                      @"GOLD V",
                                      @"PLATINUM I",
                                      @"PLATINUM I",
                                      @"PLATINUM I",
                                      @"PLATINUM I",
                                      @"PLATINUM V",
                                      @"DIAMOND I",
                                      @"DIAMOND II",
                                      @"DIAMOND III",
                                      @"DIAMOND IV",
                                      @"DIAMOND V"
                                      ];
                      
                  });
    
    return gameRegions;
}

+ (NSArray *) heroes
{
    static NSArray *heroes;
    
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken,
                  ^{
                      heroes = @[@"Ana",
                                 @"Junkrat",
                                 @"Sombra",
                                 @"Dva",
                                 @"Genji",
                                 @"Reinhardt",
                                 @"Zarya",
                                 @"Pharah",
                                 @"Orisa",
                                 @"Lucio",
                                 @"Reaper",
                                 @"Mercy",
                                 @"Doomfist",
                                 @"Bastion",
                                 @"Brigitte",
                                 @"Zenyatta",
                                 @"Hanzo",
                                 @"Roadhog",
                                 @"Soldier76",
                                 @"Mei",
                                 @"Symmetra",
                                 @"McCree",
                                 @"Winston",
                                 @"Wrecking_Ball",
                                 @"Tracer",
                                 @"Windowmaker"];
                      
                  });
    
    return heroes;
}
+ (NSArray *) PlayerChatSelfInfromation{
  
    static NSArray *Infromation;
    
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken,
                  ^{
                      Infromation = @[@"Congrats ! You made a offer! Please wait until coach accepts your offer.",
                        
                        @"Congrats ! You made a deal! Continue chatting with the trainee to arrange details for coaching session and payment. You may leave each other feedback.",
                        
                        @"You blocked user to chat.",
                                      
                        @"You unblocked user to chat.",
                                   
                        @"Congrats ! You made a offer with coin! Please wait until coach accepts your offer.",
                        
                        @"Congrats ! You invited player to group. Please wait until the player accepts your invitation.",
                                      
                        @"Congrats! You accepted the invitation. Please communicate with your group in the groupchat and enjoy playing together. Remember to rate your groupmates and leave your feedback!",
                                      
                        ];
                      
                  });
    
    return Infromation;
}
+ (NSArray *) PlayerChatPatnerInfromation{
    
    static NSArray *Infromation;
    
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken,
                  ^{
                      Infromation = @[@"Congrats! Trainee offered you a deal. Please discuss about the offer and accept if you like.",
                                      
                        @"Congrats ! Coach made a deal! Continue chatting with the coach to arrange details for coaching session and payment. You may leave each other feedback.",
                                      
                        @"User blocked you to chat.",
                                      
                        @"User unblocked you to chat.",
                                      
                        @"Congrats! Trainee offered you a deal with coin. Please discuss about the offer and accept if you like.",
                                      
                        @"Congrats! You are invited to group. Please accept if you would like to play with him/her.",
                                      
                        @"Congrats ! The player accepted your invitation. Please enjoy playing together.",
                                      
                        ];
                      
                  });
    
    return Infromation;
}
@end
