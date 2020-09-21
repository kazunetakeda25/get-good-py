//
//  TermsController.m
//  getgood
//
//  Created by Md Aminuzzaman on 28/12/17.
//  Copyright © 2017 PH. All rights reserved.
//

#import "TermsController.h"


@interface TermsController ()

@end

@implementation TermsController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(actionBack:)];
    
    tapGestureRecognizer.numberOfTapsRequired = 1;
    [imageBack addGestureRecognizer:tapGestureRecognizer];
    imageBack.userInteractionEnabled = YES;
    
    NSString *htmlString = @"<div style=\"color: white;\"> \
    <ol> \
    <li><strong><u>TERMS OF USE</u></strong></li>\
    </ol>\
    <p>GetGood is an interactive mobile phone application (&ldquo;<strong>App</strong>&rdquo;) and website at <a href=\"http://www.getgood.com.sg\" style=\"color: white;\">www.GetGoodapp.com</a> (&ldquo;<strong>Website</strong>&rdquo;) developed by GetGoodapp.com (&ldquo;<strong>GetGood</strong>&rdquo; or the &ldquo;<strong>Company</strong>&rdquo;) to provide a venue to bring game players (&ldquo;<strong>Players</strong>&rdquo;) together, trainees (&ldquo;<strong>Trainees</strong>&rdquo;) and coaches (&ldquo;<strong>Coaches</strong>&rdquo;) of game coaching services (&ldquo;<strong>Coaching Services</strong>&rdquo;) and a venue to contribute content, information and other materials (collectively, &ldquo;<strong>Users</strong>&rdquo;) together with other Users (&ldquo;<strong>Services</strong>&rdquo;).</p> \
    \<p>GetGood is a technology company that does not directly provide gaming or Coaching Services and the Company is not a coaching provider or centre. It is up to the Users to join group listing pages and/or to post for requests and/or advertisements for game Coaching Services and for the other Users to accept such requests on the App and/or the Website.</p>\
      <p>The Company is not responsible nor liable for the acts and/or omissions of any Users.</p> \
            <p>These terms and conditions &ldquo;<strong>Terms</strong>&rdquo; govern our relationship with Users.</p> \
    \<p>By downloading, using or accessing GetGood, Users are deemed to have agreed to these Terms, as updated from time to time in accordance with Section 12 below.</p> \
     <ol start=\"2\"> \
    \ <li><strong><u>LICENCE</u></strong></li> \
    </ol> \
    <p></p> \
    <p>GetGood grants you a worldwide, non-exclusive, non-transferable, royalty-free revocable licence to download and use GetGood for your personal, non-commercial use in accordance with these Terms.</p> \
        <ol start=\"3\"> \
        <li><strong><u>INTELLECTUAL PROPERTY</u></strong></li> \
        </ol> \
        <ul> \
        <li>You own all of the content and information you post on GetGood including requests for Coaching Services, ads for Coaching Services, communications via private messaging, content, information and other materials (&ldquo;<strong>Content and Information</strong>&rdquo;).</li> \
            </ul> \
            <ul> \
            <li>For Content and Information that is covered by intellectual property rights like photos, you specifically grant us a non-exclusive, transferable, sub-licensable, royalty-free, worldwide license to use such Content and Information that you post on or in connection with GetGood (&ldquo;<strong>IP License</strong>&rdquo;). This IP License ends when you delete your IP content or your account unless your content has been shared with others and they have not deleted it.</li> \
            </ul> \
            <ul>\
            <li>The Intellectual Property in and to the App and/or Website (&ldquo;<strong>Website Materials</strong>&rdquo;) are owned, licensed to or controlled by us, our licensors or our Coaches. The trademarks, service marks, and logos (&ldquo;<strong>Trade Marks</strong>&rdquo;) contained on or in GetGood are owned by GetGood or its group companies or third-party partners of GetGood (&ldquo;<strong>Third Party Coaches</strong>&rdquo;). You cannot use, copy, edit, vary, reproduce, publish, display, distribute, store, transmit, commercially exploit or disseminate the Trade Marks without the prior written consent of GetGood, the relevant group company or the Third-Party Coaches.</li> \
            </ul> \
            <ol start=\"4\"> \
            <li><strong><u>REGISTRATION</u></strong></li> \
            </ol> \
            <p>4.1 Users are required to provide their real names and details when registering for a User account on the App or Website (&ldquo;<strong>Account</strong>&rdquo;) including:-</p> \
                <p>(a) in the case of Users who are individuals, their age, date of birth, address, email addresses, residential address, and contact details and password (&ldquo;<strong>Personal Information</strong>&rdquo;);</p> \
    <p>(b) in the case of Users who are companies, businesses, partnerships or other similar corporate entities, their business name, unique entity number, and registered office address and password (&ldquo;<strong>Corporate Information</strong>&rdquo;); and</p> \
    <p>(c) in the case of Coaches, their business name, unique entity number, and registered office address and password (&ldquo;<strong>Coach Information</strong>&rdquo;).</p> \
    <p>4.2 In connection with the foregoing, Users are deemed to warrant and represent to the Company that such Personal Information, Corporate Information or Coach Information (as the case may be) is accurate and up to date.</p> \
    <p>4.3 By registering an Account with the Company, Users also agree to the following:</p> \
    <p>(a) they will not provide any false personal information on the App and/or Website, or create an Account for anyone other than themselves without permission;</p> \
    <p>(b) they will not create more than one Account;</p> \
    <p>(c) if the Company disables their Account, they will not create another one without our permission;</p> \
    <p>(d) in the case of individuals, they will not use the App and/or Website if they are under 18; If individuals are under 18 years of age, they may only use the Services with the consent of and under the supervision of your parent or legal guardian who shall be responsible for all their activities</p> \
        <p>(e) they will keep their Personal Information, Corporate Information or Coach Information (as the case may be) accurate and up-to-date;</p> \
    <p>(f) they will not share their password, permit unauthorised access their Account, or do anything else that might jeopardise the security of their Account;</p> \
    <p>(g) they will not transfer their Accounts to any other parties without first getting the prior written consent of the Company; and</p> \
    <p>(h) if they select a username or similar identifier for their Account, the Company reserves the right to remove or reclaim it if we believe it is appropriate.</p> \
        <p>4.4 Access to and use of password protected and/or secure areas of the App and/or Website and/or use of the Services are restricted to Users with Accounts only. You may not obtain or attempt to obtain unauthorised access to such parts of this App and/or Website and/or Services through any means not intentionally made available by us for your specific use.</p> \
            <p>4.5 A breach of this provision may be an offence under the Computer Misuse Act (Chapter 50A) of Singapore.</p> \
            <ol start=\"5\"> \
            <li><strong><u>PERSONAL DATA</u></strong></li> \
            </ol> \
            <p></p> \
            <p>5.1 We collect the Personal Information, Corporate Information or Coach Information (as the case may be) which Users provide when Users use our Services, including when Users sign up for an Account, sell or purchase Coaching Services and message or communicate with a User.</p> \
                <p>5.2 Users are deemed to have agreed that (in the case of individuals Users), the Company may collect, use and disclose Personal Information, as provided in the registration section, for the purposes of processing your application for registration with the Company and the administration of your Account and unless you inform us otherwise, by registering for an Account, individual Users consent to us to sending them information about Coaches and Coaching Services.</p> \
                    <p>5.3 The Company may also collect information about how Users use our App and/or Website, such as the types of content viewed or engage with or the frequency and duration of their activities.</p> \
                    <p>5.5 We collect information from or about the computers, phones, or other devices where you install or access our App and/or Website, depending on the permissions you have granted. We may associate the information we collect from your different devices, which help us provide consistent Services across your devices. Here are some examples of the device information we collect:</p> \
                    <p>(a) attributes such as the operating system, hardware version, device settings, file and software names and types, battery and signal strength, and device identifiers;</p> \
    <p>(b) device locations, including specific geographic locations, such as through GPS, Bluetooth, or WiFi signals; and</p> \
    <p>(c) connection information such as the name of your mobile operator or ISP, browser type, language and time zone, mobile phone number and IP addresses.</p> \
    <p>5.6 <u>Cookies &amp; Tracking Technologies</u></p> \
    <p>GetGood uses a variety of technologies to help us better understand how people use our site and services.</p> \
    <p>A cookie is a small data file sent from a web site to your browser that is stored on your device. GetGood uses our own cookies for a number of purposes, including to access your information when you sign in; keep track of preferences you specify; display the most appropriate content based on your interests and activity on GetGood; estimate and report GetGood's total audience size and traffic; conduct research to improve our content and services. You can configure your device's settings to reflect your preference to accept or reject cookies. If you reject all cookies, you will not be able to take full advantage of GetGood's services.</p> \
    <p>GetGood may partner with third-party services who may use various tracking technologies, such as browser cookies or Flash cookies, to provide certain services or features. These technologies allow a partner to recognize your device each time you visit GetGood, but do not allow access to personally identifiable information from GetGood. GetGood does not have access or control over these third-party technologies, and they are not covered by our privacy statement.</p> \
        <ol start=\"6\"> \
        <li><strong><u>UNDERTAKINGS BY USERS</u></strong></li> \
        </ol> \
        <p>By using the App and/or Website, Users are deemed to warrant, represent and undertake to us as follows:-</p> \
        <p>6.1 <em>Not to mislead</em></p> \
        <p>They will not knowingly with intent to deceive the Company or other Users, post information relating to the purchase or sale of Coaching Services that are false or misleading including without limitation:-</p> \
        <ul> \
        <li>in the case of Coaches, posting for Coaching Services that you are unable or unwilling to fulfil;</li> \
    </ul> \
    <ul> \
    <li>in the case of Trainees, purchasing Coaching Services without the intention of completing the Customer Contract.</li> \
    </ul> \
    <p>6.2 <em>Illegal or unauthorised acts</em></p> \
    <p>By using the App and/or Website, Users agree not to do any of the following:-</p> \
        <ul> \
        <li>they will not post unauthorised commercial communications on the App and/or Website;</li> \
    </ul> \
    <ul> \
    <li>they will not collect other Users&rsquo; content or information, or otherwise access the App and/or Website, using automated means (such as harvesting bots, robots, spiders, or scrapers) without our prior permission;</li> \
    </ul> \
    <ul> \
    <li>they will not upload viruses or other malicious code onto the App and/or Website;</li> \
    </ul> \
    <ul> \
    <li>they will not solicit login information or access an Account belonging to someone else;</li> \
    </ul> \
    <ul> \
    <li>they will not bully, intimidate, or harass any User;</li> \
    </ul> \
    <ul> \
    <li>they will not post content that is hate speech, threatening, or pornographic, incites violence or contains nudity or graphic or gratuitous violence;</li> \
    </ul> \
    <ul> \
    <li>they will not use the App and/or Website to do anything unlawful, misleading, malicious, or discriminatory;</li> \
    </ul> \
    <ul> \
    <li>they will not solicit other Users for activities resulting in a User logging into the game account of another User including without limitation activities such as competitive rank boosting;</li> \
    </ul> \
    <ul> \
    <li>they will not do anything that could disable, overburden, or impair the proper working or appearance of the App and/or Website, such as a denial of service attack or interference with functionality; and</li> \
    </ul> \
    <ul> \
    <li>they will not facilitate or encourage any violation of these Terms.</li> \
    </ul> \
    <p>6.3 <em>Infringement of other user&rsquo;s rights</em></p> \
    <ul> \
    <li>Users shall not post content or take any action on the App and/or Website that infringes or violates someone else's rights or otherwise violates the law;</li> \
        </ul> \
        <ul> \
        <li>the Company reserves the right to remove any content or information you post on the App and/or Website if we believe that it violates these Terms;</li> \
    </ul> \
    <ul> \
    <li>If we remove your content for infringing someone else&rsquo;s copyright, and you believe we removed it by mistake, we will provide you with an opportunity to appeal;</li> \
    </ul> \
    <ul> \
    <li>If you repeatedly infringe other User&rsquo;s Intellectual Property, we will disable your Account when appropriate.</li> \
    </ul> \
    <ul> \
    <li>If you collect, use or disclose information including personal data (as defined in the Personal Data Protection Act 2012 of Singapore) from other users, you agree and undertake to us that you will: obtain their consent and expressly make it known that you (and not the Company) are the one collecting their information, and post a privacy policy explaining what information you collect and how you will use it.</li> \
    </ul> \
    <ul> \
    <li>You will not post anyone's identification documents or sensitive financial information on the App and/or Website.</li> \
    </ul> \
    <p>6.4 <em>Your submissions and information</em></p> \
    <ul> \
    <li>Submissions by you</li> \
    </ul> \
    <p>You grant us a non-exclusive licence to use the materials or information that you submit to the App and/or Website and/or provide to us, including but not limited to, questions, reviews, comments, and suggestions (collectively, &ldquo;<strong>Submissions</strong>&rdquo;).</p> \
    <p>When you post comments or reviews to the App and/or Website, you also grant us the right to use the name that you submit or your Username in connection with such review, comment, or other content.</p> \
    <p>You shall not use a false e-mail address, pretend to be someone other than yourself or otherwise mislead us or third parties as to the origin of any Submissions.</p> \
    <p>We may, but shall not be obligated to, publish, remove or edit your Submissions.</p> \
    <ul> \
    <li>You consent to and authorise the use by us of any information provided by you (including Personal Data) for the purposes of sending informational and promotional e-mails to you. You may subsequently opt out of receiving promotional e-mails by clicking on the appropriate hyperlink in any promotional e-mail.</li> \
        </ul> \
        <ol start=\"7\"> \
        <li><strong><u>USE OF APP AND WEBSITE</u></strong></li> \
        </ol> \
        <ul> \
        <li><u>Availability of App and/or Website and Services</u></li> \
        </ul> \
        <p>The Company may, from time to time and without giving any reason or prior notice, upgrade, modify, suspend or discontinue the provision of or remove, whether in whole or in part, the App and/or Website or any Services and shall not be liable if any such upgrade, modification, suspension or removal prevents you from accessing the App and/or Website or any part of the Services.</p> \
            <ul> \
            <li><u>Right, but not obligation, to monitor content</u></li> \
            </ul> \
            <p>The Company reserves the absolute and unconditional right to:</p> \
            <ul> \
            <li>monitor, screen or otherwise control any activity, content or material on the App and/or Website and/or through the Services. We may in our sole and absolute discretion, investigate any violation of the Terms and may take any action it deems appropriate;</li> \
    </ul> \
    <ul> \
    <li>prevent or restrict access of any User to the App and/or Website;</li> \
    </ul> \
    <ul> \
    <li>report any activity it suspects to be in violation of any applicable law, statute or regulation to the appropriate authorities and to co-operate with such authorities; and/or</li> \
    </ul> \
    <ul> \
    <li>request any information and data from you in connection with your use of the App and/or Website at any time and to exercise our right under this paragraph if you refuse to divulge such information and/or data or if you provide or if we have reasonable grounds to suspect that you have provided inaccurate, misleading or fraudulent information and/or data.</li> \
        </ul> \
        <p>7.3 <u>Re-routing to relevant game after login into the App and/or Website</u></p> \
        <ul> \
        <li>After login into GetGood, Users have the choice to login into any game that is supported by GetGood through &ldquo;my profile&rdquo; page.</li> \
    </ul> \
    <ul> \
    <li>GetGood will route you to the login client of the Selected Game whereupon you can enter you game login ID and the password for the Selected Game. For the avoidance of doubt, we do not retain any information of your Selected Game game login ID and password.</li> \
        </ul> \
        <ul> \
        <li>After login into a game account via GetGood, you can screen through the listings of other users and start chatting with other users. You can create coaching lessons, and group up with other users.</li> \
        </ul> \
        <ul> \
        <li>If you do not log into any game account, you can view the listings and chat with users but you cannot create coaching lessons or group up with any users.</li> \
            </ul> \
            <p>7.4<strong> </strong><u>User Listing and Group Listing Services</u></p> \
            <p></p> \
            <p>GetGood provides a User listing page and a group listing page for users to list their profile and search through the listing pages to search for prospective Users or groups to join.</p> \
                <p>Users can use the chat function in GetGood to discuss with other users in order to reach an agreement to group up.</p> \
                <p>The typical flow of events for use of User listing page is set out below:</p> \
                    <ul> \
                    <li>Screen and identify User in the User listing page who you intend to group up with</li> \
                    </ul> \
                    <ul> \
                    <li>Chat with the User to discuss and reach an agreement to group up</li> \
                    </ul> \
                    <ul> \
                    <li>Invite the User through by pressing &ldquo;Invite&rdquo; button in the chat window</li> \
    </ul> \
    <ul> \
    <li>Invited User accepts invitation to join your group</li> \
    </ul> \
    <ul> \
    <li>Every Users in the group will go into the actual game to group up in-game by adding each other's game ID. The game ID is displayed on the profile of each user in the \"Users\" tab.</li> \
    </ul> \
    <ul> \
    <li>When the group is ready, group leader will press &ldquo;start game&rdquo; on the app and all Users will be able to start rating each other in the app.</li> \
    </ul> \
    <ul> \
    <li>Group leader will start game in the actual game</li> \
    </ul> \
    <ul> \
    <li>Every User in the group can rate each other on the app after the actual game has ended</li> \
    </ul> \
    <p>The typical flow of event for use of Group listing page is set out below:</p> \
        <ul> \
        <li>Screen and identify group in the group listing page which you intend to group up with</li> \
        </ul> \
        <ul> \
        <li>Chat with the group leader to discuss and reach an agreement to join the group</li> \
        </ul> \
        <ul> \
        <li>you will receive an invite from the group leader when a &ldquo;accept&rdquo; button pop up in your chat. Press the &ldquo;Accept&rdquo; and enter the group</li> \
    </ul> \
    <ul> \
    <li>Every Users in the group will go into the actual game to group up in-game by adding each other's game ID. The game ID is displayed on the profile of each user in the \"Users\" tab</li> \
    </ul> \
    <ul> \
    <li>When the group is ready, the group leader will press &ldquo;start game&rdquo; on the app and all Users will be able to start rating each other in the app.</li> \
    </ul> \
    <ul> \
    <li>Group leader will start game in the actual game</li> \
    </ul> \
    <ul> \
    <li>Every User in the group can rate each other on the app after the actual game has ended</li> \
    </ul> \
    <p>7.5 <u>Messages from GetGood</u></p> \
    <p>On occasion, GetGood will send you messages. The default form of communication is email.</p> \
    <p>Some messages from GetGood are service-related and required for members. Examples of service-related messages include, but are not limited to: a welcome/confirmation email when you register your account, notification of offers or sales of services, or correspondence with GetGood's support team. These messages are not promotional in nature. You may not opt-out of receiving service-related messages from GetGood, unless you close your account.</p> \
        <p>As a member, GetGood may also send you messages related to certain features on the site or your activity. GetGood may also send you news or updates about changes to our site or services.</p> \
        <ul> \
        <li><u>Community</u></li> \
        </ul> \
        <p>GetGood is both a marketplace and a community. We offer several features that allow members to connect and communicate in public or semi-public spaces. Please use common sense and good judgement when posting in these community spaces or sharing your personal information with others on GetGood.</p> \
        <p>Be aware that any personal information you submit there can be read, collected, or used by others, or could be used to send you unsolicited messages. GetGood generally does not remove content from community spaces, and your posts may remain public after your account is closed. You are responsible for the personal information you choose to post in community spaces on GetGood.</p> \
            <p>Another GetGood member may add you to receive updates about your public site activity (such as items you are selling and public Favorites). After a member has added you, you have the option to block that member if you do not wish to share your updates with that specific person.</p> \
                <p>Our Services enable GetGood members to share personal information with each other, on almost all occasions without GetGood&rsquo;s involvement, to complete transactions. In a typical transaction, users may have access to each other&rsquo;s name, email address and other contact and/or billing information. Our Terms of Service require that Users in possession of another User&rsquo;s personal data (the &ldquo;<strong>receiving Party</strong>&rdquo;) must (i) comply with all applicable Privacy Laws; (ii) allow the other user (the &ldquo;<strong>Disclosing Party</strong>&rdquo;) to remove him/herself from the Receiving Party&rsquo;s database; and (iii) allow the Disclosing Party to review what information has been collected about them by the Receiving Party.</p> \
    <ol start=\"8\"> \
    <li><strong><u>COACH LISTING SERVICES</u></strong></li> \
    </ol> \
    <p></p> \
    <ul> \
    <li><u>Coaching services description</u></li> \
    </ul> \
    <p>While we endeavour to provide an accurate description of the Coaching Services provided by Coaches, we do not warrant that such description is accurate, current or free from error.</p> \
        <ul> \
        <li><u>Prices of Coaching Services</u></li> \
        </ul> \
        <p>All listed prices of Coaching Services are at the discretion of each individual Coach and are subject to taxes, unless otherwise stated. The Coach reserves the right to amend the listed prices of Coaching Services at any time without giving any reason or prior notice.</p> \
        <ul> \
        <li><u>Coaches</u></li> \
        </ul> \
        <p><em><u>GetGood not a party to User Contracts</u></em></p> \
        <p>Trainees acknowledge that Coaches list and sell Coaching Services on the App and/or Website. Accordingly, each contract entered into for the sale of a Coach&rsquo;s Coaching Services (&ldquo;<strong>User Contract</strong>&rdquo;) to a Trainee shall be a User Contract entered into directly and only between the Coach and the Trainee and under no circumstances shall the Company be construed or deemed to be a party to such User Contract.</p> \
    <p></p> \
    <p><em><u>Obligations of Coaches and warranties</u></em></p> \
    <p></p> \
    <p>In using the Services to create a listing and offer a coaching service for sale, a Coach agrees to comply with the following:</p> \
        <ul> \
        <li>to provide a fair, accurate and complete description of his Coaching Services, including the price for the Coaching Services</li> \
            </ul> \
            <ul> \
            <li>to provide a separate listing for each Coaching Services</li> \
                </ul> \
                <ul> \
                <li>to include only text, descriptions, graphics, images and other content relevant to the Coaching Services</li> \
                </ul> \
                <ul> \
                <li>to list all Coaching Services in the appropriate category</li> \
                </ul> \
                <p>Without prejudice to the rest of these Terms and GetGood&rsquo;s policies, each Coach warrants, in respect of Coaching Services which a Coach offers for sale on the Services, that: </p> \
                    <p> </p> \
                    <ul> \
                    <li>the Coaching Services does not infringe upon any third party's copyright, patent, trademark, trade secret or other proprietary or intellectual property rights</li> \
                    </ul> \
                    <ul> \
                    <li>the provision of the Coaching Services complies with all laws and regulations which apply to that service.</li> \
                    </ul> \
                    <p>User Contracts made and accepted through the Services are binding.</p> \
                    <p>If you are a coach who has accepted a trainee&rsquo;s offer for a coaching service:</p> \
                        <ul> \
                        <li>You agree to complete the transaction with the trainee in a prompt manner unless there are exceptional circumstance, for instance, if the trainee fails to meet the terms of your listing (such as payment method), or you cannot authenticate the trainee's identity.</li> \
                            </ul> \
                            <ul> \
                            <li>You may not alter the coaching service price after a sale, or misrepresent the coaching service price.</li> \
                            </ul> \
                            <p><em><u>Obligations of Trainees</u></em></p> \
                            <p>If you are a trainee whose offer for Coaching Services has been accepted by a coach, you agree to make prompt payment to the coach for the Coaching Services, unless there is an exceptional circumstance, for instance, if you are cannot authenticate the coach&rsquo;s identity.</p> \
    <ol start=\"9\"> \
    <li><strong><u>LIMITATION OF LIABILITY</u></strong></li> \
    </ol> \
    <ul> \
    <li>The use of GetGood is at the user&rsquo;s own risk.</li> \
    </ul> \
    <ul> \
    <li>GetGood does not edit or control the user messages posted to or distributed on the App and/or the Website by Users (&ldquo;<strong>User Messages</strong>&rdquo;) and will not be in any way responsible or liable for such User Messages. GetGood nevertheless reserves the right for any reason in its sole discretion to remove without notice any User Messages and/or Content and Information.</li> \
        </ul> \
        <ul> \
        <li>GetGood takes no responsibility and assumes no liability for any Content and Information posted, stored or uploaded by you or any third party, or for any loss or damage thereto, nor is GetGood liable for any mistakes, defamation, slander, libel, omissions, falsehoods, obscenity, pornography or profanity you may encounter.</li> \
            </ul> \
            <ul> \
            <li>As a provider of interactive services, GetGood is not liable for any statements, representations or Content and Information provided by Users. Although GetGood has no obligation to screen, edit or monitor any of the Content and Information posted to or distributed through GetGood, GetGood reserves the right, and has absolute discretion, to remove, screen or edit without notice any Content and Information at any time and for any reason, and you are solely responsible for creating backup copies of and replacing any Content and Information you post or store on GetGood at your sole cost and expense.</li> \
                </ul> \
                <ul> \
                <li>We accept no responsibility for adverts contained within GetGood. If you agree to purchase goods and/or services from any Third Party websites who advertises in GetGood by clicking the &ldquo;Purchase&rdquo; button on GetGood, you do so at your own risk. The Third Party websites advertiser, not GetGood, is responsible for such goods and/or services and if you have any queries or complaints in relation to them, your only recourse is against the Third Party websites</li> \
                    </ul> \
                    <ul> \
                    <li>GetGood expressly disclaims:-</li> \
                    </ul> \
                    <ul> \
                    <li>all liability whatsoever to the extent permitted by law whether arising in contract, tort or otherwise in relation to the use of GetGood; and</li> \
    </ul> \
    <ul> \
    <li>all implied warranties, terms and conditions relating to GetGood (whether implied by statute or common law) including without limitation any warranty, term or condition as to accuracy, completeness, satisfactory quality, performance, fitness for purpose or any special purpose, non-infringement and information accuracy.</li> \
        </ul> \
        <ul> \
        <li>In particular but without prejudice to the foregoing, we accept no responsibility for any technical failure of the internet, data transmitted through GetGood or the failure of GetGood the app or any damage or injury to users of GetGood or their equipment as a result of or relating to their use of GetGood.</li> \
            </ul> \
            <ul> \
            <li>GetGood will not be liable, in contract, tort (including, without limitation, negligence), under statute or otherwise, as a result of or in connection with GetGood, for any: (i) economic loss (including, without limitation, loss of revenues, profits, contracts, business or anticipated savings); or (ii) loss of goodwill or reputation; or (iii) special or indirect or consequential loss.</li> \
    </ul> \
    <ul> \
    <li>For the avoidance of doubt, in the event GetGood is liable to you directly or indirectly in relation to GetGood, GetGood&rsquo;s liability shall be limited to the amount paid by you in any expenditure incurred by you through the use of GetGood.</li> \
    </ul> \
    <ol start=\"10\"> \
    <li><strong><u>GENERAL</u></strong></li> \
    </ol> \
    <p><em><u>Amendments to Terms</u></em></p> \
    <p>GetGood reserves the right to update these Terms from time to time. If it does so, the updated version will be effective immediately, and the current Terms are available through a link in GetGood to this page. You are responsible for regularly reviewing these Terms so that you are aware of any changes to them and you will be bound by the new policy upon your continued use of GetGood. No other variation to these Terms shall be effective unless in writing and signed by an authorised representative on behalf of GetGood.</p> \
        <p><em><u>Indemnity</u></em></p> \
        <p></p> \
        <p>You agree to indemnify GetGood in full and on demand from and against any damages, losses, liabilities, claims, actions, proceedings, costs (including legal costs on a full indemnity basis as well after as before judgment) and expenses which GetGood may suffer or incur relating to, in connection with, arising from your use of GetGood.</p> \
        <p></p> \
        <p><em><u>Termination<br /> </u></em><br /> If you violate any of the Terms, or otherwise create risk or possible legal exposure for us, we can stop providing all or part of GetGood to you. We will notify you by email or at the next time you attempt to access your account.</p> \
            <p><em><u>No Waiver</u></em></p> \
            <p>Any failure to exercise or enforce any right or provision of these Terms shall not constitute a waiver of such right or provision unless acknowledged and agreed to by GetGood in writing.<br /> </p> \
            <p><em><u>Governing law</u></em></p> \
             \<p>These Terms shall be governed by and construed in accordance with Singapore law and you agree to submit to the exclusive jurisdiction of the Singapore Courts.</p> \
";
    
  
    NSMutableAttributedString *attrHTMLText = [[[NSAttributedString alloc] initWithData:[htmlString dataUsingEncoding:NSUTF8StringEncoding] options:@{NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType,NSCharacterEncodingDocumentAttribute: @(NSUTF8StringEncoding)} documentAttributes:nil error:nil] mutableCopy];
    //set font here
    UIFont *font = [UIFont fontWithName:@"Poppins-Regular" size:15];
    [attrHTMLText addAttribute:NSFontAttributeName value:font range:NSMakeRange(0, [attrHTMLText length])];
    
    //set color here
    [attrHTMLText addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:NSMakeRange(0, attrHTMLText.length)];

    // Add attributed string to text view
    labelTerms.attributedText=attrHTMLText;
    
    
}


-(void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:false];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (IBAction)onBack:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

@end



