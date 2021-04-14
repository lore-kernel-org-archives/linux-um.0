Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lWck6-007gKF-PK
 for linux-um@lists.infradead.org; Wed, 14 Apr 2021 10:27:32 +0000
From: Florian Weimer <fweimer@redhat.com>
Subject: Re: [PATCH 0/4 POC] Allow executing code and syscalls in another
 address space
References: <20210414055217.543246-1-avagin@gmail.com>
Date: Wed, 14 Apr 2021 12:27:28 +0200
In-Reply-To: <20210414055217.543246-1-avagin@gmail.com> (Andrei Vagin's
 message of "Tue, 13 Apr 2021 22:52:13 -0700")
Message-ID: <87blahb1pr.fsf@oldenburg.str.redhat.com>
MIME-Version: 1.0
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
Cc: linux-kernel@vger.kernel.org, linux-api@vger.kernel.org, linux-um@lists.infradead.org, criu@openvz.org, avagin@google.com, Andrew Morton <akpm@linux-foundation.org>, Andy Lutomirski <luto@kernel.org>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, Christian Brauner <christian.brauner@ubuntu.com>, Dmitry Safonov <0x7f454c46@gmail.com>, Ingo Molnar <mingo@redhat.com>, Jeff Dike <jdike@addtoit.com>, Mike Rapoport <rppt@linux.ibm.com>, Michael Kerrisk <mtk.manpages@gmail.com>, Oleg Nesterov <oleg@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Richard Weinberger <richard@nod.at>, Thomas Gleixner <tglx@linutronix.de>

* Andrei Vagin:

> We already have process_vm_readv and process_vm_writev to read and write
> to a process memory faster than we can do this with ptrace. And now it
> is time for process_vm_exec that allows executing code in an address
> space of another process. We can do this with ptrace but it is much
> slower.
>
> = Use-cases =

We also have some vaguely related within the same address space: running
code on another thread, without modifying its stack, while it has signal
handlers blocked, and without causing system calls to fail with EINTR.
This can be used to implement certain kinds of memory barriers.  It is
also necessary to implement set*id with POSIX semantics in userspace.
(Linux only changes the current thread credentials, POSIX requires
process-wide changes.)  We currently use a signal for set*id, but it has
issues (it can be blocked, the signal could come from somewhere, etc.).
We can't use signals for barriers because of the EINTR issue, and
because the signal context is stored on the stack.

Thanks,
Florian


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

