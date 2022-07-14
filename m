Return-Path: <chenhuacai@gmail.com>
MIME-Version: 1.0
References: <20220712075255.1345991-1-chenhuacai@loongson.cn>
 <20220712075255.1345991-3-chenhuacai@loongson.cn> <CAMuHMdUazqHLbc80vpZ+Msg9A3j5aPJ3fx+CdCG3kuWDSf8WSw@mail.gmail.com>
 <CAAhV-H775jXMbcR9j=oLBuHo1PfFziZSUQWttJAEw20sUt+GAA@mail.gmail.com>
 <CAMuHMdUHbepd974u5iox3BcOyo_Q2ZgT-znruk+WCt+HMQ_Lgw@mail.gmail.com>
 <CAAhV-H78Fi0aE-h5MOgRa5L+Jt7D0wG0nLcYzx45jVney8T1BQ@mail.gmail.com>
 <CAMuHMdVXFmKR4LuXHYRrSk3Q0VRqATGbsM512DxayWCPCE-wvg@mail.gmail.com>
 <c8c959fa-f17d-f0dd-6a8d-e0b0ce622f3a@xen0n.name> <CAAhV-H6g5nLGJMz0ZsZqC5-73VSGffVdc6r0=3HHBo3Z8PQOBg@mail.gmail.com>
 <CAK8P3a0GUPSYBai3Z9vzw0wrXGLFiik6hdY3zc6nQ6mQs7yHvQ@mail.gmail.com>
In-Reply-To: <CAK8P3a0GUPSYBai3Z9vzw0wrXGLFiik6hdY3zc6nQ6mQs7yHvQ@mail.gmail.com>
From: Huacai Chen <chenhuacai@gmail.com>
Date: Thu, 14 Jul 2022 15:39:13 +0800
Message-ID: <CAAhV-H43QWXdaQuKvk+=BXA7LA6_p1aJb0qyXdhPhR_so_S0dA@mail.gmail.com>
Subject: Re: [PATCH 3/6] M68K: cpuinfo: Fix a warning for CONFIG_CPUMASK_OFFSTACK
Content-Type: text/plain; charset="UTF-8"
To: Arnd Bergmann <arnd@arndb.de>
Cc: WANG Xuerui <kernel@xen0n.name>, Geert Uytterhoeven <geert@linux-m68k.org>, Huacai Chen <chenhuacai@loongson.cn>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Michal Simek <monstr@monstr.eu>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, loongarch@lists.linux.dev, Linux-Arch <linux-arch@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Guo Ren <guoren@kernel.org>, Jiaxun Yang <jiaxun.yang@flygoat.com>, "open list:BROADCOM NVRAM DRIVER" <linux-mips@vger.kernel.org>, linux-m68k <linux-m68k@lists.linux-m68k.org>, Linux-sh list <linux-sh@vger.kernel.org>, linux-um <linux-um@lists.infradead.org>, stable <stable@vger.kernel.org>
List-ID: <linux-um.lists.infradead.org>

Hi, Arnd,

On Thu, Jul 14, 2022 at 2:59 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Thu, Jul 14, 2022 at 4:07 AM Huacai Chen <chenhuacai@gmail.com> wrote:
> > On Tue, Jul 12, 2022 at 6:15 PM WANG Xuerui <kernel@xen0n.name> wrote:
> > > On 2022/7/12 17:13, Geert Uytterhoeven wrote:
> > >
> > > But judging from the intent of this patch series (fixing WARNs on
> > > certain configs), and that the triggering condition is currently
> > > impossible on m68k (and other non-SMP) platforms, I think cleanups for
> > > such arches could come as a separate patch series later. I think the
> > > m68k refactoring is reasonable after all, due to my observation above,
> > > but for the other non-SMP arches we may want to wait for the respective
> > > maintainers' opinions.
> >
> > It seems that the best solution is only fix architectures with SMP
> > support and leave others (m68k, microblaze, um) as is. :)
>
> I think it probably makes sense to do this as a combined cleanup patch,
> which I can merge through the asm-generic tree, for all architectures
> whose maintainer does not pick it up directly. For SMP architectures,
> it's a bugfix that we probably want backported into stable kernels, while
> for non-SMP targets it is just a minor cleanup for consistency.
OK, I will send V2 later.

Huacai
>
>         Arnd

