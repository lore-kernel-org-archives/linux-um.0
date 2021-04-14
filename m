Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lWj19-007xrF-A2
 for linux-um@lists.infradead.org; Wed, 14 Apr 2021 17:09:33 +0000
Date: Wed, 14 Apr 2021 19:09:15 +0200
From: Oleg Nesterov <oleg@redhat.com>
Subject: Re: [PATCH 2/4] arch/x86: implement the process_vm_exec syscall
Message-ID: <20210414170915.GB22294@redhat.com>
References: <20210414055217.543246-1-avagin@gmail.com>
 <20210414055217.543246-3-avagin@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210414055217.543246-3-avagin@gmail.com>
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
To: Andrei Vagin <avagin@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-api@vger.kernel.org, linux-um@lists.infradead.org, criu@openvz.org, avagin@google.com, Andrew Morton <akpm@linux-foundation.org>, Andy Lutomirski <luto@kernel.org>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, Christian Brauner <christian.brauner@ubuntu.com>, Dmitry Safonov <0x7f454c46@gmail.com>, Ingo Molnar <mingo@redhat.com>, Jeff Dike <jdike@addtoit.com>, Mike Rapoport <rppt@linux.ibm.com>, Michael Kerrisk <mtk.manpages@gmail.com>, Peter Zijlstra <peterz@infradead.org>, Richard Weinberger <richard@nod.at>, Thomas Gleixner <tglx@linutronix.de>

On 04/13, Andrei Vagin wrote:
>
> +static void swap_mm(struct mm_struct *prev_mm, struct mm_struct *target_mm)
> +{
> +	struct task_struct *tsk = current;
> +	struct mm_struct *active_mm;
> +
> +	task_lock(tsk);
> +	/* Hold off tlb flush IPIs while switching mm's */
> +	local_irq_disable();
> +
> +	sync_mm_rss(prev_mm);
> +
> +	vmacache_flush(tsk);
> +
> +	active_mm = tsk->active_mm;
> +	if (active_mm != target_mm) {
> +		mmgrab(target_mm);
> +		tsk->active_mm = target_mm;
> +	}
> +	tsk->mm = target_mm;
> +	switch_mm_irqs_off(active_mm, target_mm, tsk);
> +	local_irq_enable();
> +	task_unlock(tsk);
> +#ifdef finish_arch_post_lock_switch
> +	finish_arch_post_lock_switch();
> +#endif
> +
> +	if (active_mm != target_mm)
> +		mmdrop(active_mm);
> +}

I think this should be unified with kthread_use_mm() somehow...

And does it really need the "prev_mm" argument? It must be tsk->mm, no?

Oleg.


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

