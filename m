Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-qt1-x829.google.com ([2607:f8b0:4864:20::829])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mYt0f-003ZwE-Ul
 for linux-um@lists.infradead.org; Fri, 08 Oct 2021 16:46:16 +0000
Received: by mail-qt1-x829.google.com with SMTP id z24so5349349qtv.9
 for <linux-um@lists.infradead.org>; Fri, 08 Oct 2021 09:46:12 -0700 (PDT)
Date: Fri, 8 Oct 2021 11:46:04 -0500
From: Glenn Washburn <development@efficientek.com>
Subject: Re: Using GDB to debug a user space process in UML
Message-ID: <20211008114605.1071e36d@crass-HP-ZBook-15-G2>
In-Reply-To: <CABqSeAQgYiBq7USUkb-fPZkXi6rtYeew_u1Gwg4Uxp9J3=NxsQ@mail.gmail.com>
References: <20211007013601.45fa8947@crass-HP-ZBook-15-G2>
 <CABqSeAQgYiBq7USUkb-fPZkXi6rtYeew_u1Gwg4Uxp9J3=NxsQ@mail.gmail.com>
MIME-Version: 1.0
List-Id: <linux-um.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Reply-To: development@efficientek.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+geert=linux-m68k.org@lists.infradead.org
To: YiFei Zhu <zhuyifei1999@gmail.com>
Cc: linux-um <linux-um@lists.infradead.org>

On Thu, 7 Oct 2021 11:41:45 -0700
YiFei Zhu <zhuyifei1999@gmail.com> wrote:

> On Wed, Oct 6, 2021 at 11:36 PM Glenn Washburn
> <development@efficientek.com> wrote:
> >
> > I'm trying to debug a crash in busybox while it is the init process in
> > a UML instance. I'm having trouble breaking on the entry point of the
> > busybox binary. I'm pretty new to this space, so I'm proceeding from a
> > lot of ignorance, please correct me where I'm wrong and help me clear
> > up some things.
> 
> AFAIK, that isn't possible, but not because of address space
> translation, but because UML is already ptracing user space threads.

Wow, thanks for that response! After reading your excellent and detailed
response, I'm thinking perhaps all is not lost. One idea is to have a
mode, perhaps set by a commandline flag called init_debug, where if the
init process recieves a signal that would make a coredump, the process
is stopped and the tracing thread stops ptracing it. There could be a
message output which says something like "Init PID <pid> has crashed,
been stopped, and waiting to be attached by debugger."

I make this init process specific because other processes should be
debuggable via gdb inside the UML instance. Also it might be painful if
the terminal isn't setup right. But I don't see why it couldn't be
extended to the same behavior for all processes. Yes, this might cause
a bunch of unreaped dead processes hanging around, but I think that's
acceptable considering this is a debug mode.

I think this should be able to be done manually by breaking at an
appropriate point in the kernel running under gdb (perhaps in segv
handler?). Then through gdb have the kernel call ptrace to detach from
the process, so that another gdb can attach to it. I'm trying to figure
out the right incantation to detach such that the process is left in a
SIGSTOP'ed state, instead of continuing and disappearing.

I thought I remember seeing somewhere that there was some helper
functions for detaching user-space processes. I can't find those
references right now though. And they might have been for TT mode and
not SKAS0 mode. Does this ring any bells?

If using gdb in this way could work, it could be made into some gdb
scripts to easily at least get at a crashed process with gdb. Its not
as powerful as debugging a live process, but its better than what there
is now.

Another idea, that might be easier and maybe there's ideas on how this
can be done without code changes, is to have the user-space process
coredump on the host. I've enabled codedumps for the UML process, but
they don't seem to contain the user-space processes. Probably because
the user-space processes are not threads, but actually separate
processes (or am I wrong about that?).

One current difficulty is in identifying UML host processes with their
respective process as see inside UML. Perhaps the name of the
user-space threads can be set via prctl(PR_SET_NAME, ...) to the value
of the basename of the path to the executable. Or even better,
overwrite argv for longer strings[1].

[1] https://stackoverflow.com/questions/6082189/change-process-name-in-linux/55584492#55584492

> 
> > Based on the tracing and debugging sections of the UML howto[1] and
> > other potentially out-of-date mailinglist comments, I understand that
> > the architecture of UML is that there is one kernel thread, a SIGIO
> > thread, a UBD thread, and some other threads for MMU emulation. One
> > thing that is unclear to me is where the user-space processes fir in to
> > this. In some old mailinglist emails, I've seen things that lead me to
> > belief that all user-space processes are in the kernel thread. I've
> > also seen things suggesting that each user space process has its own
> > thread, perhaps this was only with SKAS(3) mode. My guess is that they
> > are all in the one kernel thread.
> 
> Yes, each user space process in the UML has its own thread in the
> host. I think this was called skas0 in the past when we had a bunch of
> modes, but skas3&4 were dropped [1] since it needed host patches to
> switch between the different address spaces in the kernel. The main
> thing with this mode is that there's a thread in the host for each
> user space address space in the guest, and the kernel thread uses
> ptrace to control each guest thread, and uses stubs to manipulate the
> guest to perform mm syscalls. skas3/4 on the other hand, the UML
> kernel can directly switch between each address space and perform
> operations on it, so it could use a kernel thread per virtual
> processor instead.
> 
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=d0b5e15f0c0fdd759dd3dd48dc2dc2e7199e0da0
> 
> More specifically on how this works: init_new_context in UML's mm will
> either invoke copy_context_skas0 if there is a mm the task is being
> forked from, or start_userspace if not. The former ptraces user space
> threads [2] so that it runs a stub to perform a generic clone with
> CLONE_PARENT | CLONE_FILES | SIGCHLD [3], and the latter th kernel
> performs a generic clone with CLONE_FILES | SIGCHLD [4], into a
> trampoline that that maps the stubs and does some other setup in the
> new thread.
> 
> [2] https://elixir.bootlin.com/linux/v5.14.10/source/arch/um/kernel/skas/mmu.c#L33
> [3] https://elixir.bootlin.com/linux/v5.14.10/source/arch/um/kernel/skas/clone.c#L30
> [4] https://elixir.bootlin.com/linux/v5.14.10/source/arch/um/os-Linux/skas/process.c#L335
> 
> I think it's important to note that there are more like 3 kinds of
> threads in UML on the host: the kernel thread, the kernel helper
> threads (like sigio thread and ubd thread), and user space threads.
> The first two runs in the kernel address space, whereas the user space
> threads runs on the UML guest address space (they are native speed
> after all) but are being constantly ptraced.
> 
> For example, this is the process tree in the UML guest:
> 
>   USER       PID %CPU %MEM    VSZ   RSS TTY      STAT START   TIME COMMAND
>   root         2  0.0  0.0      0     0 ?        S    10:31   0:00 [kthreadd]
>   root         3  0.0  0.0      0     0 ?        I    10:31   0:00  \_
> [kworker/0:0-events]
>   [many many kthreads]
>   root        53  0.0  0.0    976   624 ?        S    10:31   0:00  \_
> bpfilter_umh
>   root        54  0.0  0.0      0     0 ?        I<   10:31   0:00  \_ [kstrp]
>   root         1  0.9  0.0   4744  2480 ?        S    10:31   0:02
> /bin/bash [a bunch of args I use for init]
>   root       144  0.3  0.0   5520  3600 tty0     Ss   10:31   0:00
> bash --rcfile /tmp/.bashrc
>   root       156  8.7  0.0   5516  3668 tty0     S    10:35   0:00  \_ bash
>   root       165  0.0  0.0   7328  1876 tty0     R+   10:35   0:00
>  \_ ps auxfww
> 
> and this is UML on the host (ps exited, sorry):
> 
>   USER         PID %CPU %MEM    VSZ   RSS TTY      STAT START   TIME COMMAND
>   zhuyife+ 4070701  1.5  0.6 8395768 206696 ?      Ss   10:31   0:05
> \_ ./linux [many many many args]
>   zhuyife+ 4070706  0.0  0.6 8395768 206696 ?      S    10:31   0:00
>    \_ ./linux [many many many args]
>   zhuyife+ 4070707  0.0  0.6 8395768 206696 ?      S    10:31   0:00
>    \_ ./linux [many many many args]
>   zhuyife+ 4070708  0.0  0.0   2588   840 ?        t    10:31   0:00
>    \_ ./linux [many many many args]
>   zhuyife+ 4070715  0.0  0.0      0     0 ?        Zs   10:31   0:00
>    \_ [linux] <defunct>
>   zhuyife+ 4070719  0.0  0.0   4824  2308 ?        t    10:31   0:00
>    \_ ./linux [many many many args]
>   zhuyife+ 4070891  0.0  0.0   5944  3136 ?        t    10:31   0:00
>    \_ ./linux [many many many args]
>   zhuyife+ 4071216  0.0  0.0   6012  3124 ?        t    10:35   0:00
>    \_ ./linux [many many many args]
> 
> PID 4070701 is the main kernel thread, it'll have a backtrace looking like:
> 
>   #0  0x00007f4e65cc45f8 in __GI___sigsuspend (set=0x612dfd60) at
> glibc/sysdeps/unix/sysv/linux/sigsuspend.c:26
>   #1  0x0000000060051406 in os_idle_sleep () at
> linux/arch/um/os-Linux/time.c:118
>   #2  0x0000000060031e64 in um_idle_sleep () at
> linux/arch/um/kernel/process.c:211
>   #3  arch_cpu_idle () at linux/arch/um/kernel/process.c:217
>   #4  0x00000000608c5543 in default_idle_call () at
> linux/kernel/sched/idle.c:112
>   #5  0x00000000600998ef in cpuidle_idle_call () at
> linux/kernel/sched/idle.c:194
>   #6  do_idle () at linux/kernel/sched/idle.c:300
>   #7  0x0000000060099e23 in cpu_startup_entry (state=CPUHP_ONLINE) at
> linux/kernel/sched/idle.c:397
>   #8  0x00000000608bcc72 in rest_init () at linux/init/main.c:721
>   #9  0x00000000600018fc in arch_call_rest_init () at linux/init/main.c:849
>   #10 0x0000000060002433 in start_kernel () at linux/init/main.c:1064
>   #11 0x0000000060005f78 in start_kernel_proc (unused=<optimized out>)
> at linux/arch/um/kernel/skas/process.c:28
>   #12 0x00000000600317c1 in new_thread_handler () at
> linux/arch/um/kernel/process.c:133
>   #13 0x0000000060036327 in uml_finishsetup () at
> linux/arch/um/kernel/um_arch.c:248
>   #14 0x0000000000000000 in ?? ()
> 
> While entering userspace, the same thread have a backtrace looking like:
> 
>   #0  ptrace (request=PTRACE_SETREGS) at
> glibc/sysdeps/unix/sysv/linux/ptrace.c:30
>   #1  0x0000000060052b7c in userspace (regs=0x67fee758,
> aux_fp_regs=0x69298028) at linux/arch/um/os-Linux/skas/process.c:404
>   #2  0x0000000060031894 in fork_handler () at
> linux/arch/um/kernel/process.c:153
>   #3  0x0000000000000000 in ?? ()
> 
> 4070706 is a helper thread (ubd thread I think):
> 
>   #0  0x00007f4e65d78923 in __GI___poll (fds=0x6153faf0
> <kernel_pollfd>, nfds=0x1, timeout=0xffffffff) at
> glibc/sysdeps/unix/sysv/linux/poll.c:29
>   #1  0x0000000060046f0a in poll (__timeout=0xffffffff, __nfds=0x1,
> __fds=0x6153faf0 <kernel_pollfd>) at /usr/include/bits/poll2.h:47
>   #2  ubd_read_poll (timeout=0xffffffff) at linux/arch/um/drivers/ubd_user.c:71
>   #3  0x00000000600468c4 in io_thread (arg=<optimized out>) at
> linux/arch/um/drivers/ubd_kern.c:1676
>   #4  0x00007f4e65d8324f in clone () at
> glibc/misc/../sysdeps/unix/sysv/linux/x86_64/clone.S:95
> 
> 4070707 is also a helper thread (sigio thread I think):
> 
>   #0  0x00007f4e65d78923 in __GI___poll (fds=0x64012960, nfds=0x2,
> timeout=0xffffffff) at glibc/sysdeps/unix/sysv/linux/poll.c:29
>   #1  0x000000006004f957 in poll (__timeout=0xffffffff,
> __nfds=<optimized out>, __fds=<optimized out>) at
> /usr/include/bits/poll2.h:47
>   #2  write_sigio_thread (unused=<optimized out>) at
> linux/arch/um/os-Linux/sigio.c:61
>   #3  0x00007f4e65d8324f in clone () at
> glibc/misc/../sysdeps/unix/sysv/linux/x86_64/clone.S:95
> 
> 4070708 is bpfilter_umh (umh user space thread), 4070719 is guest PID
> 1, and 4070891 is PID 144, and 4071216 is PID 156.
> 
> What zombie PID 4070715 is I have no idea. Probably some helper or umh
> that exited but not reaped, since it started before PID 1.
> 
> > When I break on start_thread, I can see its being called with an EIP
> > that is the value of the entry point of the busybox binary. But when I
> > set a break point (software or hardware), it never gets hit. My guess
> > is that that address, which is virtual for the UML, must get translated
> > to the real virtual address of the UML process/host kernel. If so, how
> > do I do that translation?
> 
> No, the host will see the address space of the guest user space.
> /proc/[pid]/maps in the host will contain the address mapping of the
> virtual address to a /dev/shm file (which UML considers as its
> physical memory). eg, this is that of bpfilter_umh:

Great this make using the debug symbols of the busybox binary trivial
to use.

> 
>   $ cat /proc/4070708/maps
>   00400000-00401000 r-xs 03c49000 00:15 1088516
>     /dev/shm/#1088516 (deleted)
>   00401000-00402000 r-xs fffff000 00:15 1088516
>     /dev/shm/#1088516 (deleted)
>   00402000-00403000 r-xs 1f8fc6000 00:15 1088516
>     /dev/shm/#1088516 (deleted)
>   00403000-00404000 r-xs 1f9bd0000 00:15 1088516
>     /dev/shm/#1088516 (deleted)
>   [...]
> 
> > I've also tried to step into the busybox from the kernel by stepping
> > through instructions after breaking on switch_threads. This doesn't
> > seem to ever step through non-kernel space. Am I correct that the
> > UML_LONGJMP is the part of the code that would jump into user space?
> 
> You are correct that stepping on kernel thread won't ever step into
> userspace, but for the wrong reason. User space is being executed in a
> different thread and it is already being ptraced.
> 
> As for UML_LONGJMP in switch_threads, it only switches between the
> different kernel contexts. Eg, between the first backtrace I pasted
> that belongs to swapper, and the second backtrace that belongs to a
> kernel context of a user space task.
> 
> > Also, I may be confused about TT (thread tracing) vs SKAS (separate
> > kernel address space) modes. My understanding is that the mainline has
> > what's called SKAS0, which was called TT mode. And what was called SKAS
> > mode, also called SKAS3, was never merged into mainline. Is this
> > correct?
> 
> AFAIK, SKAS0 and TT are two different modes, even though in SKAS 0
> ptrace is still being used a lot. This article [5] might explain this
> in more detail, but AFAIK, in TT, kernel and userspace are mapped into
> the same address space, and there is a seperate tracing thread that
> intercepts syscalls and switch to the "kernel part" in the same host
> thread.
> 
> [5] https://flylib.com/books/en/2.275.1.51/1/

Excellent reference.

> 
> > I've seen the question of debugging user space in UML pop up on the old
> > mailing list, but haven't really seen much in the way of an answer. Is
> > there currently a way to do this? If the UML user space process's
> > address space is remapped in the UML process, it seems like gdb could
> > theoretically be able remap the debug symbols to the right place.
> 
> I don't think it's possible, since user space threads are already
> being ptraced and AFAIK there's no "gdb server" implementation in UML

Yes, a gdb server implementation would probably be the best route to
this, but I'm guessing the most work. I wonder if the kernel's gdb
server implementation could be used and injected into the user-space
process.

> 
> > Any help would be much appreciated,
> > Glenn
> >
> > [1]
> > https://www.kernel.org/doc/html/v5.14/virt/uml/user_mode_linux_howto_v2.html#tracing-uml
> 
> YiFei Zhu

Glenn

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

