Return-Path: <linux-kernel-owner@vger.kernel.org>
Mime-Version: 1.0
Message-Id: <f64f960b-d978-4022-9e56-0d9d9a3c0ebc@www.fastmail.com>
In-Reply-To: <CAG48ez3UrzPE8rkucTgCu8ggcTEjx_h3Gj2FES1qM-uv2KD8bQ@mail.gmail.com>
References: <20210414055217.543246-1-avagin@gmail.com>
 <20210414055217.543246-3-avagin@gmail.com>
 <CAG48ez3UrzPE8rkucTgCu8ggcTEjx_h3Gj2FES1qM-uv2KD8bQ@mail.gmail.com>
Date: Mon, 28 Jun 2021 09:30:31 -0700
From: "Andy Lutomirski" <luto@kernel.org>
Subject: Re: [PATCH 2/4] arch/x86: implement the process_vm_exec syscall
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
To: Jann Horn <jannh@google.com>, Andrei Vagin <avagin@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux API <linux-api@vger.kernel.org>, linux-um@lists.infradead.org, criu@openvz.org, avagin@google.com, Andrew Morton <akpm@linux-foundation.org>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, Christian Brauner <christian.brauner@ubuntu.com>, Dmitry Safonov <0x7f454c46@gmail.com>, Ingo Molnar <mingo@redhat.com>, Jeff Dike <jdike@addtoit.com>, Mike Rapoport <rppt@linux.ibm.com>, Michael Kerrisk <mtk.manpages@gmail.com>, Oleg Nesterov <oleg@redhat.com>, "Peter Zijlstra (Intel)" <peterz@infradead.org>, Richard Weinberger <richard@nod.at>, Thomas Gleixner <tglx@linutronix.de>
List-ID: <linux-um.lists.infradead.org>



On Mon, Jun 28, 2021, at 9:13 AM, Jann Horn wrote:
> On Wed, Apr 14, 2021 at 7:59 AM Andrei Vagin <avagin@gmail.com> wrote:=

> > This change introduces the new system call:
> > process_vm_exec(pid_t pid, struct sigcontext *uctx, unsigned long fl=
ags,
> >                 siginfo_t * uinfo, sigset_t *sigmask, size_t sizemas=
k)
> >
> > process_vm_exec allows to execute the current process in an address
> > space of another process.
> [...]
>=20
> I still think that this whole API is fundamentally the wrong approach
> because it tries to shoehorn multiple usecases with different
> requirements into a single API. But that aside:
>=20
> > +static void swap_mm(struct mm_struct *prev_mm, struct mm_struct *ta=
rget_mm)
> > +{
> > +       struct task_struct *tsk =3D current;
> > +       struct mm_struct *active_mm;
> > +
> > +       task_lock(tsk);
> > +       /* Hold off tlb flush IPIs while switching mm's */
> > +       local_irq_disable();
> > +
> > +       sync_mm_rss(prev_mm);
> > +
> > +       vmacache_flush(tsk);
> > +
> > +       active_mm =3D tsk->active_mm;
> > +       if (active_mm !=3D target_mm) {
> > +               mmgrab(target_mm);
> > +               tsk->active_mm =3D target_mm;
> > +       }
> > +       tsk->mm =3D target_mm;
>=20
> I'm pretty sure you're not currently allowed to overwrite the ->mm
> pointer of a userspace thread. For example, zap_threads() assumes that=

> all threads running under a process have the same ->mm. (And if you're=

> fiddling with ->mm stuff, you should probably CC linux-mm@.)

exec_mmap() does it, so it can=E2=80=99t be entirely impossible.

