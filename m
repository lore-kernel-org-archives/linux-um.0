Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-lj1-x241.google.com ([2a00:1450:4864:20::241])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kQcv2-0002ez-2a
 for linux-um@lists.infradead.org; Thu, 08 Oct 2020 20:53:45 +0000
Received: by mail-lj1-x241.google.com with SMTP id i2so7266858ljg.4
 for <linux-um@lists.infradead.org>; Thu, 08 Oct 2020 13:53:43 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1601960644.git.thehajime@gmail.com>
 <d5df1b8807384a00f96e4b02d41a37183fad5562.1601960644.git.thehajime@gmail.com>
 <0ed761fbe77f9858244ee2ffbf3e700d7df78418.camel@sipsolutions.net>
 <CAMoF9u1XX6gJpPfUh-6hmh1RNosn+=GUf75FQsMoxacrP=f7jg@mail.gmail.com>
 <1b271e1bca9852bebc2d67c6aada25f7ce1a7240.camel@sipsolutions.net>
In-Reply-To: <1b271e1bca9852bebc2d67c6aada25f7ce1a7240.camel@sipsolutions.net>
From: Octavian Purdila <tavi.purdila@gmail.com>
Date: Thu, 8 Oct 2020 23:53:31 +0300
Message-ID: <CAMoF9u2Fc2s1uitk3D3osgq1XByebxUTirq4SROcMZg9kJ_Gfw@mail.gmail.com>
Subject: Re: [RFC v7 03/21] um: move arch/um/os-Linux dir to tools/um/uml
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
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-arch <linux-arch@vger.kernel.org>, Richard Weinberger <richard@nod.at>, jdike@addtoit.com, linux-um <linux-um@lists.infradead.org>, Akira Moroo <retrage01@gmail.com>, linux-kernel-library <linux-kernel-library@freelists.org>, Hajime Tazaki <thehajime@gmail.com>, Anton Ivanov <anton.ivanov@cambridgegreys.com>

On Thu, Oct 8, 2020 at 10:46 PM Johannes Berg <johannes@sipsolutions.net> wrote:
>
> On Thu, 2020-10-08 at 20:48 +0300, Octavian Purdila wrote:
>
> > > On Tue, 2020-10-06 at 18:44 +0900, Hajime Tazaki wrote:
> > > > This patch moves underlying OS dependent part under arch/um to tools/um
> > > > directory so that arch/um code does not need to build host build
> > > > facilities (e.g., libc).
> > >
> > > Hmm. On the one hand, that build separation seems sensible, but on the
> > > other hand this stuff *does* fundamentally belong to arch/um/, and it's
> > > not a "tool" like basically everything else there that is a pure
> > > userspace application to run *inside* the kernel, not *part of* it.
> > >
> > > For that reason, I don't really like this much.
> > >
> >
> > I see the os_*() calls as dependencies that the kernel uses. Sort of
> > like calls into the hypervisor or firmware.
>
> Right.
>
> > The current UML build is already partially split. USER_OBJS build with
> > a different rule set than the rest of the kernel objects.
>
> Yes, that's true.
>
> > IMHO this
> > change just makes this more clear and streamlined, especially with
> > regard to linking.
>
> Well, maybe? But I actually tend to see this less as a question of
> (technical) convenience but semantics, and the tools are just not
> *meant* to be things that build a kernel, they're things to be used
> inside that kernel.
>
> I dunno. Maybe the technical convenience should win, but OTOH the
> "contortions" that UML build goes through with USER_OBJS don't really
> seem bad enough to merit breaking the notion of what tools are?
>

Half-joking, technically uml is not a kernel, it is a tool that
simulates a kernel and it uses part of the Linux kernel to do that :)

> > We are using the same build system as the rest of the stuff in tools.
> > Since it is building programs and libraries and not part of the kernel
> > binary build, it is using a slightly different infrastructure, which
> > is detailed in tools/build/Documentation/Build.txt
>
> OK, thanks for the pointer, I hadn't seen that before.
>
> > The reason for picking tools was that it already has the
> > infrastructure to build programs and shared libraries and the fact
> > that it is the only place in the kernel source tree where code is not
> > built directly into the kernel binary.
>
> Yeah, but all of UML/LKL _is_ eventually built into the kernel binary
> (or library as it may be). Which is in a way exactly my objection.
>

Leaving the library/standalone build itself aside for a while, do you
agree that the various tools we are building with library mode should
be placed in tools? Things like lklfuse - mounting Linux filesystems
with fuse, or lklhijack.so - a preload library that intercept
network/file system calls and routes them through the library mode.

> You're looking at it the other way around I think - it seems that you're
> thinking the kernel binary is the vmlinux.a, and that's what the
> kernel's build system worries about; then the "vmlinux.so" (library
> mode) or "linux" (standalone mode - perhaps that's a good name?) is the
> eventual 'tool' that we build, using the previously built vmlinux.a.
>

Correct, this is my perspective.

> But that really isn't how standalone mode works, and IMHO it also
> doesn't match what tools are today.
>

What if we could use standalone mode for other purposes that would
require creating a new binary in addition to the current linux binary?

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

