Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Fhxow-0006lH-Pq for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 21 May 2006 16:58:50 -0700
Received: from mail.signal1network.com ([208.176.116.2]
	helo=ucontrol.mobiledns.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1Fhxot-0000lv-Jy
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 21 May 2006 16:58:51 -0700
From: Steven James <pyro@linuxlabs.com>
Subject: Re: [uml-devel] [PATCH] RFC allow PTRACE_SYSCALL to selectively skip
	syscalls
In-Reply-To: <200605211936.56902.blaisorblade@yahoo.it>
Message-ID: <Pine.LNX.4.58.0605211946560.664@ucontrol.mobiledns.com>
References: <Pine.LNX.4.58.0605111220070.664@ucontrol.mobiledns.com>
	<Pine.LNX.4.58.0605171020350.664@ucontrol.mobiledns.com>
	<200605191609.39884.blaisorblade@yahoo.it>
	<200605211936.56902.blaisorblade@yahoo.it>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
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
Date: Sun, 21 May 2006 19:58:35 -0400 (EDT)
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net, "Charles P. Wright" <cwright@cs.sunysb.edu>

On Sun, 21 May 2006, Blaisorblade wrote:
> On Friday 19 May 2006 16:09, Blaisorblade wrote:
> > That is more or less my idea, however I've not had the time to work on it.
> > Instead of changing the semantics we must add another option - I thought to
> > use a ptrace option (the ones you set with PTRACE_SETOPTIONS), Charles
> > Wright coded instead a PTRACE_CHECKEMU, but this is the concept.
>
> > So, I'm going to forward you the emails containing two patches:
> > *) PTRACE_CHECKEMU from Charles Wright
> > *) PTRACE_SYSCALL_MASK - to make the debugger be notified only of some
> > syscalls; the only check is via syscall number though. It's unrelated to
> > this but probably useful to you.
>
> > And I'm attaching my original version of the PTRACE_CHECKEMU thing
>
> There's yet another implementation of this; look at the first 4 threads of
> this page -  Renzo Davoli posted a set of 3-patches which include his
> PTRACE_SYSVM which has also this feature.
>
> http://marc.theaimsgroup.com/?a=106901060200003&r=1&w=2

I had hoped to test both of these today, but got caught up in a nasty bug
in 2.6.16.16 where syscall_trace_leave is sometimes getting called twice
for the same syscall.

Unfortunatly, my program counts on only being called once on entry and onc
on exit from the syscall, so it gets hopelessly confused (not to mention
the extra wasted context switches).

I haven't been keeping up quite as I should, has it bitten anyone else
and is there a fix?

The same behaviour can be seen with strace where an invalid syscall will
be reported twice.

Once I work that out, I will try the changes as well as a modification of
the SYSVM approach. It seems that a simple set of an option flag and two
task->ptrace flags set from the addr parameter from ptrace will touch less
code for the same effect.

G'day,
sjames


> --
> Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
> Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
> http://www.user-mode-linux.org/~blaisorblade
>
>
>
>
>
> ___________________________________
> Yahoo! Mail: gratis 1GB per i messaggi e allegati da 10MB
> http://mail.yahoo.it
>

||||| |||| |||||||||||||  |||
by Linux Labs International, Inc.
   Steven James, CTO

55 Marietta Street
Suite 1830
Atlanta, Ga 30303
866 824 9737 support



-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
