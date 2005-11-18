Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Ed0Hd-0001aD-Qd for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 17 Nov 2005 23:03:41 -0800
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]
	helo=grelber.thyrsus.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1Ed0Hd-0006Zp-DS
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 17 Nov 2005 23:03:41 -0800
From: Rob Landley <rob@landley.net>
References: <200511172110.jAHLAQoe010199@ccure.user-mode-linux.org>
In-Reply-To: <200511172110.jAHLAQoe010199@ccure.user-mode-linux.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511180103.29950.rob@landley.net>
Subject: [uml-devel] Re: [PATCH 2/4] UML - Eliminate anonymous union and clean
	up symlink lossage
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
Date: Fri, 18 Nov 2005 01:03:29 -0600
To: Jeff Dike <jdike@addtoit.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

On Thursday 17 November 2005 15:10, Jeff Dike wrote:
> This gives a name to the anonymous union introduced in
> skas-hold-own-ldt, allowing to build on a wider range of gccs.

Or narrower range, in the case of Ubuntu "Horny Hedgehog".  2.6.15-rc1 builds 
fine by itself, or with just patch 1 in this series, but with patch 2...

  CHK     include/linux/version.h
  UPD     include/linux/version.h
  SYMLINK include/asm -> include/asm-um
  SPLIT   include/linux/autoconf.h -> include/config/*
gcc -Wall -Wundef -Wstrict-prototypes -Wno-trigraphs -fno-strict-aliasing 
-fno-common -ffreestanding -O2     -fomit-frame-pointer  -D__arch_um__ 
-DSUBARCH=\"i386\" -Iarch/um/include 
-I/home/landley/newbuild/firmware-build/tmpdir/linux-2.6.14/arch/um/include  
-I/home/landley/newbuild/firmware-build/tmpdir/linux-2.6.14/arch/um/kernel/skas/include 
-Dvmap=kernel_vmap -Din6addr_loopback=kernel_in6addr_loopback 
-Derrno=kernel_errno -Dsigprocmask=kernel_sigprocmask  -U__i386__ -Ui386 
-march=i686 -mpreferred-stack-boundary=2 -D_LARGEFILE64_SOURCE    -nostdinc 
-isystem /usr/lib/gcc-lib/i486-linux/3.3.5/include -D__KERNEL__ -Iinclude 
-Iinclude2 
-I/home/landley/newbuild/firmware-build/tmpdir/linux-2.6.14/include -include 
include/linux/autoconf.h -S -o 
arch/um/kernel-offsets.s /home/landley/newbuild/firmware-build/tmpdir/linux-2.6.14/arch/um/sys-i386/kernel-offsets.c
In file included 
from /home/landley/newbuild/firmware-build/tmpdir/linux-2.6.14/arch/um/include/um_mmu.h:17,
                 from include2/asm/mmu.h:9,
                 from /home/landley/newbuild/firmware-build/tmpdir/linux-2.6.14/include/linux/sched.h:23,
                 from /home/landley/newbuild/firmware-build/tmpdir/linux-2.6.14/arch/um/sys-i386/kernel-offsets.c:3:
/home/landley/newbuild/firmware-build/tmpdir/linux-2.6.14/arch/um/kernel/skas/include/mmu-skas.h:19: 
error: syntax error before "uml_ldt_t"
/home/landley/newbuild/firmware-build/tmpdir/linux-2.6.14/arch/um/kernel/skas/include/mmu-skas.h:19: 
warning: no semicolon at end of struct or union
In file included from include2/asm/mmu.h:9,
                 from /home/landley/newbuild/firmware-build/tmpdir/linux-2.6.14/include/linux/sched.h:23,
                 from /home/landley/newbuild/firmware-build/tmpdir/linux-2.6.14/arch/um/sys-i386/kernel-offsets.c:3:
/home/landley/newbuild/firmware-build/tmpdir/linux-2.6.14/arch/um/include/um_mmu.h:25: 
error: field `skas' has incomplete type
make[2]: *** [arch/um/kernel-offsets.s] Error 1
make[1]: *** [_all] Error 2
make: *** [all] Error 2


-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.  Get Certified Today
Register for a JBoss Training Course.  Free Certification Exam
for All Training Attendees Through End of 2005. For more info visit:
http://ads.osdn.com/?ad_id=7628&alloc_id=16845&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
