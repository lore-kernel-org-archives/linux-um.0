Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from [10.3.1.93] (helo=sc8-sf-list1-new.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Fhrrf-0008Aa-Nk for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 21 May 2006 10:37:15 -0700
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Fhrrf-0007JD-I6 for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 21 May 2006 10:37:15 -0700
Received: from smtp001.mail.ukl.yahoo.com ([217.12.11.32])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1Fhrrd-0000Jq-Uf
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 21 May 2006 10:37:15 -0700
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] [PATCH] RFC allow PTRACE_SYSCALL to selectively skip
	syscalls
References: <Pine.LNX.4.58.0605111220070.664@ucontrol.mobiledns.com>
	<Pine.LNX.4.58.0605171020350.664@ucontrol.mobiledns.com>
	<200605191609.39884.blaisorblade@yahoo.it>
In-Reply-To: <200605191609.39884.blaisorblade@yahoo.it>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605211936.56902.blaisorblade@yahoo.it>
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Sun, 21 May 2006 19:36:56 +0200
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Steven James <pyro@linuxlabs.com>, "Charles P. Wright" <cwright@cs.sunysb.edu>

On Friday 19 May 2006 16:09, Blaisorblade wrote:
> That is more or less my idea, however I've not had the time to work on it.
> Instead of changing the semantics we must add another option - I thought to
> use a ptrace option (the ones you set with PTRACE_SETOPTIONS), Charles
> Wright coded instead a PTRACE_CHECKEMU, but this is the concept.

> So, I'm going to forward you the emails containing two patches:
> *) PTRACE_CHECKEMU from Charles Wright
> *) PTRACE_SYSCALL_MASK - to make the debugger be notified only of some
> syscalls; the only check is via syscall number though. It's unrelated to
> this but probably useful to you.

> And I'm attaching my original version of the PTRACE_CHECKEMU thing

There's yet another implementation of this; look at the first 4 threads of 
this page -  Renzo Davoli posted a set of 3-patches which include his 
PTRACE_SYSVM which has also this feature.

http://marc.theaimsgroup.com/?a=106901060200003&r=1&w=2
-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade

	

	
		
___________________________________ 
Yahoo! Mail: gratis 1GB per i messaggi e allegati da 10MB 
http://mail.yahoo.it



-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
