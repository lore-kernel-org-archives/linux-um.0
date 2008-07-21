Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KKuuV-00075Y-MJ for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 21 Jul 2008 05:54:39 -0700
Received: from static-220-247-10-204.b-man.svips.gol.ne.jp ([220.247.10.204]
	helo=tadamune.kami.home)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1KKuuU-0000mr-5L
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 21 Jul 2008 05:54:39 -0700
Date: Mon, 21 Jul 2008 21:54:26 +0900
From: Mattia Dongili <malattia@linux.it>
Message-ID: <20080721125425.GC13451@inferi.kami.home>
References: <5df78e1d0807031806s74c13c84idadc62c1d1e0e93b@mail.gmail.com>
	<5df78e1d0807091925q64c0121fk3d33c37df8d80d18@mail.gmail.com>
	<20080710170210.GB18429@c2.user-mode-linux.org>
	<5df78e1d0807140206m43291128t32f1489177ad6e3d@mail.gmail.com>
	<20080714144612.GA5751@c2.user-mode-linux.org>
	<5df78e1d0807160252j1b610c41la1a2f5092ae04be7@mail.gmail.com>
	<5df78e1d0807162155t594936c9qe5bc1616fae97f77@mail.gmail.com>
	<20080718205342.GE13572@c2.user-mode-linux.org>
	<20080720152022.GE1520@inferi.kami.home>
	<20080720154420.GA6244@c2.user-mode-linux.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20080720154420.GA6244@c2.user-mode-linux.org>
Subject: Re: [uml-devel] 2.6.25 uml kernel crashes when it calls down() on	a
	semaphore with zero counter
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Jeff Dike <jdike@addtoit.com>
Cc: user-mode-linux-devel@lists.sourceforge.net, Jiaying Zhang <jiayingz@google.com>

On Sun, Jul 20, 2008 at 11:44:20AM -0400, Jeff Dike wrote:
> On Mon, Jul 21, 2008 at 12:20:22AM +0900, Mattia Dongili wrote:
> > it's not entirely clear to me why, but that patch fixes a segfault that
> > I experience when booting uml 2.6.25 built with gcc-4.3 on a 2.6.25
> > host (I also applied your ICE workaround patch).
> 
> Hmmm, get a stack trace from it and let's see what's going on.
> 
> Presumably, you're not doing kernel development, just building a stock UML?

nope, not doing kernel development on that it's a stock UML, added
patches are just small customizations for debian:
http://svn.debian.org/viewsvn/pkg-uml/trunk/src/user-mode-linux/debian/patches/
patch #1 is not used, #2 and #3 are trivial changes. #4 is the gcc-4.3
ICE workaround and #5 is Jiaying's patch we are discussing.

The configuration is this:
http://svn.debian.org/viewsvn/pkg-uml/trunk/src/user-mode-linux/config.i386?rev=310&view=markup
on top of this I enabled the debug info to be built:
CONFIG_PRINTK_TIME=y
CONFIG_DEBUG_KERNEL=y
CONFIG_DEBUG_INFO=y
CONFIG_FRAME_POINTER=y
I also just reconfirmaed that with Jiaying's patch it doesn't happen.

Program received signal SIGILL, Illegal instruction.
0x00000000 in ?? ()
(gdb) bt
#0  0x00000000 in ?? ()
#1  0x080702e5 in __wake_up_common (q=0x16d50e88, mode=3, nr_exclusive=1, sync=0, key=0x0) at kernel/sched.c:4145
#2  0x08070323 in __wake_up_locked (q=0x16d50e88, mode=3) at kernel/sched.c:4174
#3  0x082556da in __down (sem=0x16d50e80) at lib/semaphore-sleepers.c:88
#4  0x0825401a in __down_failed () at arch/um/sys-i386/../../x86/lib/semaphore_32.S:42
#5  0x081072b7 in flush_commit_list (s=0x16dfba00, jl=0x16d50e80, flushall=1) at include/asm/arch/semaphore_32.h:99
#6  0x081077a3 in flush_async_commits (work=0x18936124) at fs/reiserfs/journal.c:3507
#7  0x08082a24 in run_workqueue (cwq=0x16ee9080) at kernel/workqueue.c:276
#8  0x08082cdf in worker_thread (__cwq=0x16ee9080) at kernel/workqueue.c:321
#9  0x0808538f in kthread (_create=0x17c679b4) at kernel/kthread.c:80
#10 0x08068f2b in run_kernel_thread (fn=0x8085347 <kthread>, arg=0x17c679b4, jmp_ptr=0x16e28bb4)
    at arch/um/os-Linux/process.c:267
#11 0x0805ae87 in new_thread_handler () at arch/um/kernel/process.c:151
#12 0x00000000 in ?? ()
(gdb) l
178      * area at compile-time..
179      */
180     static __always_inline void * __constant_c_memset(void * s, unsigned long c, size_t count)
181     {
182     int d0, d1;
183     __asm__ __volatile__(
184             "rep ; stosl\n\t"
185             "testb $2,%b3\n\t"
186             "je 1f\n\t"
187             "stosw\n"
(gdb) up
#1  0x080702e5 in __wake_up_common (q=0x16d50e88, mode=3, nr_exclusive=1, sync=0, key=0x0) at kernel/sched.c:4145
4145                    if (curr->func(curr, mode, sync, key) &&
(gdb) print *curr
$3 = {flags = 255, private = 0x0, func = 0, task_list = {next = 0x16d50e88, prev = 0x0}}

it looks like there is not func here...

(gdb) l
4140            wait_queue_t *curr, *next;
4141
4142            list_for_each_entry_safe(curr, next, &q->task_list, task_list) {
4143                    unsigned flags = curr->flags;
4144
4145                    if (curr->func(curr, mode, sync, key) &&
4146                                    (flags & WQ_FLAG_EXCLUSIVE) && !--nr_exclusive)
4147                            break;
4148            }
4149    }
(gdb) up
#2  0x08070323 in __wake_up_locked (q=0x16d50e88, mode=3) at kernel/sched.c:4174
4174            __wake_up_common(q, mode, 1, 0, NULL);
(gdb) l
4169    /*
4170     * Same as __wake_up but called with the spinlock in wait_queue_head_t held.
4171     */
4172    void __wake_up_locked(wait_queue_head_t *q, unsigned int mode)
4173    {
4174            __wake_up_common(q, mode, 1, 0, NULL);
4175    }
4176
4177    /**
4178     * __wake_up_sync - wake up threads blocked on a waitqueue.
(gdb) up
#3  0x082556da in __down (sem=0x16d50e80) at lib/semaphore-sleepers.c:88
88              wake_up_locked(&sem->wait);
(gdb) l
83
84                      spin_lock_irqsave(&sem->wait.lock, flags);
85                      tsk->state = TASK_UNINTERRUPTIBLE;
86              }
87              remove_wait_queue_locked(&sem->wait, &wait);
88              wake_up_locked(&sem->wait);
89              spin_unlock_irqrestore(&sem->wait.lock, flags);
90              tsk->state = TASK_RUNNING;
91      }
92
(gdb) print *sem
$4 = {count = {counter = 5833}, sleepers = 0, wait = {lock = {raw_lock = {<No data fields>}}, task_list = {next = 0xf,
      prev = 0xf}}}

Any other useful information I could provide?
-- 
mattia
:wq!

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
