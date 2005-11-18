Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Ed0dO-0002Lh-Iv for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 17 Nov 2005 23:26:10 -0800
Received: from smtp004.mail.ukl.yahoo.com ([217.12.11.35])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1Ed0dL-0007jb-W9
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 17 Nov 2005 23:26:10 -0800
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] 2.6.15-rc1-bk3 minor breakage
References: <1132066452.3082.12.camel@ant.internal>
In-Reply-To: <1132066452.3082.12.camel@ant.internal>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_gQYfDx9RML2K3X8"
Message-Id: <200511180834.56201.blaisorblade@yahoo.it>
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
Date: Fri, 18 Nov 2005 08:34:55 +0100
To: user-mode-linux-devel@lists.sourceforge.net, Antoine Martin <antoine@nagafix.co.uk>

--Boundary-00=_gQYfDx9RML2K3X8
Content-Type: text/plain;
  charset="windows-1251"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Tuesday 15 November 2005 15:54, Antoine Martin wrote:
> It asked me what CPU I wanted to build for?! (make oldconfig)
> It breaks if I select K7, but not if I select PPro (default).

=46ully correct note... I didn't test every possible selection, and there a=
re a=20
few missing stub headers (i.e. containing #include "asm/arch/WHATEVER").

Patch attached but untested. We must also build:=20

arch/i386/lib/mmx.c

but I expect errors from it.

> make ARCH=3Dum vmlinux

>   SYMLINK include/asm-um/elf.h
>   CHK     arch/um/include/uml-config.h
>   UPD     arch/um/include/uml-config.h
> gcc -Wall -Wundef -Wstrict-prototypes -Wno-trigraphs
> -fno-strict-aliasing -fno-common -ffreestanding -O2
> -fno-omit-frame-pointer -fno-optimize-sibling-calls -g -D__arch_um__
> -DSUBARCH=3D\"i386\" -Dvmap=3Dkernel_vmap
> -Din6addr_loopback=3Dkernel_in6addr_loopback -Iarch/um/include
> -I/usr/src/linux-2.6.15-rc1-bk3-uml/arch/um/kernel/tt/include
> -I/usr/src/linux-2.6.15-rc1-bk3-uml/arch/um/kernel/skas/include
> -D_FILE_OFFSET_BITS=3D64 -march=3Dathlon -mpreferred-stack-boundary=3D2
> -D_GNU_SOURCE -D_LARGEFILE64_SOURCE -S -o arch/um/user-offsets.s
> arch/um/sys-i386/user-offsets.c
>   CHK     arch/um/include/user_constants.h
>   UPD     arch/um/include/user_constants.h
>   CHK     include/linux/version.h
>   UPD     include/linux/version.h
>   SYMLINK include/asm -> include/asm-um
>   SPLIT   include/linux/autoconf.h -> include/config/*
> gcc -Wall -Wundef -Wstrict-prototypes -Wno-trigraphs
> -fno-strict-aliasing -fno-common -ffreestanding -O2
> -fno-omit-frame-pointer -fno-optimize-sibling-calls -g  -D__arch_um__
> -DSUBARCH=3D\"i386\" -Iarch/um/include
> -I/usr/src/linux-2.6.15-rc1-bk3-uml/arch/um/kernel/tt/include
> -I/usr/src/linux-2.6.15-rc1-bk3-uml/arch/um/kernel/skas/include
> -Dvmap=3Dkernel_vmap -Din6addr_loopback=3Dkernel_in6addr_loopback
> -Derrno=3Dkernel_errno -Dsigprocmask=3Dkernel_sigprocmask
> -fno-unit-at-a-time -U__i386__ -Ui386 -march=3Dathlon
> -mpreferred-stack-boundary=3D2 -D_LARGEFILE64_SOURCE
> -Wdeclaration-after-statement -Wno-pointer-sign  -nostdinc
> -isystem /usr/lib/gcc/i386-redhat-linux/4.0.1/include -D__KERNEL__
> -Iinclude  -include include/linux/autoconf.h -S -o
> arch/um/kernel-offsets.s arch/um/sys-i386/kernel-offsets.c
> In file included from include/asm/string.h:4,
>                  from include/linux/string.h:24,
>                  from include/linux/bitmap.h:8,
>                  from include/linux/cpumask.h:86,
>                  from include/linux/sched.h:15,
>                  from arch/um/sys-i386/kernel-offsets.c:3:
> include/asm/arch/string.h:288:21: error: asm/mmx.h: No such file or
> directory
> In file included from include/asm/string.h:4,
>                  from include/linux/string.h:24,
>                  from include/linux/bitmap.h:8,
>                  from include/linux/cpumask.h:86,
>                  from include/linux/sched.h:15,
>                  from arch/um/sys-i386/kernel-offsets.c:3:
> include/asm/arch/string.h: In function =91__constant_memcpy3d=92:
> include/asm/arch/string.h:298: warning: implicit declaration of function
> =91_mmx_memcpy=92
> include/asm/arch/string.h:298: warning: return makes pointer from
> integer without a cast
> include/asm/arch/string.h: In function =91__memcpy3d=92:
> include/asm/arch/string.h:305: warning: return makes pointer from
> integer without a cast
> make: *** [arch/um/kernel-offsets.s] Error 1
>
> Antoine

=2D-=20
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade

--Boundary-00=_gQYfDx9RML2K3X8
Content-Type: text/x-diff; charset="windows-1251"; name="add-missing-header"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="add-missing-header"

Index: linux-2.6.git/arch/um/sys-i386/Makefile
===================================================================
--- linux-2.6.git.orig/arch/um/sys-i386/Makefile
+++ linux-2.6.git/arch/um/sys-i386/Makefile
@@ -5,9 +5,13 @@ obj-y = bitops.o bugs.o checksum.o delay
 obj-$(CONFIG_HIGHMEM) += highmem.o
 obj-$(CONFIG_MODULES) += module.o
 
+# XXX: Should be lib? Supported here? For bitops.o we currently don't care.
+#lib-$(CONFIG_X86_USE_3DNOW) += mmx.o
+obj-$(CONFIG_X86_USE_3DNOW) += mmx.o
+
 USER_OBJS := bugs.o ptrace_user.o sigcontext.o fault.o
 
-SYMLINKS = bitops.c semaphore.c highmem.c module.c
+SYMLINKS = bitops.c semaphore.c highmem.c module.c mmx.c
 
 include arch/um/scripts/Makefile.rules
 
@@ -15,6 +19,7 @@ bitops.c-dir = lib
 semaphore.c-dir = kernel
 highmem.c-dir = mm
 module.c-dir = kernel
+mmx.c-dir = lib
 
 $(obj)/stub_segv.o : _c_flags = $(call unprofile,$(CFLAGS))
 
Index: linux-2.6.git/include/asm-um/mmx.h
===================================================================
--- /dev/null
+++ linux-2.6.git/include/asm-um/mmx.h
@@ -0,0 +1,6 @@
+#ifndef __UM_MMX_H
+#define __UM_MMX_H
+
+#include "asm/arch/mmx.h"
+
+#endif

--Boundary-00=_gQYfDx9RML2K3X8--

	

	
		
___________________________________ 
Yahoo! Mail: gratis 1GB per i messaggi e allegati da 10MB 
http://mail.yahoo.it



-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.  Get Certified Today
Register for a JBoss Training Course.  Free Certification Exam
for All Training Attendees Through End of 2005. For more info visit:
http://ads.osdn.com/?ad_id=7628&alloc_id=16845&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
