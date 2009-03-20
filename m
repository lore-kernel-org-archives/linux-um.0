Return-Path: <linux-kernel-owner+geert=40linux-m68k.org-S1752735AbZCTIGq@vger.kernel.org>
In-reply-to: <20090319233311.8B26BFC381@magilla.sf.frob.com> (message from
	Roland McGrath on Thu, 19 Mar 2009 16:33:11 -0700 (PDT))
Subject: Re: [patch] fix uml slowness caused by ptrace preemption bug on host
References: <E1LkQeU-00020Z-Be@pomaz-ex.szeredi.hu> <20090319233311.8B26BFC381@magilla.sf.frob.com>
Message-Id: <E1LkZjf-0002vu-84@pomaz-ex.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Fri, 20 Mar 2009 09:05:47 +0100
Sender: linux-kernel-owner@vger.kernel.org
To: roland@redhat.com
Cc: miklos@szeredi.hu, peterz@infradead.org, efault@gmx.de, rjw@sisk.pl, jdike@addtoit.com, mingo@elte.hu, oleg@redhat.com, user-mode-linux-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

On Thu, 19 Mar 2009, Roland McGrath wrote:
> I'm no scheduler expert and I don't know whether the exact placement in
> your change is the optimal one.  But it's certainly fine from a ptrace
> perspective.

I'm no scheduler expert either.

Maybe a more generic solution in the scheduler (something like this
totally untested patch) would be better?  What say you, scheduler
experts?

Thanks,
Miklos


Index: linux.git/kernel/sched.c
===================================================================
--- linux.git.orig/kernel/sched.c	2009-03-18 12:53:47.000000000 +0100
+++ linux.git/kernel/sched.c	2009-03-20 08:58:13.000000000 +0100
@@ -4629,7 +4629,8 @@ asmlinkage void __sched preempt_schedule
 	 * If there is a non-zero preempt_count or interrupts are disabled,
 	 * we do not want to preempt the current task. Just return..
 	 */
-	if (likely(ti->preempt_count || irqs_disabled()))
+	if (likely(ti->preempt_count || irqs_disabled() ||
+		   current->state != TASK_RUNNING))
 		return;
 
 	do {
