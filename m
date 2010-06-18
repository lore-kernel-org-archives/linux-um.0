Return-Path: <malattia@linux.it>
Date: Sat, 19 Jun 2010 00:35:58 +0900
From: Mattia Dongili <malattia@linux.it>
Subject: Re: [uml-devel] [RESEND][REGRESSION] um: CONFIG_STATIC_LINK=y
 broken
Message-ID: <20100618153558.GB32385@kamineko.org>
References: <alpine.DEB.1.10.1001041421450.4942@dr-wily.mit.edu>
 <AANLkTinji7n8Hd1Ldci_ruH0r8qglGjC00YQkb-MEwoV@mail.gmail.com>
 <AANLkTilcHe8jnIBcTC_FjLPGxIbuZV3snU4u0FtdoeDi@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AANLkTilcHe8jnIBcTC_FjLPGxIbuZV3snU4u0FtdoeDi@mail.gmail.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: richard -rw- weinberger <richard.weinberger@gmail.com>, user-mode-linux-devel@lists.sourceforge.net, Jeff Dike <jdike@addtoit.com>, linux-kernel@vger.kernel.org, tabbott@ksplice.com, akpm@linux-foundation.org, stable@kernel.org
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

On Fri, Jun 18, 2010 at 04:27:31PM +0200, Geert Uytterhoeven wrote:
> On Fri, Jun 18, 2010 at 15:49, richard -rw- weinberger
> <richard.weinberger@gmail.com> wrote:
> > Andrew, Linus, Jeff, ... anyone?
> > Please apply this patch.
> >
> > CONFIG_STATIC_LINK is still broken. :(
> 
> I wanted to verify Tim's patch, but after enabling CONFIG_STATIC_LINK,
> it fails to link
> (with or without your patch):

I had this patch applied to the debian package for quite some time:

it came from Jeff initially, but it's definitely unrelated....

http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=494995
Fix symbol clash between libc and the kernel.

Index: linux-source-2.6.30/arch/um/Makefile
===================================================================
--- linux-source-2.6.30.orig/arch/um/Makefile	2009-07-07 21:18:57.964418085 +0900
+++ linux-source-2.6.30/arch/um/Makefile	2009-07-07 21:19:34.828766443 +0900
@@ -66,7 +66,8 @@
 # defines more robust
 
 KERNEL_DEFINES = $(strip -Derrno=kernel_errno -Dsigprocmask=kernel_sigprocmask \
-			 -Dmktime=kernel_mktime $(ARCH_KERNEL_DEFINES))
+			 -Dmktime=kernel_mktime -Dstrrchr=kernel_strrchr \
+			 $(ARCH_KERNEL_DEFINES))
 KBUILD_CFLAGS += $(KERNEL_DEFINES)
 
 PHONY += linux

-- 
mattia
:wq!

