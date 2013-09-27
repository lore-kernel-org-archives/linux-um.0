Return-Path: <linux-kernel-owner@vger.kernel.org>
Message-ID: <52451A8D.4080509@nod.at>
Date: Fri, 27 Sep 2013 07:41:33 +0200
From: Richard Weinberger <richard@nod.at>
MIME-Version: 1.0
References: <1380255287-5818-1-git-send-email-artagnon@gmail.com> <1380255287-5818-2-git-send-email-artagnon@gmail.com>
In-Reply-To: <1380255287-5818-2-git-send-email-artagnon@gmail.com>
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Subject: Re: [PATCH 1/2] arch/um: make it work with defconfig and x86_64
To: Ramkumar Ramachandra <artagnon@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>, Michal Marek <mmarek@suse.cz>, uml-devel <user-mode-linux-devel@lists.sourceforge.net>, Jeff Dike <jdike@addtoit.com>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

Am 27.09.2013 06:14, schrieb Ramkumar Ramachandra:
> arch/um/defconfig only lists one default configuration, and that applies
> only to the i386 architecture.  Replace it with two minimal
> configuration files generated using `make savedefconfig`:
> 
>   i386_defconfig and x86_64_defconfig
> 
> The build scripts now require two updates:
> 
> 1. um's Kconfig (arch/x86/um/Kconfig) should specify an ARCH_DEFCONFIG
>    section explicitly pointing to these scripts if the required
>    variables are set.  Take care to remove the DEFCONFIG_LIST section
>    defined in the included file arch/um/Kconfig.common.
> 
> 2. um's Makefile (arch/um/Makefile) should set KBUILD_DEFCONFIG properly
>    for the top-level Makefile to pick up.  Copy the logic in
>    arch/x86/Makefile to properly pick the defconfig file depending on
>    the actual architecture; except we're working with $SUBARCH here,
>    instead of $ARCH.
> 
> Now, you can do:
> 
>   $ ARCH=um make defconfig
>   $ ARCH=um make
> 
> and successfully build User-Mode Linux on an x86_64 box in default
> configuration.

I don't much like the commit message, but I will amend it myself.
I.e. defconfig worked always on x86_64, you have to specify SUBARCH=x86_64.
Your patch adds the handy feature that make defconfig will use the host arch
automatically.

Patch queued for 3.13-rc1.

Thanks,
//richard
