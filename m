Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GYXJ8-0006Br-3M for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 13 Oct 2006 17:23:18 -0700
Received: from smtp001.mail.ukl.yahoo.com ([217.12.11.32])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1GYXJ7-00078E-Ge
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 13 Oct 2006 17:23:18 -0700
From: Blaisorblade <blaisorblade@yahoo.it>
Date: Sat, 14 Oct 2006 02:23:09 +0200
References: <451E9BAB.5030009@linuxbox.cz>
	<200610082130.52498.blaisorblade@yahoo.it>
	<452958FD.3020400@linuxbox.cz>
In-Reply-To: <452958FD.3020400@linuxbox.cz>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200610140223.09328.blaisorblade@yahoo.it>
Subject: Re: [uml-devel] SKAS mode not working, x86_64 SMP host, x86_64 guest, 
	problems with noprocmm
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
To: Nikola Ciprich <nikola.ciprich@linuxbox.cz>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Sunday 08 October 2006 22:01, Nikola Ciprich wrote:
> That's it!
> -mm3 kernel is causing this problem, and Your patch indeed fixes it! I
> completely forgot that I was also trying mm patches and I certainly
> mixed them with Your patches :-/
> at least I'm glad that I now know where the problem was...

Fine!
Next time, however, you'll save your time if you cut'n'paste the gcc output 
and do "head Makefile" (brighter variations are possible, but that should 
work if you don't use git) to get the exact version string. I don't want to 
criticize, just to give you a tip :-) !

Bye
-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade
http://www.user-mode-linux.org/~blaisorblade
Chiacchiera con i tuoi amici in tempo reale! 
 http://it.yahoo.com/mail_it/foot/*http://it.messenger.yahoo.com 


-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
