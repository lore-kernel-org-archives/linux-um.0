Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from [10.3.1.93] (helo=sc8-sf-list1-new.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Fi6VZ-0001HW-O9 for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 22 May 2006 02:15:25 -0700
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Fi6VZ-00034L-JW for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 22 May 2006 02:15:25 -0700
Received: from smtp004.mail.ukl.yahoo.com ([217.12.11.35])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1Fi6VW-00088j-RW
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 22 May 2006 02:15:25 -0700
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] [PATCH] RFC allow PTRACE_SYSCALL to selectively skip
	syscalls
References: <Pine.LNX.4.58.0605111220070.664@ucontrol.mobiledns.com>
	<200605211936.56902.blaisorblade@yahoo.it>
	<Pine.LNX.4.58.0605211946560.664@ucontrol.mobiledns.com>
In-Reply-To: <Pine.LNX.4.58.0605211946560.664@ucontrol.mobiledns.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605221115.10516.blaisorblade@yahoo.it>
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
Date: Mon, 22 May 2006 11:15:10 +0200
To: Steven James <pyro@linuxlabs.com>
Cc: user-mode-linux-devel@lists.sourceforge.net, "Charles P. Wright" <cwright@cs.sunysb.edu>, Jeff Dike <jdike@addtoit.com>

On Monday 22 May 2006 01:58, Steven James wrote:
> On Sun, 21 May 2006, Blaisorblade wrote:
> > On Friday 19 May 2006 16:09, Blaisorblade wrote:
> > > That is more or less my idea, however I've not had the time to work on
> > > it. Instead of changing the semantics we must add another option - I
> > > thought to use a ptrace option (the ones you set with
> > > PTRACE_SETOPTIONS), Charles Wright coded instead a PTRACE_CHECKEMU, but
> > > this is the concept.
> > >
> > > So, I'm going to forward you the emails containing two patches:
> > > *) PTRACE_CHECKEMU from Charles Wright
> > > *) PTRACE_SYSCALL_MASK - to make the debugger be notified only of some
> > > syscalls; the only check is via syscall number though. It's unrelated
> > > to this but probably useful to you.
> > >
> > > And I'm attaching my original version of the PTRACE_CHECKEMU thing
> >
> > There's yet another implementation of this; look at the first 4 threads
> > of this page -  Renzo Davoli posted a set of 3-patches which include his
> > PTRACE_SYSVM which has also this feature.
> >
> > http://marc.theaimsgroup.com/?a=106901060200003&r=1&w=2
>
> I had hoped to test both of these today, but got caught up in a nasty bug
> in 2.6.16.16 where syscall_trace_leave is sometimes getting called twice
> for the same syscall.
>
> Unfortunatly, my program counts on only being called once on entry and onc
> on exit from the syscall, so it gets hopelessly confused (not to mention
> the extra wasted context switches).
>
> I haven't been keeping up quite as I should, has it bitten anyone else
> and is there a fix?

I have uml/64-bit (AMD64) not working on 2.6.16/64bit, while uml-32bit works 
fine on it, and the same uml/64-bit binaries work fine on 2.6.15. I haven't 
tracked it down fully, but could it be related? Possibly yes because I now 
seem to recall you run 64-bit host. So you likely found our bug!

So, please, send a bug report to Roland McGrath <roland@redhat.com>, the 
ptrace maintainer (or so it seems), cc:ing uml-devel, Jeff and me at least. 
And note that neither UML works, though the UML crash hasn't been debugged 
down to verify it's this bug the cause.

I've built all 2.6.16-rc kernels, I hope I can do binary search to insulate a 
bit where the bug was introduced. Now I know which bug it is, it'll be 
easier. Thanks a lot!
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
