Return-Path: <linux-kernel-owner+geert=40linux-m68k.org-S1758995AbZCWPW1@vger.kernel.org>
Date: Mon, 23 Mar 2009 16:19:54 +0100
From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [patch] fix ptrace slowness
Message-ID: <20090323151954.GC21267@elte.hu>
References: <E1LllkK-0000zF-1h@pomaz-ex.szeredi.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1LllkK-0000zF-1h@pomaz-ex.szeredi.hu>
Sender: linux-kernel-owner@vger.kernel.org
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: linux-kernel@vger.kernel.org, oleg@redhat.com, peterz@infradead.org, roland@redhat.com, efault@gmx.de, rjw@sisk.pl, jdike@addtoit.com, user-mode-linux-devel@lists.sourceforge.net, torvalds@linux-foundation.org, akpm@linux-foundation.org, stable@kernel.org
List-ID: <user-mode-linux-devel.lists.sourceforge.net>


* Miklos Szeredi <miklos@szeredi.hu> wrote:

> This one incorporates comments from Oleg and Ingo.  Please apply 
> to 2.6.29 and 2.6.2[78]-stable trees.

The fix first needs to go upstream. There's an alternative patch 
below. Would you mind to give it a test? Chances are that it will 
make UML even faster than your fix.

	Ingo

diff --git a/kernel/sched.c b/kernel/sched.c
index 3e827b8..2d60f23 100644
--- a/kernel/sched.c
+++ b/kernel/sched.c
@@ -2119,7 +2119,8 @@ unsigned long wait_task_inactive(struct task_struct *p, long match_state)
 		 * yield - it could be a while.
 		 */
 		if (unlikely(on_rq)) {
-			schedule_timeout_uninterruptible(1);
+			cpu_relax();
+			cond_resched();
 			continue;
 		}
 
