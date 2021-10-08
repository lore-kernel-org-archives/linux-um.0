Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mYvnz-0040EZ-OH
 for linux-um@lists.infradead.org; Fri, 08 Oct 2021 19:45:21 +0000
Received: by mail-pl1-x62a.google.com with SMTP id n11so6401641plf.4
 for <linux-um@lists.infradead.org>; Fri, 08 Oct 2021 12:45:18 -0700 (PDT)
MIME-Version: 1.0
References: <20211007013601.45fa8947@crass-HP-ZBook-15-G2>
 <CABqSeAQgYiBq7USUkb-fPZkXi6rtYeew_u1Gwg4Uxp9J3=NxsQ@mail.gmail.com>
 <20211008114605.1071e36d@crass-HP-ZBook-15-G2>
In-Reply-To: <20211008114605.1071e36d@crass-HP-ZBook-15-G2>
From: YiFei Zhu <zhuyifei1999@gmail.com>
Date: Fri, 8 Oct 2021 12:45:07 -0700
Message-ID: <CABqSeARMxjvFoSCewyZC7AW9m4Mvi9yTg37NewL_Ws50yiwGxw@mail.gmail.com>
Subject: Re: Using GDB to debug a user space process in UML
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
To: development@efficientek.com
Cc: linux-um <linux-um@lists.infradead.org>

  On Fri, Oct 8, 2021 at 9:46 AM Glenn Washburn
<development@efficientek.com> wrote:
> Wow, thanks for that response! After reading your excellent and detailed
> response, I'm thinking perhaps all is not lost. One idea is to have a
> mode, perhaps set by a commandline flag called init_debug, where if the
> init process recieves a signal that would make a coredump, the process
> is stopped and the tracing thread stops ptracing it. There could be a
> message output which says something like "Init PID <pid> has crashed,
> been stopped, and waiting to be attached by debugger."
>
> I make this init process specific because other processes should be
> debuggable via gdb inside the UML instance. Also it might be painful if
> the terminal isn't setup right. But I don't see why it couldn't be
> extended to the same behavior for all processes. Yes, this might cause
> a bunch of unreaped dead processes hanging around, but I think that's
> acceptable considering this is a debug mode.

Some more ideas: completely untested, feel free to try out.

* When the kernel is about to panic to PID 1 dying, instead of
actually dying, send PID 1 SIGABRT, then go into an infinite loop. I
don't exactly know the signal handler list on UML user space
processes, but if that doesn't work making userspace_trampset the
signal handler to SIG_DFL should work in theory.
* For an unhandled SIGSEGV, coredump happens before the process exits
[1] which causes the kernel to panic, so if, instead of calling group
exit during the signal handling, you go into infinite D sleep. The UML
kernel might be able to get the coredump saved if wherever filesystem
it is writing to is writable.
* On the host, even though UML user space processes are being ptraced,
/proc/pid/mem is still readable, so in theory, one could construct
some sort of core dump based on /proc/pid/mem.

Note though, if the coredump is on the host, all the memory maps are
like /dev/shm/#123456 which isn't useful in determining what files are
mapped where. And like Johannes said, this just dumps the address
space of a UML process, which isn't as useful as a real coredump.

[1] https://elixir.bootlin.com/linux/v5.14.10/source/kernel/signal.c#L2782

Oh btw, UML kernel segv handler probably isn't a great place to do the
hooking. UML, like a normal kernel-mode Linux kernel, loads pages into
a process's address space lazily. So it is quite noisy even with
normal operation.

YiFei Zhu

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

