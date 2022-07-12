Return-Path: <chenhuacai@gmail.com>
MIME-Version: 1.0
References: <20220712075255.1345991-1-chenhuacai@loongson.cn>
 <20220712075255.1345991-3-chenhuacai@loongson.cn> <CAMuHMdUazqHLbc80vpZ+Msg9A3j5aPJ3fx+CdCG3kuWDSf8WSw@mail.gmail.com>
In-Reply-To: <CAMuHMdUazqHLbc80vpZ+Msg9A3j5aPJ3fx+CdCG3kuWDSf8WSw@mail.gmail.com>
From: Huacai Chen <chenhuacai@gmail.com>
Date: Tue, 12 Jul 2022 16:53:32 +0800
Message-ID: <CAAhV-H775jXMbcR9j=oLBuHo1PfFziZSUQWttJAEw20sUt+GAA@mail.gmail.com>
Subject: Re: [PATCH 3/6] M68K: cpuinfo: Fix a warning for CONFIG_CPUMASK_OFFSTACK
Content-Type: text/plain; charset="UTF-8"
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Huacai Chen <chenhuacai@loongson.cn>, Arnd Bergmann <arnd@arndb.de>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Michal Simek <monstr@monstr.eu>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, loongarch@lists.linux.dev, Linux-Arch <linux-arch@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Guo Ren <guoren@kernel.org>, Xuerui Wang <kernel@xen0n.name>, Jiaxun Yang <jiaxun.yang@flygoat.com>, "open list:BROADCOM NVRAM DRIVER" <linux-mips@vger.kernel.org>, linux-m68k <linux-m68k@lists.linux-m68k.org>, Linux-sh list <linux-sh@vger.kernel.org>, linux-um <linux-um@lists.infradead.org>, stable <stable@vger.kernel.org>
List-ID: <linux-um.lists.infradead.org>

Hi, Geert,

On Tue, Jul 12, 2022 at 4:33 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> Hi Huacai,
>
> Thanks for your patch!
>
> On Tue, Jul 12, 2022 at 9:53 AM Huacai Chen <chenhuacai@loongson.cn> wrote:
> > When CONFIG_CPUMASK_OFFSTACK and CONFIG_DEBUG_PER_CPU_MAPS is selected,
>
> DEBUG_PER_CPU_MAPS depends on SMP, which is not supported on m68k,
> and thus cannot be enabled.
This patch is derived from MIPS and LoongArch, I search all
architectures and change those that look the same as MIPS and
LoongArch.
And the warning message below is also a copy-paste from LoongArch, sorry.

Since M68K doesn't support SMP, then this patch seems to make no
difference, but does it make sense to keep consistency across all
architectures?

Huacai
>
> > cpu_max_bits_warn() generates a runtime warning similar as below while
> > we show /proc/cpuinfo. Fix this by using nr_cpu_ids (the runtime limit)
> > instead of NR_CPUS to iterate CPUs.
> >
> > [    3.052463] ------------[ cut here ]------------
> > [    3.059679] WARNING: CPU: 3 PID: 1 at include/linux/cpumask.h:108 show_cpuinfo+0x5e8/0x5f0
> > [    3.070072] Modules linked in: efivarfs autofs4
>
> efivarfs on m68k?
>
> EFIVAR_FS depends on EFI depends on !CPU_BIG_ENDIAN
>
> > [    3.076257] CPU: 0 PID: 1 Comm: systemd Not tainted 5.19-rc5+ #1052
> > [    3.099465] Stack : 9000000100157b08 9000000000f18530 9000000000cf846c 9000000100154000
> > [    3.109127]         9000000100157a50 0000000000000000 9000000100157a58 9000000000ef7430
> > [    3.118774]         90000001001578e8 0000000000000040 0000000000000020 ffffffffffffffff
> > [    3.128412]         0000000000aaaaaa 1ab25f00eec96a37 900000010021de80 900000000101c890
> > [    3.138056]         0000000000000000 0000000000000000 0000000000000000 0000000000aaaaaa
> > [    3.147711]         ffff8000339dc220 0000000000000001 0000000006ab4000 0000000000000000
> > [    3.157364]         900000000101c998 0000000000000004 9000000000ef7430 0000000000000000
> > [    3.167012]         0000000000000009 000000000000006c 0000000000000000 0000000000000000
> > [    3.176641]         9000000000d3de08 9000000001639390 90000000002086d8 00007ffff0080286
> > [    3.186260]         00000000000000b0 0000000000000004 0000000000000000 0000000000071c1c
> > [    3.195868]         ...
> > [    3.199917] Call Trace:
> > [    3.203941] [<90000000002086d8>] show_stack+0x38/0x14c
> > [    3.210666] [<9000000000cf846c>] dump_stack_lvl+0x60/0x88
> > [    3.217625] [<900000000023d268>] __warn+0xd0/0x100
> > [    3.223958] [<9000000000cf3c90>] warn_slowpath_fmt+0x7c/0xcc
> > [    3.231150] [<9000000000210220>] show_cpuinfo+0x5e8/0x5f0
> > [    3.238080] [<90000000004f578c>] seq_read_iter+0x354/0x4b4
> > [    3.245098] [<90000000004c2e90>] new_sync_read+0x17c/0x1c4
> > [    3.252114] [<90000000004c5174>] vfs_read+0x138/0x1d0
> > [    3.258694] [<90000000004c55f8>] ksys_read+0x70/0x100
> > [    3.265265] [<9000000000cfde9c>] do_syscall+0x7c/0x94
> > [    3.271820] [<9000000000202fe4>] handle_syscall+0xc4/0x160
> > [    3.281824] ---[ end trace 8b484262b4b8c24c ]---
> >
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
>
> Does this need a Fixes tag, so we know when the problem was introduced?
>
> > --- a/arch/m68k/kernel/setup_no.c
> > +++ b/arch/m68k/kernel/setup_no.c
> > @@ -201,7 +201,7 @@ static int show_cpuinfo(struct seq_file *m, void *v)
> >
> >  static void *c_start(struct seq_file *m, loff_t *pos)
> >  {
> > -       return *pos < NR_CPUS ? ((void *) 0x12345678) : NULL;
> > +       return *pos < nr_cpu_ids ? ((void *) 0x12345678) : NULL;
> >  }
>
> include/linux/cpumask.h has:
>
>     #if NR_CPUS == 1
>     #define nr_cpu_ids              1U
>
> so on m68k, both evaluate to the same value?
>
> Gr{oetje,eeting}s,
>
>                         Geert
>
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
>
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds

