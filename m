Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EzBz3-00063Q-Jc for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 18 Jan 2006 04:00:13 -0800
Received: from smtp.gentoo.org ([134.68.220.30])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1EzBz2-0000ZL-Az
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 18 Jan 2006 04:00:13 -0800
Received: from nuthatch.gentoo.osuosl.org ([140.211.166.163]
	helo=nuthatch.gentoo.org) by smtp.gentoo.org with esmtp (Exim 4.54)
	id 1EzByw-0003XC-5B for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 18 Jan 2006 12:00:06 +0000
Received: from apache by nuthatch.gentoo.org with local (Exim 4.54)
	id 1EzByv-0006Mz-T9 for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 18 Jan 2006 12:00:05 +0000
In-Reply-To: <bug-111575-25805@http.bugs.gentoo.org/>
From: bugzilla-daemon@gentoo.org
Message-Id: <E1EzByv-0006Mz-T9@nuthatch.gentoo.org>
Subject: [uml-devel] [Bug 111575] sys-kernel/usermode-sources-2.6.14: kernel
	panic when assigning more than 256M
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
Date: Wed, 18 Jan 2006 12:00:05 +0000
To: user-mode-linux-devel@lists.sourceforge.net

Clear-Text: http://bugs.gentoo.org/show_bug.cgi?id=111575
Secure: https://bugs.gentoo.org/show_bug.cgi?id=111575





------- Comment #15 from toralf.foerster@gmx.de  2006-01-18 04:00 PST -------
Hi,
has no effect: echo 262144 > /proc/sys/vm/max_map_count

switching to CONFIG_M686=y works ! (even with mem=256M)

switching to CONFIG_MODE_TT not tested

wwitching to CONFIG_M386 I got a compile error:

/usr/src/uml # make CC='ccache gcc' ARCH=um linux
  CHK     arch/um/include/uml-config.h
  UPD     arch/um/include/uml-config.h
ccache gcc -Wall -Wundef -Wstrict-prototypes -Wno-trigraphs
-fno-strict-aliasing -fno-common -ffreestanding -Os -fomit-frame-pointer
-D__arch_um__ -DSUBARCH=\"i386\" -Dvmap=kernel_vmap
-Din6addr_loopback=kernel_in6addr_loopback -Iarch/um/include 
-I/usr/src/linux-2.6.15-gentoo/arch/um/kernel/tt/include 
-I/usr/src/linux-2.6.15-gentoo/arch/um/kernel/skas/include
-D_FILE_OFFSET_BITS=64 -march=i386 -mpreferred-stack-boundary=2 -D_GNU_SOURCE
-D_LARGEFILE64_SOURCE -S -o arch/um/user-offsets.s
arch/um/sys-i386/user-offsets.c
  CHK     arch/um/include/user_constants.h
  CHK     include/linux/version.h
  UPD     include/linux/version.h
  SYMLINK include/asm -> include/asm-um
  SPLIT   include/linux/autoconf.h -> include/config/*
ccache gcc -Wall -Wundef -Wstrict-prototypes -Wno-trigraphs
-fno-strict-aliasing -fno-common -ffreestanding -Os     -fomit-frame-pointer 
-D__arch_um__ -DSUBARCH=\"i386\" -Iarch/um/include 
-I/usr/src/linux-2.6.15-gentoo/arch/um/kernel/tt/include 
-I/usr/src/linux-2.6.15-gentoo/arch/um/kernel/skas/include -Dvmap=kernel_vmap
-Din6addr_loopback=kernel_in6addr_loopback -Derrno=kernel_errno
-Dsigprocmask=kernel_sigprocmask -fno-unit-at-a-time -U__i386__ -Ui386
-march=i386 -mpreferred-stack-boundary=2 -D_LARGEFILE64_SOURCE
-Wdeclaration-after-statement   -nostdinc -isystem
/usr/lib/gcc/i686-pc-linux-gnu/3.4.4/include -D__KERNEL__ -Iinclude  -include
include/linux/autoconf.h -S -o arch/um/kernel-offsets.s
arch/um/sys-i386/kernel-offsets.c
In file included from include/asm/atomic.h:9,
                 from include/linux/spinlock.h:232,
                 from include/linux/capability.h:45,
                 from include/linux/sched.h:7,
                 from arch/um/sys-i386/kernel-offsets.c:3:
include/asm/arch/atomic.h: In function `atomic_add_return':
include/asm/arch/atomic.h:192: error: structure has no member named `x86'
make: *** [arch/um/kernel-offsets.s] Error 1


-- 
Configure bugmail: http://bugs.gentoo.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are on the CC list for the bug, or are watching someone who is.


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
