Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2]
 helo=sipsolutions.net)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kQunz-0000gI-GX
 for linux-um@lists.infradead.org; Fri, 09 Oct 2020 15:59:40 +0000
Message-ID: <d2b67bdfa5e1b48d5faf60387904aa254b3ae8da.camel@sipsolutions.net>
Subject: Re: [RFC v7 03/21] um: move arch/um/os-Linux dir to tools/um/uml
From: Johannes Berg <johannes@sipsolutions.net>
Date: Fri, 09 Oct 2020 17:59:33 +0200
In-Reply-To: <CAMoF9u2Fc2s1uitk3D3osgq1XByebxUTirq4SROcMZg9kJ_Gfw@mail.gmail.com>
 (sfid-20201008_225343_681111_E8A35813)
References: <cover.1601960644.git.thehajime@gmail.com>
 <d5df1b8807384a00f96e4b02d41a37183fad5562.1601960644.git.thehajime@gmail.com>
 <0ed761fbe77f9858244ee2ffbf3e700d7df78418.camel@sipsolutions.net>
 <CAMoF9u1XX6gJpPfUh-6hmh1RNosn+=GUf75FQsMoxacrP=f7jg@mail.gmail.com>
 <1b271e1bca9852bebc2d67c6aada25f7ce1a7240.camel@sipsolutions.net>
 <CAMoF9u2Fc2s1uitk3D3osgq1XByebxUTirq4SROcMZg9kJ_Gfw@mail.gmail.com>
 (sfid-20201008_225343_681111_E8A35813)
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
To: Octavian Purdila <tavi.purdila@gmail.com>
Cc: linux-arch <linux-arch@vger.kernel.org>, Richard Weinberger <richard@nod.at>, jdike@addtoit.com, linux-um <linux-um@lists.infradead.org>, Akira Moroo <retrage01@gmail.com>, linux-kernel-library <linux-kernel-library@freelists.org>, Hajime Tazaki <thehajime@gmail.com>, Anton Ivanov <anton.ivanov@cambridgegreys.com>

On Thu, 2020-10-08 at 23:53 +0300, Octavian Purdila wrote:

> Leaving the library/standalone build itself aside for a while, do you
> agree that the various tools we are building with library mode should
> be placed in tools? Things like lklfuse - mounting Linux filesystems
> with fuse, or lklhijack.so - a preload library that intercept
> network/file system calls and routes them through the library mode.

Yeah, I guess that makes sense. I realize the line gets blurry ...

OTOH, should these even live in the kernel tree? Almost seems like if
the base lkl library is there, the other stuff might not really need to
be, it's supposed to use the (stable) syscall API?

Dunno. Not sure "doesn't need to be" really is an argument for
"shouldn't be" anyway.

> > You're looking at it the other way around I think - it seems that you're
> > thinking the kernel binary is the vmlinux.a, and that's what the
> > kernel's build system worries about; then the "vmlinux.so" (library
> > mode) or "linux" (standalone mode - perhaps that's a good name?) is the
> > eventual 'tool' that we build, using the previously built vmlinux.a.
> > 
> 
> Correct, this is my perspective.
> 
> > But that really isn't how standalone mode works, and IMHO it also
> > doesn't match what tools are today.
> > 
> 
> What if we could use standalone mode for other purposes that would
> require creating a new binary in addition to the current linux binary?

Anything specific you have in mind?

But I still think that "UML standalone 'linux' binary" is something that
seems like the kernel build system should be able do? If only to avoid
regressions from what we have now ...

johannes


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

