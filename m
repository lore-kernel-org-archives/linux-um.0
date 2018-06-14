Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from lilium.sigma-star.at ([109.75.188.150])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1fTXBw-00088d-Vi
 for linux-um@lists.infradead.org; Thu, 14 Jun 2018 18:41:54 +0000
From: Richard Weinberger <richard@sigma-star.at>
Subject: Re: UML fails to build on arch i386
Date: Thu, 14 Jun 2018 20:41:37 +0200
Message-ID: <2135572.4iMtKPa2p5@blindfold>
In-Reply-To: <fb137ebf865a1160b06ac92cfb601fd68533c787.camel@researchut.com>
References: <eabf7e000bc0227fa6a7a74a23512cc11b84206a.camel@researchut.com>
 <CAFLxGvw8_HJGLHuaPxT0wxr6fCa3w5GkTjfrkUyVY+ZG0NoE6g@mail.gmail.com>
 <fb137ebf865a1160b06ac92cfb601fd68533c787.camel@researchut.com>
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
To: rrs@researchut.com, linux-um@lists.infradead.org

Am Donnerstag, 14. Juni 2018, 17:44:37 CEST schrieb Ritesh Raj Sarraf:
> On Thu, 2018-06-14 at 13:15 +0200, Richard Weinberger wrote:
> > > This log missed the main error line:
> > > 
> > >    CC      arch/um/kernel/maccess.o
> > >    CC      arch/um/kernel/kmsg_dump.o
> > >    CC      arch/um/kernel/skas/clone.o
> > > In file included from ./arch/x86/um/shared/sysdep/ptrace.h:42:0,
> > >                   from ./arch/um/include/shared/as-layout.h:38,
> > >                   from arch/um/kernel/skas/clone.c:11:
> > > ./arch/x86/um/shared/sysdep/ptrace_32.h:16:23: error: expected
> > > identifier before numeric constant
> > >   #define PTRACE_SYSEMU 31
> > 
> > Hmm, can you please check how PTRACE_SYSEMU is defined in your UAPI?
> > 
> > The code is pretty boring:
> > #ifndef PTRACE_SYSEMU
> > #define PTRACE_SYSEMU 31
> > #endif
> > 
> > My best guess is that PTRACE_SYSEMU is not a define but something
> > else and then
> > #define fails in an interesting way.
> 
> There's nothing much in here either.
> From file: i386-linux-gnu/sys/ptrace.h
> And it is the same code on x86_64 too, where I've been able to
> successfully build it.
> 
> 
> 
> #ifdef __x86_64__
>   /* Access TLS data.  */
>   PTRACE_ARCH_PRCTL = 30,
> # define PT_ARCH_PRCTL PTRACE_ARCH_PRCTL
> #endif
> 
>   /* Continue and stop at the next syscall, it will not be executed.  */
>   PTRACE_SYSEMU = 31,
> #define PT_SYSEMU PTRACE_SYSEMU

Okay, PTRACE_SYSEMU seems to be part of an enum, that's why UML's #ifndef does not
not protect the #define.

What libc is this?

I think we can remove UML's define check and just assume that every system has PTRACE_SYSEMU
properly defined.

Thanks,
//richard

-- 
sigma star gmbh - Eduard-Bodem-Gasse 6 - 6020 Innsbruck - Austria
ATU66964118 - FN 374287y

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

