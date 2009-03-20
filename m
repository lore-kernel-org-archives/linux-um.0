Return-Path: <linux-kernel-owner+geert=40linux-m68k.org-S1757371AbZCTN4F@vger.kernel.org>
Date: Fri, 20 Mar 2009 14:51:47 +0100
From: Oleg Nesterov <oleg@redhat.com>
Subject: Re: [patch] fix uml slowness caused by ptrace preemption bug on
	host
Message-ID: <20090320135147.GA20965@redhat.com>
References: <E1LkQeU-00020Z-Be@pomaz-ex.szeredi.hu> <20090319233311.8B26BFC381@magilla.sf.frob.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20090319233311.8B26BFC381@magilla.sf.frob.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Roland McGrath <roland@redhat.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, peterz@infradead.org, efault@gmx.de, rjw@sisk.pl, jdike@addtoit.com, mingo@elte.hu, user-mode-linux-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

On 03/19, Roland McGrath wrote:
>
> I'm no scheduler expert and I don't know whether the exact placement in
> your change is the optimal one.

Agreed, can't we do a bit more simple patch?

	--- kernel/signal.c
	+++ kernel/signal.c
	@@ -1572,8 +1572,10 @@ static void ptrace_stop(int exit_code, i
		spin_unlock_irq(&current->sighand->siglock);
		read_lock(&tasklist_lock);
		if (may_ptrace_stop()) {
	+		preempt_disable();
			do_notify_parent_cldstop(current, CLD_TRAPPED);
			read_unlock(&tasklist_lock);
	+		preempt_enable_no_resched();
			schedule();
		} else {
			/*

Yes, the task can be preempted right after spin_unlock(->siglock), but
this is unlikely. We need the "synchronous" wakeup, and this patch helps
as well.



Actually, I don't know which ptrace requests really need to make sure
the tracee was deactivated. Perhaps they can call wait_task_inactive()
themselves? I guess this is bad idea, but most of requests definitely
do not need wait_task_inactive().

Oleg.

