Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: Re: Multiple longjmp definitions with STATIC_LINKING=y
References: <4999b293-42a6-bf88-ef0b-af5e0fc3729c@gmail.com>
From: Richard Weinberger <richard@nod.at>
Message-ID: <e03da776-ea69-cfea-14c8-b2d9694d9b31@nod.at>
Date: Tue, 23 May 2017 09:28:04 +0200
MIME-Version: 1.0
In-Reply-To: <4999b293-42a6-bf88-ef0b-af5e0fc3729c@gmail.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
To: Florian Fainelli <f.fainelli@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, jdike@addtoit.com, user-mode-linux-devel@lists.sourceforge.net
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

Florian,

Am 23.05.2017 um 05:28 schrieb Florian Fainelli:
> Hi Richard,
> 
> I have been playing with UML again and trying to get it to statically
> link on a CentOS 6.9 host that has:
> 
> glibc-2.12-static
> gcc-4.4
> 
> installed results in the following:
> 
> /usr/lib/gcc/x86_64-redhat-linux/4.4.7/../../../../lib64/libpthread.a(libpthread.o):
> In function `siglongjmp':
> (.text+0x8490): multiple definition of `longjmp'
> arch/x86/um/built-in.o:/local/users/fainelli/openwrt/trunk/build_dir/target-x86_64_musl/linux-uml/linux-4.4.69/arch/x86/um/setjmp_64.S:44:
> first defined here
> /usr/lib/gcc/x86_64-redhat-linux/4.4.7/../../../../lib64/libpthread.a(libpthread.o):
> In function `sem_open':
> (.text+0x77cd): warning: the use of `mktemp' is dangerous, better use
> `mkstemp'
> collect2: ld returned 1 exit status
> make[4]: *** [vmlinux] Error 1

Meh, this is a new one.
How is musl involved in this game?

Does it help when you add another redefine-hack to arch/um/Makefile?
See -Dvmap=kernel_vmap.

> Should we have some linker script magic not to export this symbol and
> prevent a clash with libpthread.a pulling its own version?

Yes, we should. But so far nobody had the time to bite the bullet. :-)
This is not the first bug of this kind. Please see.
https://lkml.org/lkml/2015/11/19/726

Thanks,
//richard

