Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FW81g-0000eH-1G for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 19 Apr 2006 01:27:04 -0700
Received: from ebiederm.dsl.xmission.com ([166.70.28.69])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1FW81f-00033g-K4
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 19 Apr 2006 01:27:04 -0700
References: <200604131719.k3DHJcZG004674@ccure.user-mode-linux.org>
From: ebiederm@xmission.com (Eric W. Biederman)
In-Reply-To: <200604131719.k3DHJcZG004674@ccure.user-mode-linux.org> (Jeff
	Dike's message of "Thu, 13 Apr 2006 13:19:36 -0400")
Message-ID: <m1d5feotur.fsf@ebiederm.dsl.xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Subject: [uml-devel] Re: [RFC] PATCH 0/4 - Time virtualization
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
Date: Wed, 19 Apr 2006 02:25:00 -0600
To: Jeff Dike <jdike@addtoit.com>
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

Jeff Dike <jdike@addtoit.com> writes:

> This set of patches implements 
> 	time virtualization by creating a time namespace
> 	an interface to it through unshare
> 	a ptrace extension to allow UML to take advantage of this
> 	UML support
>
> The guts of the namespace is just an offset from the system time.  Within
> the container, gettimeofday adds this offset to the system time.  settimeofday
> changes the offset without touching the system time.  As such, within a 
> namespace, settimeofday is unprivileged.
>
> The interface to it is through unshare(CLONE_TIME).  This creates the new
> namespace, initialized with a zero offset from the system time.
>
> The advantage of this for UML is that it can create a time namespace for itself
> and subsequently let its process' gettimeofday run on the host, without
> being intercepted and run inside UML.  As such, it should basically run at
> native speed.
>
> In order to allow this, we need selective system call interception.  The
> third patch implements PTRACE_SYSCALL_MASK, which specifies, through a 
> bitmask, which system calls are intercepted and which aren't.

That patch should probably be separated, from the rest.
But it looks like a fairly sane idea. 


> Finally, the UML support is straightforward.  It calls unshare(CLONE_TIME)
> to create the new namespace, sets gettimeofday to run without being 
> intercepted, and makes settimeofday call the host's settimeofday instead
> of maintaining the time offset itself.

I think you missed a couple essential things to a time namespace.
Timers.  The posix timers, in particular.  The worst
of those is the monotonic timer.  

In the case of migration the ugly case to properly handle is the
monotonic timer.   That needs an offset yet it is absolutely forbidden
to provide that offset from the inside.  So this is the one namespace
that I think is inappropriate to use sys_unshare to create.
We need a system call so that we can specify the minimum or the
starting monotonic time base.

I don't know how we want to describe time while a process is not
inside of a kernel.

> As expected, a gettimeofday loop runs basically at native speed.  The two
> quick tests I did had it running inside UML at 98.8 and 99.2 % of
> native.

Interesting.

> BUG - as I was writing this, I realized that refcounting of the time_ns
> structures is wrong - they need to be incremented at process creation and
> decremented at process exit.

Actually the more I think of the using PTRACE to help with some of
these issues the more I like it.  It's only real alternative is a
security module, and that must be written as kernel code.

The reference counting is terrible, as you don't free syscall_mask,
during ptrace_detach.

As a comparison what is the overhead if you don't use syscall_mask,
and just do a ptrace_cont on the system call you want to let through?

Eric


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
