Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.24)
	id 1ARLmB-0006uC-V2
	for user-mode-linux-devel@lists.sourceforge.net; Tue, 02 Dec 2003 17:25:59 -0800
Received: from pop.gmx.de ([213.165.64.20] helo=mail.gmx.net)
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.24)
	id 1ARLmB-0000YY-8j
	for user-mode-linux-devel@lists.sourceforge.net; Tue, 02 Dec 2003 17:25:59 -0800
Message-ID: <012801c3b93c$fc6c5400$2000000a@schlepptopp>
From: "roland" <for_spam@gmx.de>
References: <H000006700062291.1070288230.@MHS>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Subject: [uml-devel] Re: [uml-user] bug:  [ 851759 ] SuSE YAST in textmode does not work
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: The user-mode Linux development list <user-mode-linux-devel.lists.sourceforge.net>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Wed, 3 Dec 2003 02:30:06 +0100
To: chip@innovates.com
Cc: user-mode-linux-user@lists.sourceforge.net, user-mode-linux-devel@lists.sourceforge.net

Hi !

> I think it is a UML bug,
i think this, too!

> What version of SuSE are you using in the UML?  I've only worked with 
> 8.1 and 8.2.  I'm curious if SuSE has done anything to fix this in 9.0 
> since they are working more with UML now.
i use suse9 - both on host and inside uml.

btw: there is a new howto (User Mode Linux with SuSE 9.0) from gerd knorr at:
http://www.suse.de/~kraxel/uml/howto.html
he has also some stuff (scripts/kernels) inside his download-dir.
http://www.suse.de/~kraxel/uml/

btw: chip, can i attach your bugreport to the SF bugtracker ?

regards
roland

ps:
i find it somewhat non-intuitive to get from http://user-mode-linux.sourceforge.net 
to the sourceforge uml-pages , i.e.
bugtracker, patchtracker, mailinglist archive are somewhat hard to find, especially for the newbie.

would others find it useful, too , if we had an additional grey "sourceforge-link-box" on the left, 
with direct links to the most important sourceforge "goodies" ? mhhh - on the other hand - it`s getting too
full on the left then....








----- Original Message ----- 
From: <chip@innovates.com>
To: <user-mode-linux-user@lists.sourceforge.net>
Sent: Monday, December 01, 2003 3:17 PM
Subject: RE: [uml-user] bug: [ 851759 ] SuSE YAST in textmode does not work


> I have experienced the same problem.  I have not found the solution 
> either.  To work around it I open a second session to the same UML I ran 
> YaST in.  I run top and kill the stuck y2base.  It will spawn one more 
> y2base that again gets "stuck" and I kill it also.  After killing it 
> twice YaST proceeds forward as usual.  There are times it will not get 
> stuck at all, but rarely.  Something y2base is checking in UML is not 
> returning as all the CPU time goes to the kernel when it is hung.  
> 
> I think it is a UML bug, but I haven't found the time to isolate where 
> it is hanging up.
> 
> What version of SuSE are you using in the UML?  I've only worked with 
> 8.1 and 8.2.  I'm curious if SuSE has done anything to fix this in 9.0 
> since they are working more with UML now.
> 
> Chip Schweiss
> 
> > -----Original Message-----
> > From: for.spam [mailto:for_spam@gmx.de]
> > Sent: Sunday, November 30, 2003 5:04 PM
> > To: user-mode-linux-devel; user-mode-linux-user
> > Subject: [uml-user] bug: [ 851759 ] SuSE YAST in textmode 
> > does not work
> > 
> > 
> > Hi,
> > i have submitted a bugreport related to yast:
> > http://sourceforge.net/tracker/index.php?func=detail&atid=1004
> > 29&aid=851759&group_id=429
> > i don`t know if it`s a yast bug or if it`s a uml bug - but 
> > the effect is, that yast isn`t really usable inside an uml. did others
> > experience this bug?  comments?
> > 
> > regards
> > roland
> > 
> > ps:
> > it is important for me to fix this, because if i setup uml`s 
> > for my users, the first thing they will do is firing up yast 
> > to install
> > packages. so - this is an essential tool which should work correct.
> > 
> > pps:
> > sorry for flooding uml-lists with so many posts - but i had 
> > just some time this weekend :D
> > 
> > 
> > 
> > -------------------------------------------------------
> > This SF.net email is sponsored by: SF.net Giveback Program.
> > Does SourceForge.net help you be more productive?  Does it
> > help you create better code?  SHARE THE LOVE, and help us help
> > YOU!  Click Here: http://sourceforge.net/donate/
> > _______________________________________________
> > User-mode-linux-user mailing list
> > User-mode-linux-user@lists.sourceforge.net
> > https://lists.sourceforge.net/lists/listinfo/user-mode-linux-user
> > 
> 
> 
> 
> -------------------------------------------------------
> This SF.net email is sponsored by: SF.net Giveback Program.
> Does SourceForge.net help you be more productive?  Does it
> help you create better code?  SHARE THE LOVE, and help us help
> YOU!  Click Here: http://sourceforge.net/donate/
> _______________________________________________
> User-mode-linux-user mailing list
> User-mode-linux-user@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/user-mode-linux-user
> 


-------------------------------------------------------
This SF.net email is sponsored by OSDN's Audience Survey.
Help shape OSDN's sites and tell us what you think. Take this
five minute survey and you could win a $250 Gift Certificate.
http://www.wrgsurveys.com/2003/osdntech03.php?site=8
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
