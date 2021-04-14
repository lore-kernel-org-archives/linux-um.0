Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-lf1-x132.google.com ([2a00:1450:4864:20::132])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lWddo-007i1t-9c
 for linux-um@lists.infradead.org; Wed, 14 Apr 2021 11:25:06 +0000
Received: by mail-lf1-x132.google.com with SMTP id e14so19804506lfn.11
 for <linux-um@lists.infradead.org>; Wed, 14 Apr 2021 04:24:58 -0700 (PDT)
MIME-Version: 1.0
References: <20210414055217.543246-1-avagin@gmail.com>
 <87blahb1pr.fsf@oldenburg.str.redhat.com>
In-Reply-To: <87blahb1pr.fsf@oldenburg.str.redhat.com>
From: Jann Horn <jannh@google.com>
Date: Wed, 14 Apr 2021 13:24:30 +0200
Message-ID: <CAG48ez2z0a4x2GfHv9L0HmO1-uzsKtfOF40erPb8ADR-m+itbg@mail.gmail.com>
Subject: Re: [PATCH 0/4 POC] Allow executing code and syscalls in another
 address space
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
To: Florian Weimer <fweimer@redhat.com>
Cc: Andrei Vagin <avagin@gmail.com>, kernel list <linux-kernel@vger.kernel.org>, Linux API <linux-api@vger.kernel.org>, linux-um@lists.infradead.org, criu@openvz.org, Andrei Vagin <avagin@google.com>, Andrew Morton <akpm@linux-foundation.org>, Andy Lutomirski <luto@kernel.org>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, Christian Brauner <christian.brauner@ubuntu.com>, Dmitry Safonov <0x7f454c46@gmail.com>, Ingo Molnar <mingo@redhat.com>, Jeff Dike <jdike@addtoit.com>, Mike Rapoport <rppt@linux.ibm.com>, Michael Kerrisk <mtk.manpages@gmail.com>, Oleg Nesterov <oleg@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Richard Weinberger <richard@nod.at>, Thomas Gleixner <tglx@linutronix.de>

On Wed, Apr 14, 2021 at 12:27 PM Florian Weimer <fweimer@redhat.com> wrote:
>
> * Andrei Vagin:
>
> > We already have process_vm_readv and process_vm_writev to read and write
> > to a process memory faster than we can do this with ptrace. And now it
> > is time for process_vm_exec that allows executing code in an address
> > space of another process. We can do this with ptrace but it is much
> > slower.
> >
> > = Use-cases =
>
> We also have some vaguely related within the same address space: running
> code on another thread, without modifying its stack, while it has signal
> handlers blocked, and without causing system calls to fail with EINTR.
> This can be used to implement certain kinds of memory barriers.

That's what the membarrier() syscall is for, right? Unless you don't
want to register all threads for expedited membarrier use?

> It is
> also necessary to implement set*id with POSIX semantics in userspace.
> (Linux only changes the current thread credentials, POSIX requires
> process-wide changes.)  We currently use a signal for set*id, but it has
> issues (it can be blocked, the signal could come from somewhere, etc.).
> We can't use signals for barriers because of the EINTR issue, and
> because the signal context is stored on the stack.

This essentially becomes a question of "how much is set*id allowed to
block and what level of guarantee should there be by the time it
returns that no threads will perform privileged actions anymore after
it returns", right?

Like, if some piece of kernel code grabs a pointer to the current
credentials or acquires a temporary reference to some privileged
resource, then blocks on reading an argument from userspace, and then
performs a privileged action using the previously-grabbed credentials
or resource, what behavior do you want? Should setuid() block until
that privileged action has completed? Should it abort that action
(which is kinda what you get with the signals approach)? Should it
just return immediately even though an attacker who can write to
process memory at that point might still be able to influence a
privileged operation that hasn't read all its inputs yet? Should the
kernel be designed to keep track of whether it is currently holding a
privileged resource? Or should the kernel just specifically permit
credential changes in specific places where it is known that a task
might block for a long time and it is not holding any privileged
resources (kinda like the approach taken for freezer stuff)?

If userspace wants multithreaded setuid() without syscall aborting,
things get gnarly really fast; and having an interface to remotely
perform operations under another task's context isn't really relevant
to the core problem here, I think.

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

