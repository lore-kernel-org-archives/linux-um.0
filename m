Return-Path: <linux-kernel-owner+geert=40linux-m68k.org-S1759129AbZCTLk7@vger.kernel.org>
Date: Fri, 20 Mar 2009 12:39:43 +0100
From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [patch] don't preempt not TASK_RUNNING tasks
Message-ID: <20090320113943.GC11751@elte.hu>
References: <E1LkbGe-00039U-Hc@pomaz-ex.szeredi.hu> <1237543392.24626.49.camel@twins> <E1Lkc6U-0003II-W1@pomaz-ex.szeredi.hu> <20090320105306.GG6256@elte.hu> <E1LkcrP-0003Np-T2@pomaz-ex.szeredi.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1LkcrP-0003Np-T2@pomaz-ex.szeredi.hu>
Sender: linux-kernel-owner@vger.kernel.org
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: peterz@infradead.org, roland@redhat.com, efault@gmx.de, rjw@sisk.pl, jdike@addtoit.com, user-mode-linux-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, akpm@linux-foundation.org
List-ID: <user-mode-linux-devel.lists.sourceforge.net>


* Miklos Szeredi <miklos@szeredi.hu> wrote:

> On Fri, 20 Mar 2009, Ingo Molnar wrote:
> > > > The first line of attack for this problem is making 
> > > > wait_task_inactive() sucks less, which shouldn't be too hard, 
> > > > that unconditional 1 jiffy sleep is simply retarded.
> > > 
> > > I completely agree.  However, I'd like to have a non-invasive 
> > > solution that can go into current and stable kernels so UML users 
> > > don't need to suffer any more.
> > 
> > Agreed. task_unlock_no_resched() should do that i think.
> 
> I don't see how that would help.

it more clearly expresses the need there, and we already have 
_no_resched API variants (we add them on an as-needed basis).

Doing:

 preempt_disable();
 read_lock();
 ...
 read_unlock();
 preempt_enable_no_resched();

Really just open-codes read_unlock_no_resched() and uglifies the 
code.

> ptrace_stop() specifically would need read_unlock_no_resched().  
> But I'm reluctant to add more spinlock functions with all their 
> variants...

if you worry about backportability, we can certainly add the easy 
fix too, if it's followed by the more involved fix(es).

	Ingo
