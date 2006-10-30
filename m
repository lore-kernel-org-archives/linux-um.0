Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GeeR9-0003O1-J1 for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 30 Oct 2006 13:12:51 -0800
Received: from gwu.lbox.cz ([62.245.111.132])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1GeeR5-0007Lf-A0
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 30 Oct 2006 13:12:51 -0800
Date: Mon, 30 Oct 2006 22:12:22 +0100
From: extmaillist@linuxbox.cz
Message-ID: <20061030211222.GB9748@umlbox3.linuxbox.cz>
References: <17728.49750.141048.595960@palau.inf.ed.ac.uk>
	<200610291943.39433.blaisorblade@yahoo.it>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <200610291943.39433.blaisorblade@yahoo.it>
Subject: Re: [uml-devel] broken mdelay
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: Julian Bradfield <jcb+uml@inf.ed.ac.uk>, Jeff Dike <jdike@addtoit.com>, user-mode-linux-devel@lists.sourceforge.net

Hello,

seems like Your patch fixed 64bit guests for me! 32bit ones running on 64bit guest seem to be still overflowing though.

Thanks!

NiK

> I've not yet looked at that messages, however:
> 
> Direct invocations of __const_udelay (see include/asm-i386/delay.h) are still 
> broken with the below patch IMHO, since you do not multiply the value passed 
> there by that magic constant - look also at arch/i386/lib/delay.c. Please try 
> if the attached patch works for you. Also, a number of other users complained 
> about the same bug (hangs on shutdown result for device-mapper users in some 
> particular conditions, for instance).
> 

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
