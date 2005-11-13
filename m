Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EbLwO-00069o-5d for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 13 Nov 2005 09:46:56 -0800
Received: from smtp001.mail.ukl.yahoo.com ([217.12.11.32])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1EbLwK-00039H-NE
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 13 Nov 2005 09:46:56 -0800
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] [PATCH] Ok, I build x86-64 -skas0,
	and it still segfaults.
References: <200511121936.41697.rob@landley.net>
In-Reply-To: <200511121936.41697.rob@landley.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511131854.12656.blaisorblade@yahoo.it>
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
Date: Sun, 13 Nov 2005 18:54:12 +0100
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Rob Landley <rob@landley.net>

On Sunday 13 November 2005 02:36, Rob Landley wrote:
> I needed to patch two things to get 2.6.15-rc1 to build on an x86-64
> system running PLD linux:
>
> diff -ru linux-2.6.15-rc1/arch/um/Kconfig.x86_64
> linux-2.6.15-rc1-new/arch/um/Kconfig.x86_64 ---
> linux-2.6.15-rc1/arch/um/Kconfig.x86_64 2005-11-13 02:08:34.318108152 +0100
> +++ linux-2.6.15-rc1-new/arch/um/Kconfig.x86_64 2005-11-13
> 01:55:47.761861224 +0100 @@ -9,7 +9,7 @@
>  #XXX: this is so in the underlying arch, but it's wrong!!!
>  config RWSEM_GENERIC_SPINLOCK
>   bool
> - default y
> + default n

The patch for this (which fixes a couple of other things, too) is attached in 
this thread and has been sent to -mm (cc'ing uml-devel):

[uml-user] 2.6.14.git: user-mode-linux/x86_64 does not build
[uml-devel] [PATCH 4/9] uml - fixups for "reuse i386 cpu-specific tuning"

> diff -ru linux-2.6.15-rc1/arch/um/Makefile
> linux-2.6.15-rc1-new/arch/um/Makefile --- linux-2.6.15-rc1/arch/um/Makefile
> 2005-11-13 02:08:34.318108152 +0100 +++
> linux-2.6.15-rc1-new/arch/um/Makefile 2005-11-13 02:01:11.364014056 +0100
> @@ -107,7 +107,7 @@
>  prepare: $(ARCH_DIR)/include/kern_constants.h
>
>  LINK-$(CONFIG_LD_SCRIPT_STATIC) += -static
> -LINK-$(CONFIG_LD_SCRIPT_DYN) += -Wl,-rpath,/lib
> +LINK-$(CONFIG_LD_SCRIPT_DYN) += -Wl,-rpath,/lib64
>
>  CPP_MODE-$(CONFIG_MODE_TT) := -DMODE_TT
>  CONFIG_KERNEL_STACK_ORDER ?= 2
Is that _needed_ on your system? I ask because it always worked and it's 
highly host distro-dependant, I guess.

> Then I ran it with my standard ./linux rootfstype=hostfs rw init=/bin/sh
> and got the following:


> Console initialized on /dev/tty0
> Failed to open 'root_fs', errno = 2
> VFS: Mounted root (hostfs filesystem).
> Stub registers -
>         0 - 9090909090909090
0x90 is the pad used to fill holes in binaries..., and it's strange it's 
there.

I guess that the dump is taken from the stack and that's how this is printed.

>         1 - 9090909090909090
>         2 - 9090909090909090
>         3 - 9090909090909090
>         4 - 9090909090909090
>         5 - 9090909090909090
>         6 - 9090909090909090
>         7 - 9090909090909090
>         8 - 9090909090909090
>         9 - 9090909090909090
>         10 - 0
>         11 - 9090909090909090
>         12 - 9090909090909090
>         13 - 9090909090909090
>         14 - 9090909090909090
>         15 - ffffffffffffffff
>         16 - 9090909090909090
>         17 - 33
>         18 - 292
>         19 - 9090909090909090
>         20 - 2b
> ...
> [Remaining registers omitted because Jeff's debug patch iterates with the
> wrong constants.  The corrected version produced only the first 20.]
> ...
> Kernel panic - not syncing: get_skas_faultinfo : failed to wait for
> SIGUSR1/SIGTRAP, pid = 10090, n = 10090, errno = 0, status = 0xb7f

-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade

	

	
		
___________________________________ 
Yahoo! Mail: gratis 1GB per i messaggi e allegati da 10MB 
http://mail.yahoo.it



-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
