//
//  ColorConstants.h
//  EDirectory
//
//  Created by Md Aminuzzaman on 9/9/17.
//  Copyright © 2017 Tappware. All rights reserved.
//

#ifndef ColorConstant_h
#define ColorConstant_h

#define  APP_NAV_BACKGROUND_COLOR        UIColorFromRGB(0x66338f)
#define  APP_VIEW_BACKGROUND_COLOR       UIColorFromRGB(0xe8e6e7)

#define  COLOR_LOGIN_BUTTON              UIColorFromRGB(0x107c10)
#define  COLOR_FOOTER_BACKGROUND         UIColorFromRGB(0x8EC44B)

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0];

#endif /* ColorConstant_h */

