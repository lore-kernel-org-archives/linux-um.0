Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EyXwV-00089x-4C for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 16 Jan 2006 09:14:55 -0800
Received: from cantor2.suse.de ([195.135.220.15] helo=mx2.suse.de)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1EyXwT-00083s-LD
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 16 Jan 2006 09:14:55 -0800
Received: from Relay1.suse.de (mail2.suse.de [195.135.221.8])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx2.suse.de (Postfix) with ESMTP id AD5161D294
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Mon, 16 Jan 2006 18:14:47 +0100 (CET)
From: Olaf Hering <olh@suse.de>
Message-ID: <20060116171447.GA15932@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Subject: [uml-devel] arch/um/include/kern_util.h:35: error: 'CONFIG_NR_CPUS'
	undeclared
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
Date: Mon, 16 Jan 2006 18:14:47 +0100
To: user-mode-linux-devel@lists.sourceforge.net


Current Linus tree does not compile for me:


girgendwas:~/linux-2.6.15$ gcc -Wp,-MD,arch/um/drivers/.chan_user.o.d -Wall -Wundef -Wstrict-prototypes -Wno-trigraphs -fno-strict-aliasing -fno-common -ffreestanding -Os -fomit-frame-pointer -D__arch_um__ -DSUBARCH=\"i386\" -Dvmap=kernel_vmap -Din6addr_loopback=kernel_in6addr_loopback -Iarch/um/include  -I/home/abuild/linux-2.6.15/arch/um/kernel/skas/include -D_FILE_OFFSET_BITS=64 -march=i686 -mpreferred-stack-boundary=2 -D_GNU_SOURCE -D_LARGEFILE64_SOURCE  -c -o arch/um/drivers/chan_user.o arch/um/drivers/chan_user.c --save-temps
In file included from arch/um/drivers/chan_user.c:16:
arch/um/include/kern_util.h:35: error: 'CONFIG_NR_CPUS' undeclared here (not in a function)

It picks up the libc headers instead of the 2.6.15 ones.

grep -E '^#[[:blank:]]+[[:digit:]]' chan_user.i 


# 1 "arch/um/drivers/chan_user.c"
# 1 "<built-in>"
# 1 "<command line>"
# 1 "arch/um/drivers/chan_user.c"
# 1 "/usr/include/unistd.h" 1 3 4
# 26 "/usr/include/unistd.h" 3 4
# 1 "/usr/include/features.h" 1 3 4
# 323 "/usr/include/features.h" 3 4
# 1 "/usr/include/sys/cdefs.h" 1 3 4
# 313 "/usr/include/sys/cdefs.h" 3 4
# 1 "/usr/include/bits/wordsize.h" 1 3 4
# 314 "/usr/include/sys/cdefs.h" 2 3 4
# 324 "/usr/include/features.h" 2 3 4
# 346 "/usr/include/features.h" 3 4
# 1 "/usr/include/gnu/stubs.h" 1 3 4
# 1 "/usr/include/bits/wordsize.h" 1 3 4
# 5 "/usr/include/gnu/stubs.h" 2 3 4
# 1 "/usr/include/gnu/stubs-32.h" 1 3 4
# 8 "/usr/include/gnu/stubs.h" 2 3 4
# 347 "/usr/include/features.h" 2 3 4
# 27 "/usr/include/unistd.h" 2 3 4
# 171 "/usr/include/unistd.h" 3 4
# 1 "/usr/include/bits/posix_opt.h" 1 3 4
# 172 "/usr/include/unistd.h" 2 3 4
# 1 "/usr/include/bits/environments.h" 1 3 4
# 176 "/usr/include/unistd.h" 2 3 4
# 186 "/usr/include/unistd.h" 3 4
# 1 "/usr/include/bits/types.h" 1 3 4
# 28 "/usr/include/bits/types.h" 3 4
# 1 "/usr/include/bits/wordsize.h" 1 3 4
# 29 "/usr/include/bits/types.h" 2 3 4
# 1 "/usr/lib/gcc/i586-suse-linux/4.1.0/include/stddef.h" 1 3 4
# 214 "/usr/lib/gcc/i586-suse-linux/4.1.0/include/stddef.h" 3 4
# 32 "/usr/include/bits/types.h" 2 3 4
# 134 "/usr/include/bits/types.h" 3 4
# 1 "/usr/include/bits/typesizes.h" 1 3 4
# 135 "/usr/include/bits/types.h" 2 3 4
# 187 "/usr/include/unistd.h" 2 3 4
# 1 "/usr/lib/gcc/i586-suse-linux/4.1.0/include/stddef.h" 1 3 4
# 196 "/usr/include/unistd.h" 2 3 4
# 256 "/usr/include/unistd.h" 3 4
# 302 "/usr/include/unistd.h" 3 4
# 353 "/usr/include/unistd.h" 3 4
# 369 "/usr/include/unistd.h" 3 4
# 391 "/usr/include/unistd.h" 3 4
# 403 "/usr/include/unistd.h" 3 4
# 427 "/usr/include/unistd.h" 3 4
# 469 "/usr/include/unistd.h" 3 4
# 1 "/usr/include/bits/confname.h" 1 3 4
# 26 "/usr/include/bits/confname.h" 3 4
# 553 "/usr/include/unistd.h" 2 3 4
# 589 "/usr/include/unistd.h" 3 4
# 615 "/usr/include/unistd.h" 3 4
# 632 "/usr/include/unistd.h" 3 4
# 833 "/usr/include/unistd.h" 3 4
# 1 "/usr/include/getopt.h" 1 3 4
# 59 "/usr/include/getopt.h" 3 4
# 73 "/usr/include/getopt.h" 3 4
# 152 "/usr/include/getopt.h" 3 4
# 834 "/usr/include/unistd.h" 2 3 4
# 919 "/usr/include/unistd.h" 3 4
# 948 "/usr/include/unistd.h" 3 4
# 969 "/usr/include/unistd.h" 3 4
# 986 "/usr/include/unistd.h" 3 4
# 1007 "/usr/include/unistd.h" 3 4
# 1033 "/usr/include/unistd.h" 3 4
# 1061 "/usr/include/unistd.h" 3 4
# 1099 "/usr/include/unistd.h" 3 4
# 7 "arch/um/drivers/chan_user.c" 2
# 1 "/usr/include/stdlib.h" 1 3 4
# 33 "/usr/include/stdlib.h" 3 4
# 1 "/usr/lib/gcc/i586-suse-linux/4.1.0/include/stddef.h" 1 3 4
# 326 "/usr/lib/gcc/i586-suse-linux/4.1.0/include/stddef.h" 3 4
# 34 "/usr/include/stdlib.h" 2 3 4
# 1 "/usr/include/bits/waitflags.h" 1 3 4
# 43 "/usr/include/stdlib.h" 2 3 4
# 1 "/usr/include/bits/waitstatus.h" 1 3 4
# 65 "/usr/include/bits/waitstatus.h" 3 4
# 1 "/usr/include/endian.h" 1 3 4
# 37 "/usr/include/endian.h" 3 4
# 1 "/usr/include/bits/endian.h" 1 3 4
# 38 "/usr/include/endian.h" 2 3 4
# 66 "/usr/include/bits/waitstatus.h" 2 3 4
# 44 "/usr/include/stdlib.h" 2 3 4
# 68 "/usr/include/stdlib.h" 3 4
# 96 "/usr/include/stdlib.h" 3 4
# 140 "/usr/include/stdlib.h" 3 4
# 236 "/usr/include/stdlib.h" 3 4
# 1 "/usr/include/xlocale.h" 1 3 4
# 28 "/usr/include/xlocale.h" 3 4
# 237 "/usr/include/stdlib.h" 2 3 4
# 429 "/usr/include/stdlib.h" 3 4
# 1 "/usr/include/sys/types.h" 1 3 4
# 29 "/usr/include/sys/types.h" 3 4
# 72 "/usr/include/sys/types.h" 3 4
# 105 "/usr/include/sys/types.h" 3 4
# 116 "/usr/include/sys/types.h" 3 4
# 133 "/usr/include/sys/types.h" 3 4
# 1 "/usr/include/time.h" 1 3 4
# 58 "/usr/include/time.h" 3 4
# 74 "/usr/include/time.h" 3 4
# 92 "/usr/include/time.h" 3 4
# 104 "/usr/include/time.h" 3 4
# 134 "/usr/include/sys/types.h" 2 3 4
# 1 "/usr/lib/gcc/i586-suse-linux/4.1.0/include/stddef.h" 1 3 4
# 148 "/usr/include/sys/types.h" 2 3 4
# 191 "/usr/include/sys/types.h" 3 4
# 216 "/usr/include/sys/types.h" 3 4
# 1 "/usr/include/sys/select.h" 1 3 4
# 31 "/usr/include/sys/select.h" 3 4
# 1 "/usr/include/bits/select.h" 1 3 4
# 32 "/usr/include/sys/select.h" 2 3 4
# 1 "/usr/include/bits/sigset.h" 1 3 4
# 23 "/usr/include/bits/sigset.h" 3 4
# 35 "/usr/include/sys/select.h" 2 3 4
# 1 "/usr/include/time.h" 1 3 4
# 118 "/usr/include/time.h" 3 4
# 45 "/usr/include/sys/select.h" 2 3 4
# 1 "/usr/include/bits/time.h" 1 3 4
# 69 "/usr/include/bits/time.h" 3 4
# 47 "/usr/include/sys/select.h" 2 3 4
# 55 "/usr/include/sys/select.h" 3 4
# 67 "/usr/include/sys/select.h" 3 4
# 99 "/usr/include/sys/select.h" 3 4
# 109 "/usr/include/sys/select.h" 3 4
# 121 "/usr/include/sys/select.h" 3 4
# 217 "/usr/include/sys/types.h" 2 3 4
# 1 "/usr/include/sys/sysmacros.h" 1 3 4
# 29 "/usr/include/sys/sysmacros.h" 3 4
# 220 "/usr/include/sys/types.h" 2 3 4
# 244 "/usr/include/sys/types.h" 3 4
# 1 "/usr/include/bits/pthreadtypes.h" 1 3 4
# 36 "/usr/include/bits/pthreadtypes.h" 3 4
# 267 "/usr/include/sys/types.h" 2 3 4
# 439 "/usr/include/stdlib.h" 2 3 4
# 1 "/usr/include/alloca.h" 1 3 4
# 25 "/usr/include/alloca.h" 3 4
# 1 "/usr/lib/gcc/i586-suse-linux/4.1.0/include/stddef.h" 1 3 4
# 26 "/usr/include/alloca.h" 2 3 4
# 613 "/usr/include/stdlib.h" 2 3 4
# 698 "/usr/include/stdlib.h" 3 4
# 712 "/usr/include/stdlib.h" 3 4
# 729 "/usr/include/stdlib.h" 3 4
# 757 "/usr/include/stdlib.h" 3 4
# 822 "/usr/include/stdlib.h" 3 4
# 910 "/usr/include/stdlib.h" 3 4
# 978 "/usr/include/stdlib.h" 3 4
# 8 "arch/um/drivers/chan_user.c" 2
# 1 "/usr/include/errno.h" 1 3 4
# 32 "/usr/include/errno.h" 3 4
# 1 "/usr/include/bits/errno.h" 1 3 4
# 25 "/usr/include/bits/errno.h" 3 4
# 1 "/usr/include/linux/errno.h" 1 3 4
# 1 "/usr/include/asm/errno.h" 1 3 4
# 1 "/usr/include/asm-generic/errno.h" 1 3 4
# 1 "/usr/include/asm-generic/errno-base.h" 1 3 4
# 5 "/usr/include/asm-generic/errno.h" 2 3 4
# 5 "/usr/include/asm/errno.h" 2 3 4
# 5 "/usr/include/linux/errno.h" 2 3 4
# 26 "/usr/include/bits/errno.h" 2 3 4
# 43 "/usr/include/bits/errno.h" 3 4
# 37 "/usr/include/errno.h" 2 3 4
# 55 "/usr/include/errno.h" 3 4
# 69 "/usr/include/errno.h" 3 4
# 9 "arch/um/drivers/chan_user.c" 2
# 1 "/usr/include/termios.h" 1 3 4
# 36 "/usr/include/termios.h" 3 4
# 1 "/usr/include/bits/termios.h" 1 3 4
# 25 "/usr/include/bits/termios.h" 3 4
# 41 "/usr/include/termios.h" 2 3 4
# 49 "/usr/include/termios.h" 3 4
# 1 "/usr/include/sys/ttydefaults.h" 1 3 4
# 106 "/usr/include/termios.h" 2 3 4
# 10 "arch/um/drivers/chan_user.c" 2
# 1 "/usr/include/string.h" 1 3 4
# 28 "/usr/include/string.h" 3 4
# 1 "/usr/lib/gcc/i586-suse-linux/4.1.0/include/stddef.h" 1 3 4
# 34 "/usr/include/string.h" 2 3 4
# 121 "/usr/include/string.h" 3 4
# 165 "/usr/include/string.h" 3 4
# 281 "/usr/include/string.h" 3 4
# 426 "/usr/include/string.h" 3 4
# 11 "arch/um/drivers/chan_user.c" 2
# 1 "/usr/include/signal.h" 1 3 4
# 31 "/usr/include/signal.h" 3 4
# 1 "/usr/include/bits/sigset.h" 1 3 4
# 103 "/usr/include/bits/sigset.h" 3 4
# 34 "/usr/include/signal.h" 2 3 4
# 58 "/usr/include/signal.h" 3 4
# 1 "/usr/include/bits/signum.h" 1 3 4
# 59 "/usr/include/signal.h" 2 3 4
# 75 "/usr/include/signal.h" 3 4
# 104 "/usr/include/signal.h" 3 4
# 153 "/usr/include/signal.h" 3 4
# 162 "/usr/include/signal.h" 3 4
# 181 "/usr/include/signal.h" 3 4
# 196 "/usr/include/signal.h" 3 4
# 1 "/usr/include/time.h" 1 3 4
# 210 "/usr/include/signal.h" 2 3 4
# 1 "/usr/include/bits/siginfo.h" 1 3 4
# 25 "/usr/include/bits/siginfo.h" 3 4
# 1 "/usr/include/bits/wordsize.h" 1 3 4
# 26 "/usr/include/bits/siginfo.h" 2 3 4
# 51 "/usr/include/bits/siginfo.h" 3 4
# 129 "/usr/include/bits/siginfo.h" 3 4
# 273 "/usr/include/bits/siginfo.h" 3 4
# 213 "/usr/include/signal.h" 2 3 4
# 1 "/usr/include/bits/sigaction.h" 1 3 4
# 25 "/usr/include/bits/sigaction.h" 3 4
# 247 "/usr/include/signal.h" 2 3 4
# 304 "/usr/include/signal.h" 3 4
# 328 "/usr/include/signal.h" 3 4
# 1 "/usr/include/bits/sigcontext.h" 1 3 4
# 28 "/usr/include/bits/sigcontext.h" 3 4
# 1 "/usr/include/asm/sigcontext.h" 1 3 4
# 1 "/usr/include/linux/compiler.h" 1 3 4
# 5 "/usr/include/asm/sigcontext.h" 2 3 4
# 20 "/usr/include/asm/sigcontext.h" 3 4
# 29 "/usr/include/bits/sigcontext.h" 2 3 4
# 334 "/usr/include/signal.h" 2 3 4
# 346 "/usr/include/signal.h" 3 4
# 1 "/usr/include/bits/sigstack.h" 1 3 4
# 26 "/usr/include/bits/sigstack.h" 3 4
# 50 "/usr/include/bits/sigstack.h" 3 4
# 349 "/usr/include/signal.h" 2 3 4
# 1 "/usr/include/sys/ucontext.h" 1 3 4
# 23 "/usr/include/sys/ucontext.h" 3 4
# 1 "/usr/include/signal.h" 1 3 4
# 24 "/usr/include/sys/ucontext.h" 2 3 4
# 1 "/usr/include/bits/sigcontext.h" 1 3 4
# 28 "/usr/include/sys/ucontext.h" 2 3 4
# 352 "/usr/include/signal.h" 2 3 4
# 1 "/usr/include/bits/sigthread.h" 1 3 4
# 31 "/usr/include/bits/sigthread.h" 3 4
# 388 "/usr/include/signal.h" 2 3 4
# 12 "arch/um/drivers/chan_user.c" 2
# 1 "/usr/include/sys/stat.h" 1 3 4
# 37 "/usr/include/sys/stat.h" 3 4
# 1 "/usr/include/time.h" 1 3 4
# 38 "/usr/include/sys/stat.h" 2 3 4
# 103 "/usr/include/sys/stat.h" 3 4
# 1 "/usr/include/bits/stat.h" 1 3 4
# 36 "/usr/include/bits/stat.h" 3 4
# 70 "/usr/include/bits/stat.h" 3 4
# 88 "/usr/include/bits/stat.h" 3 4
# 127 "/usr/include/bits/stat.h" 3 4
# 106 "/usr/include/sys/stat.h" 2 3 4
# 215 "/usr/include/sys/stat.h" 3 4
# 241 "/usr/include/sys/stat.h" 3 4
# 250 "/usr/include/sys/stat.h" 3 4
# 263 "/usr/include/sys/stat.h" 3 4
# 391 "/usr/include/sys/stat.h" 3 4
# 413 "/usr/include/sys/stat.h" 3 4
# 13 "arch/um/drivers/chan_user.c" 2
# 1 "/usr/include/sys/ioctl.h" 1 3 4
# 24 "/usr/include/sys/ioctl.h" 3 4
# 1 "/usr/include/bits/ioctls.h" 1 3 4
# 24 "/usr/include/bits/ioctls.h" 3 4
# 1 "/usr/include/asm/ioctls.h" 1 3 4
# 1 "/usr/include/asm/ioctl.h" 1 3 4
# 5 "/usr/include/asm/ioctls.h" 2 3 4
# 25 "/usr/include/bits/ioctls.h" 2 3 4
# 28 "/usr/include/sys/ioctl.h" 2 3 4
# 1 "/usr/include/bits/ioctl-types.h" 1 3 4
# 28 "/usr/include/bits/ioctl-types.h" 3 4
# 31 "/usr/include/sys/ioctl.h" 2 3 4
# 1 "/usr/include/sys/ttydefaults.h" 1 3 4
# 38 "/usr/include/sys/ioctl.h" 2 3 4
# 14 "arch/um/drivers/chan_user.c" 2
# 1 "/usr/include/sys/socket.h" 1 3 4
# 25 "/usr/include/sys/socket.h" 3 4
# 1 "/usr/include/sys/uio.h" 1 3 4
# 26 "/usr/include/sys/uio.h" 3 4
# 1 "/usr/include/bits/uio.h" 1 3 4
# 42 "/usr/include/bits/uio.h" 3 4
# 30 "/usr/include/sys/uio.h" 2 3 4
# 40 "/usr/include/sys/uio.h" 3 4
# 50 "/usr/include/sys/uio.h" 3 4
# 28 "/usr/include/sys/socket.h" 2 3 4
# 1 "/usr/lib/gcc/i586-suse-linux/4.1.0/include/stddef.h" 1 3 4
# 30 "/usr/include/sys/socket.h" 2 3 4
# 1 "/usr/include/bits/socket.h" 1 3 4
# 29 "/usr/include/bits/socket.h" 3 4
# 1 "/usr/lib/gcc/i586-suse-linux/4.1.0/include/stddef.h" 1 3 4
# 30 "/usr/include/bits/socket.h" 2 3 4
# 1 "/usr/lib/gcc/i586-suse-linux/4.1.0/include/limits.h" 1 3 4
# 11 "/usr/lib/gcc/i586-suse-linux/4.1.0/include/limits.h" 3 4
# 1 "/usr/lib/gcc/i586-suse-linux/4.1.0/include/syslimits.h" 1 3 4
# 1 "/usr/lib/gcc/i586-suse-linux/4.1.0/include/limits.h" 1 3 4
# 122 "/usr/lib/gcc/i586-suse-linux/4.1.0/include/limits.h" 3 4
# 1 "/usr/include/limits.h" 1 3 4
# 145 "/usr/include/limits.h" 3 4
# 1 "/usr/include/bits/posix1_lim.h" 1 3 4
# 153 "/usr/include/bits/posix1_lim.h" 3 4
# 1 "/usr/include/bits/local_lim.h" 1 3 4
# 36 "/usr/include/bits/local_lim.h" 3 4
# 1 "/usr/include/linux/limits.h" 1 3 4
# 37 "/usr/include/bits/local_lim.h" 2 3 4
# 154 "/usr/include/bits/posix1_lim.h" 2 3 4
# 146 "/usr/include/limits.h" 2 3 4
# 1 "/usr/include/bits/posix2_lim.h" 1 3 4
# 150 "/usr/include/limits.h" 2 3 4
# 1 "/usr/include/bits/xopen_lim.h" 1 3 4
# 34 "/usr/include/bits/xopen_lim.h" 3 4
# 1 "/usr/include/bits/stdio_lim.h" 1 3 4
# 35 "/usr/include/bits/xopen_lim.h" 2 3 4
# 154 "/usr/include/limits.h" 2 3 4
# 123 "/usr/lib/gcc/i586-suse-linux/4.1.0/include/limits.h" 2 3 4
# 8 "/usr/lib/gcc/i586-suse-linux/4.1.0/include/syslimits.h" 2 3 4
# 12 "/usr/lib/gcc/i586-suse-linux/4.1.0/include/limits.h" 2 3 4
# 32 "/usr/include/bits/socket.h" 2 3 4
# 41 "/usr/include/bits/socket.h" 3 4
# 142 "/usr/include/bits/socket.h" 3 4
# 1 "/usr/include/bits/sockaddr.h" 1 3 4
# 29 "/usr/include/bits/sockaddr.h" 3 4
# 143 "/usr/include/bits/socket.h" 2 3 4
# 162 "/usr/include/bits/socket.h" 3 4
# 257 "/usr/include/bits/socket.h" 3 4
# 284 "/usr/include/bits/socket.h" 3 4
# 1 "/usr/include/asm/socket.h" 1 3 4
# 1 "/usr/include/asm/sockios.h" 1 3 4
# 5 "/usr/include/asm/socket.h" 2 3 4
# 305 "/usr/include/bits/socket.h" 2 3 4
# 36 "/usr/include/sys/socket.h" 2 3 4
# 87 "/usr/include/sys/socket.h" 3 4
# 124 "/usr/include/sys/socket.h" 3 4
# 161 "/usr/include/sys/socket.h" 3 4
# 209 "/usr/include/sys/socket.h" 3 4
# 240 "/usr/include/sys/socket.h" 3 4
# 15 "arch/um/drivers/chan_user.c" 2
# 1 "arch/um/include/kern_util.h" 1
# 9 "arch/um/include/kern_util.h"
# 1 "/usr/include/linux/config.h" 1 3 4
# 10 "arch/um/include/kern_util.h" 2
# 1 "/usr/include/linux/threads.h" 1 3 4
# 11 "arch/um/include/kern_util.h" 2
# 1 "arch/um/include/sysdep/ptrace.h" 1
# 9 "arch/um/include/sysdep/ptrace.h"
# 1 "arch/um/include/uml-config.h" 1
# 10 "arch/um/include/sysdep/ptrace.h" 2
# 1 "arch/um/include/user_constants.h" 1
# 11 "arch/um/include/sysdep/ptrace.h" 2
# 1 "arch/um/include/sysdep/faultinfo.h" 1
# 18 "arch/um/include/sysdep/faultinfo.h"
# 12 "arch/um/include/sysdep/ptrace.h" 2
# 1 "arch/um/include/choose-mode.h" 1
# 9 "arch/um/include/choose-mode.h"
# 1 "arch/um/include/uml-config.h" 1
# 10 "arch/um/include/choose-mode.h" 2
# 13 "arch/um/include/sysdep/ptrace.h" 2
# 1 "arch/um/include/skas_ptregs.h" 1
# 1 "arch/um/include/user_constants.h" 1
# 5 "arch/um/include/skas_ptregs.h" 2
# 36 "arch/um/include/sysdep/ptrace.h" 2
# 63 "arch/um/include/sysdep/ptrace.h"
# 72 "arch/um/include/sysdep/ptrace.h"
# 130 "arch/um/include/sysdep/ptrace.h"
# 12 "arch/um/include/kern_util.h" 2
# 1 "arch/um/include/sysdep/faultinfo.h" 1
# 13 "arch/um/include/kern_util.h" 2
# 16 "arch/um/drivers/chan_user.c" 2
# 1 "arch/um/include/user_util.h" 1
# 13 "arch/um/include/user_util.h"
# 17 "arch/um/drivers/chan_user.c" 2
# 1 "arch/um/include/chan_user.h" 1
# 9 "arch/um/include/chan_user.h"
# 1 "arch/um/include/init.h" 1
# 40 "arch/um/include/init.h"
# 59 "arch/um/include/init.h"
# 75 "arch/um/include/init.h"
# 10 "arch/um/include/chan_user.h" 2
# 18 "arch/um/drivers/chan_user.c" 2
# 1 "arch/um/include/user.h" 1
# 9 "arch/um/include/user.h"
# 19 "arch/um/drivers/chan_user.c" 2
# 1 "arch/um/include/os.h" 1
# 9 "arch/um/include/os.h"
# 1 "arch/um/include/uml-config.h" 1
# 10 "arch/um/include/os.h" 2
# 1 "/usr/include/asm/types.h" 1 3 4
# 11 "arch/um/include/os.h" 2
# 1 "arch/um/include/../os/include/file.h" 1
# 12 "arch/um/include/os.h" 2
# 1 "arch/um/include/kern_util.h" 1
# 14 "arch/um/include/os.h" 2
# 34 "arch/um/include/os.h"
# 172 "arch/um/include/os.h"
# 20 "arch/um/drivers/chan_user.c" 2
# 1 "arch/um/include/choose-mode.h" 1
# 21 "arch/um/drivers/chan_user.c" 2
# 1 "arch/um/include/mode.h" 1
# 9 "arch/um/include/mode.h"
# 1 "arch/um/include/uml-config.h" 1
# 10 "arch/um/include/mode.h" 2
# 1 "/home/abuild/linux-2.6.15/arch/um/kernel/skas/include/mode-skas.h" 1
# 9 "/home/abuild/linux-2.6.15/arch/um/kernel/skas/include/mode-skas.h"
# 1 "arch/um/include/sysdep/ptrace.h" 1
# 10 "/home/abuild/linux-2.6.15/arch/um/kernel/skas/include/mode-skas.h" 2
# 17 "arch/um/include/mode.h" 2
# 22 "arch/um/drivers/chan_user.c" 2
# 69 "arch/um/drivers/chan_user.c"
-- 
short story of a lazy sysadmin:
 alias appserv=wotan


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
