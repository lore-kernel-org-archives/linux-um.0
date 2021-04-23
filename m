Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-pg1-x52a.google.com ([2607:f8b0:4864:20::52a])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lZpp8-00ECjp-4u
 for linux-um@lists.infradead.org; Fri, 23 Apr 2021 07:01:59 +0000
Received: by mail-pg1-x52a.google.com with SMTP id f29so34558630pgm.8
 for <linux-um@lists.infradead.org>; Fri, 23 Apr 2021 00:01:56 -0700 (PDT)
Date: Thu, 22 Apr 2021 23:59:15 -0700
From: Andrei Vagin <avagin@gmail.com>
Subject: Re: [PATCH 2/4] arch/x86: implement the process_vm_exec syscall
Message-ID: <YIJwQ4brDIbKKiyZ@gmail.com>
References: <20210414055217.543246-1-avagin@gmail.com>
 <20210414055217.543246-3-avagin@gmail.com>
 <20210414170915.GB22294@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210414170915.GB22294@redhat.com>
List-Id: <linux-um.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+geert=linux-m68k.org@lists.infradead.org
To: Oleg Nesterov <oleg@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-api@vger.kernel.org, linux-um@lists.infradead.org, criu@openvz.org, avagin@google.com, Andrew Morton <akpm@linux-foundation.org>, Andy Lutomirski <luto@kernel.org>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, Christian Brauner <christian.brauner@ubuntu.com>, Dmitry Safonov <0x7f454c46@gmail.com>, Ingo Molnar <mingo@redhat.com>, Jeff Dike <jdike@addtoit.com>, Mike Rapoport <rppt@linux.ibm.com>, Michael Kerrisk <mtk.manpages@gmail.com>, Peter Zijlstra <peterz@infradead.org>, Richard Weinberger <richard@nod.at>, Thomas Gleixner <tglx@linutronix.de>

On Wed, Apr 14, 2021 at 07:09:15PM +0200, Oleg Nesterov wrote:
> On 04/13, Andrei Vagin wrote:
> >
> > +static void swap_mm(struct mm_struct *prev_mm, struct mm_struct *target_mm)
> > +{
> > +	struct task_struct *tsk = current;
> > +	struct mm_struct *active_mm;
> > +
> > +	task_lock(tsk);
> > +	/* Hold off tlb flush IPIs while switching mm's */
> > +	local_irq_disable();
> > +
> > +	sync_mm_rss(prev_mm);
> > +
> > +	vmacache_flush(tsk);
> > +
> > +	active_mm = tsk->active_mm;
> > +	if (active_mm != target_mm) {
> > +		mmgrab(target_mm);
> > +		tsk->active_mm = target_mm;
> > +	}
> > +	tsk->mm = target_mm;
> > +	switch_mm_irqs_off(active_mm, target_mm, tsk);
> > +	local_irq_enable();
> > +	task_unlock(tsk);
> > +#ifdef finish_arch_post_lock_switch
> > +	finish_arch_post_lock_switch();
> > +#endif
> > +
> > +	if (active_mm != target_mm)
> > +		mmdrop(active_mm);
> > +}
> 
> I think this should be unified with kthread_use_mm() somehow...

I agree.

> 
> And does it really need the "prev_mm" argument? It must be tsk->mm, no?

No, it doesn't. It is leftover of unuse_mm. BTW why do we pass mm to kthread_unuse_mm?

Thanks,
Andrei.

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

