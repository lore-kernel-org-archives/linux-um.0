Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-qt1-x843.google.com ([2607:f8b0:4864:20::843])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kQn1P-0005pK-Fw
 for linux-um@lists.infradead.org; Fri, 09 Oct 2020 07:41:00 +0000
Received: by mail-qt1-x843.google.com with SMTP id c5so7283299qtw.3
 for <linux-um@lists.infradead.org>; Fri, 09 Oct 2020 00:40:59 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1601960644.git.thehajime@gmail.com>
 <714783a8d1d6aace7d0e315fc12ffc60b5867ada.1601960644.git.thehajime@gmail.com>
 <52dec5e578550efa0b8abbbabcf45d7ef7845c52.camel@sipsolutions.net>
In-Reply-To: <52dec5e578550efa0b8abbbabcf45d7ef7845c52.camel@sipsolutions.net>
From: Hajime TAZAKI <thehajime@gmail.com>
Date: Fri, 9 Oct 2020 16:40:46 +0900
Message-ID: <CADZqhTNqkb92=CJjvOX3esRFr72vFUHBwU2mLryPRvgDoepM6Q@mail.gmail.com>
Subject: Re: [RFC v7 16/21] um: nommu: plug in the build system
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
Cc: linux-arch@vger.kernel.org, Octavian Purdila <tavi.purdila@gmail.com>, Richard Weinberger <richard@nod.at>, Jeff Dike <jdike@addtoit.com>, linux-um@lists.infradead.org, Akira Moroo <retrage01@gmail.com>, linux-kernel-library@freelists.org, anton.ivanov@cambridgegreys.com

(I removed UMMODE_LIB vs !MMU part, but leave replies to the others)

On Thu, 08 Oct 2020 04:20:00 +0900,
Johannes Berg wrote:

> >   make defconfig ARCH=um UMMODE=library
> >   make ARCH=um UMMODE=library
>
> Why not make it a real Kconfig symbol? I find the ARCH=um tricky enough
> to remember all the time, so much I usually write a "GNUmakefile" with
>
> export ARCH=um
> include Makefile
>
> :-)
>
> > +config UMMODE_LIB
> > + bool "UML mode: library mode"
> > + default y if "$(UMMODE)" = "library"
>
> So wait, you _can_ switch that through Kconfig then, because you made it
> a visible option (string after "bool"). But it won't work, because then
> you later in the build system etc. still check UMMODE instead of
> CONFIG_UMMODE_LIB. Seems like something that ought to be fixed one way
> or the other - at the very least hide this symbol if setting it manually
> is invalid.

I now see what I went wrong..
thanks, will fix this with your suggestion not to use the command line argument.

> > + help
> > + This mode switches a mode to build a library of UML (Linux
> > + Kernel Library/LKL).  This switch is exclusive to "kernel mode"
> > + of UML, which is traditional mode of UML.
>
> Not sure if that historically made more sense, but you don't have any
> UMMODE_KERNEL option or something like that, so the help text seems
> confusing?

thanks, we will clarify this text.

> > +ifeq ($(UMMODE),library)
> > +  SUBARCH := um/nommu
> > +endif
>
> >  INSTALL_PATH=$(objtree)/tools/um
> > +ifeq ($(UMMODE),library)
>
> Here a few places using UMMODE which must come from the command line.

will fix this too.

> >  linux.o: vmlinux
> >  @echo '  LINK $@'
> > - $(Q)$(OBJCOPY) -R .eh_frame $< $@
> > + $(Q)$(OBJCOPY) -R .eh_frame -L sem_init -L sem_post -L sem_wait -L sem_destroy $< $@
>
> Care to explain?

If we will link a userspace binary with liblinux.a (LKL) and
libpthread, the the symbols sem_init, etc will conflict with the one
in the kernel (ipc/sem.c).  objcopy command with -L localizes the
symbol specified to avoid this conflict.

We will add the description as a comment.

> > + select UACCESS_MEMCPY
> > + select ARCH_THREAD_STACK_ALLOCATOR
> > + select ARCH_HAS_SYSCALL_WRAPPER
>
> You never use this except for the selects, maybe can go elsewhere?

This is used at the patch 12/21, so add Kconfig earlier and move this
to 12/21 would be better.  We'll work on.

> > +config 64BIT
> > + bool
> > + default y
> > +
> > +config GENERIC_CSUM
> > + def_bool y
> > +
> > +config GENERIC_ATOMIC64
> > + bool
> > + default y if !64BIT
> > +
> > +config SECCOMP
> > + bool
> > + default n
> > +
> > +config GENERIC_HWEIGHT
> > + def_bool y
> > +
> > +config GENERIC_CALIBRATE_DELAY
> > + bool
> > + default n
> > +
> > +config STACKTRACE_SUPPORT
> > + bool
> > + default n
>
> You ... were just changing these elsewhere, so one of that isn't needed?

you're right too. will fix it.

-- Hajime

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

