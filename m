Return-Path: <linux-kernel-owner@vger.kernel.org>
Message-ID: <1335869133.13683.125.camel@twins>
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
Date: Tue, 01 May 2012 12:45:33 +0200
In-Reply-To: <20120426165911.00cebd31.akpm@linux-foundation.org>
References: <20120423070641.GA27702@lizard> <20120423070736.GA30752@lizard>
	 <20120426165911.00cebd31.akpm@linux-foundation.org>
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Subject: Re: [PATCH 1/9] cpu: Introduce clear_tasks_mm_cpumask() helper
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Anton Vorontsov <anton.vorontsov@linaro.org>, Oleg Nesterov <oleg@redhat.com>, Russell King <linux@arm.linux.org.uk>, Mike Frysinger <vapier@gentoo.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Richard Weinberger <richard@nod.at>, Paul Mundt <lethal@linux-sh.org>, KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>, John Stultz <john.stultz@linaro.org>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, uclinux-dist-devel@blackfin.uclinux.org, linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, linaro-kernel@lists.linaro.org, patches@linaro.org, linux-mm@kvack.org
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

On Thu, 2012-04-26 at 16:59 -0700, Andrew Morton wrote:
> > +void clear_tasks_mm_cpumask(int cpu)
> 
> The operation of this function was presumably obvious to you at the
> time you wrote it, but that isn't true of other people at later times.
> 
> Please document it?
> 
> 
> > +{
> > +     struct task_struct *p;
> > +
> > +     /*
> > +      * This function is called after the cpu is taken down and marked
> > +      * offline,
> 
> hm, well.  Who said that this function will only ever be called
> after that CPU was taken down?  There is nothing in the function name
> nor in the (absent) documentation which enforces this precondition.
> 
> If someone tries to use this function for a different purpose, or
> copies-and-modifies it for a different purpose, we just shot them in
> the foot.
> 
> They'd be pretty dumb to do that without reading the local comment,
> but still...

Methinks something simple like:

	WARN_ON(cpu_online(cpu));

Ought to cure that worry, no? :-)

> 
> >        so its not like new tasks will ever get this cpu set in
> > +      * their mm mask. -- Peter Zijlstra
> > +      * Thus, we may use rcu_read_lock() here, instead of grabbing
> > +      * full-fledged tasklist_lock.
> > +      */
> > +     rcu_read_lock();
> > +     for_each_process(p) {
> > +             struct task_struct *t;
> > +
> > +             t = find_lock_task_mm(p);
> > +             if (!t)
> > +                     continue;
> > +             cpumask_clear_cpu(cpu, mm_cpumask(t->mm));
> > +             task_unlock(t);
> > +     }
> > +     rcu_read_unlock();
> > +} 
