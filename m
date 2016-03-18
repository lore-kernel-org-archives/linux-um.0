Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <richard@nod.at>) id 1ah0ks-0004PP-Ub
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 18 Mar 2016 20:12:18 +0000
Received: from a.ns.miles-group.at ([95.130.255.143] helo=radon.swed.at)
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1ah0kq-0004Da-OV
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 18 Mar 2016 20:12:18 +0000
References: <1458091505-967-1-git-send-email-elicooper@gmx.com>
	<56EB2DF8.8030102@nod.at> <56EB5CC9.1030601@gmx.com>
	<56EBBA61.4090405@nod.at> <56EC293B.8020407@gmx.com>
	<20160318164243.GA979@parts.user-mode-linux.org>
From: Richard Weinberger <richard@nod.at>
Message-ID: <56EC6117.90806@nod.at>
Date: Fri, 18 Mar 2016 21:12:07 +0100
MIME-Version: 1.0
In-Reply-To: <20160318164243.GA979@parts.user-mode-linux.org>
Subject: Re: [uml-devel] [PATCH] um: fix FPU register double-restore after
	sigreturn
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Jeff Dike <jdike@addtoit.com>, Eli Cooper <elicooper@gmx.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

Jeff, Eli,

Am 18.03.2016 um 17:42 schrieb Jeff Dike:
> On Sat, Mar 19, 2016 at 12:13:47AM +0800, Eli Cooper wrote:
>> I agree that we should keep userspace() minimal. So what in the first
>> place is the FPU state save/restore code for? Or, what (except for
>> sigreturn) could possibly mess the FPU state of the ptrace'd process
>> without it?
> 
> My (vague) recollection was that with libc in there, I couldn't be
> confident that it wouldn't unexpectedly use FP for something.  So,
> saving and restoring FP state was a hedge against that happening.
> 
> 				Jeff
> 

git blame points to:
commit fbfe9c847edf57ac8232aeafb290f272289893a3
Author: Ingo van Lil <inguin@gmx.de>
Date:   Wed Sep 14 16:21:23 2011 -0700

    um: Save FPU registers between task switches

    Some time ago Jeff prepared 42daba316557 ("uml: stop saving process FP
    state") for UML to stop saving the process FP state between task
    switches.  The assumption was that since with SKAS0 every guest process
    runs inside a host process context the host OS will take care of keeping
    the proper FP state.

    Unfortunately this is not true for multi-threaded applications, where
    all guest threads share a single host process context yet all may use
    the FPU on their own.  Although I haven't verified it I suspect things
    to be even worse in SKAS3 mode where all guest processes run inside a
    single host process.

    The patch reintroduces the saving and restoring of the FP context
    between task switches.

    [richard@nod.at: Ingo posted this patch in 2009, sadly it was never applied
    and got lost. Now in 2011 the problem was reported by Gunnar.]

    Signed-off-by: Ingo van Lil <inguin@gmx.de>
    Signed-off-by: Richard Weinberger <richard@nod.at>
    Reported-by: <gunnarlindroth@hotmail.com>
    Tested-by: <gunnarlindroth@hotmail.com>
    Cc: Stanislav Meduna <stano@meduna.org>
    Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
    Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>

So, it is not that easy. :=)

Thanks,
//richard

------------------------------------------------------------------------------
Transform Data into Opportunity.
Accelerate data analysis in your applications with
Intel Data Analytics Acceleration Library.
Click to learn more.
http://pubads.g.doubleclick.net/gampad/clk?id=278785231&iu=/4140
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

