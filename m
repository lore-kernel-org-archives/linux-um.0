Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-lf1-x130.google.com ([2a00:1450:4864:20::130])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lzHhq-002wkO-DY
 for linux-um@lists.infradead.org; Fri, 02 Jul 2021 11:51:39 +0000
Received: by mail-lf1-x130.google.com with SMTP id bq39so4977162lfb.12
 for <linux-um@lists.infradead.org>; Fri, 02 Jul 2021 04:51:36 -0700 (PDT)
MIME-Version: 1.0
References: <20210414055217.543246-1-avagin@gmail.com>
 <20210414055217.543246-3-avagin@gmail.com>
 <CAG48ez3UrzPE8rkucTgCu8ggcTEjx_h3Gj2FES1qM-uv2KD8bQ@mail.gmail.com>
 <YN6wlwFomEJ0LK1Y@gmail.com>
In-Reply-To: <YN6wlwFomEJ0LK1Y@gmail.com>
From: Jann Horn <jannh@google.com>
Date: Fri, 2 Jul 2021 13:51:08 +0200
Message-ID: <CAG48ez1=RPbsUos6yY1jMVU49U+GqSN8kFPosoFpKJZjFa4yvQ@mail.gmail.com>
Subject: Re: [PATCH 2/4] arch/x86: implement the process_vm_exec syscall
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
Cc: linux-kernel@vger.kernel.org, linux-api@vger.kernel.org, linux-um@lists.infradead.org, criu@openvz.org, avagin@google.com, Andrew Morton <akpm@linux-foundation.org>, Andy Lutomirski <luto@kernel.org>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, Christian Brauner <christian.brauner@ubuntu.com>, Dmitry Safonov <0x7f454c46@gmail.com>, Ingo Molnar <mingo@redhat.com>, Jeff Dike <jdike@addtoit.com>, Mike Rapoport <rppt@linux.ibm.com>, Michael Kerrisk <mtk.manpages@gmail.com>, Oleg Nesterov <oleg@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Richard Weinberger <richard@nod.at>, Thomas Gleixner <tglx@linutronix.de>, linux-mm@kvack.org

On Fri, Jul 2, 2021 at 8:25 AM Andrei Vagin <avagin@gmail.com> wrote:
> On Mon, Jun 28, 2021 at 06:13:29PM +0200, Jann Horn wrote:
> > On Wed, Apr 14, 2021 at 7:59 AM Andrei Vagin <avagin@gmail.com> wrote:
> > > +static void swap_mm(struct mm_struct *prev_mm, struct mm_struct *target_mm)
> > > +{
> > > +       struct task_struct *tsk = current;
> > > +       struct mm_struct *active_mm;
> > > +
> > > +       task_lock(tsk);
> > > +       /* Hold off tlb flush IPIs while switching mm's */
> > > +       local_irq_disable();
> > > +
> > > +       sync_mm_rss(prev_mm);
> > > +
> > > +       vmacache_flush(tsk);
> > > +
> > > +       active_mm = tsk->active_mm;
> > > +       if (active_mm != target_mm) {
> > > +               mmgrab(target_mm);
> > > +               tsk->active_mm = target_mm;
> > > +       }
> > > +       tsk->mm = target_mm;
> >
> > I'm pretty sure you're not currently allowed to overwrite the ->mm
> > pointer of a userspace thread. For example, zap_threads() assumes that
> > all threads running under a process have the same ->mm. (And if you're
> > fiddling with ->mm stuff, you should probably CC linux-mm@.)
> >
> > As far as I understand, only kthreads are allowed to do this (as
> > implemented in kthread_use_mm()).
>
> kthread_use_mm() was renamed from use_mm in the v5.8 kernel. Before
> that, it wasn't used for user processes in the kernel, but it was
> exported for modules, and we used it without any visible problems. We
> understood that there could be some issues like zap_threads and it was
> one of reasons why we decided to introduce this system call.
>
> I understand that there are no places in the kernel where we change mm
> of user threads back and forth, but are there any real concerns why we
> should not do that? I agree that zap_threads should be fixed, but it
> will the easy one.

My point is that if you break a preexisting assumption like this,
you'll have to go through the kernel and search for places that rely
on this assumption, and fix them up, which may potentially require
thinking about what kinds of semantics would actually be appropriate
there. Like the MCE killing logic (collect_procs_anon() and such). And
current_is_single_threaded(), in which the current patch probably
leads to logic security bugs. And __uprobe_perf_filter(). Before my
refactoring of the ELF coredump logic in kernel 5.10 (commit
b2767d97f5ff75 and the ones before it), you'd have also probably
created memory corruption bugs in races between elf_core_dump() and
syscalls like mmap()/munmap(). (Note that this is not necessarily an
exhaustive list.)

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

