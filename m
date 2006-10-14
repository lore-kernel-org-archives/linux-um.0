Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GYfkP-0000VH-6e for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 14 Oct 2006 02:24:01 -0700
Received: from gwu.lbox.cz ([62.245.111.132])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1GYfkN-00011k-Ff
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 14 Oct 2006 02:24:01 -0700
From: Nikola Ciprich <nikola.ciprich@linuxbox.cz>
In-Reply-To: <200610140223.09328.blaisorblade@yahoo.it>
References: <451E9BAB.5030009@linuxbox.cz>
	<200610082130.52498.blaisorblade@yahoo.it>
	<452958FD.3020400@linuxbox.cz>
	<200610140223.09328.blaisorblade@yahoo.it>
Date: Sat, 14 Oct 2006 12:23:50 +0300
Message-Id: <1160817830.11878.9.camel@nik-nb>
Mime-Version: 1.0
Subject: Re: [uml-devel] SKAS mode not working, x86_64 SMP host, x86_64	guest, 
	problems with noprocmm
Reply-To: nikola.ciprich@linuxbox.cz
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
Cc: user-mode-linux-devel@lists.sourceforge.net

Hi,
thanks for tips! actually I'm really glad for them as I'd like to help
in any way and later even join development if I'll be able to do sth ;).
Actually there are two questions regarding to this I have:
1) You mentioned GIT, do You use it? or Jeff? I haven't noticed any UML
git branch...
2) I'm still worried about this halt problem on amd64, can You give me
some tips I could track it down?? I't only thing which is preventing me
from migrating users on new machine, otherwise it seems to be working
great (but of course I'm still really looking forward for full SKAS ;))
thanks a lot for Your patience with me...
nik

On Sat, 2006-10-14 at 02:23 +0200, Blaisorblade wrote:
> On Sunday 08 October 2006 22:01, Nikola Ciprich wrote:
> > That's it!
> > -mm3 kernel is causing this problem, and Your patch indeed fixes it! I
> > completely forgot that I was also trying mm patches and I certainly
> > mixed them with Your patches :-/
> > at least I'm glad that I now know where the problem was...
> 
> Fine!
> Next time, however, you'll save your time if you cut'n'paste the gcc output 
> and do "head Makefile" (brighter variations are possible, but that should 
> work if you don't use git) to get the exact version string. I don't want to 
> criticize, just to give you a tip :-) !
> 
> Bye


-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
