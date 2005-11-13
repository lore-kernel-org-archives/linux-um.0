Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EbRF4-0001IJ-SQ for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 13 Nov 2005 15:26:34 -0800
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]
	helo=grelber.thyrsus.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1EbRF2-0007zs-B9
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 13 Nov 2005 15:26:34 -0800
From: Rob Landley <rob@landley.net>
Subject: Re: [uml-devel] [PATCH] Ok, I build x86-64 -skas0,
	and it still segfaults.
References: <200511121936.41697.rob@landley.net>
	<200511131854.12656.blaisorblade@yahoo.it>
In-Reply-To: <200511131854.12656.blaisorblade@yahoo.it>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511131726.22036.rob@landley.net>
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Sun, 13 Nov 2005 17:26:21 -0600
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Blaisorblade <blaisorblade@yahoo.it>

On Sunday 13 November 2005 11:54, Blaisorblade wrote:
> On Sunday 13 November 2005 02:36, Rob Landley wrote:
> > I needed to patch two things to get 2.6.15-rc1 to build on an x86-64
> > system running PLD linux:
> >
> > diff -ru linux-2.6.15-rc1/arch/um/Kconfig.x86_64
> > linux-2.6.15-rc1-new/arch/um/Kconfig.x86_64 ---
> > linux-2.6.15-rc1/arch/um/Kconfig.x86_64 2005-11-13 02:08:34.318108152
> > +0100 +++ linux-2.6.15-rc1-new/arch/um/Kconfig.x86_64 2005-11-13
> > 01:55:47.761861224 +0100 @@ -9,7 +9,7 @@
> >  #XXX: this is so in the underlying arch, but it's wrong!!!
> >  config RWSEM_GENERIC_SPINLOCK
> >   bool
> > - default y
> > + default n
>
> The patch for this (which fixes a couple of other things, too) is attached
> in this thread and has been sent to -mm (cc'ing uml-devel):
>
> [uml-user] 2.6.14.git: user-mode-linux/x86_64 does not build
> [uml-devel] [PATCH 4/9] uml - fixups for "reuse i386 cpu-specific tuning"

The second one doesn't seem related, and I couldn't find the first one in 
2.6.14-mm2 (which is the most recent kernel.org lists)...

> > diff -ru linux-2.6.15-rc1/arch/um/Makefile
> > linux-2.6.15-rc1-new/arch/um/Makefile ---
> > linux-2.6.15-rc1/arch/um/Makefile 2005-11-13 02:08:34.318108152 +0100 +++
> > linux-2.6.15-rc1-new/arch/um/Makefile 2005-11-13 02:01:11.364014056 +0100
> > @@ -107,7 +107,7 @@
> >  prepare: $(ARCH_DIR)/include/kern_constants.h
> >
> >  LINK-$(CONFIG_LD_SCRIPT_STATIC) += -static
> > -LINK-$(CONFIG_LD_SCRIPT_DYN) += -Wl,-rpath,/lib
> > +LINK-$(CONFIG_LD_SCRIPT_DYN) += -Wl,-rpath,/lib64
> >
> >  CPP_MODE-$(CONFIG_MODE_TT) := -DMODE_TT
> >  CONFIG_KERNEL_STACK_ORDER ?= 2
>
> Is that _needed_ on your system? I ask because it always worked and it's
> highly host distro-dependant, I guess.

Yes it's needed.  Otherwise:

  CC      init/version.o
  LD      init/built-in.o
  LD      .tmp_vmlinux1
/usr/bin/ld: warning: ld-linux-x86-64.so.2, needed by /lib64/libc.so.6, not 
found (try using -rpath or -rpath-link)
/lib64/libc.so.6: undefined reference to `_rtld_global@GLIBC_PRIVATE'
/lib64/libc.so.6: undefined reference to `__libc_enable_secure@GLIBC_PRIVATE'
/lib64/libc.so.6: undefined reference to `_rtld_global_ro@GLIBC_PRIVATE'
/lib64/libc.so.6: undefined reference to `_dl_out_of_memory@GLIBC_PRIVATE'
/lib64/libc.so.6: undefined reference to `_r_debug@GLIBC_2.2.5'
/lib64/libc.so.6: undefined reference to `__tls_get_addr@GLIBC_2.3'
/lib64/libc.so.6: undefined reference to `_dl_argv@GLIBC_PRIVATE'
collect2: ld returned 1 exit status
  KSYM    .tmp_kallsyms1.S
nm: '.tmp_vmlinux1': No such file
No valid symbol.
make: *** [.tmp_kallsyms1.S] Bd 1

All that's in /lib on pld is:

[rob@rg4 linux-2.6.14]$ ls -l /lib
razem 0
lrwxrwxrwx  1 root root 12 2005-09-06 12:21 cpp -> /usr/bin/cpp
drwxr-xr-x  2 root root  1 2005-11-05 18:53 firmware
drwxr-xr-x  3 root root 16 2005-11-05 18:53 modules

As opposed to:

[rob@rg4 linux-2.6.14]$ ls -l /lib64 | wc
    103     910    7541

> > Then I ran it with my standard ./linux rootfstype=hostfs rw init=/bin/sh
> > and got the following:
> >
> >
> > Console initialized on /dev/tty0
> > Failed to open 'root_fs', errno = 2
> > VFS: Mounted root (hostfs filesystem).
> > Stub registers -
> >         0 - 9090909090909090
>
> 0x90 is the pad used to fill holes in binaries..., and it's strange it's
> there.

I just applied Jeff's patch.  I dunno what the output means.

Rob


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
