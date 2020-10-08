Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-lf1-x141.google.com ([2a00:1450:4864:20::141])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kQa1l-0003Ng-Uq
 for linux-um@lists.infradead.org; Thu, 08 Oct 2020 17:48:30 +0000
Received: by mail-lf1-x141.google.com with SMTP id j30so5105623lfp.4
 for <linux-um@lists.infradead.org>; Thu, 08 Oct 2020 10:48:29 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1601960644.git.thehajime@gmail.com>
 <d5df1b8807384a00f96e4b02d41a37183fad5562.1601960644.git.thehajime@gmail.com>
 <0ed761fbe77f9858244ee2ffbf3e700d7df78418.camel@sipsolutions.net>
In-Reply-To: <0ed761fbe77f9858244ee2ffbf3e700d7df78418.camel@sipsolutions.net>
From: Octavian Purdila <tavi.purdila@gmail.com>
Date: Thu, 8 Oct 2020 20:48:18 +0300
Message-ID: <CAMoF9u1XX6gJpPfUh-6hmh1RNosn+=GUf75FQsMoxacrP=f7jg@mail.gmail.com>
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

On Wed, Oct 7, 2020 at 6:20 PM Johannes Berg <johannes@sipsolutions.net> wrote:
>

Hi Johannes,

Thank you for the review.

> On Tue, 2020-10-06 at 18:44 +0900, Hajime Tazaki wrote:
> > This patch moves underlying OS dependent part under arch/um to tools/um
> > directory so that arch/um code does not need to build host build
> > facilities (e.g., libc).
>
> Hmm. On the one hand, that build separation seems sensible, but on the
> other hand this stuff *does* fundamentally belong to arch/um/, and it's
> not a "tool" like basically everything else there that is a pure
> userspace application to run *inside* the kernel, not *part of* it.
>
> For that reason, I don't really like this much.
>

I see the os_*() calls as dependencies that the kernel uses. Sort of
like calls into the hypervisor or firmware.

The current UML build is already partially split. USER_OBJS build with
a different rule set than the rest of the kernel objects. IMHO this
change just makes this more clear and streamlined, especially with
regard to linking.

>
> >  tools/um/uml/Build                            | 48 +++++++++++++++++++
> >  tools/um/uml/drivers/Build                    | 10 ++++
>
> Also, what's with the names here? What's wrong with "Makefile"?
>
>

We are using the same build system as the rest of the stuff in tools.
Since it is building programs and libraries and not part of the kernel
binary build, it is using a slightly different infrastructure, which
is detailed in tools/build/Documentation/Build.txt

> I'm also not sure I see how this is built at all from the top level
> Makefile? Oh. I think Anton said it doesn't ... that alone would be a
> reason not to do it I guess.
>
>
> So why do you think it must be under tools/? Even if you consider "lkl"
> a "tool", that doesn't mean it must be there. I also consider a UML
> binary ("linux") a "tool" in my simulation environment, etc.
>
>
> And even LKL, which is the eventual goal here - why would you consider
> that a "tool"? I don't think we should.
>

The reason for picking tools was that it already has the
infrastructure to build programs and shared libraries and the fact
that it is the only place in the kernel source tree where code is not
built directly into the kernel binary.

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

