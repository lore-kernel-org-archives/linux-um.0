MIME-Version: 1.0
Date: Tue, 12 Jul 2022 11:13:24 +0200
References: <20220712075255.1345991-1-chenhuacai@loongson.cn>
	<20220712075255.1345991-3-chenhuacai@loongson.cn>
	<CAMuHMdUazqHLbc80vpZ+Msg9A3j5aPJ3fx+CdCG3kuWDSf8WSw@mail.gmail.com>
	<CAAhV-H775jXMbcR9j=oLBuHo1PfFziZSUQWttJAEw20sUt+GAA@mail.gmail.com>
	<CAMuHMdUHbepd974u5iox3BcOyo_Q2ZgT-znruk+WCt+HMQ_Lgw@mail.gmail.com>
	<CAAhV-H78Fi0aE-h5MOgRa5L+Jt7D0wG0nLcYzx45jVney8T1BQ@mail.gmail.com>
In-Reply-To: <CAAhV-H78Fi0aE-h5MOgRa5L+Jt7D0wG0nLcYzx45jVney8T1BQ@mail.gmail.com>
Message-ID: <CAMuHMdVXFmKR4LuXHYRrSk3Q0VRqATGbsM512DxayWCPCE-wvg@mail.gmail.com>
Subject: Re: [PATCH 3/6] M68K: cpuinfo: Fix a warning for CONFIG_CPUMASK_OFFSTACK
From: Geert Uytterhoeven <geert@linux-m68k.org>
Content-Type: text/plain; charset="UTF-8"
To: Huacai Chen <chenhuacai@gmail.com>
Cc: Huacai Chen <chenhuacai@loongson.cn>, Arnd Bergmann <arnd@arndb.de>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Michal Simek <monstr@monstr.eu>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, loongarch@lists.linux.dev, Linux-Arch <linux-arch@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Guo Ren <guoren@kernel.org>, Xuerui Wang <kernel@xen0n.name>, Jiaxun Yang <jiaxun.yang@flygoat.com>, "open list:BROADCOM NVRAM DRIVER" <linux-mips@vger.kernel.org>, linux-m68k <linux-m68k@lists.linux-m68k.org>, Linux-sh list <linux-sh@vger.kernel.org>, linux-um <linux-um@lists.infradead.org>, stable <stable@vger.kernel.org>
List-ID: <linux-um.lists.infradead.org>

Hi Huacai,

On Tue, Jul 12, 2022 at 11:08 AM Huacai Chen <chenhuacai@gmail.com> wrote:
> On Tue, Jul 12, 2022 at 5:01 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > On Tue, Jul 12, 2022 at 10:53 AM Huacai Chen <chenhuacai@gmail.com> wrote:
> > > On Tue, Jul 12, 2022 at 4:33 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > > > On Tue, Jul 12, 2022 at 9:53 AM Huacai Chen <chenhuacai@loongson.cn> wrote:
> > > > > When CONFIG_CPUMASK_OFFSTACK and CONFIG_DEBUG_PER_CPU_MAPS is selected,
> > > >
> > > > DEBUG_PER_CPU_MAPS depends on SMP, which is not supported on m68k,
> > > > and thus cannot be enabled.
> > > This patch is derived from MIPS and LoongArch, I search all
> > > architectures and change those that look the same as MIPS and
> > > LoongArch.
> > > And the warning message below is also a copy-paste from LoongArch, sorry.
> > >
> > > Since M68K doesn't support SMP, then this patch seems to make no
> > > difference, but does it make sense to keep consistency across all
> > > architectures?
> >
> > Yes, having consistency is good.  But that should be mentioned in the
> > patch description, instead of a scary warning CCed to stable ;-)
> >
> > BTW, you probably want to update the other copy of c_start() in
> > arch/m68k/kernel/setup_mm.c, too.
> For no-SMP architectures, it seems c_start() in
> arch/m68k/kernel/setup_mm.c is more reasonable (just use 1, neither
> NR_CPUS, nor nr_cpu_ids)?

The advantage of using nr_cpu_ids() is that this is one place less
to update when adding SMP support later...

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

