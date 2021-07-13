Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-pg1-x536.google.com ([2607:f8b0:4864:20::536])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1m39f9-0094fH-Qj
 for linux-um@lists.infradead.org; Tue, 13 Jul 2021 04:04:53 +0000
Received: by mail-pg1-x536.google.com with SMTP id s18so20446110pgg.8
 for <linux-um@lists.infradead.org>; Mon, 12 Jul 2021 21:04:48 -0700 (PDT)
MIME-Version: 1.0
References: <a6188b0422c2a8fe1b5e9f164bfa1796@codeaurora.org>
 <CABqSeAQpb+wEM03knfmDHwtpM6vdfrpuaTwDHA35KY0PHa92cw@mail.gmail.com>
 <3343f1643f7f2c6f85e1c446d30c453d@codeaurora.org>
In-Reply-To: <3343f1643f7f2c6f85e1c446d30c453d@codeaurora.org>
From: YiFei Zhu <zhuyifei1999@gmail.com>
Date: Mon, 12 Jul 2021 23:04:37 -0500
Message-ID: <CABqSeAQV8m=64+qENaWD-nDvCgdnC0sRN8JxvAr0Ww2Px0OkDQ@mail.gmail.com>
Subject: Re: UML kernel panic on initialization
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
To: subashab@codeaurora.org
Cc: Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, linux-um@lists.infradead.org, Johannes Berg <johannes.berg@intel.com>, stranche@codeaurora.org

On Mon, Jul 12, 2021 at 1:19 PM <subashab@codeaurora.org> wrote:
> The start of instructions is at af0 for me -
>
> Disassembly of section .text:
>
> 0000000000000af0 <_dl_rtld_di_serinfo-0x7b10>:
>       af0:       48 89 e7                mov    %rsp,%rdi
>
> The offset at af0 from start is -
>
>      15e0:       48 8d 35 79 97 01 00    lea    0x19779(%rip),%rsi
> # 1ad60 <calloc+0x56e0>

Interesting. I was expecting (from my ld-2.31.so) the initial ELF
header to be in an initial non-executable page, and .text to be in a
second page. Could you dump the segment headers with `readelf -lW
ld-2.13.so`?

Though, considering that:
* the address of the start of .text matches exactly with the expected
offset from the page where the faulting instruction is (40000af0)
* UML doesn't have ASLR so 40000000 is probably where the loader is
mapped into memory
* my ld-2.31.so has its entry point address as 0x1100 and that is also
the start of .text (PLT/GOT precedes it hence the 0x100 offset from
page start)
I'm pretty confident that 40000af0 was the entry point of the dynamic
loader after it's mapped into memory (with the ELF entry point address
as 0xaf0, you can check with `readelf -h ld-2.13.so`).

If that is the case, then this faulting instruction is the first
instruction executed in UML userspace, and the instruction is `mov
%rsp,%rdi`. This instruction should not normally fail. The only common
reason I can think of is the userspace's page isn't mapped properly
somehow; either it's not mapped at all or it's not mapped executable.

> Here is the output of the /proc/[pid]/maps -
>
> 60000000-60719000 rwxp 00000000 103:00 12718929
> <full_path_to_linux_binary>
> 60719000-6077b000 rwxp 00000000 00:00 0
> [heap]

Uhh... this is a UML kernel process. UML clones into many threads /
processes, and each userspace task (inside UML) is a separate UML
userspace process on the host (so as to isolate their address spaces,
hence different VSZ from kernel). The UML userspace processes should
not map the UML binary on the host, but rather lots and lots of
/dev/shm/#8 maps (/dev/shm/#8 is UML's "physical memory").

Since UML userspace dies almost immediately due to the segfault, you
probably want to stop it from being killed by UML kernel upon segfault
so you have a longer time window to look at the maps. What I would
probably do is to add an infinite loop where the kernel printk the
segfault information, in arch/um/kernel/trap.c, show_segv_info.

> I don't know how to get VSZ from the maps output, so I used ps instead.
> The value is 536932.
>

By the way, I compiled UML 5.13.1 with defconfig, with

  make -j4 ARCH=um SUBARCH=x86_64 CROSS_COMPILE=

and

  ./linux mem=512M root=none rootfstype=hostfs rootflags=/ ro
console=tty init=/bin/sh

Cannot reproduce this error. To make sure it's not related to config,
does the panic still occur if you use defconfig?

YiFei Zhu

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

